import 'package:fl_chart/fl_chart.dart';
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
              
              SizedBox(
                height: 180,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                    sections: [
                      _section(
                        value: station.bikes.toDouble(),
                        color: Colors.blue,
                        title: 'Bicis',
                      ),
                      _section(
                        value: station.ebikes.toDouble(),
                        color: Colors.green,
                        title: 'E-Bikes',
                      ),
                      _section(
                        value: station.numDocksAvailable.toDouble(),
                        color: Colors.grey,
                        title: 'Libres ',
                      ),
                      _section(
                        value: station.numDocksDisabled.toDouble(),
                        color: Colors.red,
                        title: 'Bloq.',
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 12),

              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.pedal_bike, color: Colors.blue),
                      const SizedBox(height: 4),
                      Text(
                        station.bikes.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Bicis'),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.electric_bike, color: Colors.green),
                      const SizedBox(height: 4),
                      Text(
                        station.ebikes.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('E-Bikes'),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.local_parking, color: Colors.grey),
                      const SizedBox(height: 4),
                      Text(
                        station.numDocksAvailable.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Libres'),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.block, color: Colors.red),
                      const SizedBox(height: 4),
                      Text(
                        station.numDocksDisabled.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text('Bloq.'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PieChartSectionData _section({
    required double value,
    required Color color,
    required String title,
  }) {
    return PieChartSectionData(
      value: value,
      color: color,
      radius: 45,
      title: value == 0 ? '' : title,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}