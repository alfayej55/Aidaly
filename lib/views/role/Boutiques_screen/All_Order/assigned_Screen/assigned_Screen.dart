import 'package:aidaly/views/role/Boutiques_screen/All_Order/assigned_Screen/innerWidget/assignet_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../controllers/Role/BoutiquesControllar/order_assigned_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';

class AssignedScreen extends StatefulWidget {
  const AssignedScreen({super.key});

  @override
  State<AssignedScreen> createState() => _AssignedScreenState();

}

class _AssignedScreenState extends State<AssignedScreen> {

  OrderAssignedController _assignedController=Get.put(OrderAssignedController());

  @override
  void initState() {
    super.initState();
    _assignedController.boutiquAssignedFirsLoad();
    _assignedController.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_assignedController.scrollController.position.pixels ==
        _assignedController.scrollController.position.maxScrollExtent ) {
      _assignedController.loadMore();
      print('Load More Check');
    }
  }
  @override
  void dispose() {
    _assignedController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() =>_assignedController .orderAssignedModel.value.isEmpty? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
          SizedBox(height: 15.h,),
          Text("You Have No Project In Assigned",style: AppStyles.h3(),),
        ],
      ),
    )
        : RefreshIndicator(onRefresh:()async{
    },
      child: ListView.separated(
        itemCount: _assignedController.orderAssignedModel.value.length + 1,
        controller: _assignedController.scrollController,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index >= _assignedController.orderAssignedModel.value.length) {
            return _assignedController.firstLoading.value
                ? CustomPageLoading()
                : SizedBox();
          } else {
            var data = _assignedController.orderAssignedModel.value[index];
            return AssignedDetails(assignedModel: data,);
          }
        },
        separatorBuilder: (context, index) {
          return Divider(color: Get.theme.dividerColor.withOpacity(0.4));
        },
      ),
    ));


  }
}
