import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/models/Role/DriverModel/driver_track_model.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/service/socket_maneger.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../helpers/prefs_helper.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../utils/app_constants.dart';

class DriverOrderTrackingControllar extends GetxController {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  Rx<DriverOrderTrackModel> orderTrackModel = DriverOrderTrackModel().obs;

  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  PolylinePoints polylinePoints = PolylinePoints();
  RxMap<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  var markerList = <Marker>[].obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxDouble deliverylatitude = 0.0.obs;
  RxDouble deliverylongitude = 0.0.obs;

  // RxDouble boutiqueLatitude = 0.0.obs;
  // RxDouble boutiqueLongitude = 0.0.obs;
  RxInt distance = 0.obs;
  RxString estimatTimes=''.obs;


  RxString trackingStatus = 'On the Way to Pickup'.obs;

  // RxDouble currentLatitude=0.0.obs;
  // RxDouble currentLongitude=0.0.obs;

  RxDouble oldLatitude = 0.0.obs;
  RxDouble oldLongitude = 0.0.obs;

  /// Track Order Details

  var drivertrackLoading = false.obs;

  driverOrderTrack(String orderId) async {
    drivertrackLoading.value = true;
    var response = await ApiClient.getData(
        '${ApiConstant.driverTrackOrderDetailsEndPoint}/$orderId');
    if (response.statusCode == 200) {
      orderTrackModel.value = DriverOrderTrackModel.fromJson(response.body['data']['attributes']);
      /// Delivery Location
      _convertAddressToLatLong();

      // boutiqueLatitude.value =
      //     orderTrackModel.value.boutiqueId!.currentLocation!.latitude!;
      // boutiqueLongitude.value =
      //     orderTrackModel.value.boutiqueId!.currentLocation!.longitude!;

      drivertrackLoading.value = false;
      update();
    } else {
      ApiChecker.checkApi(response);
      drivertrackLoading.value = false;
      update();
    }
  }

  /// Driver Current location
  getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      oldLatitude.value = position.latitude;
      oldLongitude.value = position.longitude;

      StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: LocationSettings())
              .listen((Position? updatePosition) async {
        latitude.value = updatePosition!.latitude;
        longitude.value = updatePosition.longitude;

        print('UpdateLat>>>${latitude.value}');
        print('UpdateLong>>>${longitude.value}');
        distanceGet();
        addPolyline();
        addMarkers();

        final GoogleMapController controller = await mapController.future;
        await controller
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(latitude.value, longitude.value),
          zoom: 14,
        )));
      });
      update();
    } catch (e) {}
  }

  ///Current and Old Location Dispance Get

  Future<void> distanceGet() async {
    final String apiKey = ApiConstant.googleApiKey;
    final String url =
        '${ApiConstant.estimatedTimeUrl}origins=${latitude.value},${longitude.value}&destinations=${oldLatitude.value},${oldLongitude.value}&key=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final data = json.decode(response.body);
        distance.value = data['rows'][0]['elements'][0]['distance']['value'];
        estimatTimes.value = data['rows'][0]['elements'][0]['duration']['text'];
        if (distance.value >= 3) {
          updateCurrentLocation();
        }
        update();
        print('Estimate Distance>>${distance.value}');
      } else {
        print('Failed to load Distance Matrix data');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error occurred: $e');
    }
  }

  /// Current Location Update

  updateCurrentLocation() async {
    var driverId = await PrefsHelper.getString(AppConstants.userId);

    oldLatitude.value = latitude.value;
    oldLongitude.value = longitude.value;

    /// Call For Socket

    var body = {
      'id': driverId,
      'latitute': latitude.value,
      'longitude': longitude.value,
       'deliveryTime': estimatTimes.value,
       'status':orderTrackModel.value.assignedDrivertrack
    };

    SocketApi.emit('locationUpdate', body);
    print('oldLatitude>>>${oldLatitude.value}');
    print('oldLongitude>>>${oldLongitude.value}');
    print('Socket Check>>$body');
    update();
  }
  /// PolyLine Add

  // void addPolyline() async {
  //   print('da lat>>${longitude.value},${ longitude.value}');
  //   print('da lat>>${deliverylatitude.value},${deliverylongitude.value}');
  //
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     ApiConstant.googleApiKey,// Replace with your Google Maps API Key
  //     PointLatLng(latitude.value, longitude.value),
  //     PointLatLng(deliverylatitude.value, deliverylongitude.value),
  //
  //     // PointLatLng(23.7809430103059, 90.42685133278255),
  //     travelMode: TravelMode.driving,
  //   );
  //
  //   print('da lat>>${longitude.value},${ longitude.value}');
  //   print('da lat>>${deliverylatitude.value},${deliverylongitude.value}');
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

  void addPolyline() async {
    print('da lat>>${longitude.value},${ longitude.value}');
    print('da lat>>${deliverylatitude.value},${deliverylongitude.value}');

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: ApiConstant.googleApiKey, // Replace with your Google Maps API Key
        request: PolylineRequest(
          origin:  PointLatLng(latitude.value, longitude.value),
          destination: PointLatLng(deliverylatitude.value, deliverylongitude.value),
          mode: TravelMode.driving,
        )

    );

    print('da lat>>${longitude.value},${ longitude.value}');
    print('da lat>>${deliverylatitude.value},${deliverylongitude.value}');

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


  void addMarkers() async {
    final Uint8List driverMarkerIcon =
        await getBytesFromAsset(AppIcons.carIcon, 100);

    // Find the driver marker in the list
    final driverMarkerIndex =
        markerList.indexWhere((marker) => marker.markerId == MarkerId('1'));

    if (driverMarkerIndex != -1) {
      // Update the position of the existing driver marker
      markerList[driverMarkerIndex] = markerList[driverMarkerIndex].copyWith(
        positionParam: LatLng(latitude.value, longitude.value),
      );
    } else {
      // If there's no driver marker yet, add a new one
      markerList.add(
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(latitude.value, longitude.value),
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
          position: LatLng(deliverylatitude.value, deliverylongitude.value),
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

    List locations = await locationFromAddress( orderTrackModel.value.deliveryAddress!);
    if (locations.isNotEmpty) {
      var location = locations.first;
      deliverylatitude.value=location.latitude;
      deliverylongitude.value=location.longitude;

      // var  coordinates = 'Latitude: ${location.latitude}, Longitude: ${location.longitude}';

      print('DriverDeliveryAddress: ${ orderTrackModel.value.deliveryAddress!}');
      print('DriverLatitude: ${ deliverylatitude.value}');
      print('DriverLongitude: ${deliverylongitude.value}');

    } else {

      debugPrint( 'No coordinates found for this address');

    }
  }

  /// Order Tracking Status  Text Change

  String trackingStatusText(String status) {
    if (status == DriverStatus.waytoPickup.name) {
      return "On the Way to Pickup";
    } else if (status == DriverStatus.arrivedtheStore.name) {
      return "Arrived the Store";
    } else if (status == DriverStatus.orderPicked.name) {
      return "Order Picked";
    } else if (status == DriverStatus.waytodeliver.name) {
      return "On My Way to Deliver";
    } else if (status == DriverStatus.arrivedAtLocation.name) {
      return "Arrived at Location";
    } else if (status == DriverStatus.onsuccess.name) {
      return "Order Delivered";
    } else {
      return "On the Way to Pickup"; // Default case
    }
  }

  /// Order Tracking Status Update
  var updateDriverTrackingLoading = false.obs;
  updateDriverTrackingStatus(
      {required String status, required String orderId}) async {
    updateDriverTrackingLoading(true);
    var statusText = updateDriverTrackingStatusText(status);

    var body = {'driverTrack': statusText};

    var response = await ApiClient.patchData(
        ApiConstant.driverOrderTrackingUpdate(orderId),
        body: body);

    if (response.statusCode == 200) {
      orderTrackModel.value.assignedDrivertrack = statusText;

      print('Delivery Status>>${statusText}');
      if(orderTrackModel.value.assignedDrivertrack==DriverStatus.orderDelivered.name){
        Get.toNamed(AppRoutes.driversOrderSuccessFullScreen);
      }
      orderTrackModel.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
    updateDriverTrackingLoading(false);
  }
  // enum DriverStatus{start,waytoPickup ,arrivedtheStore,orderPicked,waytodeliver,arrivedAtLocation,orderDelivered}


  String updateDriverTrackingStatusText(String status) {
    if (status == DriverStatus.waytoPickup.name) {
      return DriverStatus.arrivedtheStore.name;
    } else if (status == DriverStatus.arrivedtheStore.name) {
      return DriverStatus.orderPicked.name;
    } else if (status == DriverStatus.orderPicked.name) {
      return DriverStatus.waytodeliver.name;
    } else if (status == DriverStatus.waytodeliver.name) {
      return DriverStatus.arrivedAtLocation.name;
    } else if (status == DriverStatus.arrivedAtLocation.name) {
      return DriverStatus.onsuccess.name;
    }  else if (status == DriverStatus.onsuccess.name) {
      return DriverStatus.orderDelivered.name;
    }
    else {
      return DriverStatus.arrivedtheStore.name;
    }
  }

  // /// Main Code
  // String updateDriverTrackingStatusText(String status) {
  //   if (status == DriverStatus.waytoPickup.name) {
  //     return DriverStatus.arrivedtheStore.name;
  //   } else if (status == DriverStatus.arrivedtheStore.name) {
  //     return DriverStatus.orderPicked.name;
  //   } else if (status == DriverStatus.orderPicked.name) {
  //     return DriverStatus.waytodeliver.name;
  //   } else if (status == DriverStatus.waytodeliver.name) {
  //     return DriverStatus.arrivedAtLocation.name;
  //   } else if (status == DriverStatus.arrivedAtLocation.name) {
  //     return DriverStatus.orderDelivered.name;
  //   } else {
  //     return DriverStatus.arrivedtheStore.name;
  //   }
  // }

  // String updateDriverTrackingStatusText(String status) {
  //   if (status == DriverStatus.waytoPickup.name) {
  //     return DriverStatus.waytoPickup.name;
  //   } else if (status == DriverStatus.arrivedtheStore.name) {
  //     return DriverStatus.arrivedtheStore.name;
  //   } else if (status == DriverStatus.orderPicked.name) {
  //     return DriverStatus.arrivedtheStore.name;
  //   } else if (status == DriverStatus.waytodeliver.name) {
  //     return DriverStatus.waytodeliver.name;
  //   } else if (status == DriverStatus.arrivedAtLocation.name) {
  //     return DriverStatus.arrivedAtLocation.name;
  //   }else if(status == DriverStatus.orderDelivered.name){
  //     return DriverStatus.orderDelivered.name;
  //   }
  //   else {
  //     return DriverStatus.arrivedtheStore.name;
  //   }
  // }

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
