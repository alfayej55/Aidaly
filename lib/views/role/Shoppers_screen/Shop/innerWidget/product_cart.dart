import 'dart:ui';

import 'package:aidaly/controllers/Role/Shopper_Controllar/wishlist_controller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_Image.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../models/Role/ShopperModel/shop_subcategori_model.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../base/add_product_button.dart';
import '../../../../base/cache_network_image.dart';

class ProductCart extends StatelessWidget {
  ShopperProductModel? product;
  String? boutiqueImage;
  String? boutiqueName;
  bool isWishList;
  final Function()? onTab;
  final Function()? wishListOnTab;
  ProductCart(
      {super.key,
      this.onTab,
      this.wishListOnTab,
      this.product,
      this.boutiqueImage,
      this.boutiqueName,
      required this.isWishList
      });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// .................. Product Image.................>

          // GestureDetector(
          //   onTap: () {
          //     Get.toNamed(AppRoutes.productDetailsScreen,
          //         arguments: '${product!.id}');
          //   },
          //   child: CustomNetworkImage(
          //     imageUrl:
          //         '${ApiConstant.imageBaseUrl}${product!.firstImage!.publicFileUrl}',
          //     //borderRadius: BorderRadius.circular(12.r),
          //     height: 211.h,
          //     width: 180.w,
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          //       child: Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           color: const Color(0xFF5C5C5C).withOpacity(0.5),
          //         ),
          //         child: Padding(
          //           padding:
          //               EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          //           child: Align(
          //             alignment: Alignment.topCenter,
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //
          //                 /// .................. Product Save and add Button .................>
          //
          //                 AddProductButton(
          //                   icon: AppIcons.addButtonIcon,
          //                 ),
          //                    GestureDetector(
          //
          //                     onTap: wishListOnTab,
          //                      child: AddProductButton(
          //                      icon: AppIcons.wishListIcon,
          //                       color:isWishList
          //                         ? Get.theme.primaryColor
          //                         : Colors.white,
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          InkWell(
            onTap: onTab,
            child: CustomNetworkImage(
              imageUrl:
              '${ApiConstant.imageBaseUrl}${product!.firstImage!.publicFileUrl}',
              //borderRadius: BorderRadius.circular(12.r),
              height: 211.h,
              width: 180.w,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5C5C).withOpacity(0.5),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          /// .................. Product Save and add Button .................>

                          AddProductButton(
                            icon: AppIcons.addButtonIcon,
                          ),
                          GestureDetector(
                            onTap: wishListOnTab,
                            child: AddProductButton(
                              icon: AppIcons.wishListIcon,
                              color:isWishList
                                  ? Get.theme.primaryColor
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// .................. Product Title .................>

              Container(
                width: 130,
                child: Text(
                  product!.name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.customSize(size: 14),
                ),
              ),

              /// .................. Share Button .................>

              InkWell(
                  onTap: () {
                    Share.share('dsaf');
                  },
                  child: SvgPicture.asset(
                    AppIcons.shareIcon,
                    color: AppColors.textColor,
                    height: 20.h,
                    width: 20.w,
                  )),
            ],
          ),

          /// ..................  boutique  .................>

          Row(
            children: [
              CustomNetworkImage(
                imageUrl: '${ApiConstant.imageBaseUrl}${product!.userId!.image!.publicFileUrl}??""',
                height: 25.h,
                width: 25.w,
                boxShape: BoxShape.circle,
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.boutiqueScreen,
                      arguments: product!.userId!.id!);
                },
                child: Text(
                  product!.userId!.name ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppStyles.customSize(size: 13,fontWeight: FontWeight.w500,fontstyle: FontStyle.italic,color:Get.theme.secondaryHeaderColor),
                  //style: AppStyles.h6(color: Get.theme.secondaryHeaderColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),

          /// .................. Product Price .................>

          Text(
            '\$${product!.variants![0].price}',
            style: AppStyles.customSize(
                size: 14,
                fontWeight: FontWeight.w700,
                color: Get.theme.primaryColor),
          )
        ],
      ),
    );
  }
}
