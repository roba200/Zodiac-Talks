import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zodiac_talks/main.dart';

class AdMobService {
  static String? get nativeAdUnitId {
    if (Platform.isAndroid) {
      return nativeId;
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return interstitialId;
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }

  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return bannerId;
    } else if (Platform.isIOS) {
      return '';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    onAdOpened: (ad) => debugPrint('Ad opened'),
    onAdClosed: (ad) => debugPrint('Ad closed'),
  );

  static final NativeAdListener nativeAdListener = NativeAdListener(
    onAdLoaded: (ad) => debugPrint('Native Ad loaded'),
    onAdWillDismissScreen: (ad) {},
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    },
    onAdOpened: (ad) => debugPrint('Native Ad opened'),
    onAdClosed: (ad) => debugPrint('Native Ad closed'),
  );
}
