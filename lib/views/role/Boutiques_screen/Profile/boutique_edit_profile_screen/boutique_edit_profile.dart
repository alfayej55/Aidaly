import 'dart:io';

import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../../controllers/Role/BoutiquesControllar/profile_controllar.dart';
import '../../../../../utils/dimensions.dart';
import 'edit_profile_controllar/edit_controllar.dart';

import 'innerWidget/show_image_widget.dart';
class BoutiqueEditProfileScreen extends StatefulWidget {


  BoutiqueEditProfileScreen({super.key});

  @override
  State<BoutiqueEditProfileScreen> createState() => _BoutiqueEditProfileScreenState();
}

class _BoutiqueEditProfileScreenState extends State<BoutiqueEditProfileScreen> {
  BoutiqueProfileControllar profileEditCtrl=Get.put(BoutiqueProfileControllar());

  updateData(){
    profileEditCtrl.boutiqueNameCtrl.text=profileEditCtrl.profilModel.value.name!;
    profileEditCtrl.emailCtrl.text = profileEditCtrl.profilModel.value.email!;
    profileEditCtrl. phoneCtrl.text = profileEditCtrl.profilModel.value.phone!;
    profileEditCtrl.boutiqueRateCtrl.text = profileEditCtrl.profilModel.value.rate!;
    profileEditCtrl. addressCtrl.text = profileEditCtrl.profilModel.value.address!;
    profileEditCtrl.cityCtrl.text = profileEditCtrl.profilModel.value.city!;
    profileEditCtrl.stateCtrl.text = profileEditCtrl.profilModel.value.state!;
    profileEditCtrl.descriptionCtrl.text = profileEditCtrl.profilModel.value.description!;

  }

  @override
  void initState() {

    profileEditCtrl.profiledata();
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
                child:BoutiqueShowImage(),
              ),


              SizedBox(height: Dimensions.paddingSizeLarge.h,),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.editBoutiqueInfoText.tr,
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
                AppString.boutiqueNameText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                  controller: profileEditCtrl.boutiqueNameCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'john peter',

              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

            /// Boutique Rate

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              Text(
                AppString.boutiqueRateText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: profileEditCtrl.boutiqueRateCtrl,
                contentPaddingVertical: 15.h,
                hintText: '\$-\$\$\$',

              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),


              /// Email
              Text(
                AppString.emaiUpText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: profileEditCtrl.emailCtrl,
                contentPaddingVertical: 15.h,
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
                controller: profileEditCtrl.phoneCtrl,
                contentPaddingVertical: 15.h,
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
                controller: profileEditCtrl.addressCtrl,
                contentPaddingVertical: 15.h,
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
                          controller: profileEditCtrl.cityCtrl,
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
                          controller: profileEditCtrl.stateCtrl,
                          filColor: Colors.transparent,
                          isEmail: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),


              SizedBox(height: Dimensions.paddingSizeSmall.h,),

          /// Description
              Text(
                AppString.descriptionText.tr,
                style: AppStyles.h8(),
              ),

              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: profileEditCtrl.descriptionCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'Description',
                maxLine: 3,
              ),

              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

          /// Save Changes Button

            CustomButton(
              loading:  profileEditCtrl.boutiqueLoading.value,
                onTap: (){
               profileEditCtrl.boutiqueProfileEdit();
             }, text: AppString.saveChangesText.tr),

              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),


            ],
          ),
        ),
      ),
    );
  }
}

