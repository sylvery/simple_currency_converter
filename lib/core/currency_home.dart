import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'adbannercode.dart';

class CurrencyHome extends StatefulWidget {
  const CurrencyHome({super.key});

  @override
  State<CurrencyHome> createState() => _CurrencyHomeState();
}

class _CurrencyHomeState extends State<CurrencyHome> {
  double usd = 0.2234;
  double forexc = 33.02;
  var currency, _convertedCurrency, _usd, _local;
  TextEditingController _currencyInputController = TextEditingController();
  BannerAd banner = Adbannercode.createBannerAd();
  BannerAd fullBanner = Adbannercode.createFullBannerAd();
  BannerAd largeBanner = Adbannercode.createLargeBannerAd();
  bool _currencySwitch = true;
  var currencyType = 'PGK';
  var _foreignCurrencyName = 'BAHT';

  @override
  Widget build(BuildContext context) {
    const double small = 8.0, medium = 12.0, large = 18.0, xlarge = 24.0;
    var normalText = TextStyle(fontSize: 16, color: Colors.amber[900]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Currency Conversion"),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: AdSize.fullBanner.height.toDouble(),
              //   width: AdSize.fullBanner.width.toDouble(),
              //   child: AdWidget(ad: fullBanner),
              // ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Local'),
                  Switch(
                      value: _currencySwitch,
                      onChanged: (val) {
                        setState(() {
                          val
                              ? currencyType = 'PGK'
                              : currencyType = _foreignCurrencyName;
                          _currencySwitch = val;
                        });
                      }),
                  const Text('Foreign'),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(large, 0, large, 0),
                      child: Center(
                        child: TextField(
                          // controller: _currencyInputController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'amount to convert',
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            // if (RegExp(r'^[0-9]+$').hasMatch(value)) {
                            if (_currencySwitch) {
                              setState(() {
                                _usd = double.parse(value) / forexc;
                                _convertedCurrency = _usd / usd;
                                _local = value;
                              });
                            } else {
                              setState(() {
                                _usd = double.parse(value) * forexc;
                                _convertedCurrency = _usd * usd;
                                _local = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: medium),
                    Text(
                      'how much are you trying to convert?',
                      style: TextStyle(color: Colors.amber[900]),
                    ),
                    const SizedBox(height: xlarge),
                    Text(
                      '$currencyType ${_convertedCurrency != null ? _convertedCurrency.toStringAsFixed(2) : '0.0'}',
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: large),
                    Text(
                      "USD ${_usd ?? '0.0'}",
                      style: normalText,
                    ),
                    const SizedBox(height: large),
                    Text("Conversion Rates Used",
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: medium),
                    Text(
                      "USD: $usd",
                      style: normalText,
                    ),
                    const SizedBox(height: medium),
                    Text(
                      "Local currency: $forexc",
                      style: normalText,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextButton.icon(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Your modal content here
                        var localNew, usdNew, foreignCurrencyName;
                        return AlertDialog(
                          title: const Text("Settings"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    usdNew = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "USD $usd",
                                ),
                              ),
                              const SizedBox(height: medium),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    localNew = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Local $forexc",
                                ),
                              ),
                              const SizedBox(height: medium),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    foreignCurrencyName = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "$currencyType",
                                ),
                              ),
                              SizedBox(
                                height: AdSize.banner.height.toDouble(),
                                width: AdSize.banner.width.toDouble(),
                                child: AdWidget(ad: banner),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text("Save"),
                              onPressed: () {
                                if (usdNew != null) {
                                  setState(() {
                                    usd = double.parse(usdNew);
                                  });
                                }
                                if (localNew != null) {
                                  setState(() {
                                    forexc = double.parse(localNew);
                                  });
                                }
                                if (foreignCurrencyName != null) {
                                  setState(() {
                                    _foreignCurrencyName = foreignCurrencyName;
                                  });
                                }
                                Navigator.pop(context); // Close the modal
                              },
                            ),
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  label: const Text(
                    "Set Exchange Rates",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      iconColor: MaterialStateProperty.all(Colors.white),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12))),
                ),
              ),
              SizedBox(
                height: AdSize.largeBanner.height.toDouble(),
                width: AdSize.largeBanner.width.toDouble(),
                child: AdWidget(ad: largeBanner),
              ),
            ]),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.currency_exchange), label: "To Local"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.currency_rupee), label: "From Local"),
      //   ],
      //   onTap: (value) => setState(() => bnSelectedItem = value),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // ),
    );
  }
}
