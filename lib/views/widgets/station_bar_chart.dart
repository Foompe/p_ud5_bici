import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:p_ud5_bici/views/screens/estacion_detail_screen.dart';
import '../../viewmodels/dto/estacion_ui_data.dart';

class StationBarChart extends StatelessWidget {
  final List<EstacionUiData> stations;

  const StationBarChart({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return const SizedBox.shrink();
    }

    final topStations = List<EstacionUiData>.from(stations)
      ..sort((a, b) => b.totalBikes.compareTo(a.totalBikes))
      ..removeRange(5, stations.length > 5 ? stations.length : 5);

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

            //Gráfico
            SizedBox(
              height: 320,
              child: BarChart(
                BarChartData(
                  groupsSpace: 16,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      if (event is FlTapUpEvent && response?.spot != null) {
                        final index = response!.spot!.touchedBarGroupIndex;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StationDetailScreen(
                              station: topStations[index],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
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
                          if (i < 0 || i >= topStations.length) {
                            return const SizedBox.shrink();
                          }

                          final station = topStations[i];

                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 68,
                                    child: Text(
                                      station.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Center(
                                  child: SizedBox(
                                    width: 68,
                                    child: Text(
                                      station.totalBikes.toString(),
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(topStations.length, (index) {
                    final s = topStations[index];
                    final manual = s.bikes;
                    final electric = s.ebikes + s.boost;
                    final total = manual + electric;

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: total.toDouble(),
                          width: 28,
                          rodStackItems: [
                            BarChartRodStackItem(
                              0,
                              manual.toDouble(),
                              Colors.blue,
                            ),
                            BarChartRodStackItem(
                              manual.toDouble(),
                              total.toDouble(),
                              Colors.green,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 16),

            //Leyenda
            Row(
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
            ),
          ],
        ),
      ),
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
