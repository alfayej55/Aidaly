import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/models/add_to_cart_model.dart';
import 'package:aidaly/service/google_api_service.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../../helpers/db_helpers.dart';
import '../../../../../utils/app_colors.dart';
import 'innerWidget/addtocart_Cart.dart';
import 'innerWidget/suggested_tips_widget.dart';

class AddToCartScreen extends StatefulWidget {
  AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  //final DataBaseHelper databasehd = DataBaseHelper();

  DBHelper dbHelper = DBHelper();
  AddToCartControllar addTocartCtrl = Get.put(AddToCartControllar());

  @override
  void initState() {
    addTocartCtrl.getData();
    addTocartCtrl.firstTimeGetUserLocation();
    addTocartCtrl.deliveryCharch();
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
          AppString.myCardText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),
      body: Obx(
              () => addTocartCtrl.cart.value.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.addToCartEmptyImage,fit: BoxFit.fitHeight,height: 200.h,width:double.infinity,),
              SizedBox(height: 30.h,),
                Text('Your cart is empty',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.h3())
              ],
            ),
          )
        : SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///>>>>>>>>>>>>>>>>>>>>>>> Add to Cart List>>>>>>>>>>>>>>>>>>>>
                AddTocartCart(),
          
                SizedBox(
                  height: Dimensions.paddingSizeSmall.h,
                ),
                Divider(
                  thickness: 0.2,
                  indent: 34.w,
                  endIndent: 34.w,
                  color: AppColors.textColor.withOpacity(0.4),
                ),
          
                ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Delivery Address >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Text(
                    AppString.deliveryaddressText.tr,
                    style: AppStyles.customSize(size: 16),
                  ),
                ),
          
                Obx(
                  () => ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 25.w),
                    titleTextStyle: AppStyles.customSize(
                        size: 15,
                        fontWeight: FontWeight.w500,
                        color: Get.theme.disabledColor),
                    leading: Image.asset(
                      AppImages.deliveryLocationimage,
                      width: 32.w,
                      height: 32.h,
                    ),
                    title: Text(addTocartCtrl.shopperAddress.value),
                  ),
                ),
          
                ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Add New Address Button >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                SizedBox(
                  height: Dimensions.paddingSizeLarge.h,
                ),
          
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: GestureDetector(
                    onTap: () async {

                      /// Get a Map Location
                      // var data =
                      //     await Get.toNamed(AppRoutes.deliveryLocationScreen);
                      // if (data != null) {
                      //   addTocartCtrl.shopperLongitude.value = data["long"];
                      //   addTocartCtrl.shopperLatitude.value = data["lat"];
                      //   addTocartCtrl.shopperAddress.value = data["address"];
                      //   addTocartCtrl.distanceCalculation();
                      //   print(data);
                      //
                      // }

                      /// Get a TextFiel Adress
                      showLocationDialoag();

                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.secandaryTextColor,
                          size: 16,
                        ),
                        SizedBox(width: 5.w,),
                        Text(
                          AppString.addnewaddressText.tr,
                          style: AppStyles.customSize(size: 16,fontWeight: FontWeight.w400,
                              underlineColor:AppColors.secandaryTextColor,
                              underline:TextDecoration.underline,color:AppColors.secandaryTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
          
                SizedBox(
                  height: Dimensions.paddingSizeLarge.h,
                ),
          
                ///>>>>>>>>>>>>>>>>>>>>>>> Suggested Tips >>>>>>>>>>>>>>>>>>>>
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.suggestedTipsText.tr,
                        style: AppStyles.customSize(size: 16),
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall.h,
                      ),
          
                      ///>>>>>>>>>>>>>>>>>>>>>>> Suggested Tips Box >>>>>>>>>>>>>>>>>>>>
                      SuggestedTipsWidget()
                    ],
                  ),
                ),
          
                SizedBox(
                  height: Dimensions.paddingSizeSmall.h,
                ),
                Divider(
                  thickness: 0.2,
                  indent: 34.w,
                  endIndent: 34.w,
                  color: AppColors.textColor.withOpacity(0.4),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      ///>>>>>>>>>>>>>>>>>>>>>>> Sub Total >>>>>>>>>>>>>>>>>>>>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.subTotalText.tr,
                            style: AppStyles.h5(),
                          ),
                          Text(
                            '\$${addTocartCtrl.subTotalPrice}',
                            style: AppStyles.customSize(size: 20),
                          ),
                        ],
                      ),
          
                      SizedBox(
                        height: Dimensions.paddingSizeLarge.h,
                      ),
          
                      ///>>>>>>>>>>>>>>>>>>>>>>> Service fee >>>>>>>>>>>>>>>>>>>>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.serviceFeeText.tr,
                            style: AppStyles.h5(),
                          ),
                    
                          Obx(()=>      addTocartCtrl.deliveryCharchLoading.value?SizedBox(): Text(
                            '\$${addTocartCtrl.serviceFee}',
                            style: AppStyles.customSize(size: 20),
                          ),)
                        ],
                      ),
          
                      SizedBox(
                        height: Dimensions.paddingSizeLarge.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.shippingText.tr,
                            style: AppStyles.h5(),
                          ),
                          Obx(
                            () =>addTocartCtrl.deliveryCharchLoading.value?SizedBox(): Text(
                              '\$${addTocartCtrl.shippintFee}',
                              style: AppStyles.customSize(size: 20),
                            ),
                          ),
                        ],
                      ),
          
                      SizedBox(
                        height: Dimensions.paddingSizeLarge.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.taxText.tr,
                            style: AppStyles.h5(),
                          ),
                          Text(
                            '\$${addTocartCtrl.taxPrice}%',
                            style: AppStyles.customSize(size: 20),
                          ),
                        ],
                      ),
          
                      SizedBox(
                        height: Dimensions.paddingSizeLarge.h,
                      ),
          
                      ///>>>>>>>>>>>>>>>>>>>>>>> Total  >>>>>>>>>>>>>>>>>>>>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppString.totalText.tr,
                            style: AppStyles.customSize(
                              size: 20,
                            ),
                          ),
                          Text(
                            '\$${addTocartCtrl.totalPrice}',
                            style: AppStyles.customSize(
                                size: 30, color: Get.theme.primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeExtraLarge.h,
                ),

                /// Check Out Button

                Obx(()=>Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    loading: addTocartCtrl.cherckOrderQuentitLoading.value,
                    // height: 58.h,
                    // width: 342.w,
                    onTap: () {
                      addTocartCtrl.checkQuntite();
                      //Get.toNamed(AppRoutes.checkoutScreen);
                    },
                    text: AppString.checkoutText.tr,
                  ),
                )),

                SizedBox(
                  height: Dimensions.paddingSizeExtraLarge.h,
                ),
              ],
            ),
        ),
            ),
    );
  }


  showLocationDialoag(){

    TextEditingController locationCont=TextEditingController();

    return showDialog(context: context,
        builder: (context){
      return AlertDialog(
        title: Text('Add A New Address',style: AppStyles.h3(color: AppColors.textColor)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldSearch(
                label: '',
                itemsInView: 5,
                autoClear: true,
                controller: locationCont,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 8.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    isDense: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                future: () {
                  return GoogleApiService.fetchSuggestions(locationCont.text);


                }
            ),
            SizedBox(height: 20.h),
           Obx(()=> CustomButton(
               loading: addTocartCtrl.updateLocationLoading.value,
               onTap:(){

                 addTocartCtrl.shopperAddress.value=locationCont.text;
                 addTocartCtrl.updateDeliveryAddressLatLong(locationCont.text);
                 addTocartCtrl.distanceCalculation();
                 locationCont.clear();
                 Get.back();

               },text: AppString.update.tr))

          ],
        ),
      );
        });
  }


}
