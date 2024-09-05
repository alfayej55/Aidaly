import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Drivers_BottomMenu_screen/bottom_menu_screen.dart';
import 'delivered_Screen/delivered_screen.dart';
import 'drivers_canceled_Screen/drivers_canceled_screen.dart';
import 'drivers_inProgress_screen/driversinProgress_screen.dart';

class DriverAssignOrdersScreen extends StatelessWidget {
   DriverAssignOrdersScreen({super.key});


  final List<String> tapbarList = [AppString.inProgressText,AppString.deliveredText,AppString.canceledText];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tapbarList.length,
        child: Scaffold(
          bottomNavigationBar: DriversBottomMenu(1),
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(AppString.assignedOrdersText.tr,style:AppStyles.h1(color: Get.theme.primaryColor) ,),

            bottom: TabBar(
              indicatorColor: AppColors.textColor,
              dividerColor: Colors.transparent,
              // isScrollable: true,
              padding: EdgeInsets.zero,
              labelStyle: AppStyles.customSize(size: 16,fontWeight: FontWeight.w500,color:AppColors.textColor),
              unselectedLabelStyle:AppStyles.customSize(size: 14,fontWeight: FontWeight.w500, color:AppColors.subTextColor),
              tabs: [
                for (String tab in tapbarList) // Using a for loop to generate tabs
                  Tab(text: tab.tr),
              ],
            ),
          ),
          body: TabBarView(
            children: [

              /// In Progress Screen
              DriverInProgressScreen(),


              /// Delivered Screen

              DriverDeliveredScreen(),

              /// Canceled Screen

              DriversCanceledScreen()

            ],
          ),

        )

    );
  }
}