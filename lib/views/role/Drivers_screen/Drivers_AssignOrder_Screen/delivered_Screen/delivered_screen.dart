import 'package:aidaly/controllers/Role/Driver_Controllar/driver_delivered_controller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';
import '../../Widget/drivers_order_card.dart';

class DriverDeliveredScreen extends StatefulWidget {
  const DriverDeliveredScreen({super.key});

  @override
  State<DriverDeliveredScreen> createState() => _DriverDeliveredScreenState();
}

class _DriverDeliveredScreenState extends State<DriverDeliveredScreen> {


  DriverDeliverdController _deliverdCtrl=Get.put(DriverDeliverdController());


  @override
  void initState() {
    super.initState();
    _deliverdCtrl.deiverDeliveryFirsLoad();
    _deliverdCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_deliverdCtrl.scrollController.position.pixels ==
        _deliverdCtrl.scrollController.position.maxScrollExtent ) {
      _deliverdCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _deliverdCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>_body(context) );
  }

  _body(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
      child:    _deliverdCtrl.deliveredOrderModel.value.isEmpty?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
            SizedBox(height: 15.h,),
            Text("Your Have No Project Delivered",style: AppStyles.h3(),),
          ],
        ),
      )
          :   RefreshIndicator(
        onRefresh:()async{
        } ,
        child:  ListView.separated(
          itemCount: _deliverdCtrl.deliveredOrderModel.value.length + 1,
          controller: _deliverdCtrl.scrollController,
          shrinkWrap: true,
          primary: false,
          // scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index >= _deliverdCtrl.deliveredOrderModel.value.length) {
              return _deliverdCtrl.firstLoading.value
                  ? CustomPageLoading()
                  : SizedBox();
            } else {
              var data = _deliverdCtrl.deliveredOrderModel.value[index];
              return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.driversDeliveredDetailsScreen,arguments: data.id);
                  },
                  child: DriverOrderCard(
                    orderData: data,
                    status: 'Delivered',)
              );
            }
          },
          separatorBuilder: (context, index) {
            return Divider(color: Get.theme.dividerColor.withOpacity(0.4));
          },
        ),
      ),
    );
  }
}
