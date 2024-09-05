
import 'dart:ui';

import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../models/Role/ShopperModel/shop_model.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';

class ShopCart extends StatelessWidget {
  AllProduct? item;
   ShopCart({super.key,this.item});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Get.toNamed(AppRoutes.productScreen,arguments: '${item!.name}');
      },
      child: Stack(
        children: [
          // Background Image (Blurred)
          Container(
            width: 165.w,
            height: 101.h,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: CustomNetworkImage(
              imageUrl:'${ApiConstant.imageBaseUrl}${item!.categoryImage!.publicFileUrl}',
              borderRadius: BorderRadius.circular(12.r),
              height: 101.h,
              width:165.w,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              height: 101.h,
              width:165.w,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                color:  Color(0xFF000000).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 15.w,bottom: 12.h),
                child: Text(
                 '${item!.name}',
                  style: AppStyles.h8(
                    color: AppColors.whiteColor
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ), // Adjust opacity as needed
            ),
          ),
        ],
      ),
    );
  }
}
