import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:aidaly/models/Role/BoutiqueModel/boutique_order_track_model.dart';
import 'package:aidaly/models/Role/BoutiqueModel/trackLocationModel.dart';
import 'package:aidaly/service/api_client.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/service/socket_maneger.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/Role/ShopperModel/shopper_order_traking_model.dart';
import '../../../service/api_check.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enamdata.dart';

class ShopperOrderTrackingControllar extends GetxController {
  final Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();

  Rx<ShopperOrderTrackModel> shopperTrackModel = ShopperOrderTrackModel().obs;
  Rx<TrackLocationModel> driverLocationModel = TrackLocationModel().obs;


  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  RxList<Marker> markerList = <Marker>[].obs;
  RxDouble deliverylatitude = 0.0.obs;
  RxDouble deliverylongitude = 0.0.obs;
  RxString deliveryTime=''.obs;
  var orderTrackLoading = false.obs;



  /// Order Track Details

  shopperOrderTrack(String orderId) async {
    orderTrackLoading(true);
    var response = await ApiClient.getData(
        '${ApiConstant.boutiqueOrderTrackEndPoint}/$orderId');
    if (response.statusCode == 200) {
      shopperTrackModel.value =
          ShopperOrderTrackModel.fromJson(response.body['data']['attributes']);
      _convertAddressToLatLong();
      orderTrackLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      orderTrackLoading(false);
      update();
    }
  }

