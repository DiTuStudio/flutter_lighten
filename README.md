# Thoát Nợ

App lập kế hoạch trả nợ cá nhân cho người có nhiều khoản vay cùng lúc.
**100% dữ liệu lưu trên máy, không tài khoản, không server.**

MVP theo bản đặc tả `thoat-no-mvp-spec.md.docx` (phạm vi v1 gốc).

## Trạng thái

- `flutter analyze`: sạch, không lỗi.
- `flutter test`: 15/15 pass (engine tính toán được kiểm thử kỹ + smoke test UI).
- Chưa chạy được app đầy đủ trong môi trường build hiện tại (xem "Chạy app").

## Kiến trúc

```
lib/
├─ models/          Debt, Payment, AppSettings, enums
├─ data/            database.dart (sqflite), repository.dart
├─ engine/          interest.dart (quy đổi lãi), payoff_engine.dart (mô phỏng lộ trình)
├─ state/           app_state.dart (ChangeNotifier + Provider)
├─ services/        notification_service, ad_service, iap_service
├─ widgets/         thousands_formatter, banner_ad_widget
├─ screens/         onboarding, dashboard, edit_debt, debt_detail,
│                   strategy, roadmap, settings, paywall
└─ main.dart
test/
├─ engine_test.dart   14 test cho engine + quy đổi lãi
└─ widget_test.dart   smoke test onboarding
```

### Quyết định tính toán quan trọng
- **Lãi cố định** tính trên **gốc ban đầu** mỗi kỳ (`lãi_kỳ = gốc_ban_đầu × lãi/tháng`),
  đúng thực tế trả góp ở VN. Lãi giảm dần tính trên dư nợ hiện tại.
- **Snowball/Avalanche** dùng cơ chế rollover: dồn tiền tối thiểu được giải phóng
  + tiền trả thêm vào khoản mục tiêu.
- **Phát hiện bẫy tài chính**: nếu tổng dư nợ không giảm giữa các tháng → dừng sớm,
  báo "nợ sẽ không giảm". Giới hạn an toàn 600 tháng.

## Chạy app

Môi trường hiện tại **thiếu Android SDK và emulator**, nên chưa chạy được app.
Để chạy, chọn 1 trong 2:

**A. Android (nền tảng đích chính)**
1. Cài Android Studio + Android SDK, tạo 1 emulator (hoặc cắm máy thật).
2. `flutter run` (đã cấu hình sẵn AndroidManifest, AdMob test ID, receivers nhắc lịch).

**B. Windows desktop (chỉ để xem nhanh UI)**
1. Bật **Developer Mode**: `start ms-settings:developers` (cần cho symlink của plugin).
2. `flutter run -d windows`
   (sqflite đã được cấu hình chạy qua FFI trên desktop; quảng cáo/nhắc lịch tự tắt
   trên nền tảng không hỗ trợ).

## Việc cần làm trước khi phát hành (production)

1. **AdMob**: thay test ID trong `lib/services/ad_service.dart` (`useTestAds = false`
   + điền ID thật) và App ID trong `AndroidManifest.xml` / iOS `Info.plist`.
   **BẮT BUỘC chặn category "vay tiền / tín dụng"** trong AdMob console.
2. **IAP**: thay `MockIapService` bằng bản dùng RevenueCat (`purchases_flutter`).
   Sản phẩm Pro: mua đứt 1 lần (~99.000đ). Xem `lib/services/iap_service.dart`.
3. **iOS**: thêm `GADApplicationIdentifier` vào `Info.plist`, cấu hình quyền thông báo.
4. Tài khoản Google Play / Apple Developer để phát hành.

## Ngoài phạm vi v1 (để dành bản sau)
Đăng nhập/đồng bộ, chia sẻ, kết nối ngân hàng, import sao kê, đa ngôn ngữ,
và các ý tưởng tăng retention đã bàn (đếm ngược ngày thoát nợ, widget màn hình,
backup/restore, ăn mừng trả hết khoản).
