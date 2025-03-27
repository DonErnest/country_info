import 'package:country_info/models/country_data.dart';
import 'package:country_info/widgets/canvas.dart';
import 'package:country_info/widgets/country_search.dart';
import 'package:country_info/widgets/country_tile.dart';
import 'package:flutter/material.dart';


class CountriesList extends StatelessWidget {
  final bool? isFetching;
  final List<CountryData>? countries;
  final String? fetchedError;

  const CountriesList({super.key, this.isFetching, required this.countries, this.fetchedError});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget? mainWidget;

    if (fetchedError != null) {
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
        itemBuilder:
            (ctx, idx) => CountryTile(country: countries![idx]),
        itemCount: countries!.length,
      );
    }
    return ScreenCanvas(
      widgets: [
        Expanded(
          flex: 1,
          child: CountrySearch(),
        ),
        isFetching != null && isFetching!
            ? Center(child: CircularProgressIndicator())
            : Expanded(
          flex: 5,
          child: mainWidget
        ),
      ],
    );
  }
}
