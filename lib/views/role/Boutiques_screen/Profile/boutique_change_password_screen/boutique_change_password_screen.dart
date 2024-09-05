import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/BoutiquesControllar/profile_controllar.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';

class BoutiqueChangepasswordScreen extends StatelessWidget {
  BoutiqueChangepasswordScreen({super.key});

  BoutiqueProfileControllar _profileCtrl = Get.put(BoutiqueProfileControllar());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.arrow_back,
                size: 25,
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),
                  Text(
                    AppString.changepasswordText.tr,
                    style: AppStyles.h1(color: Get.theme.primaryColor),
                  ),
                  Text(
                    AppString.secureyouraccountText.tr,
                    style: AppStyles.h4(),
                  ),

                  ///================ Field ==================>

                  SizedBox(
                    height: Dimensions.paddingSizeExtraLarge,
                  ),

                  /// Old Password

                  Text(
                    AppString.oldPasswordText.tr,
                    style: AppStyles.h8(),
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  CustomTextField(
                    controller: _profileCtrl.oldpasswordCtrl,
                    contentPaddingVertical: 15.h,
                    isPassword: true,
                    hintText: 'Old Password',
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),

                  /// New Password

                  Text(
                    AppString.newPasswordText.tr,
                    style: AppStyles.h8(),
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),
                  CustomTextField(
                    controller: _profileCtrl.newpassCtrl,
                    contentPaddingVertical: 15.h,
                    isPassword: true,
                    hintText: 'New Password',
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),

                  /// Confirm Password
                  Text(
                    AppString.confiramPasswordText.tr,
                    style: AppStyles.h8(),
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),

                  CustomTextField(
                    controller: _profileCtrl.confirmpassCtrl,
                    contentPaddingVertical: 15.h,
                    isPassword: true,
                    hintText: 'Confirm Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your confirm password';
                      } else if (value != _profileCtrl.newpassCtrl.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.paddingSizeSmall,
                  ),

                  /// Update Button

                  SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),

               Obx(() => CustomButton(
                 loading: _profileCtrl.changePassLoading.value,
                   onTap: () {
                 if(formKey.currentState!.validate()){
                   _profileCtrl.changePassword();
                 }
               }, text: AppString.update.tr))

                ],
              )),
        ),
      ),
    );
  }
}
