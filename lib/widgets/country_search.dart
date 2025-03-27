import 'package:flutter/material.dart';

class CountrySearch extends StatefulWidget {
  final void Function(String countryName) onCountrySearch;
  
  const CountrySearch({super.key, required this.onCountrySearch});

  @override
  State<CountrySearch> createState() => _CountrySearchState();
}

class _CountrySearchState extends State<CountrySearch> {
  var searchController = TextEditingController();
  String? searchedCountryName;

  Future<void> search() async {
    if (searchedCountryName != null) {
      widget.onCountrySearch(searchedCountryName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: searchController,
              maxLines: 1,
              keyboardType: TextInputType.text,
              onChanged: (value) => setState(() => searchedCountryName = value),
              decoration: const InputDecoration(
                label: Text("Enter country name"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(onPressed: search, icon: Icon(Icons.search)),
          ),
        ],
      ),
    );
  }
}
