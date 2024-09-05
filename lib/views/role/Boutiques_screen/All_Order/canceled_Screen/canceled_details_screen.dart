import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/cache_network_image.dart';

class CanceledDetails extends StatelessWidget {


  const CanceledDetails({super.key});

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
          AppString.orderDetailsText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [

              ///  In progress Text

              Container(
                height: 36.h,
                width: 342.w,
                decoration: BoxDecoration(
                    boxShadow: [
                      AppStyles.boxShadow
                    ],
                    borderRadius: BorderRadius.circular(6).r,
                    color: Get.theme.cardColor.withOpacity(0.8)

                ),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppString.inProgressText.tr,
                      style:AppStyles.customSize(size: 14,color: Color(0xffD1A301),fontWeight: FontWeight.w500) ,),
                    Container(
                      height: 20.h,
                      child: VerticalDivider(
                        color: Get.theme.primaryColor.withOpacity(0.2),
                      ),
                    ),

                    /// Order Id

                    Text('#12345',
                      style:AppStyles.customSize(size: 14,fontWeight: FontWeight.w500) ,),
                  ],
                ),),
              ),

              SizedBox(height: 30.h),

              /// Boutique Name and Location

              Container(
                height: 83.h,
                width: 342.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10).r,
                    color: Get.theme.cardColor.withOpacity(0.5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top:15.h ),
                      child: Container(
                        height: 32.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(AppImages.ellipseImage))

                        ),
                      ),
                    ),

                    SizedBox(width: 15.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///    Boutique Name

                        Text(
                          'Boutique Name',
                          style: AppStyles.customSize(size: 16),
                        ),

                        ///    Boutique Location

                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.locationIcon),
                            SizedBox(width: 5.w,),
                            Text(
                              '5900 Cubero Dr NE, New York',
                              style: AppStyles.customSize(size: 13.92,fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),



                      ],
                    ),

                  ],
                ),
              ),


              SizedBox(height: 30.h),

              ///   Product Summary

              _productSummary(),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),

              ///Delivery Address

              _deliveryAddress(),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),

              ///Payment Method

              _paymentMethod(),

              /// Amount Summary

              _amountSummary(),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),




            ],),
        ),
      ),
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Product Summary >>>>>>>>>>>

  _productSummary(){

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.productsummaryText.tr,
          style: AppStyles.h7(),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          titleTextStyle: AppStyles.customSize(size: 14,fontWeight: FontWeight.w500,color: AppColors.textColor),
          subtitleTextStyle: AppStyles.customSize(size: 10,fontWeight: FontWeight.w500,color: AppColors.textColor),
          leading: CustomNetworkImage(
            imageUrl:"https://images.unsplash.com/photo-1513094735237-8f2714d57c13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob3BwaW5nfGVufDB8fDB8fHww",
            //borderRadius: BorderRadius.circular(12.r),
            height: 47.h,
            width:47.w,
            borderRadius: BorderRadius.circular(10),

          ),
          title: Text('Modern Nice Suit'),
          subtitle: Row(
            children: [
              SvgPicture.asset(AppIcons.bagIcon,height: 15.h,width: 15.h,),
              SizedBox(width: 5.w,),
              Text('2 Items'),
            ],
          ),

        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Delivery Address>>>>>>>>>>>

  _deliveryAddress(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.deliveryaddressText.tr,
          style: AppStyles.h7(),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: Dimensions.paddingSizeLarge.h,),

        Container(
          height: 106.h,
          width: 342.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).r,
              color: Get.theme.cardColor,
              boxShadow: [
                AppStyles.boxShadow
              ]
          ),
          child: Center(
              child:Padding(
                padding:  EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppImages.deliveryLocationimage,width: 32.w,height: 32.h,),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: Text('Selina K,21/3, Ragava Street, Silver tone,Kodaikanal - 655 789',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style:  AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Payment Method >>>>>>>>>>>

  _paymentMethod(){

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          AppString.paymentmthodText.tr,
          style: AppStyles.h7(),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          titleTextStyle: AppStyles.customSize(size: 15,fontWeight: FontWeight.w400,color: AppColors.textColor),
          subtitleTextStyle: AppStyles.customSize(size: 13,fontWeight: FontWeight.w400,color: AppColors.subTextColor),
          leading: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10).r,
                  color: Get.theme.primaryColor.withOpacity(0.1)
              ),
              child: Center(child: SvgPicture.asset(AppImages.paypalImage,height: 30.h,width: 30.w,))),
          title: Text('Paypal Classic'),
          subtitle: Text('*****7854') ,

        ),
        SizedBox(height: Dimensions.paddingSizeLarge.h,),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Amount Summary >>>>>>>>>>>
  _amountSummary(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.amountsummaryText.tr,
          style: AppStyles.h7(),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),

        ///>>>>>>>>>>>>>>>>>>>>>>> Sub Total >>>>>>>>>>>>>>>>>>>>

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.subTotalText.tr,
              style:AppStyles.h5(),
            ),
            Text(
              '\$8520.00',
              style:AppStyles.customSize(size:18),
            ),

          ],
        ),

        ///>>>>>>>>>>>>>>>>>>>>>>> Shipping >>>>>>>>>>>>>>>>>>>>

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.shippingText.tr,
              style:AppStyles.h5(),
            ),
            Text(
              '\$20.00'.tr,
              style:AppStyles.customSize(size:18),
            ),

          ],
        ),

        ///>>>>>>>>>>>>>>>>>>>>>>> Total  >>>>>>>>>>>>>>>>>>>>

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.totalText.tr,
              style:AppStyles.customSize(size: 18,),
            ),
            Text(
              '\$820.00'.tr,
              style:AppStyles.customSize(size: 22,color: Get.theme.primaryColor),
            ),

          ],
        )
      ],
    );
  }

}
