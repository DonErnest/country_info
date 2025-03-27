import 'package:country_info/models/country_data.dart';
import 'package:country_info/widgets/canvas.dart';
import 'package:country_info/widgets/country_search.dart';
import 'package:country_info/widgets/country_tile.dart';
import 'package:flutter/material.dart';

import '../services/country.dart';

class CountriesList extends StatefulWidget {
  final void Function(CountryData country) displayCountry;

  const CountriesList({
    super.key,
    required this.displayCountry,
  });

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  bool isFetching = true;
  String? fetchedError;

  List<CountryData>? countries;

  @override
  void initState() {
    super.initState();
    downloadCountries();
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


  Future<void> downloadCountries() async {
    final downloadedCountries = await getCountriesList(errorRaised);
    setState(() {
      countries = downloadedCountries;
    });
    dataFetched();
  }

  void searchInCountries(String countryName) {
    var country = getCountryByName(countryName, countries!);
    if (country != null) {
      widget.displayCountry(country);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget? mainWidget;

    if (isFetching) {
      mainWidget = Center(child: CircularProgressIndicator());
    } else if (fetchedError != null) {
      mainWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          fetchedError!,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      );
    } else {
      mainWidget = ListView.builder(
        itemBuilder: (ctx, idx) => CountryTile(country: countries![idx]),
        itemCount: countries!.length,
      );
    }
    return ScreenCanvas(
      widgets: [
        Expanded(flex: 1, child: CountrySearch(onCountrySearch: searchInCountries,)),
        Expanded(flex: 5, child: mainWidget),
      ],
    );
  }
}
