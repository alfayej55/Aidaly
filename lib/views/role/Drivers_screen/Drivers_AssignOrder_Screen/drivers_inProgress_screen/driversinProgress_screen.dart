import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../controllers/Role/Driver_Controllar/inprogress_controller.dart';
import '../../../../../utils/enamdata.dart';
import '../../../../base/general_error_screen.dart';
import '../../../../base/no_internet_screen.dart';
import '../../Widget/drivers_order_card.dart';
class DriverInProgressScreen extends StatefulWidget {
  const DriverInProgressScreen({super.key});

  @override
  State<DriverInProgressScreen> createState() => _DriverInProgressScreenState();
}

class _DriverInProgressScreenState extends State<DriverInProgressScreen> {

  DriverInprogressController _inprogressCtrl = Get.put(DriverInprogressController());

  @override
  void initState() {
    super.initState();
    _inprogressCtrl.deiverInprogressFirsLoad();
    _inprogressCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_inprogressCtrl.scrollController.position.pixels ==
        _inprogressCtrl.scrollController.position.maxScrollExtent ) {
      _inprogressCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _inprogressCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      _body(context)
      // switch (_inprogressCtrl.rxRequestStatus.value) {
      //   case Status.loading:
      //     return const CustomPageLoading();
      //   case Status.internetError:
      //     return NoInternetScreen(onTap:(){
      //       _inprogressCtrl.deiverInprogressFirsLoad();
      //     });
      //   case Status.error:
      //     return GeneralErrorScreen(onTap: (){
      //       _inprogressCtrl.deiverInprogressFirsLoad();
      //     });
      //   case Status.completed:
      //     return _body(context);
      //   default:
      //     return Container();
      // }
    );
  }

    _body(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
      child:    _inprogressCtrl.inProgressOrderModel.value.isEmpty?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
            SizedBox(height: 15.h,),
            Text("You have no projects in progress",style: AppStyles.h3(),),
          ],
        ),
      ):   RefreshIndicator(
      onRefresh:()async{
      } ,
      child:  ListView.separated(
        itemCount: _inprogressCtrl.inProgressOrderModel.value.length + 1,
        controller: _inprogressCtrl.scrollController,
        shrinkWrap: true,
        primary: false,
        // scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index >= _inprogressCtrl.inProgressOrderModel.value.length) {
            return _inprogressCtrl.firstLoading.value
                ? CustomPageLoading()
                : SizedBox();
          } else {
            var data = _inprogressCtrl.inProgressOrderModel.value[index];
            return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.driversInProgressDetailsScreen,arguments: data.id);
                },
                child: DriverOrderCard(
                  orderData: data,
                   status: 'In Progress',)
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
