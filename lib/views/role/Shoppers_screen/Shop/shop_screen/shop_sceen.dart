import 'dart:ui';

import 'package:aidaly/controllers/Role/Shopper_Controllar/shop_controller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:aidaly/views/role/shoppers_screen/bottomMenu_screen/bottom_menu..dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/enamdata.dart';
import '../../../../../utils/style.dart';

import '../../../../base/custom_page_loading.dart';
import '../../../../base/general_error_screen.dart';
import '../../../../base/no_internet_screen.dart';
import 'innerWidget/shop_card.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  ShopController shopCtrl = Get.put(ShopController());
  AddToCartControllar addTocartCtrl = Get.put(AddToCartControllar());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomMenu(1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppString.shopText.tr,
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
        body: Obx(() {
          switch (shopCtrl.rxRequestStatus.value) {
            case Status.loading:
              return const CustomPageLoading();
            case Status.internetError:
              return NoInternetScreen(onTap: () {
                shopCtrl.shopCatgegori();
              });
            case Status.error:
              return GeneralErrorScreen(onTap: () {
                shopCtrl.shopCatgegori();
              });
            case Status.completed:
              return _body(context);
            default:
              return Container();
          }
        }));
  }

  _body(BuildContext context) {
    return MasonryGridView.count(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        crossAxisCount: 2,
        itemCount: shopCtrl.shopCategoriModel.value.data!.attributes!.allProducts!.length,
        mainAxisSpacing: 10.w,
        crossAxisSpacing: 15.w,
        itemBuilder: (context, index) {
          var data=shopCtrl.shopCategoriModel.value.data!.attributes!.allProducts![index];
          return ShopCart(item: data,);
        });
  }
}
