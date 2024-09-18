import 'dart:ui';

import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../controllers/Role/Shopper_Controllar/wishlist_controller.dart';
import '../../../../../models/Role/ShopperModel/shopper_home_model.dart';
import '../../../../../utils/app_Image.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/style.dart';
import '../../../../base/add_product_button.dart';
import '../../../../base/cache_network_image.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text_field.dart';

class FeedCart extends StatelessWidget {

  ShopperHomeModel? homeModel;
   final Function()? onTap;
   FeedCart({super.key,required this.homeModel,this.onTap});
  WishListController _wishListCtrl = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       // Get.toNamed(AppRoutes.productDetailsScreen,arguments: homeModel!.id!,parameters: {"size":homeModel!.variants![0].size!});
      },
      child: CustomNetworkImage(
        imageUrl:
        "${ApiConstant.imageBaseUrl}${homeModel!.promotionImage!.publicFileUrl}",
        borderRadius: BorderRadius.circular(18.r),
        height: 500.h,
        width: 357.w,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX:0, sigmaY:0),
          child: Container(
            height: 500.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF5C5C5C).withOpacity(0.5),
              borderRadius: BorderRadius.circular(18),
            ),
            child:  Column(
              //  mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ///>>>>>>>>>>>>>>>>>> Add And Save Option>>>>>>>>>>>>>>>>>>>>>>>>>

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.boutiqueScreen,
                              arguments: homeModel!.id!);
                         // showCreateFeild(context);
                        },
                        child: AddProductButton(
                          height: 50.h,
                          width: 50.w,
                          iconheight: 30.h,
                          iconwidth: 30.w,
                          icon: AppIcons.addButtonIcon,
                        ),
                      ),

                      // GestureDetector(
                      //   onTap: onTap,
                      //   child: AddProductButton(
                      //     height: 50.h,
                      //     width: 50.w,
                      //     iconheight: 30.h,
                      //     iconwidth: 30.w,
                      //     icon: AppIcons.wishListIcon,color: homeModel!.wishlist? Get.theme.primaryColor:Colors.white,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Spacer(),

                ///>>>>>>>>>>>>>>>>>> Star and Share Option>>>>>>>>>>>>>>>>>>>>>>>>>

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.w,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    '${homeModel!.name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.customSize(
                                      size: 26,
                                      color: AppColors.whiteColor,
                                      family: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.paddingSizeSmall),
                                SvgPicture.asset(AppIcons.star),
                                SizedBox(width: 5),
                                Text(
                                  '${homeModel!.rating}',
                                  style: AppStyles.h6(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                          InkWell(onTap: (){
                            Share.share('dsaf');
                          },
                              child: SvgPicture.asset(AppIcons.shareIcon)),
                        ],
                      ),

                    ),

                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.h,vertical: 7.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.boutiqueScreen,
                                  arguments: homeModel!.id!);
                            },
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                    imageUrl: '${ApiConstant.imageBaseUrl}${homeModel!.image!.publicFileUrl}',
                                    height: 30.h,
                                    width: 30.w,
                                   boxShape: BoxShape.circle,
                                ),

                                SizedBox(width: 10.w,),
                                Text(
                                  '${homeModel!.name}',
                                  style: AppStyles.customSize(size: 17,fontWeight: FontWeight.w400,
                                      underlineColor:AppColors.secandaryTextColor,
                                      fontstyle: FontStyle.italic,
                                      underline:TextDecoration.underline,color:AppColors.secandaryTextColor),
                                )

                              ],
                            ),
                          ),
                          Text('\$${homeModel!.rate}',
                              style: AppStyles.customSize(size: 26,
                                color: AppColors.whiteColor,
                                family:'Poppins',
                                fontWeight: FontWeight.w600,
                              )
                          ),

                        ],
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ),

      ),
    );
  }

  showCreateFeild(BuildContext context) {
   // print('CheckWishList length>>${_wishListCtrl.selectedList.value.length}');

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Get.theme.cardColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Get.theme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.saveIcon,
                      height: 57.h,
                      width: 57.w,
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                Text(
                  AppString.collectionTitleText.tr,
                  style: AppStyles.customSize(size: 18.8),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeSmall,
                ),
                CustomTextField(
                  contentPaddingVertical: 15.h,
                  controller: _wishListCtrl.createWishListCtrl,
                  filColor: Colors.transparent,
                ),
                SizedBox(
                  height: Dimensions.paddingSizeExtraLarge,
                ),
                CustomButton(
                  loading: _wishListCtrl.wishListLoading.value,
                  onTap: () {
                    _wishListCtrl.selectedList.add(homeModel!.id);
                    print("Add Check>>>${_wishListCtrl.selectedList}");

                    if(_wishListCtrl.selectedList.isNotEmpty){
                      _wishListCtrl.wishListCollectionCreate('collection');
                    }else{
                      print('List Empty');
                    }

                  },
                  text: AppString.addText.tr,
                )
              ],
            ),
          );
        });
  }
}
