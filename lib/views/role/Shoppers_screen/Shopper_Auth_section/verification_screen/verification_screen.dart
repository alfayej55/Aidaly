import 'package:aidaly/controllers/Role/Shopper_Controllar/auth_controllar/signup_controllar.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../utils/app_colors.dart';

class ShopperVerificationScreen extends StatelessWidget {
  ShopperVerificationScreen({super.key});

  TextEditingController pinCodeCtrl = TextEditingController();

  var verifaiEmail=Get.arguments;

  RegisterControllar registerCtrl=Get.put(RegisterControllar());

  @override
  Widget build(BuildContext context) {
    print('Email>>$verifaiEmail');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                AppString.verificationText.tr,
                style: AppStyles.h1(color: Get.theme.primaryColor),
              ),
              Text(AppString.subVerificationText.tr, style: AppStyles.h4()),
              SizedBox(
                height: 30.h,
              ),

              /// Otp Field

              Text(AppString.oTPCodeText.tr, style: AppStyles.h8()),
              SizedBox(
                height: 10.h,
              ),

              PinCodeTextField(
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                controller: pinCodeCtrl,
                autoDisposeControllers: false,
                enablePinAutofill: true,
                appContext: (context),
                autoFocus: true,
                textStyle: const TextStyle(),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(16).r,
                  fieldHeight: 58.h,
                  fieldWidth: 45.w,
                  activeFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  borderWidth: 0.5,
                  errorBorderColor: Colors.red,
                  activeBorderWidth: 0.5,
                  selectedColor: Get.theme.primaryColor,
                  inactiveColor: Get.theme.primaryColor.withOpacity(0.1),
                ),
                length: 6,
                enableActiveFill: true,
              ),

              SizedBox(
                height: 30.h,
              ),
              ///  Otp Buttton
              registerCtrl.verificationLoading.value?CustomPageLoading():   CustomButton(onTap: (){
                registerCtrl.shopperOtpVerification(verifaiEmail, pinCodeCtrl.text);
              }, text: AppString.continuesText.tr),


              SizedBox(
                height: 10.h,
              ),

              GestureDetector(
                onTap: (){
                  registerCtrl.shopperResentOtp(verifaiEmail);
                },
                  child:registerCtrl.resentOtpLoading.value?CustomPageLoading(): Align(
                    alignment: Alignment.center,
                      child: Text(AppString.reSentCodeText.tr, style: AppStyles.h8(color: Get.theme.primaryColor)))),
            ])),

      ),
    );
  }
}
