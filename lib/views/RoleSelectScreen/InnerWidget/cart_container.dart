import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
class CartScreen extends StatelessWidget {

  final String icon;
  final Color? color;
  final String? text;
  final Color?  iconColor;
  final Color?  borderColor;
  final Color?  containerColor;
  final bool? isChecked;

  final String? subText;
  final Function()? onTap;

   CartScreen({super.key,required this.icon,this.color,this.text,this.subText, this.onTap,this.iconColor,this.borderColor,this.containerColor,this.isChecked});


  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 5,left: 15,right: 15),
        child: Container(
          height: 130.h,
          width: 342.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Get.theme.cardColor,
              border: Border.all(
                  color: borderColor!,
              ),
          ),
          child: Center(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 48,
                backgroundColor: containerColor ?? Get.theme.primaryColor.withOpacity(0.1),
                child: Center(
                  child: SvgPicture.asset(icon,color: iconColor,),
                ),
              ),
              title: Text(text!),
              titleTextStyle: AppStyles.h3(
                color: AppColors.textColor
              ),
              subtitleTextStyle: AppStyles.h5(
                color:Get.theme.dialogBackgroundColor
              ),
              subtitle:Text(subText!),
              trailing:Padding(
                padding: const EdgeInsets.only(bottom:65),
                child: Checkbox(
                    value:isChecked,
                    side: BorderSide(width: 2, color: AppColors.primaryColor.withOpacity(0.1)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                     splashRadius: 5,
                    checkColor: AppColors.whiteColor,
                    activeColor:AppColors.secandaryTextColor,
                    onChanged: (value){
                      // setState(() {
                      //   _isChecked = value!;
                      // });
                    }),
              ),


            ),
          ),
        ),
      ),
    );
  }
}
