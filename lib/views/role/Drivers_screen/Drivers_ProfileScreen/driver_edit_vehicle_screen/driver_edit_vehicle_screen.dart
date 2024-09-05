import 'dart:io';

import 'package:aidaly/controllers/Role/Driver_Controllar/vehicele_update_controller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/cache_network_image.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/app_string.dart';
import '../../../../base/custom_button.dart';

class DriverEditVehicleScreen extends StatefulWidget {
  DriverEditVehicleScreen({super.key});

  @override
  State<DriverEditVehicleScreen> createState() =>
      _DriverEditVehicleScreenState();
}

class _DriverEditVehicleScreenState extends State<DriverEditVehicleScreen> {
  VehicleUpdateControllar _vehicleCtrl = Get.put(VehicleUpdateControllar());

  @override
  void initState() {
    _vehicleCtrl.vehicleDetails();

    // TODO: implement initState
    super.initState();
  }

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
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(() => _vehicleCtrl.getVechicleLoading.value
            ? CustomPageLoading()
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    Text(
                      AppString.editVehicleText.tr,
                      style: AppStyles.h1(color: Get.theme.primaryColor),
                    ),
                    Text(
                      AppString.subeditVehicleText.tr,
                      style: AppStyles.h4(),
                    ),

                    SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),

                    ///================ Field ==================>

                    /// Make Text

                    Text(
                      AppString.makeText.tr,
                      style: AppStyles.h8(),
                    ),
                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),
                    CustomTextField(
                      controller: _vehicleCtrl.makeCtrl,
                      contentPaddingVertical: 15.h,
                    ),
                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),

                    /// Model

                    Text(
                      AppString.modelText.tr,
                      style: AppStyles.h8(),
                    ),
                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),
                    CustomTextField(
                      controller: _vehicleCtrl.modelCtrl,
                      contentPaddingVertical: 15.h,
                    ),
                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),

                    /// Year Text
                    Text(
                      AppString.yearText.tr,
                      style: AppStyles.h8(),
                    ),
                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),

                    CustomTextField(
                      controller: _vehicleCtrl.yearCtrl,
                      contentPaddingVertical: 15.h,
                    ),
                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),

                    /// Registration Number
                    Text(
                      AppString.registrationNumberText.tr,
                      style: AppStyles.h8(),
                    ),

                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),
                    CustomTextField(
                      controller: _vehicleCtrl.registerCtrl,
                      contentPaddingVertical: 15.h,
                    ),

                    SizedBox(
                      height: Dimensions.fontSizeExtraSmall,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Driver License

                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                AppString.driverLicenseText.tr,
                                style: AppStyles.customSize(
                                    size: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    _vehicleCtrl
                                        .pickImageFromCamera('licenseImage');
                                  },
                                  child: _vehicleCtrl
                                          .driverLicenseImage.isNotEmpty
                                      ? Container(
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30).r,
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    File(_vehicleCtrl
                                                        .driverLicenseImage
                                                        .value),
                                                  ),
                                                  fit: BoxFit.cover),
                                              border: Border.all(
                                                color: AppColors.subTextColor
                                                    .withOpacity(0.1),
                                              )),
                                        )
                                      : CustomNetworkImage(
                                          imageUrl:
                                              '${ApiConstant.imageBaseUrl}/${_vehicleCtrl.vehicleModelList.value.driverLicense!.destination}/${_vehicleCtrl.vehicleModelList.value.driverLicense!.filename}',
                                          height: 120,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          width: double.infinity)),
                              Text(
                                'change',
                                style: AppStyles.customSize(
                                    size: 11, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),

                        ///Driver Register
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                AppString.registrationText.tr,
                                style: AppStyles.customSize(
                                    size: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    _vehicleCtrl.pickImageFromCamera(
                                        'registrationImage');
                                  },
                                  child: _vehicleCtrl
                                          .driverRegistrationImage.isNotEmpty
                                      ? Container(
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30).r,
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    File(_vehicleCtrl
                                                        .driverRegistrationImage
                                                        .value),
                                                  ),
                                                  fit: BoxFit.cover),
                                              border: Border.all(
                                                color: AppColors.subTextColor
                                                    .withOpacity(0.1),
                                              )),
                                        )
                                      : CustomNetworkImage(
                                          imageUrl:
                                              '${ApiConstant.imageBaseUrl}/${_vehicleCtrl.vehicleModelList.value.registration!.destination}/${_vehicleCtrl.vehicleModelList.value.registration!.filename}',
                                          height: 110,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          width: double.infinity)),
                              Text(
                                'change',
                                style: AppStyles.customSize(
                                    size: 11, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),

                        ///Driver PoliceCheck
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                AppString.policeCheckText.tr,
                                style: AppStyles.customSize(
                                    size: 13, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    _vehicleCtrl.pickImageFromCamera(
                                        'policeCheckImage');
                                  },
                                  child: _vehicleCtrl
                                          .driverPoliceCheckImage.isNotEmpty
                                      ? Container(
                                          height: 120.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30).r,
                                              image: DecorationImage(
                                                  image: FileImage(
                                                    File(_vehicleCtrl
                                                        .driverPoliceCheckImage
                                                        .value),
                                                  ),
                                                  fit: BoxFit.cover),
                                              border: Border.all(
                                                color: AppColors.subTextColor
                                                    .withOpacity(0.1),
                                              )),
                                        )
                                      : CustomNetworkImage(
                                          imageUrl:
                                              '${ApiConstant.imageBaseUrl}/${_vehicleCtrl.vehicleModelList.value.policeCheck!.destination}/${_vehicleCtrl.vehicleModelList.value.policeCheck!.filename}',
                                          height: 120,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          width: double.infinity)),
                              Text(
                                'change',
                                style: AppStyles.customSize(
                                    size: 11, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Update Button
                    SizedBox(
                      height: Dimensions.fontSizeOverLarge,
                    ),
                    CustomButton(
                        loading: _vehicleCtrl.vechicleLoading.value,
                        onTap: () {
                          _vehicleCtrl.driverVehicleUpdate();
                        },
                        text: AppString.saveChangesText.tr)
                  ],
                ),
              )),
      ),
    );
  }
}
