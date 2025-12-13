import 'package:flutter/material.dart';
import 'package:p_ud5_bici/data/bici_repository.dart';
import 'package:p_ud5_bici/models/estacion_info.dart';
import 'package:p_ud5_bici/models/estacion_status.dart';
import 'package:p_ud5_bici/viewmodels/estacion_ui_data.dart';

class BiciReportVm extends ChangeNotifier {
  final BiciRepository repo;

  BiciReportVm(this.repo);

  //Estado de la UI 
  bool loading = false;  //Indica si se estan cargando los datos
  String? error;         //Mensaje de error si algo falla

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

  //Metodo para asignar favorito
  void setFavorite(String stationId) {
    _favoriteStationId = stationId;     //asignamos el parametro tomado
    notifyListeners();                  //Avisamos
  }


  /// Lista completa de estaciones listas para la UI
  List<StationUiData> get stations {
  return eInfo.map((info) {
    final status = eStatus.firstWhere(
      (s) => s.stationId == info.stationId,
    );

    final bikes = status.vehicleTypesAvailable['FIT'] ?? 0;
    final ebikes = status.vehicleTypesAvailable['EFIT'] ?? 0;
    final boost = status.vehicleTypesAvailable['BOOST'] ?? 0;

    final totalBikes = bikes + ebikes + boost;

    final occupancyPercent = info.capacity > 0
    ? double.parse(
        ((totalBikes / info.capacity) * 100).toStringAsFixed(1),
      )
    : 0.0;

    final decisionText = _decisionText(bikes, ebikes);

    //Fecha de untima actualización (manejamos el null)
    final lastUpdatedFormatted = status.lastReported != null
    ? status.lastReported!.toLocal().toString()
    : 'N/D';

    return StationUiData(
      id: info.stationId,
      name: info.name,
      address: info.address,
      capacity: info.capacity,
      physicalConfiguration: info.physicalConfiguration,
      status: status.status,
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
  StationUiData? get favoriteStation {
    try {
      return stations.firstWhere((s) => s.isFavorite);
    } catch (_) {
      return stations.isNotEmpty ? stations.first : null;
    }
  }

  /// Resto de estaciones
  List<StationUiData> get otherStations {
    return stations.where((s) => !s.isFavorite).toList();
  }

  String _decisionText(int bikes, int ebikes) {
    if (ebikes >= 1) return 'Sí';
    if (bikes >= 1) return 'Quizá';
    return 'No';
  }
}