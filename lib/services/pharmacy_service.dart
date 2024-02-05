import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_in_pharmacy/modules/product.dart';

class Pharmacy {
  // Future<dynamic> login() async {
  //   Uri uri = Uri.https('maher-tba-search-in-pharmacy.hf.space', '/getUsers');

  //   final response = await http.get(uri, headers: {
  //   'Content-Type': 'application/json'
  // });
  //   if (response.statusCode == 200) {
  //     dynamic data = json.decode(utf8.decode(response.body.codeUnits));
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<List<Product>> getProducts() async {
    Uri uri =
        Uri.https('maher-tba-search-in-pharmacy.hf.space', '/getProducts');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic data =
          json.decode(utf8.decode(response.body.codeUnits))["products"];

      List<Product> products = [];
      for (var item in data) {
        products.add(Product.fromJson(item));
      }
      return products;
    } else {
      return [];
    }
  }
}
