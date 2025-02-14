import 'package:carousel_slider/carousel_slider.dart';
import 'package:countrydata/resources/country.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryDetails extends StatelessWidget {
  final Country country;

  const CountryDetails({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    List<String?> images = [
      country.flags.png,
      country.coatOfArms.png,
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(country.name.common),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag and basic info section
            CarouselSlider(
              items: images
                  .where((item) => item != null)
                  .map(
                    (item) => Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          repeat: ImageRepeat.noRepeat,
                          image: NetworkImage(item!),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Official name
                  Text(
                    country.name.official,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),

                  // Basic Information
                  _buildSection(
                    context,
                    'Basic Information',
                    [
                      _buildInfoRow('Capital', country.capital.join(', ')),
                      _buildInfoRow('Region', country.region),
                      _buildInfoRow(
                          'Population', _formatNumber(country.population)),
                      _buildInfoRow(
                          'Area', '${_formatNumber(country.area.toInt())} km²'),
                      _buildInfoRow(
                          'Languages', country.languages.values.join(', ')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Geography
                  _buildSection(
                    context,
                    'Geography',
                    [
                      _buildInfoRow('Continent', country.continents.join(', ')),
                      _buildInfoRow(
                          'Landlocked', country.landlocked ? 'Yes' : 'No'),
                      _buildInfoRow(
                        'Coordinates',
                        '${country.latlng[0]}°, ${country.latlng[1]}°',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Additional Information
                  _buildSection(
                    context,
                    'Additional Information',
                    [
                      _buildInfoRow('Start of Week', country.startOfWeek),
                      _buildInfoRow('Timezones', country.timezones.join(', ')),
                      if (country.tld.isNotEmpty)
                        _buildInfoRow(
                            'Top Level Domain', country.tld.join(', ')),
                      _buildInfoRow('Driving Side', country.car.side),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Currency Information
                  if (country.currencies.isNotEmpty)
                    _buildSection(
                      context,
                      'Currency',
                      country.currencies.entries.map((currency) {
                        return _buildInfoRow(
                          currency.key,
                          '${currency.value.name} (${currency.value.symbol})',
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 20),

                  // Maps
                  _buildSection(
                    context,
                    'Maps',
                    [
                      _buildInfoRow(
                          'Lat and Lng', country.capitalInfo.latlng.join(', ')),
                      SizedBox(height: 10),
                      _buildLinkButton(
                        context,
                        'Open in Google Maps',
                        country.maps.googleMaps,
                      ),
                      const SizedBox(height: 8),
                      _buildLinkButton(
                        context,
                        'Open in OpenStreetMap',
                        country.maps.openStreetMaps,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(BuildContext context, String label, String url) {
    return ElevatedButton.icon(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      },
      icon: const Icon(Icons.map),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
