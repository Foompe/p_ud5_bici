import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/dto/estacion_ui_data.dart';

class FavoriteStationCard extends StatelessWidget {
  final StationUiData station;
  final VoidCallback onTap;

  const FavoriteStationCard({
    super.key,
    required this.station,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estación favorita',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                station.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(station.address),
              const SizedBox(height: 8),
              Text('Bicis: ${station.totalBikes}'),
              Text('E-bikes: ${station.ebikes}'),
            ],
          ),
        ),
      ),
    );
  }
}
