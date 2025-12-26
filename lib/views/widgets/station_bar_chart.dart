import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../viewmodels/dto/estacion_ui_data.dart';

class StationBarChart extends StatelessWidget {
  final List<EstacionUiData> stations;
  final ValueChanged<EstacionUiData> onStationTap;

  const StationBarChart({
    super.key,
    required this.stations,
    required this.onStationTap,
  });

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top 5 estaciones por número de bicis',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  groupsSpace: 16,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      if (event is FlTapUpEvent && response?.spot != null) {
                        onStationTap(
                          stations[
                            response!.spot!.touchedBarGroupIndex
                          ],
                        );
                      }
                    },
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: _titles(theme),
                  barGroups: _bars(),
                ),
              ),
            ),

            const SizedBox(height: 16),
            _legend(theme),
          ],
        ),
      ),
    );
  }

  FlTitlesData _titles(ThemeData theme) {
    return FlTitlesData(
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          reservedSize: 72,
          getTitlesWidget: (value, meta) {
            final i = value.toInt();
            if (i < 0 || i >= stations.length) {
              return const SizedBox.shrink();
            }

            final s = stations[i];

            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 68,
                    child: Text(
                      s.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.totalBikes.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> _bars() {
    return List.generate(stations.length, (i) {
      final s = stations[i];
      final manual = s.bikes;
      final electric = s.ebikes + s.boost;
      final total = manual + electric;

      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: total.toDouble(),
            width: 28,
            rodStackItems: [
              BarChartRodStackItem(0, manual.toDouble(), Colors.blue),
              BarChartRodStackItem(
                manual.toDouble(),
                total.toDouble(),
                Colors.green,
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _legend(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(
          color: Colors.blue,
          text: 'Manual',
          textStyle: theme.textTheme.bodySmall,
        ),
        const SizedBox(width: 24),
        _LegendItem(
          color: Colors.green,
          text: 'Eléctrica',
          textStyle: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}


class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final TextStyle? textStyle;

  const _LegendItem({
    required this.color,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: textStyle),
      ],
    );
  }
}
