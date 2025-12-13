import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/estacion_ui_data.dart';

class StationListItem extends StatelessWidget {
  final StationUiData station;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const StationListItem({
    super.key,
    required this.station,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(station.name),
      subtitle: Text(
        'Bicis: ${station.totalBikes} · E-bikes: ${station.ebikes}',
      ),
      trailing: IconButton(
        icon: Icon(
          station.isFavorite ? Icons.star : Icons.star_border,
        ),
        onPressed: onFavoriteTap,
      ),
    );
  }
}
