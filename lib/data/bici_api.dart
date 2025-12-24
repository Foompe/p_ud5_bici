import 'dart:convert';
import 'package:http/http.dart' as http;

class BiciApi {
  static const String _base =
      'https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl';

  //Conexión a los datos estaticos (genericos)
  Future<List<dynamic>> getInfoEstaciones() {
    return _getStations('station_information');
  }

  //Conexión al los datos dinamicos
  Future<List<dynamic>> getEstadoEstaciones() {
    return _getStations('station_status');
  }

  //Método único
  Future<List<dynamic>> _getStations(String endpoint) async {
    final url = Uri.parse('$_base/$endpoint');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}');
    }

    final decoded = jsonDecode(res.body) as Map<String, dynamic>;
    return decoded['data']['stations'] as List<dynamic>;
  }
}
