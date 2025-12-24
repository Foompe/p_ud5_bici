import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:p_ud5_bici/viewmodels/dto/estacion_ui_data.dart';

class GraficoOcupacionEstacion extends StatelessWidget {
  final EstacionUiData station;
  final double chartHeight;

  const GraficoOcupacionEstacion({
    super.key,
    required this.station,
    this.chartHeight = 180,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: chartHeight,
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
                  title: 'Libres',
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
            _StatItem(
              icon: Icons.pedal_bike,
              value: station.bikes,
              label: 'Bicis',
              color: Colors.blue,
              theme: theme,
            ),
            _StatItem(
              icon: Icons.electric_bike,
              value: station.ebikes,
              label: 'E-Bikes',
              color: Colors.green,
              theme: theme,
            ),
            _StatItem(
              icon: Icons.local_parking,
              value: station.numDocksAvailable,
              label: 'Libres',
              color: Colors.grey,
              theme: theme,
            ),
            _StatItem(
              icon: Icons.block,
              value: station.numDocksDisabled,
              label: 'Bloq.',
              color: Colors.red,
              theme: theme,
            ),
          ],
        ),
      ],
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

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int value;
  final String label;
  final Color color;
  final ThemeData theme;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}