import 'dart:convert';

import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/BoutiquesControllar/new_ordercontroller.dart';
import '../../../../../../utils/app_Image.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../base/custom_button.dart';
import 'innerWidget/newproduct_details_card.dart';

class NewOrderDetailsScreen extends StatefulWidget {
  const NewOrderDetailsScreen({super.key});

  @override
  State<NewOrderDetailsScreen> createState() => _NewOrderDetailsScreenState();
}

class _NewOrderDetailsScreenState extends State<NewOrderDetailsScreen> {
  NewOrderController _newOrderCtrl = Get.put(NewOrderController());
  var productId=Get.arguments;

  @override
  void initState() {
    _newOrderCtrl.boutiqueorderDetails(productId);
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

      body: Obx(() =>_newOrderCtrl.detailsLoading.value? CustomPageLoading(): Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              child: Center(child: Text(AppString.newRequestText.tr,
                style:AppStyles.customSize(size: 14,color: Color(0xff00A4EA)) ,),),
            ),


            /// Delivery Address

            SizedBox(height: Dimensions.paddingSizeDefault.h,),
            Container(
              height: 106.h,
              width: 342.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  color: Get.theme.cardColor.withOpacity(0.3),
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
                          child: Text(_newOrderCtrl.productDetailsModel.value.data!.attributes!.detailsOfOrder!.deliveryAddress!,
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

            SizedBox(height: Dimensions.paddingSizeDefault.h,),

            /// Product Details Widget

            ListView.builder(
                itemCount: _newOrderCtrl.productDetailsModel.value.data!.attributes!.detailsOfOrder!.orderItems!.orederedProduct!.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context,index){
                  var data=_newOrderCtrl.productDetailsModel.value.data!.attributes!.detailsOfOrder!.orderItems!.orederedProduct![index];
                  return  NewProductCardDetails(orederedProduct: data,);
                }),

            /// Accept Button

            Spacer(),

            _newOrderCtrl.acceptLoading.value?CustomPageLoading(): CustomButton(
                height: 58.h,
                width: 166.w,
                onTap: (){
                  _newOrderCtrl.newOrderAccept(productId);
                },
                text: AppString.acceptText.tr),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //
            //     /// Decline Button
            //
            //     OutlinedButton(
            //         style: ElevatedButton.styleFrom(
            //           foregroundColor: Colors.black,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(18.r),
            //               side: BorderSide(color:Get.theme.primaryColor,width: 2)
            //           ),
            //           minimumSize:Size(166.w, 58.h),
            //         ),
            //         onPressed: (){},
            //         child:Text(AppString.declineText.tr,style: AppStyles.h3(fontWeight: FontWeight.w600,color:Get.theme.primaryColor),)),
            //
            //     ///Accept Button
            //
            //    _newOrderCtrl.acceptLoading.value?CustomPageLoading(): CustomButton(
            //         height: 58.h,
            //         width: 166.w,
            //         onTap: (){
            //           _newOrderCtrl.newOrderAccept(productId);
            //         },
            //         text: AppString.acceptText.tr)
            //
            //   ],
            // ),

            SizedBox(height: Dimensions.paddingSizeDefault.h,),



          ],
        ),
      )),
    );
  }
}
