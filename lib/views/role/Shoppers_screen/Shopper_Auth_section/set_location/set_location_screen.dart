import 'package:aidaly/controllers/Role/Shopper_Controllar/auth_controllar/signup_controllar.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../base/custom_button.dart';

class ShopperSetLocationScreen extends StatelessWidget {
   ShopperSetLocationScreen({super.key});


  RegisterControllar registerCtrl=Get.put(RegisterControllar());

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

      body: Column(

        children: [

           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                left: 20,
                right: 20,
                text: AppString.setLocationText.tr,
                fontsize: 28.h,
                fontWeight: FontWeight.w600,
                color: Get.theme.primaryColor,
              ),
              CustomText(
                left: 20,
                right: 20,
                text: AppString.subsetLocationText.tr,
                textAlign: TextAlign.start,
                textStyle: AppStyles.h4(),
                maxline: 9,
              ),
            ],
          ),

             SizedBox(height: Dimensions.paddingSizeExtraLarge,),
             Image.asset(AppImages.locationImage),
             SizedBox(height: Dimensions.paddingSizeExtraLarge,),

           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
             
               children: [
              /// ........... Set Location Button ...........

                 CustomButton(
                   onTap: (){
                     registerCtrl.getCurrentLocation().then((value) => registerCtrl.shopperSetLocation());
                    // Get.toNamed(AppRoutes.accountSuccessScreen);
                   },
                   height: 58.h,
                   width: 342.w,
                   text: AppString.userCurrentLocationText.tr,
                   textStyle: AppStyles.h7(
                       color: AppColors.whiteColor,
                       letterSpacing: 2
                   ),
                 ),
                 SizedBox(height: Dimensions.paddingSizeSmall,),

                 /// ........... Set  For Map Location Button ...........

                 InkWell(
                   onTap: (){

                   },
                   child: Container(
                     height: 58.h,
                     width: 342.w,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(18.r),
                         border: Border.all(color: Get.theme.primaryColor)
                     ),

                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         SvgPicture.asset(AppIcons.currentLocationIcon),
                         SizedBox(width:Dimensions.fontSizeSmall),
                         CustomText(
                           text: AppString.setFromMapText.tr,
                           fontWeight: FontWeight.w600,
                           color: Get.theme.primaryColor,
                           maxline: 9,
                         ),

                       ],
                     ),
                   ),
                 )
               ],
             ),
           ),
          SizedBox(height: Dimensions.paddingSizeExtraLarge,),


        ],
      ),
    );
  }
}
