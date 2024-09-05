import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/views/base/divaider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/Role/Shopper_Controllar/shopper_profile_controller.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../../utils/style.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../bottomMenu_screen/bottom_menu..dart';
import '../../../base/cache_network_image.dart';
import 'innerWidget/custom_listTile.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   ShopperProfileController _profileCtrl=Get.put(ShopperProfileController());

   @override
  void initState() {
     _profileCtrl.profiledata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(4),
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
      body: Obx((){
        switch (_profileCtrl.rxRequestStatus.value) {
          case Status.loading:
            return const CustomPageLoading();
          case Status.internetError:
            return NoInternetScreen(onTap:(){
              _profileCtrl.profiledata();
            });
          case Status.error:
            return GeneralErrorScreen(onTap: (){
              _profileCtrl.profiledata();
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
                  subtitleTextStyle: AppStyles.h6(color: AppColors.secandaryTextColor),

              leading: CustomNetworkImage(
                imageUrl:
                "${ApiConstant.imageBaseUrl}${_profileCtrl.profilModel.value.image!.publicFileUrl}",
                //borderRadius: BorderRadius.circular(12.r),
                height: 60.h,
                width: 60.w,
                boxShape: BoxShape.circle,
              ),

              title: Text('${_profileCtrl.profilModel.value.name}'),

              subtitle: Text('${_profileCtrl.profilModel.value.email}'),

              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.editprofileScreen);
                },
                child: Text(
                  AppString.editText.tr,
                  style: AppStyles.h6(color: Colors.white),
                ),
              )),

         // SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

          /// Notification Setting

          // CustomListTile(
          //   title:AppString.notificationSettingText.tr,
          //   icon:AppIcons.notificationIcon ,
          //   onTap: (){
          //     Get.toNamed(AppRoutes.notificationSettingScreen);
          //   },
          // ),

         // CustomDivaider(),

          /// Change Password

          CustomListTile(
            title:AppString.changepasswordText.tr,
            icon:AppIcons.bagIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.passwordCheangeScreen);

            },
          ),

          CustomDivaider(),

          /// My Order
          CustomListTile(
            title:AppString.myOrderText.tr,
            icon:AppIcons.bagIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.myOrderScreen);
            },
          ),
          CustomDivaider(),

          //  WishList Folder
          // CustomListTile(
          //   title:AppString.wishListFolderText.tr,
          //   icon:AppIcons.wishListIcon ,
          //   onTap: (){
          //     Get.toNamed(AppRoutes.wishListFolderScreen);
          //   },
          // ),

        // CustomDivaider(),

        /// Chat History
          CustomListTile(
            title:AppString.chathistoryText.tr,
            icon:AppIcons.massegeIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.chatHistoryScreen);
            },
          ),

          CustomDivaider(),

         /// Language

          CustomListTile(
            title:AppString.languageText.tr,
            icon:AppIcons.languageIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.languageScreen);
            },
          ),

          CustomDivaider(),

      /// Help & Support
          CustomListTile(
            title:AppString.helpText.tr,
            icon:AppIcons.helpIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.helpScreen);
            },
          ),

          CustomDivaider(),


        /// Terms of Use

          CustomListTile(
            title:AppString.termsofUseText.tr,
            icon:AppIcons.massegeIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.termsAndUseScreen);
            },
          ),
          CustomDivaider(),

         ///Privacy Policy

          CustomListTile(
            title:AppString.privacyPolicyText.tr,
            icon:AppIcons.privacyIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.privacyScreen);
            },
          ),
          CustomDivaider(),

      ///Logout
          CustomListTile(
            title:AppString.logoutText.tr,
            icon:AppIcons.logoutIcon ,
            onTap: (){
              _profileCtrl.shopperLogout();
            },
          ),

          CustomDivaider(),

        ],
      ),
    );
  }
}
