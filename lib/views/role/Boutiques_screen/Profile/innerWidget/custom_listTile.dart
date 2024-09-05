import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';

class BoutiqueCustomListTile extends StatelessWidget {

 final String icon;
 final String title;
 final Function() onTap;

 BoutiqueCustomListTile({super.key,required this.icon,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
      titleTextStyle: AppStyles.h8(color: AppColors.textColor),
      leading: SvgPicture.asset(icon,color: Get.theme.primaryColor,height: 25.h,width: 25.w,),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios_sharp,color:Colors.black,size:20,),
      onTap:onTap
    );
  }
}
