import 'package:country_info/models/country_data.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    super.key,
    required this.country,
  });

  final CountryData? country;

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Text("Region:"),
                    Spacer(),
                    Text(country!.region),
                  ],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
