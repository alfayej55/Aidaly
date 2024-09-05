import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../models/Role/BoutiqueModel/boutique_dashboard_model.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import 'boutique_dashboard_order_card.dart';

class DashboardOrderCard extends StatelessWidget {
  BoutiqueDashBoardModel? dashBoard;
   DashboardOrderCard({super.key,required this.dashBoard});

  // var data=[
  //   {
  //     'title':AppString.activeOrders,
  //     'icon':AppIcons.activeOrderIcon,
  //
  //   },
  //   {
  //     'title':AppString.completedOrders,
  //     'icon':AppIcons.completedOrderIcon
  //   },
  //   {
  //     'title':AppString.receivedOrders,
  //     'icon':AppIcons.receivedOrderIcon
  //   },
  //   {
  //     'title':AppString.totalOrders,
  //     'icon':AppIcons.totalOrderIcon
  //   }
  // ];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BoutiqueDashboardOrderCard(
              title: AppString.activeOrders.tr,
              amount: '${dashBoard!.activeOrder!.totalAmount}',
              order: '${dashBoard!.activeOrder!.totalOrder}',
              image:AppIcons.activeOrderIcon,
            ),
            BoutiqueDashboardOrderCard(
              title: AppString.completedOrders.tr,
              amount: '${dashBoard!.compliteOrder!.totalAmount}',
              order: '${dashBoard!.compliteOrder!.totalOrder}',
              image:AppIcons.completedOrderIcon,
            ),
          ],
        ),

        SizedBox(height: 46.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BoutiqueDashboardOrderCard(
              title: AppString.receivedOrders.tr,
              amount: '${dashBoard!.reciveOrder!.totalAmount}',
              order: '${dashBoard!.reciveOrder!.totalOrder}',
              image:AppIcons.receivedOrderIcon,
            ),
            BoutiqueDashboardOrderCard(
              title:AppString.totalOrders.tr,
              amount: '${dashBoard!.totalOrdar!.totalAmount}',
              order: '${dashBoard!.totalOrdar!.totalOrder}',
              image:AppIcons.totalOrderIcon,
            ),
          ],
        ),
      ],
    );

    // return MasonryGridView.count(
    //   itemCount: 4,
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   primary: false,
    //   crossAxisCount: 2,
    //   mainAxisSpacing: 46.h,
    //   crossAxisSpacing: 11.w,
    //   itemBuilder: (context, index) {
    //     return   Stack(
    //       alignment: Alignment.topCenter,
    //       clipBehavior: Clip.none,
    //       children: [
    //         Container(
    //           height: 135.h,
    //           width: 158.w,
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20),
    //               color: Get.theme.cardColor,
    //               boxShadow: [
    //                 AppStyles.boutiqueboxShadow
    //               ]
    //           ),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //
    //           /// Active Order Text
    //
    //               SizedBox(height:Dimensions.paddingSizeDefault.h),
    //               Text(
    //                   data[index]['title']!.tr,
    //                   style: AppStyles.customSize(size:14,fontWeight:FontWeight.w500)
    //               ),
    //
    //               SizedBox(height:Dimensions.paddingSizeSmall.h),
    //
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                       '${dashBoard!.activeOrder!.totalOrder}',
    //                       style: AppStyles.h7()
    //                   ),
    //
    //                   Text(
    //                       '(\$${dashBoard!.activeOrder!.totalAmount})',
    //                       style: AppStyles.h8(color: Get.theme.disabledColor)
    //                   ),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //
    //         Positioned(
    //           top: -30.h,
    //           child: Container(
    //             height: 65.h,
    //             width: 65.w,
    //             decoration: BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 color: Get.theme.cardColor,
    //                 boxShadow: [
    //                   AppStyles.boutiqueCircleboxShadow
    //                 ]
    //             ),
    //             child: Center(
    //               child: SvgPicture.asset(data[index]['icon']!,height: 38.h,width: 38.w,),
    //             ),
    //           ),
    //         )
    //       ],
    //     );
    //   },
    // );
  }
}
