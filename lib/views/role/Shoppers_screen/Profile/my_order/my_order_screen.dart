
import 'package:aidaly/controllers/Role/Shopper_Controllar/my_order_controller.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/style.dart';
import 'my_order_card.dart';

class ShopperMyOrderScreen extends StatelessWidget {
   ShopperMyOrderScreen({super.key});

  MyOrderController _myOrderCtrl=Get.put(MyOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.myOrderText.tr,
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

      body: Obx(() =>  _myOrderCtrl.myOrderLoading.value?CustomPageLoading():
          _myOrderCtrl.myOrderModel.isEmpty?      Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppImages.wishlistEmptyImage),
                SizedBox(height: 15.h,),
                Text("You Habe No Orders",
                  textAlign: TextAlign.center,
                  style: AppStyles.h3(),),
              ],
            ),
          ):
      Expanded(
        child: ListView.separated(
          itemCount: _myOrderCtrl.myOrderModel.value.length,
          // controller: _myOrderCtrl.scrollController,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var data=_myOrderCtrl.myOrderModel.value[index];
            return MyOrderCard(myOrder: data);
          },
          separatorBuilder: (context, index) {
            return Divider(color: Get.theme.dividerColor.withOpacity(0.4));
          },
        ),
      )),
    );
  }
}

