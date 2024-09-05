import 'package:aidaly/controllers/Role/BoutiquesControllar/in_progress_controller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';
import '../../Widget/order_card.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {

  InProgressController _inProgressCtrl=Get.put(InProgressController());


  @override
  void initState() {
    super.initState();
    _inProgressCtrl.inProgressOrderFirsLoad();
    _inProgressCtrl.scrollController.addListener(_scrollListener);
  }


  void _scrollListener() {
    if (_inProgressCtrl.scrollController.position.pixels ==
        _inProgressCtrl.scrollController.position.maxScrollExtent ) {
      _inProgressCtrl.loadMore();
      print('Load More Check');
    }
  }
  @override
  void dispose() {
    _inProgressCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>_inProgressCtrl.firstLoading.value?Center(child: CustomPageLoading()):  _inProgressCtrl.newOrderModel.value.isEmpty?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
          SizedBox(height: 15.h,),
          Text("No Projects Are Currently In Progress",
            textAlign: TextAlign.center,
            style: AppStyles.h3(),),
        ],
      ),
    )
        :Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child:RefreshIndicator( onRefresh:()async{
      } ,
        child:  ListView.separated(
          itemCount: _inProgressCtrl.newOrderModel.value.length + 1,
          controller: _inProgressCtrl.scrollController,
          // scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index >= _inProgressCtrl.newOrderModel.value.length) {
              return _inProgressCtrl.firstLoading.value
                  ? CustomPageLoading()
                  : SizedBox();
            } else {
              var data = _inProgressCtrl.newOrderModel.value[index];
              return GestureDetector(
                  onTap: () {Get.toNamed(AppRoutes.inProgressDetailsScreen,arguments: data.id);},
                  child: BoutiquesOrderCard(
                    status: 'In Progress',
                    orderData: data,
                  ));
            }
          },
          separatorBuilder: (context, index) {
            return Divider(color: Get.theme.dividerColor.withOpacity(0.4));
          },
        ),
      ),
    ));
  }
}
