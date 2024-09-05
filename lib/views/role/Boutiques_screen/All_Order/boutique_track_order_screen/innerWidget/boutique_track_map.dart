import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../controllers/Role/BoutiquesControllar/boutique_order_traking_controller.dart';

class BoutiqueGoogleMapScreen extends StatefulWidget {
  BoutiqueGoogleMapScreen({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng( 23.777176, 90.399452),
    zoom: 14.4746,
  );

  @override
  State<BoutiqueGoogleMapScreen> createState() => _BoutiqueGoogleMapScreenState();
}

class _BoutiqueGoogleMapScreenState extends State<BoutiqueGoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  BoutiqueOrderTrackingControllar orderTracCtrl=Get.put(BoutiqueOrderTrackingControllar());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.777176, 90.399452),
    zoom: 14.4746,
  );

  @override
  void initState() {
  // orderTracCtrl.getCurrentLocation();
  //   orderTracCtrl.addPolyline();
  //   orderTracCtrl.addMarkers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: 341.0.h,
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled:true,
        initialCameraPosition:_kGooglePlex,
        polylines: Set<Polyline>.of(orderTracCtrl.polylines.values),
        markers: Set<Marker>.of(orderTracCtrl.markerList.value),
        onMapCreated: (GoogleMapController controller) {
          orderTracCtrl.mapController.complete(controller);
        },
      ),

    ));

  }
}
