

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_Image.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';

class TermAcceptSuccesscScreen extends StatelessWidget {
  const TermAcceptSuccesscScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:80.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200.h,),
            Text(
              "Your Term Of Use Accept Confirm",
              textAlign: TextAlign.center,
              style: AppStyles.h1(
                color: Get.theme.primaryColor,
              ),
            ),

            // Text(
            //   AppString.suborderCompletedSuccessText.tr,
            //   textAlign: TextAlign.center,
            //   style: AppStyles.h6(
            //     color: Get.theme.disabledColor,
            //   ),
            // ),
            //
            // SizedBox(height: Dimensions.paddingSizeSmall,),
            SvgPicture.asset(AppImages.accountSuccessImage),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  padding: EdgeInsets.only(bottom: 15.h),
                  onTap: (){
                    Get.back();
                  },
                  height: 58.h,
                  width: 342.w,
                  text:AppString.doneText.tr,
                  textStyle: AppStyles.h7(
                      color: AppColors.whiteColor,
                      letterSpacing: 2
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
