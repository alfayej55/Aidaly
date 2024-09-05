import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/cache_network_image.dart';
import 'package:aidaly/views/base/divaider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/Role/BoutiqueModel/boutique_order_assigned_model.dart';
import '../../../../../../utils/dimensions.dart';

class AssignedDetails extends StatelessWidget {
  BoutiqueOrderAssignedModel assignedModel;
   AssignedDetails({super.key,required this.assignedModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 14.w,vertical: 13.h),
      child: Row(
        children: [
          /// Product Image

          CustomNetworkImage(
            imageUrl:
            "${assignedModel.orderItems!.orederedProduct![0].image}",
            borderRadius: BorderRadius.circular(10.r),
            height: 131.h,
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
                  '${assignedModel.orderItems!.orederedProduct![0].productName}',
                  style: AppStyles.customSize(size: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),

                /// Product Order Id

                Text(
                  'Order ${assignedModel.orderId}',
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
                      '${assignedModel.orderItems!.orederedProduct!.length} items',
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
                        '${DateFormat('MMM dd, yyyy').format(assignedModel!.createdAt!)}',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment:CrossAxisAlignment.start ,
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
                        '${assignedModel.deliveryAddress}',
                          style: AppStyles.customSize(
                            size: 10, fontWeight: FontWeight.w500),
                           overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                      ),
                    ),
                  ],
                ),


                ///Track Driver
                SizedBox(
                  height: Dimensions.paddingSizeExtraSmall.w,
                ),

                GestureDetector(
                  onTap: (){

                    if(assignedModel.assignedDrivertrack !=null ){
                      Get.toNamed(AppRoutes.boutiquesTrackOrderScreen,arguments: assignedModel.id);
                    }

                    else{
                      Fluttertoast.showToast(msg: 'Order In progress');
                    }

                  },
                  child: Container(
                    height: 25.h,
                    width: 98.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.primaryColor,
                    ),
                    child: Center(
                      child: Text('Track Driver',style: AppStyles.customSize(size: 10,color: Colors.white),),
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );


  }
}
