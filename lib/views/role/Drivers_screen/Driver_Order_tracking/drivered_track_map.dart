import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../controllers/Role/Driver_Controllar/driver_order_traking_controller.dart';

class DriverGoogleMapScreen extends StatefulWidget {
  DriverGoogleMapScreen({super.key});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng( 23.777176, 90.399452),
    zoom: 14.4746,
  );

  @override
  State<DriverGoogleMapScreen> createState() => _DriverGoogleMapScreenState();
}

class _DriverGoogleMapScreenState extends State<DriverGoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  DriverOrderTrackingControllar _orderTrackingCtrl=Get.put(DriverOrderTrackingControllar());

  @override
  void initState() {

    _orderTrackingCtrl.getCurrentLocation();
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
        onTap: (position){
          // print('GoogleSetLat ${position.latitude}');
          // print('GoogleSetLog ${position.longitude}');
        },
        zoomGesturesEnabled: true,
        zoomControlsEnabled:true,
        initialCameraPosition:DriverGoogleMapScreen._kGooglePlex,
        polylines: Set<Polyline>.of(_orderTrackingCtrl.polylines.values),
        markers: Set<Marker>.of(_orderTrackingCtrl.markerList.value),
        onMapCreated: (GoogleMapController controller) {
          _orderTrackingCtrl.mapController.complete(controller);
        },
      ),

    ));
  }
}
