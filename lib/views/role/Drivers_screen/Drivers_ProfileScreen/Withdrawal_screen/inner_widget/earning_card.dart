import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../utils/style.dart';

class EarningCard extends StatelessWidget {
 final String? title;
 final String? amount;
  const EarningCard({super.key,this.title,this.amount});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 135.h,
          width: 158.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Get.theme.cardColor,
              boxShadow: [
                AppStyles.boutiqueboxShadow
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              /// Active Order Text

              SizedBox(height:Dimensions.paddingSizeDefault.h),
              Text(
                 title!.tr,
                  style: AppStyles.customSize(size:14,fontWeight:FontWeight.w500)
              ),

              SizedBox(height:Dimensions.paddingSizeSmall.h),

              Text(
                  '\$ $amount',
                  style: AppStyles.customSize(size: 18)
              )
            ],
          ),
        ),

        Positioned(
          top: -30.h,
          child: Container(
            height: 65.h,
            width: 65.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.cardColor,
                boxShadow: [
                  AppStyles.boutiqueCircleboxShadow
                ]
            ),
            child: Center(
              child: SvgPicture.asset(AppIcons.earningIcon,height: 38.h,width: 38.w,color: Get.theme.primaryColor,),
            ),
          ),
        )
      ],
    );
  }
}
