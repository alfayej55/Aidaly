
import 'dart:ui';

import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'innerWidget/custom_button.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  PageController pageCtrl=PageController();

  var data=[
    {
      'title':AppString.onboardingText1.tr,
      'subTitle':AppString.subonboardingText1.tr,
      'image':AppImages.onboardingImage1.tr
    },
    {
      'title':AppString.onboardingText2.tr,
      'subTitle':AppString.subonboardingText2.tr,
      'image':AppImages.onboardingImage2
    },
    {
      'title':AppString.onboardingText3.tr,
      'subTitle':AppString.subonboardingText3.tr,
      'image':AppImages.onboardingImage3
    }
  ];

  var currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: data.length,
              controller: pageCtrl,
              itemBuilder: (context,index){
              return  Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(data[index]['image']!,fit: BoxFit.cover,width: double.infinity,),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX:0, sigmaY:0),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [const Color(0xFFFFFFFF).withOpacity(0.3),Color(0xFF1E66CA)],
                        ),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 25.w,top: 300.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data[index]['title']!,style: AppStyles.h1(color: AppColors.whiteColor),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),
                            Text(data[index]['subTitle']!,style: AppStyles.h6(color: AppColors.onboardintSubTextColor),textAlign: TextAlign.start,maxLines: 5,overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),// Adjust opacity as needed
                    ),
                  ),

                ],
              );
          },
            onPageChanged: (value){
              currentIndex=value;
            },

          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: pageCtrl,
                  count:  3,
                  axisDirection: Axis.horizontal,
                  effect:  SlideEffect(
                      spacing:  8.0,
                      paintStyle:  PaintingStyle.fill,
                      dotHeight: 10,
                      dotWidth: 10,
                      strokeWidth:  1.5,
                      dotColor:  Colors.grey,
                      activeDotColor:AppColors.whiteColor
                  ),
                ),

                ContinueCustomButton(
                  onTap: (){
                    if(currentIndex==2){
                      
                     Get.offNamed(AppRoutes.roleSelectScreen);

                    }
                    else{

                      pageCtrl.nextPage(duration: Duration(seconds: 1),curve:Curves.easeOutExpo);

                    }

                  },
                  
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
