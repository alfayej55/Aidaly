import 'dart:io';

import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../controllers/Role/Shopper_Controllar/auth_controllar/signup_controllar.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_page_loading.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';
import 'innerWidget/show_image_pic.dart';
class ShopperSingUpScreen extends StatelessWidget {
  ShopperSingUpScreen({super.key});

  RegisterControllar registerCtrl=Get.put(RegisterControllar());
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
                        registerCtrl.imagePath.value.isNotEmpty? Container(
                          height: 90.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: FileImage(
                                File(registerCtrl.imagePath.value),
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
              CustomText(
                left: 5,
                text: AppString.fullNameText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h,),

              /// Full Name

              CustomTextField(
                controller: registerCtrl.fullNameCtrl,
                filColor: Colors.transparent,
                contentPaddingVertical: 15.h,
                hintText: 'Full Name',

              ),

              SizedBox(height: Dimensions.fontSizeExtraSmall),
              CustomText(
                left: 5,
                text: AppString.emaiUpText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),

              /// Email

              CustomTextField(
                controller: registerCtrl.emailCtrl,
                filColor: Colors.transparent,
                contentPaddingVertical: 15.h,
                hintText: 'Email',
                isEmail: true,
              ),

              SizedBox(height: Dimensions.fontSizeExtraSmall),
              CustomText(
                left: 5,
                text: AppString.dateOfBirthText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),

              /// Date of Birth

              GestureDetector(
                onTap: ()async{
                  registerCtrl.selectDate(context);
                },
                child: Container(
                  height: 58,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Get.theme.primaryColor.withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          registerCtrl.selectedDate != null
                              ? registerCtrl.selectedDate.value
                              : 'Select your Date of Birth',
                          // age(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)
                        ),
                        SvgPicture.asset(AppIcons.calender,)
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.fontSizeExtraSmall),

              CustomText(
                left: 5,
                text: AppString.phoneText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),

              /// Phone Number

              CustomTextField(
                controller: registerCtrl.phoneNumberCtrl,
                filColor: Colors.transparent,
                contentPaddingVertical: 15.h,
                hintText: 'Phone Number',
                keyboardType: TextInputType.number,

              ),


              SizedBox(height: Dimensions.fontSizeExtraSmall),
              CustomText(
                left: 5,
                text: AppString.addressText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),

              /// Address

              CustomTextField(
                controller: registerCtrl.addressCtrl,
                filColor: Colors.transparent,
                contentPaddingVertical: 15.h,
                hintText: 'Address',

              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),

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
                          controller: registerCtrl.cityCtrl,
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
                          controller: registerCtrl.stateCtrl,
                          filColor: Colors.transparent,
                          hintText: 'State',
                        ),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(height: 20),
              SizedBox(height: Dimensions.fontSizeExtraSmall),
              CustomText(
                left: 5,
                text: AppString.passwordText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),

              SizedBox(height: Dimensions.fontSizeExtraSmall),

              /// Password

              CustomTextField(
                controller: registerCtrl.passwordCtrl,
                filColor: Colors.transparent,
                contentPaddingVertical: 15.h,
                hintText: 'Password',
                isPassword: true,

              ),


              SizedBox(height: Dimensions.fontSizeExtraSmall),


              CustomText(
                left: 5,
                text: AppString.confiramPasswordText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: Dimensions.fontSizeExtraSmall),


              /// Confiram Password

              CustomTextField(
                controller: registerCtrl.confirmpasswordCtrl,
                filColor: Colors.transparent,
                isPassword: true,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Enter your confirm password';
                  } else if (value != registerCtrl.passwordCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                contentPaddingVertical: 15.h,
                hintText: ' Confirm Password',
              ),

              SizedBox(height: Dimensions.fontSizeOverLarge),

              ///    ................  SignUp Button.........

              registerCtrl.signUpLoading.value?CustomPageLoading():   CustomButton(
                onTap: (){
                  if(formKey.currentState!.validate()){
                    registerCtrl.shopperSingUp();
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
              SizedBox(height: Dimensions.fontSizeOverLarge),

              /// ................. I don’t have an account? Login  ...........

              InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.loginScreen);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: AppString.signInRouteText.tr,
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
          )
          ),
        )),
      ),
    );
  }
}
