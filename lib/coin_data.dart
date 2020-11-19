import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const COIN_API_KEY = 'EDA6AB7D-95F3-4E3E-9DE6-8DE4B73F8189';
const BASE_COIN_API_URL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Map<String, Map<String, double>> currenciesData = {};

  CoinData() {
    for (String cryptoCurrency in cryptoList) {
      currenciesData[cryptoCurrency] = {};
    }
  }

  String _requestUrl(String cryptoCurrency, String currency) {
    return '$BASE_COIN_API_URL/$cryptoCurrency/$currency?apikey=$COIN_API_KEY';
  }

  Future<void> _fetchData(String currency) async {
    double exchangeRate = 0.0;
    for (String cryptoCurrency in cryptoList) {
      if (currenciesData[cryptoCurrency][currency] == null) {
        http.Response response = await http.get(_requestUrl(cryptoCurrency, currency));
        var fetchedData = await JsonDecoder().convert(response.body);
        print(fetchedData);
        if (fetchedData != null) {
          exchangeRate = fetchedData['rate'].toDouble();
        } else {
          debugger(message: 'fetchedData is null');
        }
        currenciesData[cryptoCurrency][currency] = exchangeRate;
      }
    }
    return;
  }

  Future<List<Map<String, double>>> getCoinDataFor(String currency) async {
    List<Map<String, double>> data = [];

    await _fetchData(currency);
    for (String cryptoCurrency in cryptoList) {
      print('on getCointDataFor');
      print(currenciesData[cryptoCurrency][currency]);
      var coinData = currenciesData[cryptoCurrency][currency];
      data.add({cryptoCurrency: coinData != null ? coinData : 0.0});
    }

    return data;
  }
}
