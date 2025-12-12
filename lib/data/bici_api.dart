import 'dart:convert';
import 'package:http/http.dart' as http;

class BiciApi {
  static const String _base = 'https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl';

  //Conexión a los datos estaticos (genericos)
  Future<List<dynamic>> getInfoEstaciones() async {
    final url = Uri.parse('$_base/station_information');
    final res = await http.get(url);

    if(res.statusCode != 200) {
      throw Exception("HTTP ${res.statusCode}");
    }

    final decoded = jsonDecode(res.body);
    if(decoded is! List) {
      throw Exception("Respuesta inesperada");
    }

    return decoded;
  }

  //Conexión al los datos dinamicos
  Future<List<dynamic>> getEstadoEstaciones() async {
    final url = Uri.parse('$_base/station_status');
    final res = await http.get(url);

    if(res.statusCode != 200) {
      throw Exception("HTTP ${res.statusCode}");
    }

    final decoded = jsonDecode(res.body);
    if(decoded is! List) {
      throw Exception("Respuesta inesperada");
    }

    return decoded;
  }
}