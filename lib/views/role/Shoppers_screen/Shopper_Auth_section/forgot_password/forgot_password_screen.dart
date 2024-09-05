import 'package:aidaly/controllers/Role/Shopper_Controllar/auth_controllar/signin_controllar.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';

class ShopperForgotPasswortScreen extends StatelessWidget {
  ShopperForgotPasswortScreen({super.key});

   SignInControllar forgotPassCtrl=Get.put(SignInControllar());

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              text: AppString.emaiUpText.tr,
              fontsize: 17,
              fontWeight: FontWeight.w500,
              maxline: 3,
              textAlign: TextAlign.start,
            ),

            SizedBox(height: Dimensions.paddingSizeSmall,),
            CustomTextField(
              controller:forgotPassCtrl.forgotEmailCtrl,
              filColor: Colors.transparent,
              isEmail: true,
            ),
            SizedBox(height: Dimensions.fontpaddingOverLarge,),

            Obx(() => forgotPassCtrl.loading.value?CustomPageLoading():CustomButton(
              onTap: (){
                forgotPassCtrl.shopperForgotPass();
              },
              height: 58.h,
              width: 342.w,
              text:AppString.continuesText.tr,
              textStyle: AppStyles.h7(
                  color: AppColors.whiteColor,
                  letterSpacing: 2
              ),
            ),)
            
          ],
        ),
      ),
    );
  }
}
