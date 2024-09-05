import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Widget/order_card.dart';
class CanceledScreen extends StatelessWidget {
  const CanceledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
         shrinkWrap: true,
        primary: false,
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        itemBuilder:(context,index){
      return GestureDetector(
        onTap: (){
          Get.toNamed(AppRoutes.canceledDetailsScreen);
        },
          child: BoutiquesOrderCard( status: 'Canceled',));

    }, separatorBuilder:(context,index){
      return Divider(color: Get.theme.dividerColor.withOpacity(0.4));
    }, itemCount: 7);
  }
}
