import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';

class ContinueCustomButton extends StatelessWidget {
  final Function() onTap;
   ContinueCustomButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 51.h,
        width: 140.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:AppColors.whiteColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Continue',style: TextStyle(color:Get.theme.primaryColor,fontFamily: 'Poppins',fontSize: 15,fontWeight: FontWeight.w600),),
            SizedBox(width: 5.w,),
            Icon(Icons.arrow_forward,color:Get.theme.primaryColor,),
          ],
        ),

      ),
    );
  }
}
