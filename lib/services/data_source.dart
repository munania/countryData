import 'dart:convert';

import 'package:http/http.dart' as http;

import '../resources/country.dart';

class CountryService {
  static const String baseUrl = 'https://restcountries.com/v3.1';

  Future<List<Country>> getAllCountries() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/all'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}
