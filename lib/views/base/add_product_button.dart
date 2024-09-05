import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_colors.dart';

class AddProductButton extends StatelessWidget {
  final String icon;
  final double? height;
  final double? width;
  final double? iconheight;
  final double? iconwidth;
  final Color? color;
  const AddProductButton({super.key,required this.icon,this.height,this.width,this.iconheight,this.iconwidth,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height ?? 27.h,
      width: width ?? 27.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.iconCartColor.withOpacity(0.5),
      ),
      child: Center(
        child: SvgPicture.asset(icon,height: iconheight??16.h,width:iconwidth?? 16.62.w,color:color?? AppColors.whiteColor,),
      ),

    );
  }
}
