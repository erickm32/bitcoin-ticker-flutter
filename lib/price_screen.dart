import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = 'USD';
  CoinData coinData = CoinData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: FutureBuilder(
        future: coinData.getCoinDataFor(selectedValue),
        builder: (context, snapshot) {
          List<Map<String, double>> exchangeData = [];
          if (snapshot.hasData) {
            exchangeData = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${exchangeData[0].keys.first} = ${exchangeData[0].values.first.toStringAsFixed(2)} $selectedValue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${exchangeData[1].keys.first} = ${exchangeData[1].values.first.toStringAsFixed(2)} $selectedValue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ${exchangeData[2].keys.first} = ${exchangeData[2].values.first.toStringAsFixed(2)} $selectedValue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  color: Colors.lightBlue,
                  child: getCurrencySelector(),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                'No more API requests left :(',
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget getCurrencySelector() {
    return Platform.isAndroid ? androidPicker() : iosPicker();
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> currencies = currenciesList
        .map(
          (currency) => DropdownMenuItem(
            child: Text(currency),
            value: currency,
          ),
        )
        .toList();

    return DropdownButton<String>(
      value: selectedValue,
      items: currencies,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
          // coinData.getCoinDataFor(selectedValue);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> currencies = currenciesList.map((currency) => Text(currency)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
      },
      children: currencies,
    );
  }

  List<Widget> cardsWithPadding(List<Map<String, double>> exchangeData) {
    return exchangeData.map((Map<String, double> data) {
      return Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 ${exchangeData[0]} = ${data[selectedValue]} $selectedValue',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
