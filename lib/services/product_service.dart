import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductService {

  static const String baseUrl =
      "http://10.248.129.139:8080/api/products";

  static Future<ProductModel?> getProduct(
      String barcode) async {

    final url =
        "$baseUrl/barcode/$barcode";

    print("URL => $url");

    final response = await http.get(
      Uri.parse(url),
    );

    print(
        "STATUS => ${response.statusCode}");

    print(
        "BODY => ${response.body}");

    if (response.statusCode == 200) {

      final data =
      jsonDecode(response.body);

      return ProductModel.fromJson(data);
    }

    return null;
  }
}
