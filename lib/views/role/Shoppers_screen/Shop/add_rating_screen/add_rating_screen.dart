import 'dart:io';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/Shopper_Controllar/product_details_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';

class RatingAndReivewScreen extends StatelessWidget {
   RatingAndReivewScreen({super.key});

   ProduceDetailsController ratingCtrl=Get.put(ProduceDetailsController());
   final _formKey = GlobalKey<FormState>();
   var productId=Get.arguments;

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
          AppString.ratingreivewText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),
      body: Form(
        key: _formKey,
          child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: SingleChildScrollView(

            child:Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: Dimensions.paddingSizeDefault.h,
              ),
              Text(
                AppString.ratingText.tr,
                style: AppStyles.h8(),
              ),
              RatingBar.builder(
                initialRating: 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  ratingCtrl.rating.value=rating;
                  print('Rating>>${rating}');
                },
              ),


              SizedBox(
                height: Dimensions.paddingSizeDefault.h,
              ),

              ///>>>>>>>>>>>>>>>>>>>> Height  and width Feild >>>>>>>>>>>>>>>>>>>>>>>

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  ///>>>>>>>>>>>>>>>>>>>> Height >>>>>>>>>>>>>>>>>>>>>>>

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Height',
                        style: AppStyles.h8(),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall.h,
                      ),
                      Container(
                        width: 166.w,
                        child: CustomTextField(
                          contentPaddingVertical: 15.h,
                          controller:ratingCtrl.heightCtrl,
                          filColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),



                  ///>>>>>>>>>>>>>>>>>>>>  Weight >>>>>>>>>>>>>>>>>>>>>>>

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight',
                        style: AppStyles.h8(),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall.h,
                      ),
                      Container(
                        width: 166.w,
                        child: CustomTextField(
                          contentPaddingVertical: 15.h,
                          controller: ratingCtrl.widthCtrl,
                          filColor: Colors.transparent,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: Dimensions.paddingSizeDefault.h,
              ),

              ///>>>>>>>>>>>>>>>>>>>> Review Feild >>>>>>>>>>>>>>>>>>>>>>>

              Text(
                AppString.reviewsText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextField(
                contentPaddingVertical: 15.h,
                controller: ratingCtrl.reviewCtrl,
                maxLine: 2,
                filColor: Colors.transparent,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Review';
                  }
                  return null;
                },
              ),

              SizedBox(
                height: Dimensions.paddingSizeDefault.h,
              ),

              ///>>>>>>>>>>>>>>>>>>>> Add Image Feild >>>>>>>>>>>>>>>>>>>>>>>

              Container(
                height: 130.h,
                child: ListView.builder(
                    itemCount: ratingCtrl.images.value.length+1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      if(ratingCtrl.images.value.length>index){
                        return  Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            height:130.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                image: DecorationImage(image: FileImage(File(ratingCtrl.images.value[index])),fit: BoxFit.cover),
                                color: Get.theme.primaryColor.withOpacity(0.1)
                            ),

                          ),
                        );
                      }else{
                        return GestureDetector(
                          onTap: (){
                            ratingCtrl.pickImageFromCamera();
                          },
                          child: Container(
                            height:130.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30).r,
                                color: Get.theme.primaryColor.withOpacity(0.1)
                            ),
                            child: Center(child: Icon(Icons.camera_alt),),
                          ),
                        );
                      }
                    }),
              ),

              SizedBox(
                height: Dimensions.paddingSizeExtraLarge.h,
              ),

              /// Add Comment Button

              Align(
                alignment: Alignment.bottomCenter,
                child:ratingCtrl.loading.value?CustomPageLoading(): CustomButton(
                  onTap: (){
                    if(ratingCtrl.rating != 0.0){
                      ratingCtrl.addComment(productId);
                    }
                    else{
                      showToastMessage.showMessage("Add Rating");
                    }

                  },
                  height: 58.h,
                  width: 342.w,
                  text:AppString.addText.tr,
                  textStyle: AppStyles.h7(
                      color: AppColors.whiteColor,
                      letterSpacing: 2
                  ),
                ),
              ),

            ],
          )),
        ),
      )),
    );
  }
}
