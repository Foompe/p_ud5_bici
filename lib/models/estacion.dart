class Estacion {
  final String stationId;
  final String name;
  final String physicalConfiguration;
  final double lat;
  final double lon;
  final double altitude;
  final String address;
  final String postCode;
  final int capacity;
  final bool isChargingStation;
  final int geofencedCapacity;
  final List<String> rentalMethods; //! Deberia ser enum? ("key", "transitcard", "creditcard", "phone")
  final bool isVirtualStation;
  final List<dynamic> groups;  //! Como debo tratar este dato
  final double nearbyDistance;
  final String bluetoothId;
  final bool rideCodeSupport;
  final Map<String, dynamic> rentalUris; //! y este? 

  Estacion({
    required this.stationId,
    required this.name,
    required this.physicalConfiguration,
    required this.lat,
    required this.lon,
    required this.altitude,
    required this.address,
    required this.postCode,
    required this.capacity,
    required this.isChargingStation,
    required this.geofencedCapacity,
    required this.rentalMethods,
    required this.isVirtualStation,
    required this.groups,
    required this.nearbyDistance,
    required this.bluetoothId,
    required this.rideCodeSupport,
    required this.rentalUris,
  });

  factory Estacion.fromJson(Map<String, dynamic> json) {
    return Estacion(
      stationId: json["station_id"].toString(),
      name: json["name"] ?? "",
      physicalConfiguration: json["physical_configuration"] ?? "",
      lat: (json["lat"] as num).toDouble(),
      lon: (json["lon"] as num).toDouble(),
      altitude: (json["altitude"] as num).toDouble(),
      address: json["address"] ?? "",
      postCode: json["post_code"] ?? "",
      capacity: json["capacity"] ?? 0,
      isChargingStation: json["is_charging_station"] ?? false,
      geofencedCapacity: json["geofenced_capacity"] ?? 0,
      rentalMethods: List<String>.from(json["rental_methods"] ?? []),
      isVirtualStation: json["is_virtual_station"] ?? false,
      groups: json["groups"] ?? [],
      nearbyDistance: (json["nearby_distance"] as num?)?.toDouble() ?? 0.0,
      bluetoothId: json["_bluetooth_id"] ?? "",
      rideCodeSupport: json["_ride_code_support"] ?? false,
      rentalUris: Map<String, dynamic>.from(json["rental_uris"] ?? {}),
    );
  }
}