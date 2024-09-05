import 'package:aidaly/controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/payment_service.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/Shopper_Controllar/payment_controller.dart';
import '../../../../../service/google_api_service.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_button.dart';
import 'innerWidget/payment_cart.dart';

class CheckOutScreen extends StatefulWidget {
   CheckOutScreen({super.key});
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var selectedOption;

  AddToCartControllar addCartCtrl=Get.put(AddToCartControllar());
  StripePaymentController paymentCtrl=Get.put(StripePaymentController());

  @override
  void initState() {
    addCartCtrl.estimatedTimeGet();
    addCartCtrl.getCurrentLocation();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ShopperAdd>>${addCartCtrl.shopperAddress}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:InkWell(
          onTap: (){
            Get.back();
          },
          child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.arrow_back,size: 25,color: Get.theme.primaryColor,)),
        ),
        // centerTitle: true,
        title: Text(
          AppString.checkoutText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),

      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 25.w),
        child: SingleChildScrollView(

          child:Obx(() =>  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              PaymentCart(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(AppString.paymentmthodText.tr,
              //       style: AppStyles.customSize(size: 16),),
              //     ///>>>>>>>>>>>>>>>>>>> Add a New  Card >>>>>>>>>>>>>>>>>>>>
              //     GestureDetector(
              //       onTap: (){
              //         Get.toNamed(AppRoutes.addCartScreen);
              //       },
              //       child: Row(
              //         children: [
              //           Icon(Icons.add,color: AppColors.primaryColor,size: 14,),
              //
              //           Text(AppString.addNewCardText.tr,
              //             style: AppStyles.h5(color: Get.theme.primaryColor),),
              //
              //         ],
              //       ),
              //     )
              //   ],
              //
              // ),
              // ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Payment Option >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              // PaymentCart(),

              Divider(
                thickness:0.2,
                indent: 20.w,
                endIndent: 20.w,
                color: AppColors.textColor.withOpacity(0.4),
              ),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),

              ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Delivery Address >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

              Text(AppString.deliveryaddressText.tr,
                style: AppStyles.customSize(size: 16),),


              ListTile(
                contentPadding: EdgeInsets.zero,
                titleTextStyle: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor) ,
                leading: Image.asset(AppImages.deliveryLocationimage,width: 32.w,height: 32.h,),
                title: Text(addCartCtrl.shopperAddress.value),
              ),


              //
              // ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Add New Address Button >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              // SizedBox(height: Dimensions.paddingSizeLarge.h,),
              //
              // GestureDetector(
              //   onTap: (){
              //     Get.toNamed(AppRoutes.deliveryLocationScreen);
              //    // _showAlertDialog(context);
              //   },
              //   child: Row(
              //     children: [
              //       Icon(Icons.add,color: AppColors.secandaryTextColor,size: 14,),
              //
              //       Text(AppString.addnewaddressText.tr,
              //         style: AppStyles.customSize(
              //             fontWeight: FontWeight.w400,
              //             size: 16,
              //             color: Get.theme.secondaryHeaderColor),),
              //
              //     ],
              //   ),
              // ),

              ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Time >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              Row(
                children: [
                  Image.asset(AppImages.deliveryimage),
                  SizedBox(width: 10.w,),

                  Expanded(
                    child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: AppString.estimatedDeliveryText.tr,style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w500,color: AppColors.textColor)
                              ),
                              TextSpan(
                                  text:addCartCtrl.estimatTimes.value,style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w600,color: AppColors.textColor))
                            ]
                        )),
                  )

                ],
              ),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              Divider(
                thickness:0.2,
                indent: 20.w,
                endIndent: 20.w,
                color: AppColors.textColor.withOpacity(0.4),
              ),

              ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Suggested Tips  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
              Row(
                children: [
                  Text(
                    AppString.suggestedTipsText.tr,
                    style: AppStyles.customSize(size: 16),
                  ),
                  SizedBox(width: Dimensions.paddingSizeSmall.h,),
                  Text(
                    ': ${addCartCtrl.selectedtips*100}%',
                    style: AppStyles.customSize(size: 16,color: Get.theme.primaryColor),
                  ),

                ],
              ),

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              ///>>>>>>>>>>>>>>>>>>>>>>> Total  >>>>>>>>>>>>>>>>>>>>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.totalText.tr,
                    overflow: TextOverflow.ellipsis,
                    style:AppStyles.customSize(size: 20,),
                  ),
                  Text(
                    '\$${addCartCtrl.totalPrice}',
                    overflow: TextOverflow.ellipsis,
                    style:AppStyles.customSize(size: 25,color: Get.theme.primaryColor),
                  ),
                ],
              ),

              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),
              Align(
                alignment: Alignment.center,
                child: CustomButton(
                  onTap: ()async{


                       PaymentService().makePayment(amount: addCartCtrl.totalPrice.toInt(), currency: 'usd', packageID: '123', paymentType: 'card');


                     // await paymentCtrl.initPaymentSheet();
                     // await Stripe.instance.presentPaymentSheet();

                    //Get.toNamed(AppRoutes.orderBookingScreen);
                  }, text:AppString.payNowText.tr,),
              ),

            ],
          )),
        ),
      ),
    );
  }

/// Update Delivery Location
  void _showAlertDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Locatiuon'),
          content:       Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TypeAheadField(
              controller: addCartCtrl.deliveryLocation,
              onSelected: (value) {
                addCartCtrl.deliveryLocation.text=value;

              },
              //focusNode: stateFocusNode,
              // controller:stateController,

              builder: (context, controller, focusNode) {
                return TextFormField(
                  cursorColor: AppColors.hintColor,
                  focusNode: focusNode,
                  controller: controller,
                  cursorHeight: 20.sp,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Select Location";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Select Location",
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    suffixIconConstraints:
                    BoxConstraints(maxHeight: 35.h, maxWidth: 35.w),

                  ),
                  // onFieldSubmitted: (value) {
                  //   _submitCrewController.locationController.text=value;
                  // },
                  onChanged: (value) {
                    addCartCtrl.deliveryLocation.text=value;
                  },
                );
              },
              itemBuilder: (context, suggestion) {
                ///list item builder
                return ListTile(
                  title: Text(suggestion,style: TextStyle(color: Colors.black),),
                );
              },
              suggestionsCallback: (value) async {
                debugPrint("Search Text : $value");
                return GoogleApiService.fetchSuggestions(value);
              },

            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancle'),
              onPressed: () {
                Get.back();
              },
            ),

            TextButton(
              child: const Text('Yes',style:TextStyle(),),
              onPressed: () async{

              },
            ),
          ],
        );
      },
    );
  }

}
