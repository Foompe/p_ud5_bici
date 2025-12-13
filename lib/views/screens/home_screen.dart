import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/bici_report_vm.dart';
import 'package:p_ud5_bici/viewmodels/estacion_ui_data.dart';
import 'package:p_ud5_bici/views/widgets/favorite_station_card.dart';
import 'package:p_ud5_bici/views/widgets/station_detail_sheet.dart';
import 'package:p_ud5_bici/views/widgets/station_list_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BiciReportVm>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bici Coruña'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: vm.loadEstaciones,
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(context, vm),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BiciReportVm vm) {
    if (vm.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return Center(child: Text('Error: ${vm.error}'));
    }

    return Column(
      children: [
        if (vm.favoriteStation != null)
          FavoriteStationCard(
            station: vm.favoriteStation!,
            onTap: () => _openDetail(context, vm.favoriteStation!),
          ),

        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Resto de estaciones',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        Expanded(
          child: ListView.separated(
            itemCount: vm.otherStations.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final station = vm.otherStations[i];
              return StationListItem(
                station: station,
                onTap: () => _openDetail(context, station),
                onFavoriteTap: () => vm.setFavorite(station.id),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openDetail(BuildContext context, StationUiData station) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => StationDetailSheet(station: station),
    );
  }
}
