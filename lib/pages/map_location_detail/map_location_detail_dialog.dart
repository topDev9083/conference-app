import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/close_icon.dart';
import '../../widgets/connection_information.dart';
import '../../widgets/image.dart';
import 'bloc/map_location_detail_bloc.dart';
import 'bloc/map_location_detail_state.dart';

class MapLocationDetailDialog extends StatelessWidget {
  final int mapLocationId;

  static Future<void> show(
    final BuildContext context, {
    required final int mapLocationId,
  }) {
    return showDialog(
      context: context,
      builder: (final _) => Dialog(
        child: MapLocationDetailDialog._(mapLocationId: mapLocationId),
      ),
    );
  }

  const MapLocationDetailDialog._({
    required this.mapLocationId,
  });

  @override
  Widget build(final BuildContext context) {
    return BlocProvider(
      create: (final _) => MapLocationDetailBloc(mapLocationId),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CloseIcon(
                onTap: Navigator.of(context).pop,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 60,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: _MapLocationInfo(),
          ),
        ],
      ),
    );
  }
}

class _MapLocationInfo extends StatelessWidget {
  const _MapLocationInfo();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<MapLocationDetailBloc, MapLocationDetailState>(
      builder: (final _, final state) => state.mapLocationApi.data == null
          ? ConnectionInformation(
              error: state.mapLocationApi.error,
              onRetry: MapLocationDetailBloc.of(context).getMapLocationDetail,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.mapLocationApi.data!.map!.name}/${state.mapLocationApi.data!.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 19),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 640,
                    maxHeight: 444,
                  ),
                  child: Stack(
                    children: [
                      WCImage(
                        image: state.mapLocationApi.data!.map!.image,
                      ),
                      Positioned.fill(
                        child: LayoutBuilder(
                          builder: (final _, final constraint) => Stack(
                            children: [
                              Positioned(
                                left: constraint.maxWidth *
                                        state.mapLocationApi.data!.offsetX -
                                    20,
                                top: constraint.maxHeight *
                                        state.mapLocationApi.data!.offsetY -
                                    40,
                                child: const WCImage(
                                  image: 'pin_red.png',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
