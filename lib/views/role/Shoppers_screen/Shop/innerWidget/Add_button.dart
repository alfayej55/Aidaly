import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class AddButton extends StatelessWidget {
  final VoidCallback? ontap;
  final IconData? icon;
   AddButton({super.key,required this.ontap,this.icon});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Container(

        height: 30.h,
        width: 30.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.theme.primaryColor.withOpacity(0.1),
            border: Border.all(color: Get.theme.primaryColor.withOpacity(0.1),width: 1)
        ),
        child: Center(
          child: Icon(icon,size: 14,color: Get.theme.secondaryHeaderColor,),
        ),
      ),
    );
  }
}
