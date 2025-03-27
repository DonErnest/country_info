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
  var searchController = TextEditingController();
  String? searchedCountyName;
  bool? isFetching;
  String? fetchedError;

  List<CountryData>? countries;

  CountryData? country;
  List<String>? borderingCountries;

  @override
  void initState() {
    super.initState();
    downloadCountries();
  }

  Future<void> downloadCountries() async {
    fetchingData();
    final downloadedCountries = await getCountriesList(errorRaised);
    setState(() {
      countries = downloadedCountries;
    });
    dataFetched();
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

  void fetchingData() {
    setState(() {
      isFetching = true;
    });
  }

  void dataFetched() {
    setState(() {
      isFetching = false;
    });
  }

  void errorRaised(String error) {
    setState(() {
      fetchedError = error;
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
            countries: countries, fetchedError: fetchedError,
        ),
      ),
    );
  }
}
