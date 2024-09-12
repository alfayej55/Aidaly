import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/BoutiquesControllar/boutique_withdrow_controller.dart';
import '../../../../../utils/app_string.dart';
import 'innerWidget/bank_info_card.dart';

class BoutiqueBankInfoScreen extends StatefulWidget {
  const BoutiqueBankInfoScreen({super.key});

  @override
  State<BoutiqueBankInfoScreen> createState() => _BoutiqueBankInfoScreenState();
}

class _BoutiqueBankInfoScreenState extends State<BoutiqueBankInfoScreen> {
  BoutiqueWithdroController _boutiquewithCtrl=Get.put(BoutiqueWithdroController());
  
  @override
  void initState() {
    _boutiquewithCtrl.newBankInfo();
    // TODO: implement initState
    super.initState();
  }
  
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

      body: Obx(()=> Column(



        children: [

          ///  Bank Info Card

          _boutiquewithCtrl.bankinfoLoading.value? CustomPageLoading(): ListView.builder(
              itemCount: _boutiquewithCtrl.newBankList.value.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal:24.w,vertical: 10.h),
              primary: false,
              itemBuilder: (context,index){
                var data=_boutiquewithCtrl.newBankList.value[index];
                return BoutiqueBankInfoCard(
                  bankModdel: data,
                );
              }),


          /// Add a New Bank Info Text
    SizedBox(height: 20.h,),

          Align(
            alignment: Alignment.center,
            child: GestureDetector(
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
            ),
          )

        ],
      )),
      
    );
  }
}
