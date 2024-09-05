import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_Image.dart';
import '../../../../../../utils/style.dart';


class BoutiqueBankInfoCard extends StatelessWidget {
  const BoutiqueBankInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        height:118.h,
        width: 342.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.65).r,
            color: Get.theme.cardColor,
            boxShadow: [
              AppStyles.boxShadow
            ]
        ),

        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bank of America',style: AppStyles.customSize(size: 15,),),
                Container(
                  height: 33.h,
                  width: 54.5.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.43).r,
                      color: Get.theme.cardColor,
                      image: DecorationImage(image: AssetImage(AppImages.bankCardimage),fit: BoxFit.cover),
                      boxShadow: [
                        AppStyles.boxShadow
                      ]
                  ),
                )
              ],
            ),
            SizedBox(height: 10.h,),
            Text('Account Number',style: AppStyles.customSize(size: 10,fontWeight: FontWeight.w400),),
            Text('Ending with****1234',style: AppStyles.customSize(size: 16,fontWeight: FontWeight.w500,color: Get.theme.primaryColor),)
          ],
        ),

      ),
    );
  }
}
