import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../base/custom_page_loading.dart';

class SocialLoginButton extends StatelessWidget {
 bool loading;
 final String icon;
   SocialLoginButton({super.key,required this.icon,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 55.h,
      width: 104.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Get.theme.cardColor,
          border: Border.all(
              color: Get.theme.primaryColor.withOpacity(0.1)
          ),
          boxShadow: [
            AppColors.shadow
          ]


      ),
      child: loading?CustomPageLoading(): Center(
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