  // getCurrentLocation() async {
  //   try {
  //     LocationPermission permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Fluttertoast.showToast(msg:'Location permissions are denied.');
  //       //locationMessage = 'Location permissions are denied.';
  //       return;
  //     }
  //
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best);
  //     latitude.value=position.latitude;
  //     longitude.value=position.longitude;
  //
  //     StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: LocationSettings()).listen(
  //             (Position? updatePosition) async{
  //           latitude.value=updatePosition!.latitude;
  //           longitude.value=updatePosition.longitude;
  //           final GoogleMapController controller = await mapController.future;
  //           await controller.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(
  //             target: LatLng(latitude.value,longitude.value),
  //             zoom:14,
  //           )));
  //
  //         });
  //
  //     update();
  //
  //   } catch (e) {
  //
  //   }
  //
  //   addPolyline();
  //   addMarkers();
  // }

  /// driverLocation
  listenDriverLocation() async {
    // debugPrint('DriverLocationId>>$driverId');
    SocketApi.socket.on('orderStatus', (data) async {
      driverLocationModel.value = TrackLocationModel.fromJson(data);
      deliveryTime.value=driverLocationModel.value.deliveryTime!;

      final GoogleMapController controller = await mapController.future;
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:LatLng(driverLocationModel.value.location!.latitude!,
            driverLocationModel.value.location!.longitude!),
        zoom: 14,
      )));

      driverLocationModel.refresh();
      addPolyline();
      addMarkers();
      orderTextUpdate();
      update();
      debugPrint('DriverLocationddd>>${driverLocationModel.value.location!.longitude}');
    });
  }

  offDriverLocation()async{
    SocketApi.socket.off('orderStatus');
    debugPrint('Socket Off');
  }

  /// Order Status Text
  orderTextUpdate(){

    if (driverLocationModel.value.assignedDrivertrack == DriverStatus.orderPicked.name) {
      return "Keep the order to be ready";
    } else if (driverLocationModel.value.assignedDrivertrack == DriverStatus.waytodeliver) {
      return "Driver is on its way";
    }
    else if (driverLocationModel.value.assignedDrivertrack == DriverStatus.arrivedAtLocation){
      return "Driver is delivering the order to customer";
    }
    else{
      return "Keep the order to be ready";
    }

  }



  // /// PolyLine Add
  // void addPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     ApiConstant.googleApiKey, // Replace with your Google Maps API Key
  //     PointLatLng(driverLocationModel.value.location!.latitude!, driverLocationModel.value.location!.longitude!),
  //     PointLatLng(deliverylatitude.value,deliverylongitude.value),
  //     // PointLatLng(23.7809430103059, 90.42685133278255),
  //     travelMode: TravelMode.driving,
  //   );
  //
  //   if (result.points.isNotEmpty) {
  //     // Clear previous polyline coordinates
  //     polylineCoordinates.value.clear();
  //
  //     // Add new points to the polyline coordinates
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.value.add(LatLng(point.latitude, point.longitude));
  //     });
  //     polylineCoordinates.refresh();
  //
  //     // Create a new polyline
  //     Polyline polyline = Polyline(
  //       polylineId: PolylineId("poly"),
  //       color: Colors.red,
  //       points: polylineCoordinates.value,
  //       width: 3,
  //     );
  //
  //     // Update the polyline map
  //     polylines[PolylineId("poly")] = polyline;
  //
  //     // Notify listeners to update the UI
  //     update();
  //   }
  // }



  /// PolyLine Add
  void addPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: ApiConstant.googleApiKey, // Replace with your Google Maps API Key
      request: PolylineRequest(
       origin: PointLatLng(driverLocationModel.value.location!.latitude!, driverLocationModel.value.location!.longitude!),
       destination: PointLatLng(deliverylatitude.value, deliverylongitude.value),
       mode: TravelMode.driving,
     )
    );

    if (result.points.isNotEmpty) {
      // Clear previous polyline coordinates
      polylineCoordinates.value.clear();

      // Add new points to the polyline coordinates
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.value.add(LatLng(point.latitude, point.longitude));
      });
      polylineCoordinates.refresh();

      // Create a new polyline
      Polyline polyline = Polyline(
        polylineId: PolylineId("poly"),
        color: Colors.red,
        points: polylineCoordinates.value,
        width: 3,
      );

      // Update the polyline map
      polylines[PolylineId("poly")] = polyline;

      // Notify listeners to update the UI
      update();
    }
  }





  /// Add Marker
  void addMarkers() async {
    final Uint8List driverMarkerIcon =
    await getBytesFromAsset(AppIcons.carIcon, 100);

    // Find the driver marker in the list
    final driverMarkerIndex =
    markerList.indexWhere((marker) => marker.markerId == MarkerId('1'));

    if (driverMarkerIndex != -1) {
      // Update the position of the existing driver marker
      markerList[driverMarkerIndex] = markerList[driverMarkerIndex].copyWith(
        positionParam: LatLng(driverLocationModel.value.location!.latitude!,
            driverLocationModel.value.location!.longitude!),
      );
    } else {
      // If there's no driver marker yet, add a new one
      markerList.add(
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(driverLocationModel.value.location!.latitude!,
              driverLocationModel.value.location!.longitude!),
          infoWindow: InfoWindow(
            title: 'Driver',
          ),
          draggable: true,
          onDragEnd: (value) {
            // value is the new position
          },
          icon: BitmapDescriptor.fromBytes(driverMarkerIcon),
        ),
      );

      /// User Marker
      markerList.add(
        Marker(
          markerId: MarkerId('2'),
          //position: LatLng(23.7809430103059, 90.42685133278255),
          position: LatLng(deliverylatitude.value,deliverylongitude.value),
          infoWindow: InfoWindow(
            title: 'User',
          ),

          draggable: true,
          onDragEnd: (value) {
            // value is the new position
          },
          icon: BitmapDescriptor.defaultMarker, // Blue marker for user
        ),
      );
    }
  }

  /// Convert Delivery Address to Lat Long

  _convertAddressToLatLong() async {

    List locations = await locationFromAddress(shopperTrackModel.value.deliveryAddress!);
    if (locations.isNotEmpty) {
      var location = locations.first;
      deliverylatitude.value=location.latitude;
      deliverylongitude.value=location.longitude;

      // var  coordinates = 'Latitude: ${location.latitude}, Longitude: ${location.longitude}';

      print('DriverDeliveryAddress: ${shopperTrackModel.value.deliveryAddress!}');
      print('DriverLatitude: ${ deliverylatitude.value}');
      print('DriverLongitude: ${deliverylongitude.value}');

    } else {

      debugPrint( 'No coordinates found for this address');

    }
  }

  /// Custom Marker
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
