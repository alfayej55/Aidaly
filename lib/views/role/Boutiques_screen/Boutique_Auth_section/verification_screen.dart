import 'dart:async';

import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controllers/Role/BoutiquesControllar/auth_controllar/boutique_signup_controllar.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';

class BoutiqueVerificationScreen extends StatefulWidget {
  BoutiqueVerificationScreen({super.key});

  @override
  State<BoutiqueVerificationScreen> createState() => _BoutiqueVerificationScreenState();
}

class _BoutiqueVerificationScreenState extends State<BoutiqueVerificationScreen> {
  TextEditingController pinCodeCtrl = TextEditingController();

  BoutiqueSignUpControllar signUpCtrl=Get.put(BoutiqueSignUpControllar());

  var verifaiEmail=Get.arguments;

  final formKey = GlobalKey<FormState>();


  int _start = 180; // 3 minutes in seconds
  Timer _timer = Timer(Duration(seconds: 1), () {});

  startTimer() {
    print("Start Time$_start");
    print("Start Time$_timer");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }


  @override
  void initState() {
    super.initState();
   startTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child:Obx(() =>  Column(
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
              signUpCtrl.verificationLoading.value?CustomPageLoading(): CustomButton(onTap: (){
                signUpCtrl.boutiqueOtpVerification(verifaiEmail, pinCodeCtrl.text);
              }, text: AppString.continuesText.tr),

              SizedBox(
                height: 10.h,
              ),

              Align(
                alignment: Alignment.center,
                  child: Text(timerText,style: AppStyles.h3(color: AppColors.primaryColor),)),
              SizedBox(height: 5.h,),

              timerText == 00.00? SizedBox(): GestureDetector(
                  onTap: (){

                    if(timerText=="00:00"){
                      setState(() {
                        _start=180;
                        startTimer();
                        signUpCtrl.boutiqueResentOtp(verifaiEmail);
                      });
                    }
                    else{
                      showToastMessage.showMessage("Please wait 3 minute");
                    }
                  },
                  child:signUpCtrl.resentOtpLoading.value?CustomPageLoading():
                  Align(
                      alignment: Alignment.center,
                      child: Text(AppString.reSentCodeText.tr, style: AppStyles.h8(color: Get.theme.primaryColor)))),

            ]),)

      ),
    );
  }
}
