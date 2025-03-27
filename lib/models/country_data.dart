class CountryData {
  final String name;
  final String capital;
  final String region;
  final double area;

  final double population;
  final String flag;
  final List<String> borderingCountryCodes;

  factory CountryData.fromJson(Map<String, dynamic> json) {
    List<dynamic> countryCodes = json.containsKey("borders")? json["borders"] : [];
    return CountryData(
        name: json["name"]["common"],
        capital: json["capital"][0],
        region: json["region"],
        area: json["area"],
        population: json["population"] / 1000,
        flag: json["flags"]["png"],
        borderingCountryCodes: countryCodes.map((countryCode) => countryCode as String).toList(),
    );
  }

  const CountryData({
    required this.name,
    required this.capital,
    required this.region,
    required this.area,
    required this.population,
    required this.flag,
    required this.borderingCountryCodes,
  });
}
