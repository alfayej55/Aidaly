import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../../controllers/Role/BoutiquesControllar/profile_controllar.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_text_field.dart';
class BoutiqueHelpAndSupportScreen extends StatelessWidget {
  BoutiqueHelpAndSupportScreen({super.key});



  BoutiqueProfileControllar profileCtrl=Get.put(BoutiqueProfileControllar());

  TextEditingController emailCtrl=TextEditingController();
  TextEditingController describeCtrl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.helpText.tr,
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

       body: SingleChildScrollView(

         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [

             SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

             Align(
               alignment: Alignment.center,
                 child: SvgPicture.asset(AppImages.helpsupportimage)),
         
             SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),
         
             /// Email
         
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 24.w),
               child: Text(
                 AppString.emaiUpText.tr,
                 style: AppStyles.h8(),
               ),
             ),
             SizedBox(height: Dimensions.paddingSizeSmall.h,),
             CustomTextField(
               controller: emailCtrl,
               contentPaddingVertical:15.h,
               contentPaddingHorizontal: 24.w,
         
             ),
             SizedBox(height: Dimensions.paddingSizeminiSmall.h,),
         
         
           ///Describe your issue
         
         
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 24.w),
               child: Text(
                 AppString.describeyourissueText.tr,
                 style: AppStyles.h8(),
               ),
             ),
             SizedBox(height: Dimensions.paddingSizeSmall.h,),
             CustomTextField(
               controller: describeCtrl,
               contentPaddingVertical:15.h,
               maxLine: 3,
               contentPaddingHorizontal: 24.w,
             ),
             SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

         /// SubMit Button

             Obx(
                 ()=> Align(
                 alignment: Alignment.center,
                   child: CustomButton(
                     loading:profileCtrl.helpSupportLoading.value ,
                       onTap: (){
                         profileCtrl.helpAndSupport(emailCtrl.text,describeCtrl.text);
                   }, text: AppString.submit.tr)),
             )
         
           ],
         ),
       ),
    );
  }
}
