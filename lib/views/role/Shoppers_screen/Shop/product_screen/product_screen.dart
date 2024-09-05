import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../../controllers/Role/Shopper_Controllar/shop_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/style.dart';
import '../innerWidget/product_cart.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var productName = Get.arguments;

  ShopController shopCtrl = Get.put(ShopController());
  AddToCartControllar addTocartCtrl = Get.put(AddToCartControllar());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    shopCtrl.subCategoryFirstLoad(productName);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.extentBefore) {
        shopCtrl.loadMore(productName);
        print('LoadMore');

      }
    });
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
            productName,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
          actions: [
            InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.addToCartScreen);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Badge(
                  label: Obx(() => Center(child: Text(addTocartCtrl.cart.value.length.toString(),style: AppStyles.h6(color: Colors.white),)),),
                  child:  SvgPicture.asset(AppIcons.bagIcon,height: 32.h,width: 32.w,),
                ),
              ),
            )
          ],
        ),

        ///>>>>>>>>>>>>>>>>>>>>>>>>>>> All Product >>>>>>>>>>>>>>>>>>>>>>>>

        body: Obx(() => shopCtrl.isFirstLoadRunning.value
            ? const CustomPageLoading() :shopCtrl.shopSubCategoriModel.isEmpty?Center(child: Text("There Are No Products",style: AppStyles.h3(),),)
            : RefreshIndicator(
                onRefresh: () async {
                  return await shopCtrl.refreshLoad(productName);
                },
                child: MasonryGridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  controller: scrollController,
                  crossAxisCount: 2,
                  itemCount: shopCtrl.shopSubCategoriModel.value.length + 1,
                  mainAxisSpacing: 30.h,
                  crossAxisSpacing: 22.w,
                  itemBuilder: (context, index) {
                    if (index >= shopCtrl.shopSubCategoriModel.value.length) {

                      return shopCtrl.isLoadMoreRunning.value
                          ? CustomPageLoading()
                          : SizedBox();

                    } else {
                      var data = shopCtrl.shopSubCategoriModel.value[index];
                      return ProductCart(isWishList: data.wishlist,
                          onTab: (){
                              Get.toNamed(AppRoutes.productDetailsScreen,arguments: data.id!,parameters: {"size":data.variants![0].size!});
                                   // Get.toNamed(AppRoutes.productDetailsScreen,
                                   //  arguments: '${data.id}');
                          },
                          wishListOnTab: (){
                          shopCtrl.addWishList(data.id!, index);
                          },
                          product: data);
                    }
                  },
                ),
              )));
  }
}
