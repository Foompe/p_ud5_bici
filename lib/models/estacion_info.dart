//Información (estatica) general de las estaciones

class EstacionInfo {
  final String stationId;
  final String name;
  final String physicalConfiguration; //{REGULAR,ELECTRICBIKESTATION }
  final String address;
  final int capacity;

  EstacionInfo({
    required this.stationId,
    required this.name,
    required this.physicalConfiguration,
    required this.address,
    required this.capacity,
  });

  factory EstacionInfo.fromJson(Map<String, dynamic> json) {
    return EstacionInfo(
      stationId: json['station_id'].toString(),
      name: (json['name'] ?? '') as String,
      physicalConfiguration: (json['physical_configuration'] ?? "") as String,
      address: (json['address'] ?? '') as String,
      capacity: (json['capacity'] as num?)?.toInt() ?? 0,
    );
  }
}
