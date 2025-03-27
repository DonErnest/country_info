import 'dart:convert';

import 'package:country_info/models/country_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CountrySearch extends StatefulWidget {
  final void Function(CountryData? country) setCountry;
  final void Function(List<String>? names) setBorderCountries;
  final void Function() dataFetched;
  final void Function(String error) errorRaised;
  final void Function() searchingCountry;

  const CountrySearch({super.key, required this.setCountry, required this.dataFetched, required this.errorRaised, required this.setBorderCountries, required this.searchingCountry});

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  var searchController = TextEditingController();
  String? searchedCountyName;

  Future<dynamic> searchCountry(String countryName) async {
    final uri = Uri.parse('https://restcountries.com/v3.1/name/${countryName}');
    try {
      final response = await get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData;
      }
    } catch (error) {
      widget.errorRaised("Network error. Please, try again later or write to the app support");
      return null;
    }
  }

  Future<List<String>?> searchBorderCountries(List<String> countryCodes) async {
    final uri = Uri.parse('https://restcountries.com/v3.1/alpha?codes=${countryCodes.join(",")}');
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

  Future<void> search() async {
    if (searchedCountyName != null) {
      widget.searchingCountry();
      final rawData = await searchCountry(searchedCountyName!);
      if (rawData != null && rawData.length != 0) {
        final countries = rawData.map((json) => CountryData.fromJson(json)).toList();
        var country = countries.first;
        widget.setCountry(country);

        List<String>? borderCountries;
        if (country.borderingCountryCodes != null) {
          if (country.borderingCountryCodes.isNotEmpty) {
            borderCountries = await searchBorderCountries(country.borderingCountryCodes);
          } else if (country.borderingCountryCodes.isEmpty){
            borderCountries = [];
          }
        }
        widget.setBorderCountries(borderCountries);
      } else {
        widget.setCountry(null);
      };
      widget.dataFetched();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: searchController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              onChanged: (value) => setState(() => searchedCountyName = value),
              decoration: const InputDecoration(
                label: Text("Enter country name"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(onPressed: search, icon: Icon(Icons.search)),
          ),
        ],
      ),
    );
  }
}
