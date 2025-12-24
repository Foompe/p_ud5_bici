import 'package:flutter/material.dart';
import 'package:p_ud5_bici/data/bici_repository.dart';
import 'package:p_ud5_bici/models/estacion_info.dart';
import 'package:p_ud5_bici/models/estacion_status.dart';
import 'package:p_ud5_bici/viewmodels/dto/estacion_ui_data.dart';

class BiciReportVm extends ChangeNotifier {
  final BiciRepository repo;

  BiciReportVm(this.repo);

  //Estado de la UI
  bool loading = false; //Indica si se estan cargando los datos
  String? error; //Mensaje de error si algo falla

  List<EstacionInfo> eInfo = [];
  List<EstacionStatus> eStatus = [];

  //Asignamos la estación favorita al iniciar
  String _favoriteStationId = '68';

  //Carga principal
  Future<void> loadEstaciones() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      eInfo = await repo.fetchInfo();
      eStatus = await repo.fetchEstado();
    } catch (e) {
      error = e.toString();
      eInfo = [];
      eStatus = [];
    }

    loading = false;
    notifyListeners();
  }

  //Metodo para asignar favorito
  void setFavorite(String stationId) {
    _favoriteStationId = stationId; //asignamos el parametro tomado
    notifyListeners(); //Avisamos
  }

  /// Lista completa de estaciones listas para la UI
  List<EstacionUiData> get stations {
    return eInfo.map((info) {
      final status = eStatus.firstWhere((s) => s.stationId == info.stationId);

      final bikes = status.bicisPorTipo('FIT');
      final ebikes = status.bicisPorTipo('EFIT');
      final boost = status.bicisPorTipo('BOOST');

      final totalBikes = bikes + ebikes + boost;

      final occupancyPercent = info.capacity > 0
          ? double.parse(
              ((totalBikes / info.capacity) * 100).toStringAsFixed(1),
            )
          : 0.0;

      final decisionText = _decisionText(bikes, ebikes, boost);

      //Hora de untima actualización (manejamos el null)
      final t = status.lastReported.toLocal();

      final lastUpdatedFormatted =
          status.lastReported.millisecondsSinceEpoch > 0
          ? '${t.hour.toString().padLeft(2, '0')}:'
                '${t.minute.toString().padLeft(2, '0')}:'
                '${t.second.toString().padLeft(2, '0')}'
          : '--:--:--';

      return EstacionUiData(
        id: info.stationId,
        name: info.name,
        address: info.address,
        capacity: info.capacity,
        isInService: status.isInService,
        isElectricStation: info.isElectricStation,
        numBikesAvailable: status.numBikesAvailable,
        numBikesDisabled: status.numBikesDisabled,
        numDocksAvailable: status.numDocksAvailable,
        numDocksDisabled: status.numDocksDisabled,
        bikes: bikes,
        ebikes: ebikes,
        boost: boost,
        totalBikes: totalBikes,
        occupancyPercent: occupancyPercent,
        lastReported: status.lastReported,
        lastUpdatedFormatted: lastUpdatedFormatted,
        decisionText: decisionText,
        isFavorite: info.stationId == _favoriteStationId,
      );
    }).toList();
  }

  /// Estación favorita
  EstacionUiData? get favoriteStation {
    for (final s in stations) {
      if (s.isFavorite) return s;
    }
    return null;
  }

  /// Resto de estaciones
  List<EstacionUiData> get otherStations {
    return stations.where((s) => !s.isFavorite).toList();
  }

  String _decisionText(int bikes, int ebikes, int boost) {
    if ((ebikes + boost) >= 1) return 'Sí';
    if (bikes >= 1) return 'Quizá';
    return 'No';
  }
}
