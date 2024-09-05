import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../../models/Role/BoutiqueModel/boutique_order_details_model.dart';
import '../../../../../../../utils/app_icons.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../../../utils/style.dart';
import '../../../../../../base/cache_network_image.dart';


class NewProductCardDetails extends StatelessWidget {
  OrederedProduct orederedProduct;
   NewProductCardDetails({super.key,required this.orederedProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 157.h,
      width: 342.w,
      child: Row(
        children: [

          /// Product Image

          CustomNetworkImage(
            imageUrl:orederedProduct.image!,
            borderRadius: BorderRadius.circular(10.r),
            height: 103.h,
            width: 80.w,

          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Title
                Text(
                  orederedProduct.productName!,
                  style: AppStyles.customSize(size: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),

                /// Product Order Id
                ///
                Text(
                  'New',
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
                      '${orederedProduct.quantity} items',
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
                      'Aug 20, 2023',
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


                /// new order

                SizedBox(
                  height: Dimensions.paddingSizeExtraSmall.w,
                ),

                /// Product Price

                Text('\$${orederedProduct.productPrice}',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.customSize(size: 16,fontWeight: FontWeight.w700,color:Get.theme.primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
