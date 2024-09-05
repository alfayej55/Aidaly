import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../../controllers/Role/Driver_Controllar/driver_withrow_controller.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/style.dart';
import 'inner_widget/earning_card.dart';
import 'inner_widget/withdrow_history.dart';

class DriverWithdrawalScreen extends StatefulWidget {
   DriverWithdrawalScreen({super.key});

  @override
  State<DriverWithdrawalScreen> createState() => _DriverWithdrawalScreenState();
}

class _DriverWithdrawalScreenState extends State<DriverWithdrawalScreen> {
  DriverWithdroController _withdroController=Get.put(DriverWithdroController());
  @override
  void initState() {
    _withdroController.earnGet();
    _withdroController.getWithdrowAmound();

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
            AppString.withdrawalText.tr,
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

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(()=>_withdroController.withdrowLoading.value?CustomPageLoading():Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 45.h,),

            /// Earned this Month

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                EarningCard(
                  title: AppString.earnedthisMonthText,
                  amount: '${_withdroController.earneModelList.value.earnThisMonth}',
                ),

                EarningCard(
                  title: AppString.totalEarnedText,
                  amount: '${_withdroController.earneModelList.value.totalEarnign}',
                )
              ],
            ),

            SizedBox(height: 20.h,),
            /// Earned Button
            CustomButton(onTap: (){
              Get.toNamed( AppRoutes.driversAddNewBankScreen);
            },
                text: AppString.withdrawEarningsText.tr),

            SizedBox(height: 20.h,),

            Text(AppString.historyText.tr,style: AppStyles.h7(),),


            /// Earning History

            Expanded(
              child:  ListView.separated(
                itemCount: _withdroController.withrdrowModelList.value.length,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                  var withrowInfo=_withdroController.withrdrowModelList.value[index];
                  return WithdrawalHistory(
                    withdeowModel: withrowInfo,
                  );
                },
                separatorBuilder: (context,index){
                  return Divider(color: Get.theme.dividerColor.withOpacity(0.2),);
                },
              ),

            )

          ],
        )),

      ),
    );
  }
}
