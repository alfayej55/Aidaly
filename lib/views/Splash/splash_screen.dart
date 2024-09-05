import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_constants.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(Duration(seconds: 3),()async{
      var role=await PrefsHelper.getString(AppConstants.userRoles);

      if(role==Status.shopper.name){
        Get.offNamed(AppRoutes.homeScreen);
      }
      else if(role==Status.boutique.name){
        Get.offNamed(AppRoutes.homeBoutique);
      }
      else if(role==Status.driver.name){
        Get.offNamed(AppRoutes.driversHomeScreen);
      }
      else{
        Get.offNamed(AppRoutes.onBoardingScreen);
      }

    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(
                AppImages.splashScreenImage,
                color: AppColors.whiteColor,
              ),
            ),
        
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20),
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: CustomButton(
            //       width: 120,
            //       color: AppColors.whiteColor,
            //       textStyle: TextStyle(
            //         color: AppColors.primaryColor,
            //         fontFamily: 'Poppins',
            //         fontWeight: FontWeight.w600,
            //         fontSize: 18,
            //       ),
            //       onTap: ()async {
            //         var role=await PrefsHelper.getString(AppConstants.userRoles);
            //         print('Role1>>${role.toString()}');
            //         print('Role>>${Status.shopper.name}');
            //         if(role==Status.shopper.name){
            //           Get.offNamed(AppRoutes.homeScreen);
            //         }
            //         else if(role==Status.boutique.name){
            //           Get.offNamed(AppRoutes.homeBoutique);
            //         }
            //         else if(role==Status.driver.name){
            //           Get.offNamed(AppRoutes.driversHomeScreen);
            //         }
            //         else{
            //           Get.offNamed(AppRoutes.onBoardingScreen);
            //         }
            //
            //         // Add your onTap functionality here
            //       },
            //       text: AppString.getStartedText.tr,
            //     ),
            //   ),
            // ),
        
          ],
        ),
      )

    );
  }
}
