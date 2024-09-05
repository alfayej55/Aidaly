import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/Role/Driver_Controllar/driver_profile_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../base/cache_network_image.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../Drivers_BottomMenu_screen/bottom_menu_screen.dart';
import 'innerWidget/custom_listTile.dart';

class DriverProfileScreen extends StatelessWidget {
   DriverProfileScreen({super.key});

  DriverProfileController profileCtrl=Get.put(DriverProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DriversBottomMenu(2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.profileText.tr,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
      ),

        body:  Obx((){
          switch (profileCtrl.rxRequestStatus.value) {
            case Status.loading:
              return const CustomPageLoading();
            case Status.internetError:
              return NoInternetScreen(onTap:(){
                profileCtrl.profiledata();
              });
            case Status.error:
              return GeneralErrorScreen(onTap: (){
                profileCtrl.profiledata();
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
      child: Column(
          children: [
            /// >>>>>>>>>>>>>>>>>>> Profile >>>>>>>>>>>>>>>>>
            ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                titleTextStyle: AppStyles.customSize(
                    size: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor),
                subtitleTextStyle:
                AppStyles.h6(color: AppColors.secandaryTextColor),
                leading: CustomNetworkImage(
                  imageUrl:
                  "${ApiConstant.imageBaseUrl}${profileCtrl.profilModel.value.image!.publicFileUrl}",
                  //borderRadius: BorderRadius.circular(12.r),
                  height: 60.h,
                  width: 60.w,
                  boxShape: BoxShape.circle,
                ),
                title: Text('${profileCtrl.profilModel.value.name}'),
                subtitle: Text('${profileCtrl.profilModel.value.email}'),

                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.driversEditProfileScreen);
                  },
                  child: Text(
                    AppString.editText.tr,
                    style: AppStyles.h6(color: Colors.white),
                  ),
                )),

            SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

            /// Notification Setting

            // DriverCustomListTile(
            //   title:AppString.notificationSettingText.tr,
            //   icon:AppIcons.notificationIcon ,
            //   onTap: (){
            //     Get.toNamed(AppRoutes.driversNotificationSettingScreen);
            //   },
            // ),

           // Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            /// Chat History
            DriverCustomListTile(
              title:AppString.chathistoryText.tr,
              icon:AppIcons.massegeIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driverChatHistoryScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            /// Change Password

            DriverCustomListTile(
              title:AppString.changepasswordText.tr,
              icon:AppIcons.bagIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversChangePasswordScreen);

              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            /// Language

            DriverCustomListTile(
              title:AppString.languageText.tr,
              icon:AppIcons.languageIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversLanguageScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            /// Help & Support
            DriverCustomListTile(
              title:AppString.helpText.tr,
              icon:AppIcons.helpIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversHelpScreenScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

      /// Edit Vehicle Details

            DriverCustomListTile(
              title:AppString.editVehicleDetailsText.tr,
              icon:AppIcons.editvehicleIcon ,
              onTap: (){
               Get.toNamed(AppRoutes.driverEditVehicleScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            /// Bank Info
            DriverCustomListTile(
              title:AppString.bankInfoText.tr,
              icon:AppIcons.bankInfoIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversBankInfoScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

           /// Withdrawal

            DriverCustomListTile(
              title:AppString.withdrawalText.tr,
              icon:AppIcons.withdrawlIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversWithdrawalScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            /// Terms of Use

            DriverCustomListTile(
              title:AppString.termsofUseText.tr,
              icon:AppIcons.massegeIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversTermAndUseScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            ///Privacy Policy

            DriverCustomListTile(
              title:AppString.privacyPolicyText.tr,
              icon:AppIcons.privacyIcon ,
              onTap: (){
                Get.toNamed(AppRoutes.driversPrivacyScreen);
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

            ///Logout

            DriverCustomListTile(
              title:AppString.logoutText.tr,
              icon:AppIcons.logoutIcon ,
              onTap: (){
                profileCtrl.driverLogout();
              },
            ),

            Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          ],
        ),
    );
  }
}