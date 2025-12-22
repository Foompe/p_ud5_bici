import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../viewmodels/dto/estacion_ui_data.dart';

class StationPdfExporter {
  static Future<void> exportStationDetail(
    EstacionUiData station,
  ) async {
    final doc = pw.Document();
    final now = DateTime.now();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // TÍTULO
              pw.Text(
                'Informe de estación',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 16),

              // DATOS ESTÁTICOS
              pw.Text(
                'Datos de la estación',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              _row('Nombre', station.name),
              _row('Dirección', station.address),
              _row(
                'Tipo',
                station.isElectricStation
                    ? 'Estación eléctrica'
                    : 'Estación normal',
              ),
              _row('Capacidad', station.capacity.toString()),

              pw.SizedBox(height: 16),

              // ESTADO ACTUAL
              pw.Text(
                'Estado actual',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              _row(
                'Estado',
                station.isInService ? 'Activa' : 'Inactiva',
              ),
              _row(
                'Bicis disponibles',
                station.totalBikes.toString(),
              ),
              _row(
                'E-bikes',
                station.ebikes.toString(),
              ),
              _row(
                'Ocupación',
                '${station.occupancyPercent.toStringAsFixed(0)}%',
              ),

              pw.SizedBox(height: 16),

              // FECHAS
              pw.Text(
                'Fechas',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              _row(
                'Última actualización',
                station.lastUpdatedFormatted,
              ),
              _row(
                'Generado el',
                _formatDateTime(now),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => doc.save(),
    );
  }

  // ───────── Helpers ─────────

  static pw.Widget _row(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 140,
            child: pw.Text(
              '$label:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }

  static String _formatDateTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}:'
        '${dt.second.toString().padLeft(2, '0')}';
  }
}
