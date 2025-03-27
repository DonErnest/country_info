import 'package:country_info/models/country_data.dart';
import 'package:country_info/widgets/country_card.dart';
import 'package:country_info/widgets/country_search.dart';
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
    if (fetchedError != null) {
      countryWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          fetchedError!,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      );
    }
    if (country != null) {
      countryWidget = CountryCard(
        country: country,
        borderingCountriesNames: borderingCountries,
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Country info")),
        body: Center(
          child: Column(
            children: [
              CountrySearch(
                setCountry: displayCountryInfo,
                setBorderCountries: displayDisplayCountriesInfo,
                dataFetched: dataFetched,
                errorRaised: errorRaised,
                searchingCountry: fetchingData,
              ),
              isFetching != null && isFetching!
                  ? Center(child: CircularProgressIndicator())
                  : countryWidget,
            ],
          ),
        ),
      ),
    );
  }
}
