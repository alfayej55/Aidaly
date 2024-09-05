import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../controllers/Role/Shopper_Controllar/order_tracking_controllar.dart';

class GoogleMapScreen extends StatefulWidget {
   GoogleMapScreen({super.key});
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  ShopperOrderTrackingControllar _orderTracCtrl=Get.put(ShopperOrderTrackingControllar());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.777176, 90.399452),
    zoom: 14.4746,
  );

   @override
  void initState() {
    // _orderTracCtrl.getCurrentLocation();
     //orderTracCtrl.addPolyline();
     //orderTracCtrl.addMarkers();
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
        polylines: Set<Polyline>.of(_orderTracCtrl.polylines.values),
        markers: Set<Marker>.of(_orderTracCtrl.markerList.value),
        onMapCreated: (GoogleMapController controller) {
          _orderTracCtrl.mapController.complete(controller);
        },
      ),

    ));

  }
}
