

import 'dart:async';
import 'dart:convert';

import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/helpers/prefs_helper.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/models/add_to_cart_model.dart';
import 'package:aidaly/views/base/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/db_helpers.dart';
import '../../../models/Role/ShopperModel/product_details_model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';

class AddToCartControllar extends GetxController{

  DBHelper dbHelper = DBHelper();

  @override
  void onInit() async {
    getData();
    super.onInit();
  }
  TextEditingController deliveryLocation=TextEditingController();
  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  /// search location controller


  RxString estimatTimes=''.obs;
  RxDouble distanceInMiles=0.0.obs;

  RxDouble boutiqueLatitude=0.0.obs;
  RxDouble boutiqueLongitude=0.0.obs;

  RxDouble shopperLatitude= 0.0.obs;
  RxDouble shopperLongitude= 0.0.obs;

   RxString shopperAddress=''.obs;

  RxList<String> sizes=<String>[].obs;
  RxString selectedSize=''.obs;
  RxString selectedColor=''.obs;
  RxList<String> tipsList=<String>[].obs;
  RxDouble selectedtips= 0.0.obs;

  bool firstGet = true;

  RxInt productQuantity=1.obs;
  RxInt quantity = 1.obs;
  RxDouble subTotalPrice = 0.00.obs;
  RxDouble serviceFee = 5.00.obs;
  RxDouble shippintFee = 0.00.obs;

  RxDouble taxPrice = 7.00.obs;
  RxDouble totalPrice = 00.0.obs;

  var orderCheckoutId='';


 // RxDouble get totalPrice => _subTotalPrice;
  RxList<Cart> cart = <Cart>[].obs;


  Future getData() async {
    try {
      cart.value = await dbHelper.getCartList();
      update();
      totalPriceCalculation();
    } catch (e) {
      print('Error fetching cart data: $e');
      return []; // Return an empty list in case of an error
    }
  }


  void addQuantity(int index) {
    cart[index].quantity!.value = cart[index].quantity!.value + 1;
    totalPriceCalculation();
    update();
  }

  void deleteQuantity(int index) {
    final currentQuantity = cart[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity!.value = currentQuantity - 1;
    }
    totalPriceCalculation();
    update();
  }

  void removeItem(int index) {
    cart.removeAt(index);
    totalPriceCalculation();
    update();
  }

  totalPriceCalculation()async{
    var _DemoTotalPrice=0.0;
    cart.forEach((element) {
      var _ItemTotalPrice=element.productPrice!*element.quantity!.value;
      _DemoTotalPrice = _DemoTotalPrice+_ItemTotalPrice;
    });

    subTotalPrice.value=_DemoTotalPrice;
    var tips=(subTotalPrice.value*selectedtips.value*100)/100;
    subTotalPrice.value=subTotalPrice.value+tips;
    update();

    double subtotal = subTotalPrice.value+serviceFee.value+shippintFee.value;
    double taxAmount = subtotal * (taxPrice.value/100);
    var result= subtotal+ taxAmount;
    totalPrice.value= double.parse(result.toStringAsFixed(2));
    update();

  }

  /// Shipping Calculation

   shippingCalculateFare(double miles) {
    double baseFare = 10.0;
    if (miles <= 5) {
      shippintFee.value= double.parse(baseFare.toStringAsFixed(2));
     

      print('Shippin Fee>> ${shippintFee.value}');

      update();
    } else {
      shippintFee.value = double.parse((baseFare + (miles - 5)).toStringAsFixed(2));
      print('Shippin Fee>> ${shippintFee.value}');

      update();
    }

    totalPriceCalculation();

  }

/// Delivery Estimate

