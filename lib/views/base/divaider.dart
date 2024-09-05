import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

class CustomDivaider extends StatelessWidget {
  const CustomDivaider({super.key});

  @override
  Widget build(BuildContext context) {
    return   Divider(
      thickness:1,
      indent: 20.w,
      endIndent: 20.w,
      color:Get.theme.dividerColor.withOpacity(0.2),
    );
  }
}
