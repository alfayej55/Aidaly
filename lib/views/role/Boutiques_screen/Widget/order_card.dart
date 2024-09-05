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

import '../../../../models/Role/BoutiqueModel/boutique_order_model.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/dimensions.dart';

class BoutiquesOrderCard extends StatelessWidget {

  final String  status;
  final BoutiqueOrderModel? orderData;

  const BoutiquesOrderCard({super.key,required this.status,this.orderData});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          CustomNetworkImage(
            imageUrl:
            "${orderData!.orderItems!.orederedProduct![0].image}",
            borderRadius: BorderRadius.circular(12.r),
            height: 131.h,
            width: 80.w,

          ),
          SizedBox(width:15.w,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Title
                Text(
                  '${orderData!.orderItems!.orederedProduct![0].productName}',
                  style: AppStyles.customSize(size: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),

                /// Product Order Id

                Text(
                  'Order ${orderData!.orderId}',
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
                    Expanded(
                      child: Text(
                        '${orderData!.deliveryAddress}',
                        style: AppStyles.customSize(
                            size: 10, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),

                /// new order

                SizedBox(
                  height: Dimensions.paddingSizeExtraSmall.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(status,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.customSize(size: 12,color: Color(0xfff00A4EA)),
                    ),

                    SizedBox(
                      width: Dimensions.paddingSizeExtraLarge.w,
                    ),


                    /// Product Price

                    Text('\$${orderData!.totalAmount}',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.customSize(size: 16,fontWeight: FontWeight.w700,color:Get.theme.primaryColor),
                    )

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
