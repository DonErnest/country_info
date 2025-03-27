import 'package:country_info/models/country_data.dart';
import 'package:country_info/screens/country_detail.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  final CountryData country;

  const CountryTile({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(country.name),
        trailing: Text(country.emojiFlag),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => CountryDetail(country: country),
            ),
          );
        },
      ),
    );
  }
}
