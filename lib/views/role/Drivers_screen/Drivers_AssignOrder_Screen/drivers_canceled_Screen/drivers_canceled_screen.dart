import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../controllers/Role/Driver_Controllar/canceled_order_controller.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/cache_network_image.dart';
import '../../../../base/custom_page_loading.dart';
import '../../Widget/drivers_order_card.dart';

class DriversCanceledScreen extends StatefulWidget {
  const DriversCanceledScreen({super.key});

  @override
  State<DriversCanceledScreen> createState() => _DriversCanceledScreenState();
}

class _DriversCanceledScreenState extends State<DriversCanceledScreen> {
  DriverCancelController _cancelCtrl = Get.put(DriverCancelController());

  @override
  void initState() {
    super.initState();
    _cancelCtrl.driverCancelFirsLoad();
    _cancelCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_cancelCtrl.scrollController.position.pixels ==
        _cancelCtrl.scrollController.position.maxScrollExtent) {
      _cancelCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _cancelCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _body(context));
  }

  _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: _cancelCtrl.cancelOrderModel.isEmpty
          ?   Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
            SizedBox(height: 15.h,),
            Text("You Have No Project In Canceled",style: AppStyles.h3(),),
          ],
        ),
      )
          : RefreshIndicator(
              onRefresh: () async {},
              child: ListView.separated(
                itemCount: _cancelCtrl.cancelOrderModel.value.length + 1,
                controller: _cancelCtrl.scrollController,
                shrinkWrap: true,
                primary: false,
                // scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index >= _cancelCtrl.cancelOrderModel.value.length) {
                    return _cancelCtrl.firstLoading.value
                        ? CustomPageLoading()
                        : SizedBox();
                  } else {
                    var data = _cancelCtrl.cancelOrderModel.value[index];
                    return GestureDetector(
                        onTap: () {
                               Get.toNamed(AppRoutes.driversCancledDetailsScreen,
                              arguments: data.id);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Product Image
                            CustomNetworkImage(
                              imageUrl:
                                  "${ApiConstant.imageBaseUrl}${data!.boutiqueId!.image!.publicFileUrl}",
                              // borderRadius: BorderRadius.circular(12.r),
                              height: 62.h,
                              width: 62.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(
                              width: 11.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Product Title
                                Text(
                                  '${data!.boutiqueId!.name}',
                                  style: AppStyles.customSize(size: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),

                                /// Product Order Id

                                Text(
                                  data!.orderId!.orderId.toString(),
                                  style: AppStyles.h6(
                                      color: Get.theme.secondaryHeaderColor),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),

                                SizedBox(
                                  height: Dimensions.paddingSizeSmall.w,
                                ),

                                /// Item quantity and Date time
                                Row(
                                  children: [
                                    /// Item quantity
                                    SvgPicture.asset(
                                      AppIcons.bagIcon,
                                      height: 15.h,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall.w,
                                    ),
                                    Text(
                                      '${data!.orderId!.orderItems!.orederedProduct!.length} items',
                                      style: AppStyles.customSize(
                                          size: 10,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),

                                    Container(
                                      height: 15,
                                      child: VerticalDivider(
                                        color: Get.theme.primaryColor,
                                        thickness: 1,
                                      ),
                                    ),

                                    /// Date Time

                                    SvgPicture.asset(
                                      AppIcons.calender,
                                      height: 15.h,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall.w,
                                    ),
                                    Text(
                                      '${DateFormat('MMM dd, yyyy').format(data!.orderId!.createdAt!)}',
                                      style: AppStyles.customSize(
                                          size: 10,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 179.w,
                                  child: Divider(
                                    color: Color(0xff7F6B52),
                                  ),
                                ),

                                /// Location

                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.locationIcon,
                                      height: 15.h,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall.w,
                                    ),
                                    Container(
                                      width: 180.w,
                                      child: Text(
                                        "${data!.orderId!.deliveryAddress}",
                                        style: AppStyles.customSize(
                                            size: 10,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'Canceled',
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.customSize(
                                  size: 12, color: Colors.red),
                            ),
                          ],
                        ));
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider(
                      color: Get.theme.dividerColor.withOpacity(0.4));
                },
              ),
            ),
    );
  }
}
