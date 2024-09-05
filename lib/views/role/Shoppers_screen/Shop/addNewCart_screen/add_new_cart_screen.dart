import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';

class AddCartScreen extends StatelessWidget {
  AddCartScreen({super.key});

  TextEditingController cartCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        // centerTitle: true,
        title: Text(
          AppString.addCardText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 198.h,
                width: 358.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21).r,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xFF70350B),
                      Color(0xFF1F1D1C),
                    ],
                  ),
                ),
              ),
          
          
              SizedBox(
                height: Dimensions.paddingSizeExtraLarge.h,
              ),
          
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///>>>>>>>>>>>>>>>>>>>> Cart Owner>>>>>>>>>>>>>>>>>>>>>>>
                    Text(
                      AppString.cardOwnerText.tr,
                      style: AppStyles.h8(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      contentPaddingVertical: 15.h,
                      controller: cartCtrl,
                      filColor: Colors.transparent,
                      isEmail: true,
                    ),
          
                    SizedBox(
                      height: Dimensions.paddingSizeSmall.h,
                    ),
          
                    ///>>>>>>>>>>>>>>>>>>>> Cart Cart Number >>>>>>>>>>>>>>>>>>>>>>>
          
                    Text(
                      AppString.cartnumberText.tr,
                      style: AppStyles.h8(),
                    ),
          
                    SizedBox(
                      height: Dimensions.paddingSizeExtraSmall.h,
                    ),
                    CustomTextField(
                      contentPaddingVertical: 15.h,
                      controller: cartCtrl,
                      filColor: Colors.transparent,
                      isEmail: true,
                    ),
                  ],
                ),
              ),
          
          
              SizedBox(
                height: Dimensions.paddingSizeSmall.h,
              ),
          
              ///>>>>>>>>>>>>>>>>>>>> Cart Expire and CVV Number >>>>>>>>>>>>>>>>>>>>>>>
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
          
          
                    ///>>>>>>>>>>>>>>>>>>>> Cart Expire >>>>>>>>>>>>>>>>>>>>>>>
          
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.expiryText.tr,
                          style: AppStyles.h8(),
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeSmall.h,
                        ),
                        Container(
                          width: 166.w,
                          child: CustomTextField(
                            contentPaddingVertical: 15.h,
                            controller: cartCtrl,
                            filColor: Colors.transparent,
                            isEmail: true,
                          ),
                        ),
                      ],
                    ),
          
          
          
                    ///>>>>>>>>>>>>>>>>>>>>  CVV Number >>>>>>>>>>>>>>>>>>>>>>>
          
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.cVVText.tr,
                          style: AppStyles.h8(),
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeSmall.h,
                        ),
                        Container(
                          width: 166.w,
                          child: CustomTextField(
                            contentPaddingVertical: 15.h,
                            controller: cartCtrl,
                            filColor: Colors.transparent,
                            isEmail: true,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
          
              SizedBox(
                height: Dimensions.paddingSizeExtraLarge.h,
              ),
          
              ///>>>>>>>>>>>>>>>>>>>> ADD Button >>>>>>>>>>>>>>>>>>>>>>>
          
          
              CustomButton(
          
                onTap: (){
                  //  Get.toNamed(AppRoutes.checkoutScreen);
                }, text:'Add',)
            ],
          ),
        ),
      ),
    );
  }
}
