import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:timbu_api_task/constants/app_constants.dart';
import 'package:timbu_api_task/models/products.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  String baseUrl = baseApiUrl;
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  List<Products> items = [];

  final queryParameters = {
    "organization_id": apiOrganizationId,
    "Appid": apiAppid,
    "Apikey": apiAppkey,
  };

  getProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await http.get(
          Uri.parse("${baseUrl}products")
              .replace(queryParameters: queryParameters),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        final myProducts = jsonDecode(response.body)["items"];
        for (int i = 0; i < myProducts.length; i++) {
          items.add(Products.fromMap(myProducts[i]));
        }
        _isLoading = false;
        notifyListeners();
      }
      return items;
    } catch (e) {
      print(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }
}
