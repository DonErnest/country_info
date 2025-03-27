import 'package:country_info/models/country_data.dart';
import 'package:country_info/widgets/canvas.dart';
import 'package:country_info/widgets/country_card.dart';
import 'package:flutter/material.dart';

class CountryDetail extends StatelessWidget {
  final CountryData country;
  final List<String>? borderingCountriesNames;
  const CountryDetail({super.key, required this.country, this.borderingCountriesNames});

  @override
  Widget build(BuildContext context) {
    return ScreenCanvas(widgets: [CountryCard(country: country)]);
  }
}
