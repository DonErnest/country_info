import 'dart:convert';

import 'package:country_info/models/country_data.dart';
import 'package:country_info/widgets/country_card.dart';
import 'package:country_info/widgets/country_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class CountryInformator extends StatefulWidget {
  const CountryInformator({super.key});

  @override
  State<CountryInformator> createState() => _CountryInformatorState();
}

class _CountryInformatorState extends State<CountryInformator> {
  var searchController = TextEditingController();
  String? searchedCountyName;

  CountryData? country;

  @override
  void initState() {
    super.initState();
  }

  displayCountryInfo(CountryData? selectedCountry) {
    setState(() {
      country = selectedCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget countryWidget = Text("no country has been found");
    if (country != null) {
      countryWidget = CountryCard(country: country);
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Country info")),
        body: Center(
          child: Column(
            children: [
              CountrySearch(setCountry: displayCountryInfo),
              countryWidget,
            ],
          ),
        ),
      ),
    );
  }
}
