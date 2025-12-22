import 'package:flutter/material.dart';
import 'package:p_ud5_bici/services/estacion_pdf_exporter.dart';
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
            : CustomScrollView(
                slivers: [
                  // 📊 Gráfica
                  SliverToBoxAdapter(
                    child: StationBarChart(stations: vm.stations),
                  ),

                  // ⭐ Favorito
                  if (vm.favoriteStation != null)
                    SliverToBoxAdapter(
                      child: FavoriteStationCard(
                        station: vm.favoriteStation!,
                        onTap: () => _openDetail(context, vm.favoriteStation!),
                      ),
                    ),

                  // 📝 Título lista
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Resto de estaciones',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  // 📋 Lista (con espacio y scroll)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      final station = vm.otherStations[i];
                      return StationListItem(
                        station: station,
                        onTap: () => _openDetail(context, station),
                        onFavoriteTap: () => vm.setFavorite(station.id),
                      );
                    }, childCount: vm.otherStations.length),
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
