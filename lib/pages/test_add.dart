import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as MobileAds;
import 'package:google_mobile_ads/google_mobile_ads.dart%20';
import 'package:zodiac_talks/ad_mob_service.dart';
import 'package:zodiac_talks/components/banner_ad.dart';

class TestAd extends StatefulWidget {
  const TestAd({super.key});

  @override
  State<TestAd> createState() => _TestAdState();
}

class _TestAdState extends State<TestAd> {
  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createInterstitialAd();
  }

  InterstitialAd? _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobService.interstitialAdUnitId!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) => _interstitialAd = ad,
          onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _interstitialAd = null;
    }
  }

  void _createBannerAd() {
    _banner = MobileAds.BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  MobileAds.BannerAd? _banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: _showInterstitialAd, child: Text("press")),
      ),
      bottomNavigationBar: _banner == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 52,
              child: MobileAds.AdWidget(ad: _banner!),
            ),
    );
  }
}
