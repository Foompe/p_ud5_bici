class EstationInfo {
  final String stationId;
  final String name;
  final String address;
  final double lat;
  final double lon;
  final int capacity;

  EstationInfo({
    required this.stationId,
    required this.name,
    required this.address,
    required this.lat,
    required this.lon,
    required this.capacity,
  });

  factory EstationInfo.fromJson(Map<String, dynamic> json) {
    return EstationInfo(
      stationId: json['station_id'].toString(),
      name: (json['name'] ?? '') as String,
      address: (json['address'] ?? '') as String,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      capacity: (json['capacity'] as num?)?.toInt() ?? 0,
    );
  }
}
