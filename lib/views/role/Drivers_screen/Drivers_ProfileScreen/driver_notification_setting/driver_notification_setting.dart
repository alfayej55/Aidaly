import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/views/base/divaider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';

class DriverNotificationSettingScreen extends StatefulWidget {
  const DriverNotificationSettingScreen({super.key});

  @override
  State<DriverNotificationSettingScreen> createState() => _DriverNotificationSettingScreenState();
}

class _DriverNotificationSettingScreenState extends State<DriverNotificationSettingScreen> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.notificationSettingText.tr,
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

      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

   /// Show Notification

          ListTile(
            titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
            title: Text(AppString.showNotificationText.tr),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
            trailing:  Transform.scale(
              scale: 0.7, // Adjust scale factor as needed
              child: CupertinoSwitch(
                activeColor: Get.theme.primaryColor,
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                  });
                },
              ),
            )

          ),
          CustomDivaider(),

          /// Order Update
          SizedBox(height: Dimensions.paddingSizeSmall.h,),


          ListTile(
              titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
              title: Text(AppString.orderUpdateText.tr),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              trailing:  Transform.scale(
                scale: 0.7, // Adjust scale factor as needed
                child: CupertinoSwitch(
                  activeColor: Get.theme.primaryColor,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              )

          ),
          CustomDivaider(),

          /// App System Update

          ListTile(
              titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
              title: Text(AppString.appSystemUpdateText.tr),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              trailing:  Transform.scale(
                scale: 0.7, // Adjust scale factor as needed
                child: CupertinoSwitch(
                  activeColor: Get.theme.primaryColor,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              )

          ),
          CustomDivaider(),


          /// Show On Tap Bar

          ListTile(
              titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
              title: Text(AppString.showOnTopBarText.tr),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              trailing:  Transform.scale(
                scale: 0.7, // Adjust scale factor as needed
                child: CupertinoSwitch(
                  activeColor: Get.theme.primaryColor,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              )

          ),
          CustomDivaider(),



          /// Sound

          ListTile(
              titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
              title: Text(AppString.soundText.tr),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              trailing:  Transform.scale(
                scale: 0.7, // Adjust scale factor as needed
                child: CupertinoSwitch(
                  activeColor: Get.theme.primaryColor,
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              )

          ),
          CustomDivaider()
        ],
      ),
    );
  }
}
