import 'package:p_ud5_bici/data/bici_api.dart';
import 'package:p_ud5_bici/models/estacion_info.dart';
import 'package:p_ud5_bici/models/estacion_status.dart';

class BiciRepository {
  final BiciApi api;

  BiciRepository(this.api);

  //Convertimos los dimanic de BiciApi a los modelos
  Future<List<EstacionInfo>> fetchInfo() async {
    final list = await api.getInfoEstaciones();
    return list
        .map((e) => EstacionInfo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EstacionStatus>> fetchEstado() async {
    final list = await api.getEstadoEstaciones();
    return list
        .map((e) => EstacionStatus.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
