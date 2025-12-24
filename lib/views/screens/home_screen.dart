import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/bici_report_vm.dart';
import 'package:p_ud5_bici/viewmodels/dto/estacion_ui_data.dart';
import 'package:p_ud5_bici/views/screens/estacion_detail_screen.dart';
import 'package:p_ud5_bici/views/widgets/favorite_station_card.dart';
import 'package:p_ud5_bici/views/widgets/station_bar_chart.dart';
import 'package:p_ud5_bici/views/widgets/station_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BiciReportVm>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bici Coruña 2.0'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.loadEstaciones,
          ),
        ],
      ),

      body: SafeArea(
        child: vm.loading
            ? const Center(child: CircularProgressIndicator())
            : vm.error != null
            ? Center(child: Text('Error: ${vm.error}'))
            : ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  //Gráfica
                  StationBarChart(stations: vm.stations),

                  //Favorito
                  if (vm.favoriteStation != null)
                    FavoriteStationCard(
                      station: vm.favoriteStation!,
                      onTap: () => _openDetail(context, vm.favoriteStation!),
                    ),

                  //Lista estaciones
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Resto de estaciones',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  for (final station in vm.otherStations)
                    StationListItem(
                      station: station,
                      onTap: () => _openDetail(context, station),
                      onFavoriteTap: () => vm.setFavorite(station.id),
                    ),
                ],
              ),
      ),
    );
  }

  void _openDetail(BuildContext context, EstacionUiData station) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StationDetailScreen(station: station)),
    );
  }
}
