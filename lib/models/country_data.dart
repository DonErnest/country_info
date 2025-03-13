class CountryData {
  final String name;
  final String capital;
  final String region;
  final double area;

  final double population;
  final String flag;

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      name: json['name'],
      capital: json['capital'],
      region: json['region'],
      area: json['area'],
      population: json['population'] ,
      flag: json['flags']['png'],
    );
  }

  const CountryData({
    required this.name,
    required this.capital,
    required this.region,
    required this.area,
    required this.population,
    required this.flag,
  });
}
