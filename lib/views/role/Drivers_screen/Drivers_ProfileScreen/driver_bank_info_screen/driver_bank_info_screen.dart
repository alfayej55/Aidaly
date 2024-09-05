import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_string.dart';
import 'innerWidget/bank_info_card.dart';

class DriverBankInfoScreen extends StatelessWidget {
  const DriverBankInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.bankInfoText.tr,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: Get.theme.primaryColor,
              )),
        ),
      ),

      body: Column(
        children: [

          ///  Bank Info Card

         ListView.builder(
            itemCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal:24.w,vertical: 10.h),
              primary: false,
              itemBuilder: (context,index){
            return BoutiqueBankInfoCard();
          }),

          /// Add a New Bank Info Text

          GestureDetector(
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueAddNewBankScreen);

            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Icon(Icons.add,color: Get.theme.secondaryHeaderColor,),
                  SizedBox(width: 5.w,),

                  Text(AppString.addaNewBankInfoText.tr,
                    style: AppStyles.customSize(size: 16,color: Get.theme.secondaryHeaderColor,fontWeight: FontWeight.w400),)
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
