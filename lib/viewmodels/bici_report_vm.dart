import 'package:flutter/material.dart';
import 'package:p_ud5_bici/data/bici_repository.dart';
import 'package:p_ud5_bici/models/estacion_info.dart';
import 'package:p_ud5_bici/models/estacion_status.dart';

class BiciReportVm extends ChangeNotifier {
  final BiciRepository repo;

  BiciReportVm(this.repo);

  bool loading = false;
  String? error;

  List<EstacionInfo> eInfo = [];
  List<EstacionStatus> eStatus = [];

  //Info simple

  int get estacionesEnServicio =>
      eStatus.where((e) => e.status == 'IN_SERVICE').length;

  int get totalBicisDisponibles =>
      eStatus.fold(0, (sum, e) => sum + e.numBikesAvailable);

  //Busquedas por id

  EstacionInfo? infoById(String stationId) {
    try {
      return eInfo.firstWhere((e) => e.stationId == stationId);
    } catch (_) {
      return null;
    }
  }

  EstacionStatus? statusById(String stationId) {
    try {
      return eStatus.firstWhere((e) => e.stationId == stationId);
    } catch (_) {
      return null;
    }
  }

  // ---------- Getter combinado ----------

  List<Map<String, dynamic>> get estacionesCompletas {
    return eInfo.map((info) {
      final status = statusById(info.stationId);

      return {'info': info, 'status': status};
    }).toList();
  }

  //Carga principal
  Future<void> loadEstaciones() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      eInfo = await repo.fechInfo();
      eStatus = await repo.fechEstado();
    } catch (e) {
      error = e.toString();
      eInfo = [];
      eStatus = [];
    }

    loading = false;
    notifyListeners();
  }
}
