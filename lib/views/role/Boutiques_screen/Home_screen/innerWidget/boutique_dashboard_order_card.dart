import 'package:aidaly/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';


class BoutiqueDashboardOrderCard extends StatelessWidget {
  final String? title;
  final String? amount;
  final String? image;
  final String order;
  BoutiqueDashboardOrderCard({super.key,required this.title,required this.amount,required this.image,required this.order});


  @override
  Widget build(BuildContext context) {
    return Stack(
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                      '${order}',
                      style: AppStyles.h7()
                  ),

                  Text(
                      '(\$$amount)',
                      style: AppStyles.h8(color: Get.theme.disabledColor)
                  ),

                ],
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
              child: SvgPicture.asset(image!,height: 38.h,width: 38.w,),
            ),
          ),
        )
      ],
    );
  }
}
