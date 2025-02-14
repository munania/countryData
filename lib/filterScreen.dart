import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final Function(List<String>, List<String>) onFiltersSelected;

  const FilterScreen({super.key, required this.onFiltersSelected});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> selectedContinents = [];
  List<String> selectedTimeZones = [];

  final List<String> continents = [
    'Africa',
    'Antarctica',
    'Asia',
    'Australia',
    'Europe',
    'North America',
    'South America'
  ];

  final List<String> timeZones = [
    'UTC-01:00',
    'UTC-02:00',
    'UTC-03:00',
    'UTC-04:00',
    'UTC-05:00',
    'UTC-06:00',
    'UTC-07:00',
    'UTC-08:00',
  ];

  void _toggleContinent(String continent) {
    setState(() {
      if (selectedContinents.contains(continent)) {
        selectedContinents.remove(continent);
      } else {
        selectedContinents.add(continent);
      }
    });
  }

  void _toggleTimeZone(String timeZone) {
    setState(() {
      if (selectedTimeZones.contains(timeZone)) {
        selectedTimeZones.remove(timeZone);
      } else {
        selectedTimeZones.add(timeZone);
      }
    });
  }

  void _resetFilters() {
    setState(() {
      selectedContinents.clear();
      selectedTimeZones.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Advanced Filter',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('Sort by Continents',
              style: TextStyle(fontWeight: FontWeight.w500)),
          Wrap(
            spacing: 8,
            children: continents
                .map((continent) => FilterChip(
                      selected: selectedContinents.contains(continent),
                      label: Text(continent),
                      onSelected: (_) => _toggleContinent(continent),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Text('Sort by Time Zones',
              style: TextStyle(fontWeight: FontWeight.w500)),
          Wrap(
            spacing: 8,
            children: timeZones
                .map((zone) => FilterChip(
                      selected: selectedTimeZones.contains(zone),
                      label: Text(zone),
                      onSelected: (_) => _toggleTimeZone(zone),
                    ))
                .toList(),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onFiltersSelected(
                        selectedContinents, selectedTimeZones);
                    Navigator.pop(context);
                  },
                  child: const Text('Show results'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
