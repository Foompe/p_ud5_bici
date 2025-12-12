//Información (dinamica) del estado de la estación

class EstacionStatus {
  final String stationId;
  final int numBikesAvailable;      //bicis disponibles
  final int numBikesDisabled;       //bicis desactivadas
  final String status;              // {PLANNED , IN_SERVICE}
  final int numDocksAvailable;      // espacios disponibles
  final int numDocksDisabled;       // espacios desactivados
  final DateTime? lastReported;     // timestamp convertido
  final Map<String, int> vehicleTypesAvailable; // ej: {'FIT': 3, 'EFIT': 21, 'BOOST': 0}

  EstacionStatus({
    required this.stationId,
    required this.numBikesAvailable,
    required this.numBikesDisabled,
    required this.status,
    required this.numDocksAvailable,
    required this.numDocksDisabled,
    required this.vehicleTypesAvailable,
    this.lastReported,
  });

  factory EstacionStatus.fromJson(Map<String, dynamic> json) {
    
    // Construcción segura del mapa vehicleTypesAvailable
    final Map<String, int> vTypes = {};
    if (json['vehicle_types_available'] is List) {
      for (final item in (json['vehicle_types_available'] as List)) {
        if (item is Map<String, dynamic>) {
          final id = (item['vehicle_type_id'] ?? '').toString();
          final count = (item['count'] as num?)?.toInt() ?? 0;
          vTypes[id] = count;
        }
      }
    }

    // timestamp en segundos -> DateTime (si existe)
    DateTime? lastReported;
    if (json['last_reported'] != null) {
      final lr = (json['last_reported'] as num?)?.toInt();
      if (lr != null) {
        lastReported = DateTime.fromMillisecondsSinceEpoch(lr * 1000);
      }
    }

    return EstacionStatus(
      stationId: (json['station_id']).toString(),
      numBikesAvailable: (json['num_bikes_available'] as num?)?.toInt() ?? 0,
      numBikesDisabled: (json['num_bikes_disabled'] as num?)?.toInt() ?? 0,
      status: (json['status'] ?? '').toString(),
      numDocksAvailable: (json['num_docks_available'] as num?)?.toInt() ?? 0,
      numDocksDisabled: (json['num_docks_disabled'] as num?)?.toInt() ?? 0,
      vehicleTypesAvailable: vTypes,
      lastReported: lastReported,
    );
  }
}