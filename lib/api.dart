import 'dart:convert';

import 'package:http/http.dart';

final baseUri = "https://restcountries.com/v3.1/";

Future<dynamic> getCountries(Function(String error) errorCatcher) async {
  final uri = Uri.parse("${baseUri}all");
  try {
    final response = await get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    }
  } catch (error) {
    errorCatcher("Network error. Please, try again later or write to the app support");
    return null;
  }
}


Future<dynamic> searchCountry(String countryName, Function(String error) errorCatcher) async {
  final uri = Uri.parse('${baseUri}name/${countryName}');
  try {
    final response = await get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    }
  } catch (error) {
    errorCatcher("Network error. Please, try again later or write to the app support");
    return null;
  }
}


Future<List<String>?> searchBorderCountries(List<String> countryCodes) async {
  final uri = Uri.parse('${baseUri}alpha?codes=${countryCodes.join(",")}');
  try {
    final response = await get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((country) => country["name"]["common"] as String).toList();
    }
  } catch (error) {
    return null;
  }
  return null;
}