import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../base/custom_button.dart';

class OrderBookedSuccessScreen extends StatelessWidget {
  const OrderBookedSuccessScreen({super.key});

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
              AppString.orderBookesuccessText.tr,
              textAlign: TextAlign.center,
              style: AppStyles.h1(
                color: Get.theme.primaryColor,
              ),
            ),

            Text(
              AppString.suborderBookesuccessText.tr,
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
                  onTap: (){
                    Get.toNamed(AppRoutes.homeScreen);
                  },
                  height: 58.h,
                  width: 342.w,
                  text:AppString.trackorderText.tr,
                  textStyle: AppStyles.h7(
                      color: AppColors.whiteColor,
                      letterSpacing: 2
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.paddingSizeExtraLarge,),

          ],
        ),
      ),
    );
  }
}
