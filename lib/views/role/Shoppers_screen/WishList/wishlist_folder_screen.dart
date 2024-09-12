import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../Utils/app_Image.dart';
import '../../../../controllers/Role/Shopper_Controllar/wishlist_controller.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/style.dart';
import '../../shoppers_screen/bottomMenu_screen/bottom_menu..dart';
import '../Shop/innerWidget/product_cart.dart';

class WishListFolderScreen extends StatefulWidget {
  const WishListFolderScreen({super.key});

  @override
  State<WishListFolderScreen> createState() => _WishListFolderScreenState();
}

class _WishListFolderScreenState extends State<WishListFolderScreen> {
  WishListController _wishListCtrl = Get.put(WishListController());

  var currentIndex = 0;

  @override
  void initState() {
    _wishListCtrl.wishListFolderName();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(3),
      appBar: AppBar(
        centerTitle: true,

        backgroundColor: Colors.transparent,
        // leading: InkWell(
        //   onTap: () {
        //     Get.offAllNamed(AppRoutes.wishListScreen);
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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            '${AppString.wishListCollenctionText.tr}',
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
      ),
      body: Obx(() => _wishListCtrl.folderLoading.value
          ? CustomPageLoading() :_wishListCtrl.wishlistFolderName.value.isEmpty
          ? Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.wishlistEmptyImage),
            SizedBox(height:10.h,),
            Text("Add items to start a Collection",style: AppStyles.h4())
          ],
        ),

      )
          :  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var index = 0;
                                index <
                                    _wishListCtrl
                                        .wishlistFolderName.value.length;
                                index++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                    _wishListCtrl.wishListname.value =
                                        _wishListCtrl
                                            .wishlistFolderName.value[index];
                                    _wishListCtrl.wishListFolder(
                                        _wishListCtrl.wishListname.value);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${_wishListCtrl.wishlistFolderName.value[index]}',
                                        style: currentIndex == index
                                            ? AppStyles.customSize(
                                                size: 17,
                                                fontWeight: FontWeight.bold)
                                            : AppStyles.h5(
                                                color: AppColors.subTextColor),
                                      ),
                                      Container(
                                          width: 50.w,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: currentIndex == index
                                                ? AppColors.textColor
                                                : Colors.transparent,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )),
                SizedBox(
                  height: 25.h,
                ),
                Expanded(
                  child: _wishListCtrl.wishListFolderLoading.value
                      ? CustomPageLoading()
                      : MasonryGridView.count(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          controller: _wishListCtrl.scrollController,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              _wishListCtrl.wishListFolderModel.value.length,
                          mainAxisSpacing: 30.h,
                          crossAxisSpacing: 22.w,
                          itemBuilder: (context, index) {
                            var data =
                                _wishListCtrl.wishListFolderModel.value[index];
                            return InkWell(
                              onTap: (){
                               // print("Size>>>${data.wishlistId!.productId!.variants![0].size!}");
                               Get.toNamed(AppRoutes.productDetailsScreen,arguments: data.wishlistId!.productId!.id!,parameters: {"size":data.wishlistId!.productId!.variants![0].size!});
                              },
                              child: ProductCart(
                                  isWishList: true,
                                  product: data.wishlistId!.productId),
                            );
                          },
                        ),
                )
              ],
            )),
    );
  }
}
