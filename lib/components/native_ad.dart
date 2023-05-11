import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as MobileAds;
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ad_mob_service.dart';

class NativeA extends StatefulWidget {
  const NativeA({super.key});

  @override
  State<NativeA> createState() => _NativeAState();
}

class _NativeAState extends State<NativeA> {
  @override
  void initState() {
    super.initState();
    _createNativeAd();
  }

  void _createNativeAd() {
    _native = MobileAds.NativeAd(
      adUnitId: AdMobService.nativeAdUnitId!,
      listener: AdMobService.nativeAdListener,
      request: const AdRequest(),
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
    )..load();
  }

  MobileAds.NativeAd? _native;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 400, // minimum recommended width
          minHeight: 400, // minimum recommended height
          maxWidth: 400,
          maxHeight: 400,
        ),
        child: _native == null
            ? Container()
            : Container(
                height: 90,
                width: 320,
                margin: EdgeInsets.only(bottom: 0),
                child: MobileAds.AdWidget(ad: _native!),
              ),
      ),
    );
  }
}
