import 'dart:io';

import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../controllers/Role/Driver_Controllar/driver_profile_controller.dart';
import '../../../../../models/Role/profile_model.dart';
import '../../../../../utils/dimensions.dart';
import 'edit_profile_controllar/edit_controllar.dart';

import 'innerWidget/show_image_widget.dart';

class DriverEditProfileScreen extends StatefulWidget {
  DriverEditProfileScreen({
    super.key,
  });

  @override
  State<DriverEditProfileScreen> createState() =>
      _DriverEditProfileScreenState();
}

class _DriverEditProfileScreenState extends State<DriverEditProfileScreen> {
  
  DriverProfileController profileCtrl = Get.put(DriverProfileController());


  updateData() {

    profileCtrl.fullNameCtrl.text = profileCtrl.profilModel.value.name!;
    profileCtrl.emailCtrl.text = profileCtrl.profilModel.value.email!;
    profileCtrl. phoneCtrl.text = profileCtrl.profilModel.value.phone!;
    profileCtrl. addressCtrl.text = profileCtrl.profilModel.value.address!;
    profileCtrl.cityCtrl.text = profileCtrl.profilModel.value.city!;
    profileCtrl.stateCtrl.text = profileCtrl.profilModel.value.state!;

   // profileCtrl.imagePath.value= profileCtrl.profilModel.value.image!.publicFileUrl!;

  }

  @override
  void initState() {
       updateData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image

              Align(
                alignment: Alignment.center,
                child: DriverShowImage(),
              ),

              SizedBox(
                height: Dimensions.paddingSizeLarge.h,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.editProfileText.tr,
                    style: AppStyles.h1(color: Get.theme.primaryColor),
                  ),
                  Text(
                    AppString.subeditProfileText.tr,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.h4(),
                  )
                ],
              ),

              ///Full Name

              SizedBox(
                height: Dimensions.paddingSizeLarge.h,
              ),
              Text(
                AppString.fullNameText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),
              CustomTextField(
                controller:profileCtrl. fullNameCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'john peter',
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),

              /// Email
              Text(
                AppString.emaiUpText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),
              CustomTextField(
                controller:profileCtrl. emailCtrl,
                contentPaddingVertical: 15.h,
                readOnly: true,
                hintText: 'test1123@gmail.com',
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),

              /// Phone Number

              Text(
                AppString.phoneText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),
              CustomTextField(
                controller:profileCtrl. phoneCtrl,
                contentPaddingVertical: 15.h,
                hintText: '+92 123456789',
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),

              /// Address
              Text(
                AppString.addressText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),
              CustomTextField(
                controller: profileCtrl.addressCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'Selina K, 21/3, Ragava Street, Silver tone',
              ),
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),

              /// City and State

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// City
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.cityText.tr,
                        style: AppStyles.h8(),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall.h,
                      ),
                      Container(
                        width: 166.w,
                        child: CustomTextField(
                          contentPaddingVertical: 15.h,
                          controller:profileCtrl. cityCtrl,
                          filColor: Colors.transparent,
                          hintText: 'Miami',
                        ),
                      ),
                    ],
                  ),

                  /// State

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.stateText.tr,
                        style: AppStyles.h8(),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall.h,
                      ),
                      Container(
                        width: 166.w,
                        child: CustomTextField(
                          contentPaddingVertical: 15.h,
                          controller:profileCtrl. stateCtrl,
                          filColor: Colors.transparent,
                          hintText: 'Florida',
                        ),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: Dimensions.paddingSizeExtraLarge.h,
              ),

              /// Save Changes Button

              CustomButton(
                  padding: EdgeInsets.only(
                    bottom: Dimensions.paddingSizeExtraLarge.h,
                  ),
                  loading: profileCtrl.driverProfileEditLoaditn.value,
                  onTap: () {
                    profileCtrl.driverProfileEdit();
                  },

                  text: AppString.saveChangesText.tr),
            ],
          ))
        ),
      ),
    );
  }
}
