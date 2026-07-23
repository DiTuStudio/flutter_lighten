import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Quản lý quảng cáo (AdMob).
///
/// LƯU Ý QUAN TRỌNG khi lên production:
///  1. Thay các ID test bên dưới bằng ad unit ID thật.
///  2. Trong AdMob console, CHẶN category "vay tiền / tín dụng / cho vay"
///     (Blocking controls) — app định vị "giúp thoát nợ" tuyệt đối không được
///     hiển thị quảng cáo vay tiền.
///  3. Thêm App ID thật vào AndroidManifest.xml và Info.plist.
class AdService {
  AdService._();
  static final AdService instance = AdService._();

  bool _initialized = false;

  // ---- Test ad unit IDs của Google (an toàn khi phát triển) ----
  static const _testBannerAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const _testBannerIos = 'ca-app-pub-3940256099942544/2934735716';
  static const _testInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const _testInterstitialIos = 'ca-app-pub-3940256099942544/4411468910';
  static const _testRewardedAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const _testRewardedIos = 'ca-app-pub-3940256099942544/1712485313';

  // TODO(prod): đổi sang false và điền ID thật trước khi phát hành.
  static const bool useTestAds = true;

  /// CÔNG TẮC TỔNG: đổi thành false để TẮT HOÀN TOÀN quảng cáo
  /// (hữu ích khi cần chạy nhanh trên simulator mà không muốn dính ads).
  ///
  /// TODO(prod): bản này chưa bật ads — đổi lại true khi đã có ad unit ID thật
  /// và đã chặn category "vay tiền nhanh/tín dụng" trong AdMob console.
  static const bool adsEnabled = false;

  String get bannerUnitId {
    if (useTestAds) {
      return Platform.isIOS ? _testBannerIos : _testBannerAndroid;
    }
    return Platform.isIOS ? 'PROD_BANNER_IOS' : 'PROD_BANNER_ANDROID';
  }

  String get interstitialUnitId {
    if (useTestAds) {
      return Platform.isIOS ? _testInterstitialIos : _testInterstitialAndroid;
    }
    return Platform.isIOS ? 'PROD_INTERSTITIAL_IOS' : 'PROD_INTERSTITIAL_ANDROID';
  }

  String get rewardedUnitId {
    if (useTestAds) {
      return Platform.isIOS ? _testRewardedIos : _testRewardedAndroid;
    }
    return Platform.isIOS ? 'PROD_REWARDED_IOS' : 'PROD_REWARDED_ANDROID';
  }

  Future<void> init() async {
    if (!adsEnabled) return;
    if (_initialized) return;
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) return;
    try {
      // iOS: xin quyền App Tracking Transparency TRƯỚC khi khởi tạo ads.
      // (Trên Android hàm này không làm gì.)
      await _requestTracking();
      await MobileAds.instance.initialize();
      _initialized = true;
    } catch (e) {
      debugPrint('AdService init failed: $e');
    }
  }

  Future<void> _requestTracking() async {
    try {
      final status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } catch (e) {
      debugPrint('ATT request failed: $e');
    }
  }

  bool get initialized => _initialized;

  InterstitialAd? _interstitial;

  /// Nạp trước 1 interstitial để sẵn sàng hiển thị sau hành động tích cực.
  void preloadInterstitial() {
    if (!_initialized) return;
    InterstitialAd.load(
      adUnitId: interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed: $error');
          _interstitial = null;
        },
      ),
    );
  }

  /// Hiển thị interstitial nếu đã sẵn sàng, rồi nạp lại cho lần sau.
  void showInterstitialIfReady() {
    final ad = _interstitial;
    if (ad == null) return;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preloadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        preloadInterstitial();
      },
    );
    ad.show();
    _interstitial = null;
  }

  // ---- Rewarded video (nguồn doanh thu phụ; đổi lấy Pro tạm 24h) ----

  RewardedAd? _rewarded;

  /// Nạp trước 1 rewarded ad.
  void preloadRewarded() {
    if (!_initialized) return;
    RewardedAd.load(
      adUnitId: rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewarded = ad,
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded failed: $error');
          _rewarded = null;
        },
      ),
    );
  }

  bool get isRewardedReady => _rewarded != null;

  /// Hiển thị rewarded ad. Gọi [onReward] nếu user xem đủ và nhận thưởng.
  /// Trả về true nếu ad đã được hiển thị.
  Future<bool> showRewarded({required VoidCallback onReward}) async {
    final ad = _rewarded;
    if (ad == null) {
      preloadRewarded();
      return false;
    }
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        preloadRewarded();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        preloadRewarded();
      },
    );
    _rewarded = null;
    ad.show(onUserEarnedReward: (_, reward) => onReward());
    return true;
  }
}
