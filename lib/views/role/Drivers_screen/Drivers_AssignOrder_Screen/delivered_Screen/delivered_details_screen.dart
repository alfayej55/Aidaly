import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/Driver_Controllar/driver_delivered_controller.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/cache_network_image.dart';
import '../../../../base/custom_page_loading.dart';

class DriversDeliveredDetails extends StatefulWidget {


  const DriversDeliveredDetails({super.key});

  @override
  State<DriversDeliveredDetails> createState() => _DriversDeliveredDetailsState();
}

class _DriversDeliveredDetailsState extends State<DriversDeliveredDetails> {

  var productId=Get.arguments;

  DriverDeliverdController _driverDeliveryCtrl=Get.put(DriverDeliverdController());
  @override
  void initState() {

    _driverDeliveryCtrl.driverDeliveryDetails(productId);
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

      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(() => _driverDeliveryCtrl.detailsLoading.value?CustomPageLoading():Column(

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
                  Text(AppString.deliveredText.tr,
                    style:AppStyles.customSize(size: 14,color: Color(0xffD1A301),fontWeight: FontWeight.w500) ,),
                  Container(
                    height: 20.h,
                    child: VerticalDivider(
                      color: Get.theme.primaryColor.withOpacity(0.2),
                    ),
                  ),

                  /// Order Id

                  Text('${_driverDeliveryCtrl.deliverDetailsModel.value.orderId}',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top:15.h,left: 10.w),
                    child: CustomNetworkImage(
                      imageUrl:"${ApiConstant.imageBaseUrl}${_driverDeliveryCtrl.deliverDetailsModel.value.boutiqueId!.image!.publicFileUrl}",
                      boxShape: BoxShape.circle,
                      height: 42.h,
                      width:42.w,),
                  ),

                  SizedBox(width: 15.w,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///    Boutique Name

                      Text(
                        '${_driverDeliveryCtrl.deliverDetailsModel.value.boutiqueId!.name}',
                        style: AppStyles.customSize(size: 16),
                      ),

                      ///    Boutique Location

                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.locationIcon),
                          SizedBox(width: 5.w,),
                          Text(
                            '${_driverDeliveryCtrl.deliverDetailsModel.value.boutiqueId!.address}',
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

            /// Product Summary

            _productSummary(),

            /// Delivery Address

            _deliveryAddress(),


          ],)),
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
            imageUrl:"${_driverDeliveryCtrl.deliverDetailsModel.value.orderItems!.orederedProduct![0].image}",
            //borderRadius: BorderRadius.circular(12.r),
            height: 47.h,
            width:47.w,
            borderRadius: BorderRadius.circular(10),

          ),
          title: Text("${_driverDeliveryCtrl.deliverDetailsModel.value.orderItems!.orederedProduct![0].productName}"),
          subtitle: Row(
            children: [
              SvgPicture.asset(AppIcons.bagIcon,height: 15.h,width: 15.h,),
              SizedBox(width: 5.w,),
              Text('${"${_driverDeliveryCtrl.deliverDetailsModel.value.orderItems!.orederedProduct![0].quantity}"} Items'),
            ],
          ),

        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Delivery Address>>>>>>>>>>>

  _deliveryAddress(){

    /// To tracking location

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
                      child: Text('${_driverDeliveryCtrl.deliverDetailsModel.value.deliveryAddress}',
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
}
