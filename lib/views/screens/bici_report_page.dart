import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/bici_report_vm.dart';
import 'package:provider/provider.dart';

class BiciReportPage extends StatefulWidget {
  const BiciReportPage({super.key});

  @override
  State<BiciReportPage> createState() => _BiciReportPageState();
}

class _BiciReportPageState extends State<BiciReportPage> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BiciReportVm>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informe Bicis'),
        actions: [
          IconButton(
            tooltip: 'Recargar',
            onPressed: vm.loadEstaciones,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildBody(vm),
      ),
    );
  }

  Widget _buildBody(BiciReportVm vm) {
    if (vm.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(
        child: Text(
          'Error: ${vm.error}',
          textAlign: TextAlign.center,
        ),
      );
    }

    if (vm.eInfo.isEmpty || vm.eStatus.isEmpty) {
      return const Center(child: Text('No hay datos'));
    }

    final info = vm.eInfo.first;
    final status = vm.eStatus.first;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ---------- RESUMEN ----------
          _SummaryBox(
            estacionesEnServicio: vm.estacionesEnServicio,
            totalBicisDisponibles: vm.totalBicisDisponibles,
          ),

          const SizedBox(height: 16),

          // ---------- ESTACION INFO ----------
          const Text(
            'ESTACIÓN INFO (primera)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          _kv('stationId', info.stationId),
          _kv('name', info.name),
          _kv('physicalConfiguration', info.physicalConfiguration),
          _kv('address', info.address),
          _kv('capacity', info.capacity.toString()),

          const Divider(height: 32),

          // ---------- ESTACION ESTADO ----------
          const Text(
            'ESTACIÓN ESTADO (primera)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          _kv('stationId', status.stationId),
          _kv('status', status.status),
          _kv('numBikesAvailable', status.numBikesAvailable.toString()),
          _kv('numBikesDisabled', status.numBikesDisabled.toString()),
          _kv('numDocksAvailable', status.numDocksAvailable.toString()),
          _kv('numDocksDisabled', status.numDocksDisabled.toString()),
          _kv(
            'lastReported',
            status.lastReported?.toIso8601String() ?? 'null',
          ),

          const SizedBox(height: 8),
          const Text(
            'vehicleTypesAvailable:',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          ...status.vehicleTypesAvailable.entries.map(
            (e) => Text('  ${e.key}: ${e.value}'),
          ),
        ],
      ),
    );
  }

  Widget _kv(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$key: $value'),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final int estacionesEnServicio;
  final int totalBicisDisponibles;

  const _SummaryBox({
    required this.estacionesEnServicio,
    required this.totalBicisDisponibles,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: _SummaryItem(
                label: 'Estaciones en servicio',
                value: estacionesEnServicio.toString(),
              ),
            ),
            Expanded(
              child: _SummaryItem(
                label: 'Bicis disponibles',
                value: totalBicisDisponibles.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}


