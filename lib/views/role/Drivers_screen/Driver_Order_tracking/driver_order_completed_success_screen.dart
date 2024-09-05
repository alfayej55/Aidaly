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
import '../../../base/custom_button.dart';


class DriverOrderCompletedSuccessScreen extends StatelessWidget {
  const DriverOrderCompletedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:70.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200.h,),
            Text(
              AppString.orderCompletedSuccessText.tr,
              textAlign: TextAlign.center,
              style: AppStyles.h1(
                color: Get.theme.primaryColor,
              ),
            ),

            Text(
              AppString.suborderCompletedSuccessText.tr,
              textAlign: TextAlign.center,
              style: AppStyles.h6(
                color: Get.theme.disabledColor,
              ),
            ),

            SizedBox(height: Dimensions.paddingSizeSmall,),
            SvgPicture.asset(AppImages.accountSuccessImage),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  padding: EdgeInsets.only(bottom: 15.h),
                  onTap: (){
                    Get.offAllNamed(AppRoutes.driversHomeScreen);
                  },

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
