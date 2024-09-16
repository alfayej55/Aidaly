import 'package:aidaly/controllers/Role/BoutiquesControllar/auth_controllar/boutique_signin_controllar.dart';
import 'package:aidaly/helpers/push_notification_helpers.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../../../controllers/Role/other_login_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_string.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';
import 'innerWidget/sociallogin_button.dart';


class BoutiqueLoginScreen extends StatelessWidget {
  BoutiqueLoginScreen({super.key});

  BoutiqueSignInControllar signInCtrl=Get.put(BoutiqueSignInControllar());
  OtherLoginController _otherLogingCtrl=Get.put(OtherLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     appBar: AppBar(
       backgroundColor: Colors.transparent,
       leading: InkWell(
         onTap: (){
           Get.back();
         },
           child: Icon(Icons.arrow_back)),
     ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///================ Login Text==================>
              SizedBox(height: 30.h,),
              CustomText(
                text: AppString.loginText.tr,
                fontsize: 28,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                color: Get.theme.primaryColor,

              ),
              CustomText(
                text: AppString.subloginText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w400,
                maxline: 3,
                textAlign: TextAlign.start,
              ),

              ///================ Field ==================>

              SizedBox(height: 35.h,),

              CustomText(
                left: 5,
                text: AppString.emaiUpText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h,),

              /// email
              CustomTextField(
                controller: signInCtrl.emailCtrl,
                filColor: Colors.transparent,
                isEmail: true,
              ),
              SizedBox(height: 15.h,),
              /// password

              CustomText(
                left: 5,
                text: AppString.passwordText.tr,
                fontsize: 17,
                fontWeight: FontWeight.w500,
                maxline: 3,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10.h,),

              CustomTextField(
                controller: signInCtrl.passwordCtrl,
                filColor: Colors.transparent,
                isPassword: true,
              ),
              SizedBox(height: 5.h,),


              /// ........... Forgot password...........


              InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.boutiqueforgotScreen);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    right:15,
                    color: Get.theme.secondaryHeaderColor,
                    text: AppString.forgotPasswordText.tr,
                    fontsize: 12,
                    fontWeight: FontWeight.w500,
                    maxline: 3,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),

              ///================ Login Button ==================>

              SizedBox(height: 35.h,),
              signInCtrl.loading.value?CustomPageLoading(): CustomButton(
                onTap: (){
                  NotificationHelper.getFcmToken();
                  signInCtrl.boutiqueSignIn();
                },
                height: 58.h,
                width: 342.w,
                text: AppString.loginText.tr,
                textStyle: AppStyles.h7(
                    color: AppColors.whiteColor,
                    letterSpacing: 2
                ),
              ),
              // SizedBox(height: 20.h,),
              //
              // ///================ Divider Button ==================>
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SizedBox(
              //       width: 153.w,
              //       child:  Divider(
              //         color: Get.theme.disabledColor,
              //       ),
              //     ),
              //
              //     CustomText(
              //       text: 'Or',
              //       fontsize: 14.sp,
              //       fontWeight: FontWeight.w700,
              //       color: Get.theme.disabledColor,
              //     ),
              //     SizedBox(
              //       width: 153.w,
              //       child: Divider(
              //         color: Get.theme.disabledColor,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.h,),
              // Obx(()=> Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     SocialLoginButton(icon: AppIcons.facebookIcon,),
              //     InkWell(
              //         onTap: (){
              //           _otherLogingCtrl.googleLogin("boutique");
              //         },
              //         child: SocialLoginButton(
              //           loading: _otherLogingCtrl.googleLoginLoading.value,
              //           icon: AppIcons.googleIcon,)),
              //     SocialLoginButton(icon: AppIcons.appleIcon,)
              //   ],
              // ),),
              ///================ Sing up  ==================>
              SizedBox(height: 50.h,),

              InkWell(
                onTap: (){

                  Get.toNamed(AppRoutes.boutiquesingUpScreen);

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
                              text: AppString.singUpText.tr,
                              style: AppStyles.h3(
                                  color: Get.theme.primaryColor
                              )
                          )
                        ]
                    ),

                  ),
                ),
              )

            ],
          )),
        ),
      ),
    );
  }
}
