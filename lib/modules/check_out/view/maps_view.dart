import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart';
import 'package:foodit/core/export.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/dash_container.dart';
import '../../cart/provider/map_controller.dart';

class MapsView extends StatelessWidget {
  const MapsView({super.key});
  @override
  Widget build(BuildContext context) {
    final MapController1 controller = Get.put(MapController1());
    // TODO: implement build
    return Column(
      children: [
        DashContainer(
          height: 8.fh,
          width: double.maxFinite,
          child: Row(
            children: [
              Icon(
                Icons.my_location_outlined,
                size: 20,
                color: context.color.lightGrey,
              ).ph(10),
              Flexible(
                child: Obx(
                  () => Text(
                    "Latitude: ${controller.locationModel.value.latitude?.toStringAsFixed(3)},  Longitude: ${controller.locationModel.value.longitude?.toStringAsFixed(3)}",
                    style: context.textStyles.bodyLarge,
                  ).pr(10),
                ),
              ),
            ],
          ),
        ),
        Obx(() => controller.locLoaded.isTrue
            ? SizedBox(
                height: 300,
                width: 100.fw,
                child: FlutterMap(
                  options: MapOptions(
                    onTap: (tapPosition, point) {
                      controller.changeMarkerPosition(point);
                      print(point);
                    },
                    center: LatLng(controller.cent.value?.latitude ?? 0,
                        controller.cent.value?.longitude ?? 0),
                    zoom: 13.0,
                  ),
                  // ignore: sort_child_properties_last
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.app',
                    ),
                    Obx(
                      () => controller.locationModel.value != null
                          ? MarkerLayer(
                              markers: [
                                Marker(
                                  width: 30.0,
                                  height: 30.0,
                                  point: LatLng(
                                      controller.locationModel.value.latitude ??
                                          0,
                                      controller
                                              .locationModel.value.longitude ??
                                          0),
                                  builder: (ctx) => const Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.blue),
                                )
                              ],
                            )
                          : const Text(""),
                    )
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  Text(
                    "Loading Map",
                    style: context.textStyles.bodyMedium,
                  ).pv(16),
                ],
              )),
      ],
    );
  }
}