  Future<void> estimatedTimeGet() async {

    boutiqueLatitude.value=await PrefsHelper.getDouble(AppConstants.boutiqueLat)??0.0;
    boutiqueLongitude.value=await PrefsHelper.getDouble(AppConstants.boutiqueLog)??0.0;

    final String apiKey = ApiConstant.googleApiKey;
    final String url =
        '${ApiConstant.estimatedTimeUrl}origins=${shopperLatitude.value},${shopperLongitude.value}&destinations=${boutiqueLatitude.value},${boutiqueLongitude.value}&key=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final data = json.decode(response.body);
        estimatTimes.value = data['rows'][0]['elements'][0]['duration']['text'];

       print('Estimate Distance>>$data');
      } else {
        // If the server returns a response other than 200, throw an exception
        print('Failed to load Distance Matrix data');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error occurred: $e');
    }
  }

  Future getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        var  locationMessage = 'Location permissions are denied.';
        return locationMessage;
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      shopperLatitude.value=position.latitude;
      shopperLongitude.value=position.longitude;
      await PrefsHelper.setDouble(AppConstants.shopperLat,shopperLatitude.value);
      await PrefsHelper.setDouble(AppConstants.shopperLag,shopperLongitude.value);

      update();

    } catch (e) {

    }

  }

  ///initialCameraPosition

  firstTimeGetUserLocation()async{

    shopperLatitude.value= await PrefsHelper.getDouble(AppConstants.shopperLat)??0.0;
    shopperLongitude.value= await PrefsHelper.getDouble(AppConstants.shopperLag)??0.0;

    List<Placemark> placemarks = await placemarkFromCoordinates(
        shopperLatitude.value, shopperLongitude.value);
    Placemark placemark = placemarks[0];
    String address = '${placemark.street}, ${placemark.administrativeArea}, ${placemark.country}';
    shopperAddress.value =  address;
    print('First time>>>${ shopperAddress.value}');
    distanceCalculation();
    update();

  }

  /// Shopper and Boutique Distance;

  distanceCalculation()async{

    boutiqueLatitude.value=await PrefsHelper.getDouble(AppConstants.boutiqueLat)??0.0;
    boutiqueLongitude.value=await PrefsHelper.getDouble(AppConstants.boutiqueLog)??0.0;

    print('Shopper Lat${shopperLatitude}');
    print('Shopper Long${shopperLongitude}');

    var distanceInMeters = await Geolocator.distanceBetween(shopperLatitude.value, shopperLongitude.value,  boutiqueLatitude.value, boutiqueLongitude.value);
    distanceInMiles.value = distanceInMeters / 1609.34;
    ///  Call Shipping Feee
    shippingCalculateFare(distanceInMiles.value);

    print('Distance Miles>>>${distanceInMiles.value}');

  }

  Rx<LatLng?> markerPosition = Rx<LatLng?>(null);
  RxSet<Marker> markers = <Marker>{}.obs;


  /// Update Delivery Address
  void updateDeliveryAddress(LatLng position) async{
      markerPosition.value = position;
      markers.value = {
       Marker(
        markerId: const MarkerId('marker'),
        position: position,
      ),
    };

      shopperLatitude.value= position.latitude;
      shopperLongitude.value= position.longitude;

    List<Placemark> placemarks = await placemarkFromCoordinates(

        shopperLatitude.value,  shopperLongitude.value);
      Placemark placemark = placemarks[0];

       String address = '${placemark.street}, ${placemark.administrativeArea}, ${placemark.country}';

        shopperAddress.value = address;
         print('Update >>${ shopperAddress.value}');
         distanceCalculation();
          update();
  }

  /// Give a String Address Update Delivery Address using an address string

  var updateLocationLoading=false.obs;

  Future<void> updateDeliveryAddressLatLong(String address) async {
    updateLocationLoading(true);
    print("jhgasj>>>$address");
    try {
      // Convert the address string to LatLng
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        LatLng position = LatLng(locations[0].latitude, locations[0].longitude);

        shopperLatitude.value = position.latitude;
        shopperLongitude.value = position.longitude;

        print('Update lat>> ${shopperLatitude.value}');
        print('Update  long>> ${shopperLongitude.value }');
        distanceCalculation();
        updateLocationLoading(false);
        update();
      } else {
        print('No location found for the provided address.');
        updateLocationLoading(false);
        update();
      }
    } catch (e) {
      print('Error in updateDeliveryAddress: $e');
      updateLocationLoading(false);
      update();
    }
  }






  /// CheckOut

var loading=false.obs;

  void orderComplete() async {
    print('Payement>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>');
     var boutiqueId= await  PrefsHelper.getString(AppConstants.boutiqueId);
      // UserId userId=UserId.fromJson(json.decode(boutiqueId));

     print('BoutiqueId>>$boutiqueId');
    loading.value = true;
    // Assuming cart is an RxList<CartItem>
    List<Map<String, dynamic>> cartItems = cart.map((item) => item.toMap()).toList();

    var paymentMethod = {
      "transectionId": "sdkjf09uijsdfjkdsf",
      "methodName": "paypal"
    };

    Map<String, dynamic> body = {
      'orderItemsId': orderCheckoutId,
      'totalAmount': totalPrice.value.toString(),
        'subTotal':subTotalPrice.toString(),
      'deliveryAddress': shopperAddress.value,
      'paymentMethod': paymentMethod,
      'tips': selectedtips.value.toString(),
      'shippingFee': shippintFee.value.toString(),
      'serviceFee': serviceFee.value.toString(),
      'OrderItems': 'frtsdrfg',
      'tax':taxPrice.value.toString(),
      "boutiqueId":boutiqueId,
      'status': 'neworder',
      'paymentStatus': 'pending'
    };

    Response response = await ApiClient.postData(
        ApiConstant.paymentCheckoutEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {
       dbHelper.deleteTable('cart');
       print(' Order Compled>>>>');
      Get.offAllNamed(AppRoutes.homeScreen);
      loading.value = false;
      update();
    }
    else if(response.statusCode==401){
      Fluttertoast.showToast(msg: 'Product Not Aviable');
    }
    else {
      Fluttertoast.showToast(msg: response.body['message']);
      ApiChecker.checkApi(response);
      loading.value = false;
      update();
    }
  }

  /// Add to Cart Quntite Check

  var cherckOrderQuentitLoading=false.obs;


 checkQuntite()async{
   cherckOrderQuentitLoading(true);
   List<Map<String, dynamic>> cartItems = cart.map((item) => item.toMap()).toList();
   var body={
     "items":cartItems
   };

   var responce=await ApiClient.postData(ApiConstant.orderQuntityCheckEndPoint, jsonEncode(body));
   if(responce.statusCode==200){
     orderCheckoutId = responce.body["data"]["_id"];
     print("pringIddddd>>>>$orderCheckoutId");
     Get.toNamed(AppRoutes.checkoutScreen);
     cherckOrderQuentitLoading(false);
     update();
   }
   else if(responce.statusCode==400){
     print('ghadjgbfajsjkal');
     showToastMessage.showMessage(responce.body["message"]);
     cherckOrderQuentitLoading(false);
     update();
   }
   else{
     ApiChecker.checkApi(responce);
     cherckOrderQuentitLoading(false);
     update();
   }
 }

}



