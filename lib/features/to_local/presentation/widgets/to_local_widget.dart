import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToLocalWidget extends StatefulWidget {
  const ToLocalWidget({super.key});

  @override
  State<ToLocalWidget> createState() => _ToLocalWidgetState();
}

class _ToLocalWidgetState extends State<ToLocalWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  double small = 8.0, medium = 12.0, large = 18.0, xlarge = 24.0;
  double usd = 0.2234;
  double forexc = 33.02;
  var currency;
  var _convertedCurrency;
  var _usd;
  var _local;

  widgetContainer() {
    return Column(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(large, 0, large, 0),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {
                      _usd = int.parse(value) / forexc;
                      _convertedCurrency = _usd / usd;
                      _local = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: medium),
            const Text('how much are you trying to convert?'),
            SizedBox(height: xlarge),
            Text(
              'PGK ${_convertedCurrency != null ? _convertedCurrency.toStringAsFixed(2) : '0.0'}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: large),
            Text("USD ${_usd ?? '0.0'}"),
            SizedBox(height: large),
            Text("Conversion Rates Used",
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: medium),
            Text("USD: $usd"),
            SizedBox(height: medium),
            Text("Local currency: $forexc"),
          ],
        ),
      ),
      // banner,
      Padding(
        padding: const EdgeInsets.all(12),
        child: TextButton.icon(
          icon: const Icon(Icons.settings),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // Your modal content here
                var localNew, usdNew;
                return AlertDialog(
                  title: const Text("Set Exchange Rates"),
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
                          labelText: "USD currently $usd",
                        ),
                      ),
                      SizedBox(height: medium),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            localNew = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Local Currency currently $forexc",
                        ),
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
                            // print("local $_localNew");
                            forexc = double.parse(localNew);
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
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              iconColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(18))),
        ),
      )
    ]);
  }

  void setExchangeRates(usd, forexc) {
    setState(() {
      usd = usd;
      forexc = forexc;
    });
  }
}
