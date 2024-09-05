import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/Driver_Controllar/auth_controllar/driver_signin_controllar.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';

class DriverSetNewPasswordScreen extends StatelessWidget {
  DriverSetNewPasswordScreen({super.key});

  DriverSignInControllar signInCtrl=Get.put(DriverSignInControllar());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(

          child:Obx(() =>  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: Dimensions.paddingSizeExtraLarge,),
              CustomText(
                text: AppString.forgotPasswordText2.tr,
                fontsize: 28,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                color: Get.theme.primaryColor,

              ),
              CustomText(

                text: AppString.subforgotPasswordText2.tr,
                fontsize: 17,
                fontWeight: FontWeight.w400,
                maxline: 3,
                textAlign: TextAlign.start,

              ),

              ///================ Field ==================>

              SizedBox(height: Dimensions.paddingSizeExtraLarge,),

              CustomText(
                left: 5,
                text: AppString.setNewPasswordText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),

              SizedBox(height: Dimensions.paddingSizeSmall,),
              CustomTextField(

                controller:signInCtrl.newPassCtrl ,
                filColor: Colors.transparent,
                isPassword: true,
              ),

              SizedBox(height: Dimensions.paddingSizeSmall,),

              CustomText(
                left: 5,
                text: AppString.confiramPasswordText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),

              SizedBox(height: Dimensions.paddingSizeSmall,),
              CustomTextField(

                controller:signInCtrl.confiramPassCtrl ,
                filColor: Colors.transparent,
                isPassword: true,
              ),


              SizedBox(height: Dimensions.fontpaddingOverLarge,),
              signInCtrl.setPasswordLoading.value?CustomPageLoading(): CustomButton(
                onTap: (){
                  signInCtrl.driverSetNewPassword();
                },
                height: 58.h,
                width: 342.w,
                text:AppString.update.tr,
                textStyle: AppStyles.h7(
                    color: AppColors.whiteColor,
                    letterSpacing: 2
                ),
              ),

            ],
          )),
        ),
      ),
    );
  }
}
