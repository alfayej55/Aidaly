import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/BoutiquesControllar/in_progress_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/cache_network_image.dart';

class InProgressOrderDetails extends StatefulWidget {


  const InProgressOrderDetails({super.key});

  @override
  State<InProgressOrderDetails> createState() => _InProgressOrderDetailsState();
}

class _InProgressOrderDetailsState extends State<InProgressOrderDetails> {
  InProgressController _inProgressCtrl=Get.put(InProgressController());

  var productId=Get.arguments;

  @override
  void initState() {
    _inProgressCtrl.inProgressDetails(productId);
    // TODO: implement initState
    super.initState();
  }


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

      body: Obx(() =>_inProgressCtrl.detailsLoading.value?CustomPageLoading(): Padding(
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

                    Text('${_inProgressCtrl.inprogressDetailsModel.value.orderId}',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 10.w),
                      child: CustomNetworkImage(
                        imageUrl:"${ApiConstant.imageBaseUrl}${_inProgressCtrl.inprogressDetailsModel.value.boutiqueId!.image!.publicFileUrl}",
                        boxShape: BoxShape.circle,
                        height: 47.h,
                        width:47.w,
                      ),
                    ),

                    SizedBox(width: 10.w,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///    Boutique Name

                        Text(
                        _inProgressCtrl.inprogressDetailsModel.value.boutiqueId!.name.toString(),
                          style: AppStyles.customSize(size: 16),
                        ),

                        ///    Boutique Location

                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.locationIcon),
                            SizedBox(width: 5.w,),
                            Text(
                              _inProgressCtrl.inprogressDetailsModel.value.boutiqueId!.address.toString(),
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

              /// Amount Summary

              _amountSummary(),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),



              /// Button

              CustomButton(
                padding: EdgeInsets.only(bottom: 15.h),
                onTap: (){
                  Get.toNamed(AppRoutes.allDriversScreen,arguments:_inProgressCtrl.inprogressDetailsModel.value.id);
                }, text: AppString.assigntoDriverText.tr,

              ),


            ],),
        ),
      )),
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
            imageUrl:"${_inProgressCtrl.inprogressDetailsModel.value.orderItems!.orederedProduct![0].image}",
            //borderRadius: BorderRadius.circular(12.r),
            height: 47.h,
            width:47.w,
            borderRadius: BorderRadius.circular(10),

          ),
          title: Text(_inProgressCtrl.inprogressDetailsModel.value.orderItems!.orederedProduct![0].productName.toString()),
          subtitle: Row(
            children: [
              SvgPicture.asset(AppIcons.bagIcon,height: 15.h,width: 15.h,),
              SizedBox(width: 5.w,),
              Text('${_inProgressCtrl.inprogressDetailsModel.value.orderItems!.orederedProduct!.length} Items'),
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
                      child: Text(_inProgressCtrl.inprogressDetailsModel.value.deliveryAddress.toString(),
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
              '\$${_inProgressCtrl.inprogressDetailsModel.value.subTotal}',
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
              '\$${_inProgressCtrl.inprogressDetailsModel.value.shippingFee}',
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
              '\$${totalCalculetion()}',
              style:AppStyles.customSize(size: 22,color: Get.theme.primaryColor),
            ),

          ],
        )
      ],
    );
  }

/// Totla Calculetion

  totalCalculetion(){
    var subTotal = double.parse(_inProgressCtrl.inprogressDetailsModel.value.subTotal!);
    var shippingFee = double.parse(_inProgressCtrl.inprogressDetailsModel.value.shippingFee!);


    var total = subTotal + shippingFee;

    // Return the total with 2 decimal places
    return total.toStringAsFixed(2);
  }
}
