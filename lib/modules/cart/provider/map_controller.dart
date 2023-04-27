// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../../../data/models/map_model.dart';

class MapController1 extends GetxController {
  RxString id = "".obs;
  Rx<MapModel> map =
      MapModel(route: [], center: Cordinate(lat: 27.700769, lng: 85.300140))
          .obs;
  RxBool loaded = false.obs;
  RxBool locLoaded = false.obs;
  RxBool hasBetween = false.obs;
  RxList<LocationData> between = <LocationData>[].obs;

  final loc = Rx<LocationData?>(null);
  final cent = Rx<LocationData?>(null);
  Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  void _startLocationTracking() async {
    try {
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        if (locLoaded.isFalse) {
          // loc.value = currentLocation;
          // loc.refresh();
          // locLoaded.value = true;
          // locLoaded.refresh();
          cent.value = currentLocation;
          cent.refresh();
          locationModel.value = LocationModel(
              latitude: currentLocation.latitude,
              longitude: currentLocation.longitude);
          print("hellooooooooooooo");
          locLoaded.value = true;
          update();
        }
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _startLocationTracking();
  }

  // loadMap(id, [travel = true]) async {
  //   id.value = id;
  //       loaded.value = true;
  //       map.refresh();
  //   final res = await ApiService().getData("destination/map/${id.value}");
  //   if (res != null) {
  //     if (res.statusCode == 200) {
  //       final data = jsonDecode(res.body);
  //       map.value = MapModel.fromJson(data);
  //       if (travel) {
  //         Get.toNamed(Routes.map);
  //       } else {
  //         getBetween();
  //       }
  //     } else {
  //       errorSnackbar("Destination", "Map for destination doesnot exists");
  //     }
  //   } else {}
  // }
  // 26.445843478439503, 87.27260873461532
  Rx<LocationModel> locationModel =
      LocationModel(latitude: 26.445843478439503, longitude: 87.27260873461532)
          .obs;
  changeMarkerPosition(LatLng point) {
    locationModel.value =
        LocationModel(latitude: point.latitude, longitude: point.longitude);
    print(locationModel.value);
    locationModel.refresh();
    update();
  }
}

class LocationModel {
  final double? latitude;
  final double? longitude;
  LocationModel({
    this.latitude,
    this.longitude,
  });
}
