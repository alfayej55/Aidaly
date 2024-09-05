import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/boutique_track_order_screen/innerWidget/boutique__track_bottom_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morphable_shape/morphable_shape.dart';

import '../../../../../utils/dimensions.dart';
import '../../../../controllers/Role/Driver_Controllar/driver_order_traking_controller.dart';
import '../../../../controllers/massage_controller/inbox_massage_controller.dart';
import '../../../base/cache_network_image.dart';
import 'drivered_track_map.dart';


class DriverOrderTrackScreen extends StatefulWidget {

  DriverOrderTrackScreen({super.key});

  @override
  State<DriverOrderTrackScreen> createState() => _DriverOrderTrackScreenState();
}

class _DriverOrderTrackScreenState extends State<DriverOrderTrackScreen> {
  DriverOrderTrackingControllar _orderTrackingCtrl=Get.put(DriverOrderTrackingControllar());
  InboxMassageControlelr _chatController = Get.put(InboxMassageControlelr());
  var productId=Get.arguments;


  @override
  void initState() {
    _orderTrackingCtrl.driverOrderTrack(productId);
    // _orderTrackingCtrl.updateDriverTrackingStatus(status:DriverStatus.waytoPickup.name,orderId:_orderTrackingCtrl.orderTrackModel.value.id!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.orderTrackText.tr,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
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
      ),

      body: SafeArea(
        child:Obx(() =>  _orderTrackingCtrl.drivertrackLoading.value?CustomPageLoading(): Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///>>>>>>>>>>>>>>>>>>>>> Google map>>>>>>>>>>>>>>>>>>

            DriverGoogleMapScreen(),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.paddingSizeLarge,),
                    /// Driver details
                    _boutiqueDetails(),

                    SizedBox(height: Dimensions.paddingSizeLarge,),

                    ///>>>>>>>>>>>>>>>>>>>>>Customer Details>>>>>>>>>>>>>>>>>>
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        AppString.customerDetailsText.tr,
                        style: AppStyles.h7(),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: Dimensions.paddingSizeminiSmall.h,),

                    /// Customar details

                    _customarDetails(),

                    SizedBox(height: Dimensions.paddingSizeminiSmall.h,),

                    ///>>>>>>>>>>>>>>>>>>>>>Product Summary>>>>>>>>>>>>>>>>>>

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [

                          ///Product Summary
                          _productSummary(),

                          ///Delivery Address

                          _deliveryAddress(),


                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),

                    ///>>>>>>>>>>>>>>>>>>>>>Button>>>>>>>>>>>>>>>>>>

                    Align(
                      alignment: Alignment.center,
                      child: Obx(()=>
                        CustomButton(
                            padding: EdgeInsets.only(bottom: 20.h),
                            loading: _orderTrackingCtrl.updateDriverTrackingLoading.value,
                            onTap: (){
                              _orderTrackingCtrl.updateDriverTrackingStatus(status:_orderTrackingCtrl.orderTrackModel.value.assignedDrivertrack!,orderId:_orderTrackingCtrl.orderTrackModel.value.id!);
                              },
                            text: _orderTrackingCtrl.trackingStatusText('${_orderTrackingCtrl.orderTrackModel.value.assignedDrivertrack}')),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        )),
      ),
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Boutique Details>>>>>>>>>>>

  _boutiqueDetails(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 17.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Get.theme.cardColor.withOpacity(0.5 ),
          boxShadow: [
            AppStyles.boxShadow
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///  Boutique Image
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl:"${ApiConstant.imageBaseUrl}${_orderTrackingCtrl.orderTrackModel.value.boutiqueId!.image!.publicFileUrl}",
              //borderRadius: BorderRadius.circular(12.r),
              height: 32.h,
              width:32.w,
              boxShape: BoxShape.circle,

            ),
            SizedBox(width:15.w,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///  Boutique Name
                Container(
                  width: 190.w,
                  child: Text(
                    '${_orderTrackingCtrl.orderTrackModel.value.boutiqueId!.name}',
                    style: AppStyles.customSize(size: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 7.h,),
                ///  Boutique Location

                Row(
                  children: [
                    SvgPicture.asset(AppIcons.locationIcon),
                    Text(
                      '${_orderTrackingCtrl.orderTrackModel.value.boutiqueId!.address}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: AppStyles.customSize(size: 13.92,fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),

            ///  Boutique Message

            GestureDetector(
              onTap: (){
                _chatController.firstCreeateMassage(_orderTrackingCtrl.orderTrackModel.value.boutiqueId!.id!);
              },
              child: Container(
                height: 35.h,
                width: 35.w,
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle
                ),
                child: Center(child: SvgPicture.asset(AppIcons.massegeIcon,color: Get.theme.primaryColor,height: 19.h,width: 19.w,),),
              ),
            )

          ],
        ),
      ),
    );

  }

  /// >>>>>>>>>>>>>>>>>> Customer Details >>>>>>>>>

  _customarDetails(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 17.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Get.theme.cardColor.withOpacity(0.5 ),
            boxShadow: [
              AppStyles.boxShadow
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///  Boutique Image
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNetworkImage(
                      imageUrl:"${ApiConstant.imageBaseUrl}${_orderTrackingCtrl.orderTrackModel.value.userId!.image!.publicFileUrl}",
                      //borderRadius: BorderRadius.circular(12.r),
                      height: 32.h,
                      width:32.w,
                      boxShape: BoxShape.circle,

                    ),
                    SizedBox(width:15.w,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///  User Name
                        Container(
                          width: 190.w,
                          child: Text(
                            '${_orderTrackingCtrl.orderTrackModel.value.userId!.name}',
                            style: AppStyles.customSize(size: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 7.h,),
                        ///  User Location

                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.locationIcon),
                            Text(
                              '${_orderTrackingCtrl.orderTrackModel.value.userId!.address}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: AppStyles.customSize(size: 13.92,fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),

            ///  User Message
            GestureDetector(
              onTap: (){
                _chatController.firstCreeateMassage(_orderTrackingCtrl.orderTrackModel.value.userId!.id!);
              },
              child: Container(
                height: 35.h,
                width: 35.w,
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle
                ),
                child: Center(child: SvgPicture.asset(AppIcons.massegeIcon,color: Get.theme.primaryColor,height: 19.h,width: 19.w,),),
              ),
            )

          ],
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
            imageUrl:"${_orderTrackingCtrl.orderTrackModel.value.orderItems!.orederedProduct![0].image}",
            //borderRadius: BorderRadius.circular(12.r),
            //borderRadius: BorderRadius.circular(12.r),
            height: 47.h,
            width:47.w,
            borderRadius: BorderRadius.circular(10),

          ),
          title: Text('${_orderTrackingCtrl.orderTrackModel.value.userId!.name}'),
          subtitle: Row(
            children: [
              SvgPicture.asset(AppIcons.bagIcon,height: 15.h,width: 15.h,),
              SizedBox(width: 5.w,),
              Text('${_orderTrackingCtrl.orderTrackModel.value.orderItems!.orederedProduct!.length} Items'),
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
              color: Get.theme.cardColor.withOpacity(0.5),
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
                      child: Text('${_orderTrackingCtrl.orderTrackModel.value.deliveryAddress}',
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
