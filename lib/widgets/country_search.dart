import 'dart:convert';

import 'package:country_info/api.dart';
import 'package:country_info/models/country_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CountrySearch extends StatefulWidget {

  const CountrySearch({super.key});

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  var searchController = TextEditingController();
  String? searchedCountyName;

  Future<void> search() async {
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
