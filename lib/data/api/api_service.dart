import 'dart:convert';
import 'package:flutter_assignment/data/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String endPoint = "/content/dam/global-tcs/en/worldwide-json/worldwide-map-5-12.json";

  Future<dynamic> getData() async {
    try {
      final response = await http.get(Uri.parse('$baseURL$endPoint'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      rethrow;
    }
  }
}
