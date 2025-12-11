class EstacionStatus {
  final String stationId;
  final int numBikesAvailable;
  final int numBikesDisabled;
  final String status;
  final int numDocksAvailable;
  final int lastReported;
  final Map<String, int> vehicleTypes; //{ "FIT":7, "EFIT":12, "BOOST":0 }
  final List<dynamic> vehicleDocksAvailable;

  EstacionStatus({
    required this.stationId,
    required this.numBikesAvailable,
    required this.numBikesDisabled,
    required this.status,
    required this.numDocksAvailable,
    required this.lastReported,
    required this.vehicleTypes,
    required this.vehicleDocksAvailable,
  });

  factory EstacionStatus.fromJson(Map<String, dynamic> json) {
    final Map<String, int> types = {};
    if (json['vehicle_types_available'] is List) {
      for (var item in json['vehicle_types_available']) {
        try {
          final id = item['vehicle_type_id'].toString();
          final count = (item['count'] as num?)?.toInt() ?? 0;
          types[id] = count;
        } catch (e) {
        }
      }
    }

    return EstacionStatus(
      stationId: json['station_id'].toString(),
      numBikesAvailable: (json['num_bikes_available'] as num?)?.toInt() ?? 0,
      numBikesDisabled: (json['num_bikes_disabled'] as num?)?.toInt() ?? 0,
      status: (json['status'] ?? '') as String,
      numDocksAvailable: (json['num_docks_available'] as num?)?.toInt() ?? 0,
      lastReported: (json['last_reported'] as num?)?.toInt() ?? 0,
      vehicleTypes: types,
      vehicleDocksAvailable: json['vehicle_docks_available'] as List? ?? [],
    );
  }
}
