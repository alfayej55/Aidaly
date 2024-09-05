import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/canceled_Screen/canceled_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/delivered_Screen/delivered_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/inProgress_Screen/inProgress_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottomMenu_screen/bottom_menu_screen.dart';
import 'assigned_Screen/assigned_Screen.dart';
import 'newOrder_Screen/new_order_screen.dart';

class AllOrderScreen extends StatelessWidget {
   AllOrderScreen({super.key});

  final List<String> tapbarList = [AppString.newOrderText, AppString.inProgressText, AppString.assignedText,AppString.deliveredText];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tapbarList.length,
        child: Scaffold(
          bottomNavigationBar: BoutiqueBottomMenu(1), // Pass tapbarList to the bottom menu
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(AppString.allOrderText.tr,style:AppStyles.h1(color: Get.theme.primaryColor) ,),
            bottom: TabBar(
              indicatorColor: AppColors.textColor,
              dividerColor: Colors.transparent,
              isScrollable: true,
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

               /// New Order Screen
              NewOrderScreen(),// Replace with your content for 'New Order'

              /// In Progress Screen
              InProgressScreen(),

              // Replace with your content for 'In Progress'
              AssignedScreen(),

              /// Delivered Screen

              DeliveredScreen(),

              /// Canceled Screen
              // CanceledScreen()

            ],
          ),
        ));
  }
}
