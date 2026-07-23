import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:purchases_flutter/purchases_flutter.dart';

/// Cấu hình IAP (RevenueCat).
///
/// Cách bật RevenueCat thật — phải khớp CHÍNH XÁC với code bên dưới:
///  1. Tạo project trên https://app.revenuecat.com, thêm app iOS/Android
///     (bundle id: dev.izidev.lighten).
///  2. Tạo entitlement identifier đúng bằng "pro" (khớp [entitlementId]).
///  3. Tạo 1 sản phẩm mua đứt 1 lần (non-consumable) trong App Store Connect /
///     Play Console, import vào RevenueCat, gắn vào entitlement "pro".
///  4. Trong Offering mặc định ("default", đánh dấu Current), tạo 1 Package
///     với Package Type = "Lifetime" (RevenueCat tự gán identifier
///     `$rc_lifetime`) và gắn sản phẩm ở bước 3 vào package này — code dùng
///     `offerings.current?.lifetime` nên BẮT BUỘC phải là type Lifetime,
///     không phải Custom, để SDK nhận đúng.
///  5. Lấy Public API key (Project settings > API keys) và điền vào
///     androidApiKey / iosApiKey bên dưới.
/// Khi còn để trống → app tự dùng [MockIapService] (chạy được không cần cấu hình).
class IapConfig {
  /// Public SDK key (khác nhau theo nền tảng). Lấy trong RevenueCat > API keys.
  static const String androidApiKey = ''; // TODO(prod): điền key Android
  static const String iosApiKey = 'appl_uDHaUNBZknGojitwGusVsvkjpPL';

  /// Tên entitlement cấu hình trong RevenueCat.
  static const String entitlementId = 'pro';

  /// Chỉ true khi ĐÚNG nền tảng hiện tại đã có key — tránh trường hợp điền key
  /// iOS trước rồi Android vô tình bị coi là "đã cấu hình" (gọi RevenueCat SDK
  /// mà chưa Purchases.configure() do thiếu key sẽ crash).
  static bool get isConfigured => defaultTargetPlatform == TargetPlatform.iOS
      ? iosApiKey.isNotEmpty
      : androidApiKey.isNotEmpty;
}

/// Trừu tượng hoá mua hàng trong app (IAP). UI chỉ phụ thuộc interface này.
abstract class IapService {
  /// Trả về true nếu mua thành công (entitlement Pro đã kích hoạt).
  Future<bool> buyPro();

  /// Khôi phục giao dịch đã mua. Trả về true nếu tìm thấy Pro.
  Future<bool> restore();

  /// Kiểm tra trạng thái Pro hiện tại (dùng để đồng bộ lúc mở app).
  Future<bool> isProActive();

  /// Giá gói Pro, đã định dạng & localize sẵn theo store (VD "$4.99", "99.000 ₫").
  /// Null nếu chưa lấy được (chưa cấu hình RevenueCat, offline, ...) — UI nên
  /// hiện text chung chung ("mua một lần") thay vì đoán giá.
  Future<String?> proPriceString();
}

/// Chọn implementation phù hợp: RevenueCat nếu đã điền key, ngược lại dùng mock.
IapService createIapService() =>
    IapConfig.isConfigured ? RevenueCatIapService() : MockIapService();

/// Gọi 1 lần lúc khởi động app (chỉ có tác dụng khi đã cấu hình RevenueCat).
Future<void> configureIap() async {
  if (!IapConfig.isConfigured) return;
  try {
    final apiKey = defaultTargetPlatform == TargetPlatform.iOS
        ? IapConfig.iosApiKey
        : IapConfig.androidApiKey;
    if (apiKey.isEmpty) return;
    await Purchases.setLogLevel(LogLevel.info);
    await Purchases.configure(PurchasesConfiguration(apiKey));
  } catch (e) {
    debugPrint('configureIap failed: $e');
  }
}

/// Bản thật dùng RevenueCat.
class RevenueCatIapService implements IapService {
  bool _hasPro(CustomerInfo info) =>
      info.entitlements.active.containsKey(IapConfig.entitlementId);

  @override
  Future<bool> buyPro() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      // Sản phẩm Pro là mua đứt 1 lần → ưu tiên gói lifetime, fallback gói đầu tiên.
      final package = current?.lifetime ??
          (current != null && current.availablePackages.isNotEmpty
              ? current.availablePackages.first
              : null);
      if (package == null) {
        debugPrint('RevenueCat: không tìm thấy gói Pro trong Offering hiện tại.');
        return false;
      }
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _hasPro(result.customerInfo);
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      if (code != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('RevenueCat buyPro error: $code');
      }
      return false;
    } catch (e) {
      debugPrint('RevenueCat buyPro failed: $e');
      return false;
    }
  }

  @override
  Future<bool> restore() async {
    try {
      final info = await Purchases.restorePurchases();
      return _hasPro(info);
    } catch (e) {
      debugPrint('RevenueCat restore failed: $e');
      return false;
    }
  }

  @override
  Future<bool> isProActive() async {
    try {
      final info = await Purchases.getCustomerInfo();
      return _hasPro(info);
    } catch (e) {
      debugPrint('RevenueCat isProActive failed: $e');
      return false;
    }
  }

  @override
  Future<String?> proPriceString() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      final package = current?.lifetime ??
          (current != null && current.availablePackages.isNotEmpty
              ? current.availablePackages.first
              : null);
      return package?.storeProduct.priceString;
    } catch (e) {
      debugPrint('RevenueCat proPriceString failed: $e');
      return null;
    }
  }
}

/// Bản giả lập cho phát triển/thử nghiệm không cần tài khoản store.
class MockIapService implements IapService {
  @override
  Future<bool> buyPro() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    debugPrint('[MockIap] Mua Pro thành công (giả lập).');
    return true;
  }

  @override
  Future<bool> restore() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    debugPrint('[MockIap] Không tìm thấy giao dịch (giả lập).');
    return false;
  }

  @override
  Future<bool> isProActive() async => false;

  @override
  Future<String?> proPriceString() async => null;
}
