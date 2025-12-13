import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/estacion_ui_data.dart';

class StationDetailSheet extends StatelessWidget {
  final StationUiData station;

  const StationDetailSheet({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                station.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(station.address),
              const Divider(),
              Text('Estado: ${station.status}'),
              Text('Actualizado: ${station.lastUpdatedFormatted}'),
              const SizedBox(height: 8),
              Text('Bicis: ${station.totalBikes}'),
              Text('E-bikes: ${station.ebikes}'),
              Text('Boost: ${station.boost}'),
              Text('Anclajes libres: ${station.numDocksAvailable}'),
              const SizedBox(height: 12),
              Text(
                '¿Me compensa bajar ahora? ${station.decisionText}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
