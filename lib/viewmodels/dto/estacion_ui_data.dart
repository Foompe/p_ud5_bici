// DTO de presentación para la vista
class StationUiData {
  //Identificador
  final String id;

  //Datos estaticos de la estación
  final String name;
  final String address;
  final int capacity;
  final String physicalConfiguration;

  //Datos dinamicos de la estación
  final String status; 

  final int numBikesAvailable;
  final int numBikesDisabled;

  final int numDocksAvailable;
  final int numDocksDisabled;

  //Tipos de bicicleta
  final int bikes;   // FIT
  final int ebikes;  // EFIT
  final int boost;   // BOOST

  //Calculadas
  final int totalBikes;     // bikes + ebikes + boost
  final double occupancyPercent;

  //Fecha actualización
  final DateTime? lastReported;
  final String lastUpdatedFormatted;

  //Datos para muestra
  final String decisionText; // “Sí / Quizá / No”
  final bool isFavorite;

  StationUiData({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.physicalConfiguration,
    required this.status,
    required this.numBikesAvailable,
    required this.numBikesDisabled,
    required this.numDocksAvailable,
    required this.numDocksDisabled,
    required this.bikes,
    required this.ebikes,
    required this.boost,
    required this.totalBikes,
    required this.occupancyPercent,
    required this.lastReported,
    required this.lastUpdatedFormatted,
    required this.decisionText,
    required this.isFavorite,
  });
}
