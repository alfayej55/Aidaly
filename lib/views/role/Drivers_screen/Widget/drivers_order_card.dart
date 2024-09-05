import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/cache_network_image.dart';
import 'package:aidaly/views/base/divaider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/Role/DriverModel/order_model.dart';
import '../../../../utils/dimensions.dart';

class DriverOrderCard extends StatelessWidget {
 final DriverOrderModel? orderData;
  final String  status;

  const DriverOrderCard({super.key,required this.status, this.orderData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Product Image
        CustomNetworkImage(
          imageUrl: "${ApiConstant.imageBaseUrl}${orderData!.boutiqueId!.image!.publicFileUrl}",
          // borderRadius: BorderRadius.circular(12.r),
          height: 62.h,
          width: 62.w,
            boxShape: BoxShape.circle,
        ),
        SizedBox(width:11.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Title
            Text(
              '${orderData!.boutiqueId!.name}',
              style: AppStyles.customSize(size: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),

            /// Product Order Id

            Text(
              orderData!.orderId.toString(),
              style: AppStyles.h6(color: Get.theme.secondaryHeaderColor),
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
                  '${orderData!.orderItems!.orederedProduct!.length} items',
                  style: AppStyles.customSize(
                      size: 10, fontWeight: FontWeight.w500),
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
                  '${DateFormat('MMM dd, yyyy').format(orderData!.createdAt!)}',
                  style: AppStyles.customSize(
                      size: 10, fontWeight: FontWeight.w500),
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
                    "${orderData!.deliveryAddress}",
                    style: AppStyles.customSize(
                        size: 10, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),

          ],
        ),
        Text(
          status,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.customSize(size: 12,color: Color(0xfff00A4EA)),
        ),
      ],
    );
  }
}
