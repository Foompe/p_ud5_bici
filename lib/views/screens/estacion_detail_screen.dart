import 'package:flutter/material.dart';
import 'package:p_ud5_bici/services/estacion_pdf_exporter.dart';
import 'package:p_ud5_bici/viewmodels/dto/estacion_ui_data.dart';
import 'package:p_ud5_bici/views/widgets/grafico_ocupacion_estacion.dart';

class StationDetailScreen extends StatelessWidget {
  final EstacionUiData station;

  const StationDetailScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Estado estación
    final statusColor = station.isInService ? Colors.green : Colors.red;
    final statusText = station.isInService ? 'Activa' : 'Inactiva';

    // Color decisión
    final decisionColor = station.decisionText == 'Sí'
        ? Colors.green.shade100
        : station.decisionText == 'Quizá'
        ? Colors.orange.shade100
        : Colors.red.shade100;

    return Scaffold(
      appBar: AppBar(title: Text(station.name)),

      //Botón exportación a pdf
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          StationPdfExporter.exportStationDetail(station);
        },
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text('Exportar PDF'),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(station.address, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          station.isElectricStation
                              ? Icons.flash_on
                              : Icons.pedal_bike,
                          size: station.isElectricStation
                              ? 20
                              : 16, //Ajustamos el tamaño según el icono
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          station.isElectricStation
                              ? 'Estación eléctrica'
                              : 'Estación normal',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Chip(
                      avatar: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      label: Text(statusText),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Última actualización',
                          style: theme.textTheme.labelSmall,
                        ),
                        Text(
                          station.lastUpdatedFormatted,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            //Gráfico
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Ocupación actual',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    '${station.occupancyPercent.toStringAsFixed(0)}%',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Center(
              child: GraficoOcupacionEstacion(
                station: station,
                chartHeight: 220,
              ),
            ),

            const SizedBox(height: 32),

            //Mostar si bajar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                color: decisionColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                '¿Me compensa bajar ahora?\n'
                '${station.decisionText}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
