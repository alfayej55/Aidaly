import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'InnerWidget/cart_container.dart';
class RoleSelectPage extends StatefulWidget {
   RoleSelectPage({super.key});

  @override
  State<RoleSelectPage> createState() => _RoleSelectPageState();
}

class _RoleSelectPageState extends State<RoleSelectPage> {

  var data=[
    {
      'icon':AppIcons.profileIcon,
      'title':AppString.shoppersText.tr,
      'subTitle': AppString.subShoppersText.tr,
    },
    {
      'icon':AppIcons.boutiquesIcon,
      'title':AppString.boutiquesText.tr,
      'subTitle': AppString.subBoutiquesText.tr,
    },
    {
      'icon':AppIcons.driversIcon,
      'title':AppString.driversText.tr,
      'subTitle': AppString.subDriversText.tr,
    }
  ];

  var currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomText(
                 left: 15,
                 text: AppString.continueText.tr,
                 fontsize: 28,
                 textAlign: TextAlign.start,
                 fontWeight: FontWeight.w600,
                 color: Get.theme.primaryColor,

               ),
               CustomText(
                 left: 15,
                 right: 10,
                 text: AppString.subContinueText.tr,
                 fontsize: 17,
                 fontWeight: FontWeight.w400,
                 maxline: 3,
                 textAlign: TextAlign.start,

               ),
             ],
           ),

          SizedBox(height: 10.h,),
            ListView.builder(
              itemCount: data.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder:(context,index){
                  return CartScreen (
                      onTap: (){
                        setState(() {
                          currentIndex=index;
                        });
                      },
                      isChecked:  currentIndex==index?true:false,
                      icon: data[index]['icon']!,
                      text: data[index]['title']!,
                      subText: data[index]['subTitle']!,
                      iconColor: currentIndex==index?AppColors.whiteColor:Get.theme.primaryColor,
                      borderColor: currentIndex==index?Get.theme.primaryColor:Get.theme.primaryColor.withOpacity(0.1),
                      containerColor: currentIndex==index?Get.theme.primaryColor:Get.theme.primaryColor.withOpacity(0.1)
                    );
                }),

           SizedBox(
             height: 35.h,
           ),

              CustomButton(
                height: 58.h,
                  width: 342.w,
                  onTap: (){
                  if(currentIndex==0){
                    Get.toNamed(AppRoutes.loginScreen);
                  }
                  else if(currentIndex==1){
                    Get.toNamed(AppRoutes.boutiqueloginScreen);
                  }
                  else if(currentIndex==2){
                    Get.toNamed(AppRoutes.driversloginScreen);
                  }

                  }, text: AppString.productcontinueText.tr)

        ],
      ),


    );
  }
}

