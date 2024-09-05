import 'dart:ui';

import 'package:aidaly/controllers/Role/Shopper_Controllar/wishlist_controller.dart';

import 'package:flutter/material.dart';
import 'package:aidaly/views/role/shoppers_screen/bottomMenu_screen/bottom_menu..dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_Image.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../../utils/style.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_page_loading.dart';

import '../../../base/custom_text_field.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../Shop/innerWidget/product_cart.dart';

import 'create_collection.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  WishListController _wishListCtrl = Get.put(WishListController());

  @override
  void initState() {
    super.initState();
    _wishListCtrl.wishListFirstLoad();
    _wishListCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_wishListCtrl.scrollController.position.pixels ==
        _wishListCtrl.scrollController.position.maxScrollExtent) {
      _wishListCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _wishListCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,

        // leading: InkWell(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: CircleAvatar(
        //       radius: 20,
        //       backgroundColor: Colors.transparent,
        //       child: Icon(
        //         Icons.arrow_back,
        //         size: 25,
        //         color: Get.theme.primaryColor,
        //       )),
        // ),
        // centerTitle: true,
        title: Text(
          AppString.wishlistText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
        actions: [
          Obx(
            () => Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: _wishListCtrl.selectedList.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        showCreateFeild(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.secandaryTextColor,
                            size: 14,
                          ),
                          Text(
                            AppString.createcollectionText.tr,
                            style: AppStyles.customSize(
                                fontWeight: FontWeight.w400,
                                size: 14,
                                color: Get.theme.secondaryHeaderColor),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
      body:
      // Obx(() {
      //   switch (_wishListCtrl.rxRequestStatus.value) {
      //     case Status.loading:
      //       return const CustomPageLoading();
      //     case Status.internetError:
      //       return NoInternetScreen(onTap: () {
      //         _wishListCtrl.wishListFirstLoad();
      //       });
      //     case Status.error:
      //       return GeneralErrorScreen(onTap: () {
      //         _wishListCtrl.wishListFirstLoad();
      //       });
      //     case Status.completed:
      //       return _wishListCtrl.wishListModel.value.isEmpty
      //           ? Center(
      //               child: Image.asset(
      //                 AppImages.emptyCartImage,
      //                 fit: BoxFit.fitHeight,
      //               ),
      //             )
      //           : _body(context);
      //
      //     // return _body(context);
      //     default:
      //       return Container();
      //   }
      // }),

      Obx(() =>_wishListCtrl.isFirstLoadRunning.value?CustomPageLoading():
      _wishListCtrl.wishListModel.value.isEmpty
          ? Center(
             child:Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SvgPicture.asset(AppImages.wishlistEmptyImage),
                 SizedBox(height:10.h,),
                 Text("Add items to start a WishList",style: AppStyles.h4(),)
               ],
             ),
            
            )
          : _body(context))
    );
  }

  _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return await _wishListCtrl.refreshLoad();
      },
      child: MasonryGridView.count(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        controller: _wishListCtrl.scrollController,
        crossAxisCount: 2,
        itemCount: _wishListCtrl.wishListModel.value.length + 1,
        mainAxisSpacing: 30.h,
        crossAxisSpacing: 22.w,
        itemBuilder: (context, index) {
          if (index >= _wishListCtrl.wishListModel.value.length) {
            return _wishListCtrl.isFirstLoadRunning.value
                ? CustomPageLoading()
                : SizedBox();
          } else {
            var data = _wishListCtrl.wishListModel.value[index];

            bool isSelected =
                _wishListCtrl.selectedList.value.contains(data.id);

            return InkWell(
              onTap: () {
                setState(() {
                  _wishListCtrl.toggleSelection(data.id.toString());
                });
              },
              child: Stack(
                children: [
                  ProductCart(
                      isWishList: data.productId!.wishlist,
                      product: data.productId),
                  isSelected
                      ? BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(
                            height: 211.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF000000).withOpacity(0.20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 57.h,
                                    width: 57.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.iconCartColor
                                          .withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          }
        },
      ),
    );
  }

  showCreateFeild(BuildContext context) {
    print('CheckWishList length>>${_wishListCtrl.selectedList.value.length}');

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
                    _wishListCtrl.wishListCollectionCreate();
                  },
                  text: AppString.addText.tr,
                )
              ],
            ),
          );
        });
  }
}
