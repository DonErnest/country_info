import 'package:country_info/models/country_data.dart';
import 'package:country_info/screens/countries_list.dart';
import 'package:country_info/services/country.dart';
import 'package:country_info/widgets/country_card.dart';
import 'package:country_info/widgets/country_search.dart';
import 'package:country_info/widgets/country_tile.dart';
import 'package:flutter/material.dart';

class CountryInformator extends StatefulWidget {
  const CountryInformator({super.key});

  @override
  State<CountryInformator> createState() => _CountryInformatorState();
}

class _CountryInformatorState extends State<CountryInformator> {
  CountryData? country;
  List<String>? borderingCountries;

  @override
  void initState() {
    super.initState();
  }

  displayCountryInfo(CountryData? selectedCountry) {
    setState(() {
      country = selectedCountry;
    });
  }

  displayDisplayCountriesInfo(List<String>? foundCountries) {
    setState(() {
      borderingCountries = foundCountries;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget countryWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text("no country has been found"),
    );

    if (country != null) {
      countryWidget = CountryCard(
        country: country,
        borderingCountriesNames: borderingCountries,
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Country info")),
        body: CountriesList(
          displayCountry: displayCountryInfo,
        ),
      ),
    );
  }
}
