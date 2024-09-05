import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morphable_shape/morphable_shape.dart';

import '../../../../controllers/Role/Shopper_Controllar/order_tracking_controllar.dart';
import '../../../../controllers/massage_controller/inbox_massage_controller.dart';
import '../../../../utils/dimensions.dart';
import '../../../base/cache_network_image.dart';
import '../../../base/custom_page_loading.dart';
import 'innerWidget/shopper_track_bottom_menu.dart';
import 'innerWidget/google_map.dart';

class OrderTrackScreen extends StatefulWidget {
  const OrderTrackScreen({super.key});

  @override
  State<OrderTrackScreen> createState() => _OrderTrackScreenState();
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  var orderId = Get.arguments;

  ShopperOrderTrackingControllar _trackingCtrl =
      Get.put(ShopperOrderTrackingControllar());





  @override
  void initState() {
    _trackingCtrl.shopperOrderTrack(orderId);
    _trackingCtrl.listenDriverLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _trackingCtrl.offDriverLocation();
    // TODO: implement dispose
    super.dispose();
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
      bottomNavigationBar: Obx(
        () => _trackingCtrl.orderTrackLoading.value
            ? CustomPageLoading()
            : BottomNavBarWidget(
                driverInfo: _trackingCtrl.shopperTrackModel.value.assignedDriver),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///>>>>>>>>>>>>>>>>>>>>> Google map>>>>>>>>>>>>>>>>>>

          GoogleMapScreen(),

          Expanded(
            child: Obx(
              () => _trackingCtrl.orderTrackLoading.value
                  ? Center(child: CustomPageLoading())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),

                          ///>>>>>>>>>>>>>>>>>>>>> Deliver Processing >>>>>>>>>>>>>>>>>>

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppString.driverisonitsText.tr,
                                  style: AppStyles.h7(),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${_trackingCtrl.orderTextUpdate()}',
                                  style: AppStyles.customSize(
                                      size: 14, fontWeight: FontWeight.w500),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                ///>>>>>>>>>>>>>>>>>>>>> Driver Images >>>>>>>>>>>>>>>>>>

                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                          AppImages.driverisonItimage),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: AppString.arrivinginText.tr,
                                            style: AppStyles.h8(
                                                color: AppColors.textColor)),

                                        ///>>>>>>>>>>>>>>>>>>>>> Deliver Time >>>>>>>>>>>>>>>>>>
                                        TextSpan(
                                            text:
                                                ' ${_trackingCtrl.deliveryTime.value}',
                                            style: AppStyles.customSize(
                                                size: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Get.theme.primaryColor))
                                      ]))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///>>>>>>>>>>>>>>>>>>>>>Divider>>>>>>>>>>>>>>>>>>

                          Divider(
                            thickness: 0.2,
                            indent: 24.w,
                            endIndent: 24.w,
                            color: AppColors.textColor.withOpacity(0.4),
                          ),

                          ///>>>>>>>>>>>>>>>>>>>>>Product Summary>>>>>>>>>>>>>>>>>>

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              children: [
                                ///Product Summary

                                _productSummary(),

                                ///Delivery Address

                                _deliveryAddress(),

                                SizedBox(
                                  height: 15.h,
                                ),

                                /// Payment Method

                                _paymentMethod(),

                                /// Amount Sunnary

                                _amountSummary(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          )
        ],
      )),
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Product Summary >>>>>>>>>>>

  _productSummary() {
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
          titleTextStyle: AppStyles.customSize(
              size: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor),
          subtitleTextStyle: AppStyles.customSize(
              size: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor),
          leading: CustomNetworkImage(
            imageUrl:
                "${_trackingCtrl.shopperTrackModel.value.orderItems!.orederedProduct![0].image}",
            //borderRadius: BorderRadius.circular(12.r),
            height: 47.h,
            width: 47.w,
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
              '${_trackingCtrl.shopperTrackModel.value.orderItems!.orederedProduct![0].productName}'),
          subtitle: Row(
            children: [
              SvgPicture.asset(
                AppIcons.bagIcon,
                height: 15.h,
                width: 15.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                  '${_trackingCtrl.shopperTrackModel.value.orderItems!.orederedProduct![0].quantity} Items'),
            ],
          ),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Delivery Address>>>>>>>>>>>

  _deliveryAddress() {
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
        SizedBox(
          height: Dimensions.paddingSizeLarge.h,
        ),
        Container(
          height: 106.h,
          width: 342.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15).r,
              color: Get.theme.cardColor,
              boxShadow: [AppStyles.boxShadow]),
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.deliveryLocationimage,
                  width: 32.w,
                  height: 32.h,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Text(
                    '${_trackingCtrl.shopperTrackModel.value.deliveryAddress}',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: AppStyles.customSize(
                        size: 15,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.disabledColor),
                  ),
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Payment Method >>>>>>>>>>>

  _paymentMethod() {
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
          titleTextStyle: AppStyles.customSize(
              size: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor),
          subtitleTextStyle: AppStyles.customSize(
              size: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.subTextColor),
          leading: Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10).r,
                  color: Get.theme.primaryColor.withOpacity(0.1)),
              child: Center(
                  child: SvgPicture.asset(
                AppImages.paypalImage,
                height: 30.h,
                width: 30.w,
              ))),
          title: Text('Paypal Classic'),
          subtitle: Text('*****7854'),
        ),
        SizedBox(
          height: Dimensions.paddingSizeLarge.h,
        ),
      ],
    );
  }

  ///>>>>>>>>>>>>>>>>>>> Amount Summary >>>>>>>>>>>
  _amountSummary() {
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
              style: AppStyles.h5(),
            ),
            Text(
              '\$${_trackingCtrl.shopperTrackModel.value.subTotal}',
              style: AppStyles.customSize(size: 18),
            ),
          ],
        ),

        ///>>>>>>>>>>>>>>>>>>>>>>> Shipping >>>>>>>>>>>>>>>>>>>>

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.shippingText.tr,
              style: AppStyles.h5(),
            ),
            Text(
              '\$${_trackingCtrl.shopperTrackModel.value.shippingFee}',
              style: AppStyles.customSize(size: 18),
            ),
          ],
        ),

        ///>>>>>>>>>>>>>>>>>>>>>>> Total  >>>>>>>>>>>>>>>>>>>>

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.totalText.tr,
              style: AppStyles.customSize(
                size: 18,
              ),
            ),
            Text(
              '\$${totalCalculetion()}',
              style:
                  AppStyles.customSize(size: 22, color: Get.theme.primaryColor),
            ),
          ],
        )
      ],
    );
  }

  totalCalculetion() {
    var subTotal =
        double.parse(_trackingCtrl.shopperTrackModel.value.subTotal!);
    var shippingFee =
        double.parse(_trackingCtrl.shopperTrackModel.value.shippingFee!);

    return subTotal + shippingFee;
  }
}
