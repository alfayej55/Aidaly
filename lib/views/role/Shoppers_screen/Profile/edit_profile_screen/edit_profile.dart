import 'dart:io';

import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../../controllers/Role/Shopper_Controllar/shopper_profile_controller.dart';
import '../../../../../utils/app_Image.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dimensions.dart';
import 'edit_profile_controllar/edit_controllar.dart';
import 'innerWidget/show_image_pic.dart';
import 'innerWidget/show_image_widget.dart';
class EditProfileScreen extends StatefulWidget {


   EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   ShopperProfileController _profileCtrl=Get.put(ShopperProfileController());

   updateData(){

     _profileCtrl.fullNameCtrl.text=_profileCtrl.profilModel.value.name!;
     _profileCtrl.emailCtrl.text = _profileCtrl.profilModel.value.email!;
     _profileCtrl. phoneCtrl.text = _profileCtrl.profilModel.value.phone!;
     _profileCtrl. addressCtrl.text = _profileCtrl.profilModel.value.address!;
     _profileCtrl.cityCtrl.text = _profileCtrl.profilModel.value.city!;
     _profileCtrl.stateCtrl.text = _profileCtrl.profilModel.value.state!;

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
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              Align(
                alignment: Alignment.center,
                child:ShopperShowImage(),
              ),


              SizedBox(height: Dimensions.paddingSizeLarge.h,),

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

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              Text(
                AppString.fullNameText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                  controller: _profileCtrl.fullNameCtrl,
                  hintText: 'john peter',

              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              /// Email
              Text(
                AppString.emaiUpText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: _profileCtrl.emailCtrl,
                readOnly: true,
                hintText: 'test1123@gmail.com',


              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              /// Phone Number

              Text(
                AppString.phoneText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: _profileCtrl.phoneCtrl,
                hintText: '+92 123456789',

              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

             /// Address

              Text(
                AppString.addressText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: _profileCtrl.addressCtrl,
                hintText: 'Selina K, 21/3, Ragava Street, Silver tone',

              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

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
                          controller: _profileCtrl.cityCtrl,
                          filColor: Colors.transparent,
                          isEmail: true,
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
                          controller: _profileCtrl.stateCtrl,
                          filColor: Colors.transparent,
                          isEmail: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

          /// Save Changes Button

            Obx(()=> CustomButton(
               loading: _profileCtrl.shopperLoading.value,
                onTap: (){
                 _profileCtrl.shopperProfileEdit();
                }, text: AppString.saveChangesText.tr)),

              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

            ],
          ),
        ),
      ),
    );
  }
}

