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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
                  '1 BTC = ? USD',
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
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> currencies =
        currenciesList.map((currency) => Text(currency)).toList();

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
      },
      children: currencies,
    );
  }
}
