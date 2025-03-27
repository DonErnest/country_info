import 'package:country_info/models/country_data.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final CountryData? country;
  final List<String>? borderingCountriesNames;

  const CountryCard({
    super.key,
    required this.country,
    this.borderingCountriesNames,
  });

  @override
  Widget build(BuildContext context) {
    var borderingCountriesMessage = "Could not retrieve data";
    print(borderingCountriesNames);
    if (borderingCountriesNames != null ) {
      if (borderingCountriesNames!.isNotEmpty) {
        borderingCountriesMessage = borderingCountriesNames!.join("\n");
      } else if (borderingCountriesNames!.isEmpty) {
        borderingCountriesMessage = "No neighbors";
      }
    }
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.flag),
            title: Text(country!.name),
            subtitle: Column(
              children: [
                Image.network(country!.flag),
                Divider(),
                Row(
                  children: [Text("Region:"), Spacer(), Text(country!.region)],
                ),
                Row(
                  children: [
                    Text("Capital:"),
                    Spacer(),
                    Text(country!.capital),
                  ],
                ),
                Row(
                  children: [
                    Text("Area(km square):"),
                    Spacer(),
                    Text(country!.area.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Population(mln):"),
                    Spacer(),
                    Text(country!.population.toString()),
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text("Borders with:"),
                    Spacer(),
                    Text(
                      textAlign: TextAlign.right,
                      borderingCountriesMessage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
