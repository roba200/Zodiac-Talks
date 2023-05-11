import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as MobileAds;
import 'package:google_mobile_ads/google_mobile_ads.dart%20';

import '../ad_mob_service.dart';

class BannerA extends StatefulWidget {
  const BannerA({super.key});

  @override
  State<BannerA> createState() => _BannerAState();
}

class _BannerAState extends State<BannerA> {
  MobileAds.BannerAd? _banner;
  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd() {
    _banner = MobileAds.BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 228, 228, 228),
      width: double.infinity,
      child: _banner == null
          ? Container()
          : Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 52,
              child: MobileAds.AdWidget(ad: _banner!),
            ),
    );
  }
}
