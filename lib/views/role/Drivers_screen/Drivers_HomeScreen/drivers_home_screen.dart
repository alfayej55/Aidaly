import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/helpers/prefs_helper.dart';
import 'package:aidaly/helpers/push_notification_helpers.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/socket_maneger.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_Image.dart';
import '../../../../controllers/Role/Driver_Controllar/home_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/style.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../Drivers_BottomMenu_screen/bottom_menu_screen.dart';
import '../Widget/drivers_order_card.dart';
import 'dashboard_order_card.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen>
    with WidgetsBindingObserver {
  DriverHomeController _newOrderCtrl = Get.put(DriverHomeController());

  @override
  void initState() {
    // TODO: implement initState
    _newOrderCtrl.deiverNewOrderFirsLoad();
    _newOrderCtrl.driverDashBoard();
    NotificationHelper.firebaseListenNotification(context: context);
    _newOrderCtrl.scrollController.addListener(_scrollListener);
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  void _scrollListener() {
    if (_newOrderCtrl.scrollController.position.pixels ==
        _newOrderCtrl.scrollController.position.maxScrollExtent) {
      _newOrderCtrl.loadMore();
      print('Load More Check');
    }
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  // void setStatus(String status) async {
  //   var driverId=await PrefsHelper.getString(AppConstants.driverId);
  //   print("driverId: $driverId");
  //
  //   var body={
  //     "id":driverId,
  //     "status":status
  //   };
  //
  //   debugPrint('bodyTest>>$body');
  //   SocketApi.emit('userActive',body);
  // }
  //
  //
  //
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //    super.didChangeAppLifecycleState(state);
  //   if (state == AppLifecycleState.resumed) {
  //     setState(() {
  //       setStatus('active');
  //     });
  //     print("userOnline: online");
  //
  //   } else {
  //    setState(() {
  //      setStatus('inactive');
  //    });
  //     print("userOffline : offline");
  //   }
  //
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: DriversBottomMenu(0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              AppString.homeScreenHaderText.tr,
              style: AppStyles.customSize(
                  size: 14, color: AppColors.secandaryTextColor),
            ),
          ),
          actions: [
            InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.notificationScreen);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 34.w),
                  child: SvgPicture.asset(AppIcons.notificationIcon),
                )),
          ],
        ),
        body: Obx(() => _body(context)));

    // body:  Obx((){
    //   switch (_newOrderCtrl.rxRequestStatus.value) {
    //     case Status.loading:
    //       return const CustomPageLoading();
    //     case Status.internetError:
    //       return NoInternetScreen(onTap:(){
    //         _newOrderCtrl.deiverNewOrderFirsLoad();
    //       });
    //     case Status.error:
    //       return GeneralErrorScreen(onTap: (){
    //         _newOrderCtrl.deiverNewOrderFirsLoad();
    //       });
    //     case Status.completed:
    //       return _body(context);
    //     default:
    //       return Container();
    //   }
    // }));
  }

  _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.driverDashboardText.tr,
                style: AppStyles.h1(color: Get.theme.primaryColor)),

            SizedBox(height: Dimensions.paddingSizeExtraSmall.h),
            Divider(
              color: Get.theme.dividerColor.withOpacity(0.4),
            ),

            SizedBox(height: Dimensions.paddingSizeExtraLarge.h),

            ///........................... Deshboard Orders Cart........................

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DriverDashboardOrderCard(
                  title: AppString.activeOrders.tr,
                  image: AppIcons.activeOrderIcon,
                  amount: _newOrderCtrl.dashBoardModel.value.activeOrders !=null?'${_newOrderCtrl.dashBoardModel.value.activeOrders}':'0',
                ),
                DriverDashboardOrderCard(
                  title: AppString.completedOrders.tr,
                  image:AppIcons.completedOrderIcon,
                  amount:
                  _newOrderCtrl.dashBoardModel.value.compliteOrders !=null? '${_newOrderCtrl.dashBoardModel.value.compliteOrders}':"0",
                )
              ],
            ),

            ///...........................Current Orders ........................

            SizedBox(height: Dimensions.paddingSizeDefault.h),

           _newOrderCtrl.newOrderModel.isNotEmpty? Column(
              children: [
                Text(AppString.drivercurrentOrdersText.tr, style: AppStyles.h7()),
                SizedBox(
                  height: 25.h,
                ),

                ///...........................Current Orders  Card ........................
                RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.separated(
                    itemCount: _newOrderCtrl.newOrderModel.value.length + 1,
                    controller: _newOrderCtrl.scrollController,
                    shrinkWrap: true,
                    primary: false,
                    // scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index >= _newOrderCtrl.newOrderModel.value.length) {
                        return _newOrderCtrl.firstLoading.value
                            ? CustomPageLoading()
                            : SizedBox();
                      } else {
                        var data = _newOrderCtrl.newOrderModel.value[index];
                        return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.driversnewOrderDetails,
                                  arguments: data.id);
                            },
                            child: DriverOrderCard(
                              orderData: data,
                              status: 'New Orders',
                            ));
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                          color: Get.theme.dividerColor.withOpacity(0.4));
                    },
                  ),
                ),
              ],
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}
