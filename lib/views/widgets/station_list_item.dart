import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/dto/estacion_ui_data.dart';

class StationListItem extends StatelessWidget {
  final EstacionUiData station;
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
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      title: Text(station.name),
      subtitle: Text(
        'Bicis: ${station.totalBikes} · E-bikes: ${station.ebikes}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 📊 Ocupación
          Container(
            width: 60,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pie_chart,
                  size: 14,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${station.occupancyPercent.toStringAsFixed(0)}%',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // ⭐ Favorito (ligero, sin IconButton)
          GestureDetector(
            onTap: onFavoriteTap,
            child: Icon(
              station.isFavorite ? Icons.star : Icons.star_border,
              color: station.isFavorite ? Colors.amber : theme.iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }
}
