import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zodiac_talks/components/native_ad.dart';

import '../ad_mob_service.dart';

class InfoCard extends StatefulWidget {
  final String text;
  final String date;
  InfoCard({super.key, required this.text, required this.date});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 212,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 215, 19, 135))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    widget.date,
                    style: GoogleFonts.teko(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 215, 19, 135)),
                  ),
                  SizedBox(height: 30),
                  Text(
                    widget.text,
                    style: GoogleFonts.timmana(height: 1, fontSize: 19),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 212 - 17.5,
            left: (width / 2) - 15 - 42,
            child: GestureDetector(
              onTap: () {
                _showInterstitialAd();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      content: SingleChildScrollView(
                        child: Column(children: [
                          // NativeA(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.text,
                              style: GoogleFonts.timmana(
                                  height: 1.2, fontSize: 19),
                            ),
                          )
                        ]),
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 35,
                width: 84,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 215, 19, 135))),
                child: Center(
                  child: Text(
                    "See more",
                    style: GoogleFonts.sumana(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Color.fromARGB(255, 215, 19, 135)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
