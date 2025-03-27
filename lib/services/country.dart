import 'package:country_info/api.dart';
import 'package:country_info/models/country_data.dart';

Future<List<CountryData>> getCountriesList(
  Function(String error) errorCatcher,
) async {
  final rawData = await getCountries(errorCatcher);
  if (rawData != null && rawData.length != 0) {
    return List<CountryData>.from(
      rawData.map((json) => CountryData.fromJson(json)).toList(),
    );
  }
  return [];
}

CountryData? getCountryByName(String countryName, List<CountryData> countries) {
  return countries.firstWhere(
    (country) =>
        country.name.toLowerCase().trim() == countryName.toLowerCase().trim(),
  );
}
