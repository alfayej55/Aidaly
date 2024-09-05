import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/Role/BoutiquesControllar/profile_controllar.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../base/cache_network_image.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../bottomMenu_screen/bottom_menu_screen.dart';
import 'innerWidget/custom_listTile.dart';

class BoutiqueProfileScreen extends StatefulWidget {
   BoutiqueProfileScreen({super.key});

  @override
  State<BoutiqueProfileScreen> createState() => _BoutiqueProfileScreenState();
}

class _BoutiqueProfileScreenState extends State<BoutiqueProfileScreen> {
  BoutiqueProfileControllar profileCtrl=Get.put(BoutiqueProfileControllar());
  @override
  void initState() {
     profileCtrl.profiledata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BoutiqueBottomMenu(3),
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
                  Get.toNamed(AppRoutes.boutiqueEditProfileScreen);
                },
                child: Text(
                  AppString.editText.tr,
                  style: AppStyles.h6(color: Colors.white),
                ),
              )),

          SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

          /// Notification Setting

          // BoutiqueCustomListTile(
          //   title:AppString.notificationSettingText.tr,
          //   icon:AppIcons.notificationIcon ,
          //   onTap: (){
          //     Get.toNamed(AppRoutes.boutiqueNotificationSettingScreen);
          //   },
          // ),

        //  Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          /// Chat History
          BoutiqueCustomListTile(
            title:AppString.chathistoryText.tr,
            icon:AppIcons.massegeIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueChatHistoryScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          /// Change Password

          BoutiqueCustomListTile(
            title:AppString.changepasswordText.tr,
            icon:AppIcons.bagIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueChangePasswordScreen);

            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          /// Language

          BoutiqueCustomListTile(
            title:AppString.languageText.tr,
            icon:AppIcons.languageIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueLanguageScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          /// Help & Support
          BoutiqueCustomListTile(
            title:AppString.helpText.tr,
            icon:AppIcons.helpIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueHelpScreenScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

    /// Shopper Review

          BoutiqueCustomListTile(
            title:AppString.shoppersReviewText.tr,
            icon:AppIcons.shopperReviewIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueShopperReviewScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          /// Bank Info
          BoutiqueCustomListTile(
            title:AppString.bankInfoText.tr,
            icon:AppIcons.bankInfoIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueBankInfoScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

    /// Withdrawal
          BoutiqueCustomListTile(
            title:AppString.withdrawalText.tr,
            icon:AppIcons.withdrawlIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueWithdrawalScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          /// Terms of Use

          BoutiqueCustomListTile(
            title:AppString.termsofUseText.tr,
            icon:AppIcons.massegeIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiqueTermAndUseScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),
          ///Privacy Policy

          BoutiqueCustomListTile(
            title:AppString.privacyPolicyText.tr,
            icon:AppIcons.privacyIcon ,
            onTap: (){
              Get.toNamed(AppRoutes.boutiquePrivacyScreen);
            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

          ///Logout

          BoutiqueCustomListTile(
            title:AppString.logoutText.tr,
            icon:AppIcons.logoutIcon ,
            onTap: (){
              profileCtrl.boutiqueLogout();

            },
          ),

          Divider(color: Get.theme.dividerColor.withOpacity(0.2),),

        ],
      ),
    );
  }
}