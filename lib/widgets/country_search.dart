import 'dart:convert';

import 'package:country_info/models/country_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CountrySearch extends StatefulWidget {
  final void Function(CountryData? country) setCountry;

  const CountrySearch({super.key, required this.setCountry});

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  var searchController = TextEditingController();
  String? searchedCountyName;

  Future<dynamic> searchCountry(String countryName) async {
    final uri = Uri.parse('https://restcountries.com/v3.1/name/${countryName}');
    final response = await get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    }
    return null;
  }

  Future<void> search() async {
    if (searchedCountyName != null) {
      final rawData = await searchCountry(searchedCountyName!);
      if (rawData != null && rawData.length != 0) {
        final countries =
            rawData
                .map(
                  (json) => CountryData(
                    name: json["name"]["common"],
                    capital: json["capital"][0],
                    region: json["region"],
                    area: json["area"],
                    population: json["population"] / 1000,
                    flag: json["flags"]["png"],
                  ),
                )
                .toList();

      };
      widget.setCountry(null);
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
