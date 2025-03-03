import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//paste in AndroidManifest.xml
// <meta-data
// android:name="com.google.android.gms.ads.APPLICATION_ID"
// android:value="pub-3511968554265090" />

class Adbannercode extends StatelessWidget {
  const Adbannercode({super.key});
  static BannerAd createBannerAd() {
    BannerAd adBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3511968554265090/6761108640',
      listener: BannerAdListener(
        onAdLoaded: (ad) => const SnackBar(
            content: Text('Ad loaded'), duration: Duration(seconds: 3)),
        onAdFailedToLoad: (ad, error) => SnackBar(
            content: Text('Ad display failed: $error'),
            duration: const Duration(seconds: 3)),
      ),
      request: const AdRequest(),
    );
    adBanner.load();
    return adBanner;
  }

  static BannerAd createFullBannerAd() {
    BannerAd adBanner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: 'ca-app-pub-3511968554265090/6761108640',
      listener: BannerAdListener(
        onAdLoaded: (ad) => const SnackBar(
            content: Text('Ad loaded'), duration: Duration(seconds: 3)),
        onAdFailedToLoad: (ad, error) => SnackBar(
            content: Text('Ad display failed: $error'),
            duration: const Duration(seconds: 3)),
      ),
      request: const AdRequest(),
    );
    adBanner.load();
    return adBanner;
  }

  static BannerAd createLargeBannerAd() {
    BannerAd adBanner = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: 'ca-app-pub-3511968554265090/6761108640',
      listener: BannerAdListener(
        onAdLoaded: (ad) => const SnackBar(
            content: Text('Ad loaded'), duration: Duration(seconds: 3)),
        onAdFailedToLoad: (ad, error) => SnackBar(
            content: Text('Ad display failed: $error'),
            duration: const Duration(seconds: 3)),
      ),
      request: const AdRequest(),
    );
    adBanner.load();
    return adBanner;
  }

  static BannerAd createFluidBannerAd() {
    BannerAd adBanner = BannerAd(
      size: AdSize.fluid,
      adUnitId: 'ca-app-pub-3511968554265090/6761108640',
      listener: BannerAdListener(
        onAdLoaded: (ad) => const SnackBar(
            content: Text('Ad loaded'), duration: Duration(seconds: 3)),
        onAdFailedToLoad: (ad, error) => SnackBar(
            content: Text('Ad display failed: $error'),
            duration: const Duration(seconds: 3)),
      ),
      request: const AdRequest(),
    );
    adBanner.load();
    return adBanner;
  }

  @override
  Widget build(BuildContext context) {
    BannerAd bannerAd = createBannerAd();
    return AdWidget(ad: bannerAd);
  }
}
