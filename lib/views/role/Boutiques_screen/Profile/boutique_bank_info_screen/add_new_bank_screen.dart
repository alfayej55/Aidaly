import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/BoutiquesControllar/boutique_withdrow_controller.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';

class BoutiqueAddNewBank extends StatelessWidget {
   BoutiqueAddNewBank({super.key});

   BoutiqueWithdroController _boutiquewithCtrl=Get.put(BoutiqueWithdroController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.addaNewBankText.tr,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
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
                color: Get.theme.primaryColor,
              )),
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          /// Bank Name
              Text(
                AppString.bankNameText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: _boutiquewithCtrl.bankNameCtrl,
                contentPaddingVertical: 15.h,
          
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
          /// Bank Account
              Text(
                AppString.accountNumberText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: _boutiquewithCtrl.accountNumberCtrl,
                contentPaddingVertical: 15.h,
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              Text(
                AppString.withdrowAmoundText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller: _boutiquewithCtrl.amoundCtrl,
                contentPaddingVertical: 15.h,
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
          
              /// Add Button
          
              SizedBox(height: 40.h,),
             Obx(()=>  CustomButton(
             loading: _boutiquewithCtrl.withdrowLoading.value,
                 onTap: (){
                   _boutiquewithCtrl.withdrowAmound();
                 },
                 text:"Withdrow"))
          
            ],
          ),
        ),
      ),
    );
  }
}
