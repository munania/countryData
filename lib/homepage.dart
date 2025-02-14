import 'package:countrydata/country_details.dart';
import 'package:countrydata/filterScreen.dart';
import 'package:countrydata/resources/country.dart';
import 'package:countrydata/services/data_source.dart';
import 'package:countrydata/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final CountryService _countryService = CountryService();

  List<String> selectedContinents = [];
  List<Country> filteredCountries = [];
  List<String> selectedTimeZones = [];
  List<Country> countries = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Load countries and list them alphabetically
  Future<void> _loadCountries() async {
    try {
      final result = await _countryService.getAllCountries();
      // Sort countries alphabetically
      result.sort((a, b) => a.name.common.compareTo(b.name.common));

      setState(() {
        countries = result;
        filteredCountries =
            result; // Initialize filtered list with all countries
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading countries: $e')),
        );
      }
    }
  }

  // Filter countries using input string in search bar
  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCountries = List.from(countries);
      } else {
        filteredCountries = countries
            .where((country) =>
                country.name.common.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // open bottom sheet for more advanced filtering options
  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterScreen(
        onFiltersSelected: (continents, timeZones) {
          setState(() {
            selectedContinents = continents;
            selectedTimeZones = timeZones;
            _applyFilters();
          });
        },
      ),
    );
  }

  // Apply filters selected in the bottom sheet
  void _applyFilters() {
    filteredCountries = countries.where((country) {
      final meetsContinent = selectedContinents.isEmpty ||
          selectedContinents.contains(country.region);
      final meetsTimeZone = selectedTimeZones.isEmpty ||
          selectedTimeZones.any((zone) => country.timezones.contains(zone));
      return meetsContinent && meetsTimeZone;
    }).toList();

    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      filteredCountries = filteredCountries
          .where((country) => country.name.common
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore.',
          style: TextStyle(
            fontSize: 24,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: IconButton(
              icon: Icon(
                context.watch<ThemeProvider>().isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search countries...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                // Clear button
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterCountries('');
                        },
                      )
                    : null,
              ),
              onChanged: _filterCountries,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(width: 10),
                      Text('EN')
                    ],
                  ),
                  InkWell(
                    onTap: _openBottomSheet,
                    child: Row(
                      children: [
                        Icon(Icons.filter_alt),
                        SizedBox(width: 10),
                        Text('Filter')
                      ],
                    ),
                  ),
                ],
              )),
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Found ${filteredCountries.length} countries',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          // Country List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredCountries.isEmpty
                    ? const Center(
                        child: Text('No countries found'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  country.flags.png,
                                  width: 70,
                                  height: 70,
                                  cacheWidth: 70,
                                  cacheHeight: 70,
                                  fit: BoxFit.fitHeight,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.flag),
                                ),
                              ),
                              title: Text(
                                country.name.common,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Capital: ${country.capital.join(", ")}'),
                                  Text('Region: ${country.region}'),
                                  Text(
                                    'Population: ${country.population.toString().replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},',
                                        )}',
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CountryDetails(country: country)));
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
