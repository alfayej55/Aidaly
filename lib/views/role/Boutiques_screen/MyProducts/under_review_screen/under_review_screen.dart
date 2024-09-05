import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_string.dart';
import '../../../../base/custom_button.dart';


class UnderReviewScreen extends StatelessWidget {
  const UnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Spacer(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal:59.w ),
            child: Text(

              AppString.productUnderReviewText.tr,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.customSize(size: 23.27,fontWeight: FontWeight.w700,color: Get.theme.primaryColor),
            ),
          ),
          SizedBox(height: Dimensions.paddingSizeExtraSmall,),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal:59.w ),
            child: Text(
              AppString.subproductUnderReviewText.tr,
              textAlign: TextAlign.center,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.customSize(size: 12,fontWeight: FontWeight.w400,color: Get.theme.disabledColor),
            ),
          ),

          SizedBox(height: Dimensions.paddingSizeExtraSmall,),
          SvgPicture.asset(AppImages.productUnderReviewImage),

          Spacer(),

          CustomButton(onTap: (){
            Get.toNamed(AppRoutes.myProductBoutiqueScreen);
          },
              text: AppString.productcontinueText.tr),
          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
          
        ],
      ),
    );
  }
}
