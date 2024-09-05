import 'dart:async';

import 'package:aidaly/controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../Utils/app_Image.dart';
import '../../../../../../utils/style.dart';

class DeliveryLocation extends StatelessWidget {
  DeliveryLocation({super.key});

  AddToCartControllar addCtrl = AddToCartControllar();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.791275582872142, 90.39232734518325),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: Get.theme.primaryColor,
              )),
        ),
      ),
      body: Obx(() => Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  onTap: (position) {
                    addCtrl.updateDeliveryAddress(position);
                  },
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  markers: addCtrl.markers.value,
                  onMapCreated: (GoogleMapController controller) {
                    addCtrl.mapController.complete(controller);
                  },
                ),
              ),
              Container(
                height: 190.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: Colors.white),
                child: Column(
                  children: [
                    Obx(
                      () => ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                        titleTextStyle: AppStyles.customSize(
                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: Get.theme.disabledColor),
                        leading: Image.asset(
                          AppImages.deliveryLocationimage,
                          width: 32.w,
                          height: 32.h,
                        ),
                        title: Text(addCtrl.shopperAddress.value),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButton(
                        onTap: () {
                          Get.back(result: {
                            "address": addCtrl.shopperAddress.value,
                            "lat": addCtrl.shopperLatitude.value,
                            "long": addCtrl.shopperLongitude.value
                          });
                        },
                        text: AppString.update.tr)
                  ],
                ),
              )
            ],
          )),
    );
  }
}
