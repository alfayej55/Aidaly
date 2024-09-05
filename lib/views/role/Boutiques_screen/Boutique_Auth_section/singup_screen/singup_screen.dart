import 'dart:io';

import 'package:aidaly/helpers/push_notification_helpers.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/BoutiquesControllar/auth_controllar/boutique_signup_controllar.dart';
import '../../../../../controllers/Role/Shopper_Controllar/auth_controllar/signup_controllar.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';
import 'innerWidget/show_image_pic.dart';
class BoutiqueSingUpScreen extends StatelessWidget {
  BoutiqueSingUpScreen({super.key});

  BoutiqueSignUpControllar signUpCtrl=Get.put(BoutiqueSignUpControllar());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(

        child: Form(
          key: formKey,
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:   Obx(() =>  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height:50.h),
              ///================ Image==================>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.arrow_back,size: 25,)),
                  ),

                  GestureDetector(
                    onTap: (){
                      ShowImagePickerRegister().showImagePickerOption(context);

                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        signUpCtrl.imagePath.value.isNotEmpty? Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: FileImage(
                                File(signUpCtrl.imagePath.value),
                              ),fit: BoxFit.cover ),
                              border: Border.all(
                                color:AppColors.subTextColor.withOpacity(0.1),

                              )
                          ),

                        ):Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color:AppColors.subTextColor.withOpacity(0.1),

                              )
                          ),
                          child: Center(
                            child: SvgPicture.asset(AppImages.registerImage),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Get.theme.primaryColor,
                            child: Center(
                              child: Icon(Icons.add,color: AppColors.whiteColor,size: 15,),
                            ),
                          ),
                        )

                      ],

                    ),
                  ),
                  Container()
                ],
              ),
              SizedBox(height: 20.h,),

              ///================ sign Up Text==================>
              CustomText(
                text: AppString.singUpText.tr,
                fontsize: 28,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                color: Get.theme.primaryColor,

              ),
              CustomText(
                text: AppString.subsingUpText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w400,
                maxline: 3,
                textAlign: TextAlign.start,

              ),

              ///================ sign Up Field ==================>

              SizedBox(height: Dimensions.fontSizeExtraSmall),

              //
              // CustomText(
              //   left: 5,
              //   text: AppString.boutiqueNameText.tr,
              //   fontsize: 17,
              //   fontWeight: FontWeight.w500,
              //   maxline: 3,
              //   textAlign: TextAlign.start,
              // ),
              // SizedBox(height: 10.h,),

              ///Full Name

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              Text(
                AppString.boutiqueNameText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: signUpCtrl.boutiqueNameCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'Boutique Name',

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
                controller: signUpCtrl.boutiqueRateCtrl,
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
                controller: signUpCtrl.emailCtrl,
                contentPaddingVertical: 15.h,
                isEmail: true,
                hintText: 'Email',
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),



              /// Password
              Text(
                AppString.passwordText.tr,
                style: AppStyles.h8(),
              ),
              CustomTextField(
                controller: signUpCtrl.passwordCtrl,
                filColor: Colors.transparent,
                isPassword: true,
                contentPaddingVertical: 15.h,
                hintText: 'Password',
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),



              /// Confiram Password
              Text(
                AppString.confiramPasswordText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),
              CustomTextField(
                controller: signUpCtrl.confirmCtrl,
                filColor: Colors.transparent,
                isPassword: true,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Enter your confirm password';
                  } else if (value != signUpCtrl.passwordCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                contentPaddingVertical: 15.h,
                hintText: ' Confirm Password',
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              /// Phone Number

              Text(
                AppString.phoneText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: signUpCtrl.phoneCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'Phone Number',
                keyboardType: TextInputType.number,


              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              /// Address

              Text(
                AppString.addressText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: signUpCtrl.addressCtrl,
                contentPaddingVertical: 15.h,
                hintText: 'Address',

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
                          controller: signUpCtrl.cityCtrl,
                          filColor: Colors.transparent,
                          hintText: 'City',

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
                          controller: signUpCtrl.stateCtrl,
                          filColor: Colors.transparent,
                          hintText: 'State',

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
                controller: signUpCtrl.descriptionCtrl,
                contentPaddingVertical: 15.h,
                maxLine: 3,
                hintText: 'Description',
              ),
              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

              /// ................. Button ...........

             signUpCtrl.signUpLoading.value?CustomPageLoading(): CustomButton(
                onTap: (){

                  if(formKey.currentState!.validate()){
                    signUpCtrl.boutiqueSingUp();
                  }
                },
                height: 58.h,
                width: 342.w,
                text: AppString.singUpText.tr,
                textStyle: AppStyles.h7(
                    color: AppColors.whiteColor,
                    letterSpacing: 2
                ),
              ),

              /// ................. I don’t have an account? Login  ...........

              SizedBox(height: Dimensions.fontSizeOverLarge),


              InkWell(
                onTap:(){


                  Get.toNamed(AppRoutes.boutiqueloginScreen);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: AppString.autherAccountText.tr,
                              style: AppStyles.h5(
                                  color: Get.theme.disabledColor
                              )
                          ),
                          TextSpan(
                              text: AppString.loginText.tr,
                              style: AppStyles.h3(
                                  color: Get.theme.primaryColor
                              )
                          )
                        ]
                    ),

                  ),
                ),
              ),

              SizedBox(height: Dimensions.fontSizeOverLarge),

            ],
          )),
        )),
      ),
    );
  }
}
