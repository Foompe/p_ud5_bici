//Información actual de la estación

class EstacionStatus {
  final String stationId;
  final int numBikesAvailable;      //bicis disponibles
  final int numBikesDisabled;       //bicis desactivadas
  final String status;              // {PLANNED , IN_SERVICE}
  final int numDocksAvailable;      // espacios disponibles
  final int numDocksDisabled;       // espacios desactivados
  final Map<String, int> vehicleTypesAvailable;



  EstacionStatus({
    required this.stationId,
    required this.numBikesAvailable,
    required this.numBikesDisabled,
    required this.status,
    required this.numDocksAvailable,
    required this.numDocksDisabled,
    required this.vehicleTypesAvailable
  });

  factory EstacionStatus.fromJson(Map<String, dynamic> json) {
    return EstacionStatus(
      stationId: (json['station_id'].toString(),
      numBikesAvailable: 
      )
    )
  }
  
}
