import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/divaider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_Image.dart';
import '../../../../controllers/Role/BoutiquesControllar/new_ordercontroller.dart';
import '../../../../helpers/push_notification_helpers.dart';
import '../../../../main.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../../shoppers_screen/bottomMenu_screen/bottom_menu..dart';
import '../bottomMenu_screen/bottom_menu_screen.dart';
import 'innerWidget/dashboard_order_card.dart';
import '../Widget/order_card.dart';

class BoutiqueHomeScreen extends StatefulWidget {
  const BoutiqueHomeScreen({super.key});

  @override
  State<BoutiqueHomeScreen> createState() => _BoutiqueHomeScreenState();
}

class _BoutiqueHomeScreenState extends State<BoutiqueHomeScreen> {
  NewOrderController _newOrderCtrl = Get.put(NewOrderController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    _newOrderCtrl.boutiqueNewOrderFirsLoad();

    NotificationHelper.firebaseListenNotification(context: context);

      //  NotificationHelper.init(flutterLocalNotificationsPlugin);
     //NotificationHelper.notificationPermission();
    // _firebaseMessaging.requestPermission();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Message received: ${message.messageId}');
    //   // Handle foreground message
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('Message opened: ${message.messageId}');
    //   // Handle message opened
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: const BoutiqueBottomMenu(0),
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
      body: Obx((){
            switch (_newOrderCtrl.rxRequestStatus.value) {
              case Status.loading:
            return const CustomPageLoading();
             case Status.internetError:
             return NoInternetScreen(onTap:(){
              _newOrderCtrl.boutiqueDashBoard();
            });
          case Status.error:
            return GeneralErrorScreen(onTap: (){
              _newOrderCtrl.boutiqueDashBoard();
            });
          case Status.completed:
            return _body(context);
          default:
            return Container();
        }
      }));

  }
   _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.boutiqueDashboard.tr,
                style: AppStyles.h1(color: Get.theme.primaryColor)),
            SizedBox(height: Dimensions.paddingSizeExtraSmall.h),

            Divider(
              color: Get.theme.dividerColor.withOpacity(0.4),
            ),

            SizedBox(height: Dimensions.paddingSizeExtraLarge.h),

            ///........................... Orders Cart........................

            DashboardOrderCard(dashBoard: _newOrderCtrl.dashBoardModel.value,),
            ///...........................New Order Requests ........................

            SizedBox(height: Dimensions.paddingSizeDefault.h),
            Text(AppString.newOrderRequests.tr, style: AppStyles.h7()),
            ///...........................New Order Card ........................
            _newOrderCtrl.newOrderModel.value.isEmpty?Container():  ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: _newOrderCtrl.newOrderModel.value.length,
              itemBuilder: (context, index) {
                var data = _newOrderCtrl.newOrderModel.value[index];
                return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.orderDetailsScreen,arguments: data.id);
                    },
                    child: BoutiquesOrderCard(
                      status: 'New Order',
                      orderData: data,
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider(
                    color: Get.theme.dividerColor.withOpacity(0.4));
              },
            )
          ],
        ),
      ),
    );
  }
}
