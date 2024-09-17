import 'dart:io';

import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/Role/Driver_Controllar/auth_controllar/vehicle_controllar.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/app_string.dart';
import '../../../base/custom_button.dart';

class DriverVehicleScreen extends StatelessWidget {
  DriverVehicleScreen({super.key});
  VehicleControllar vehicleCtrl=Get.put(VehicleControllar());


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:InkWell(
          onTap: (){
            Get.back();
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.arrow_back,size: 25,)),
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(

          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: Dimensions.paddingSizeExtraLarge,),
              Text(
                AppString.editVehicleText.tr,
                style: AppStyles.h1(color: Get.theme.primaryColor),

              ),
              Text(
                AppString.subeditVehicleText.tr,
                style: AppStyles.h4(),
              ),

              SizedBox(height: Dimensions.paddingSizeExtraLarge,),

              ///================ Field ==================>


              /// Make Text

              Text(
                AppString.makeText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall,),
              CustomTextField(
                controller: vehicleCtrl.makeCtrl,
                contentPaddingVertical:15.h,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall,),

              /// Model

              Text(
                AppString.modelText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall,),
              CustomTextField(
                controller:vehicleCtrl. modelCtrl,
                contentPaddingVertical:15.h,

              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall,),



              /// Year Text
              Text(
                AppString.yearText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall,),

              CustomTextField(
                controller: vehicleCtrl.yearCtrl,
                contentPaddingVertical:15.h,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall,),


              /// Registration Number
              Text(
                AppString.registrationNumberText.tr,
                style: AppStyles.h8(),
              ),

              SizedBox(height: Dimensions.fontSizeExtraSmall,),
              CustomTextField(
                controller:vehicleCtrl. registerCtrl,
                contentPaddingVertical:15.h,
              ),

              SizedBox(height: Dimensions.fontSizeExtraSmall,),


              ///================ Driver License Pic Section  ==================>

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ///Driver License

                  Expanded(
                    child: Column(
                      children: [
                        Text(AppString.driverLicenseText.tr,style: AppStyles.customSize(size: 13,fontWeight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        InkWell(
                          onTap: (){
                            vehicleCtrl.pickImageFromCamera('licenseImage');
                          },
                          child: vehicleCtrl.driverLicenseImage.isNotEmpty?Container(
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                image: DecorationImage(
                                    image: FileImage(

                                      File(vehicleCtrl.driverLicenseImage.value),
                                    ),fit: BoxFit.cover ),
                                border: Border.all(
                                  color:AppColors.subTextColor.withOpacity(0.1),

                                )
                            ),

                          ): Container(
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                color: Get.theme.primaryColor.withOpacity(0.1)
                            ),
                            child: Center(child: Icon(Icons.camera_alt),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w,),

                  ///Driver Register
                  Expanded(
                    child: Column(
                      children: [
                        Text(AppString.registrationText.tr,style: AppStyles.customSize(size: 13,fontWeight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        InkWell(
                          onTap: (){
                            vehicleCtrl.pickImageFromCamera('registrationImage');
                          },
                          child: vehicleCtrl.driverRegistrationImage.isNotEmpty?Container(
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                image: DecorationImage(
                                    image: FileImage(
                                      File(vehicleCtrl.driverRegistrationImage.value),
                                    ),fit: BoxFit.cover ),
                                border: Border.all(
                                  color:AppColors.subTextColor.withOpacity(0.1),

                                )
                            ),

                          ): Container(
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                color: Get.theme.primaryColor.withOpacity(0.1)
                            ),
                            child: Center(child: Icon(Icons.camera_alt),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w,),

                  ///Driver PoliceCheck

                  Expanded(
                    child: Column(
                      children: [
                        Text(AppString.policeCheckText.tr,style: AppStyles.customSize(size: 13,fontWeight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        InkWell(
                          onTap: (){
                            vehicleCtrl.pickImageFromCamera('policeCheckImage');
                          },
                          child: vehicleCtrl.driverPoliceCheckImage.isNotEmpty?Container(
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                image: DecorationImage(
                                    image: FileImage(
                                      File(vehicleCtrl.driverPoliceCheckImage.value),
                                    ),fit: BoxFit.cover ),
                                border: Border.all(
                                  color:AppColors.subTextColor.withOpacity(0.1),

                                )
                            ),

                          ): Container(
                            height:120.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                color: Get.theme.primaryColor.withOpacity(0.1)
                            ),
                            child: Center(child: Icon(Icons.camera_alt),),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              /// Update Button
              SizedBox(height: Dimensions.fontSizeOverLarge,),
              Obx(()=>CustomButton(
                  loading: vehicleCtrl.vechicleLoading.value,
                  padding: EdgeInsets.only(bottom: 30.h),
                  onTap: (){
                    vehicleCtrl.driverVehicleDetails();
                  }, text: AppString.continuesText.tr)),

            ],
          )),
        ),
      ),
    );
  }
}

