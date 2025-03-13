import 'dart:convert';

import 'package:country_info/models/country_data.dart';
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

  Future<dynamic> searchCountry(String countryName) async {
    final uri = Uri.parse('https://restcountries.com/v3.1/name/${countryName}');
    final response = await get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData;
    }
    return null;
  }

  Future<void> search() async {
    if (searchedCountyName != null) {
      final rawData = await searchCountry(searchedCountyName!);
      final countries = rawData.map(
            (json) => CountryData(
          name: json["name"]["common"],
          capital: json["capital"][0],
          region: json["region"],
          area: json["area"],
          population: json["population"] / 1000,
          flag: json["flags"]["png"],
        ),
      ).toList();
      print(countries.first.flag);
      setState(() {
        country = countries.first;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget countryWidget = Text("no country has been found");
    if (country != null) {
      countryWidget = Card(
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Country info")),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: searchController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged:
                          (value) => setState(() => searchedCountyName = value),
                      decoration: const InputDecoration(
                        label: Text("Enter country name"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: search,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
              countryWidget,
            ],
          ),
        ),
      ),
    );
  }
}
