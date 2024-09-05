import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';

class DriverAccountSuccessFullScreen extends StatelessWidget {
  const DriverAccountSuccessFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
          CustomText(
            left: 20,
            right: 20,
            text: AppString.accountSuccessText.tr,
            fontsize: 28.h,
            maxline: 5,
            fontWeight: FontWeight.w600,
            color: Get.theme.primaryColor,
          ),
          CustomText(
            left: 20,
            right: 20,
            text: AppString.subaccountSuccessText.tr,
            textAlign: TextAlign.center,
            textStyle: AppStyles.h4(),
            maxline: 5,
          ),
          SizedBox(height: Dimensions.paddingSizeSmall,),
          SvgPicture.asset(AppImages.accountSuccessImage),

    ///>>>>>>>>>>>>>>>>>>>>>>>>> Continue Button>>>>>>>>>>>>>>>>>

           Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: (){
                  Get.toNamed(AppRoutes.driversloginScreen);
                },
                height: 58.h,
                width: 342.w,
                text:AppString.continuesText.tr,
                textStyle: AppStyles.h7(
                    color: AppColors.whiteColor,
                    letterSpacing: 2
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.paddingSizeSmall,),
          
        ],
      ),
    );
  }
}
