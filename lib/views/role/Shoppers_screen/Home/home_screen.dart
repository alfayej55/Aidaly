import 'dart:ui';

import 'package:aidaly/controllers/Role/Shopper_Controllar/home_controller.dart';
import 'package:aidaly/helpers/push_notification_helpers.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aidaly/views/role/shoppers_screen/bottomMenu_screen/bottom_menu..dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../utils/enamdata.dart';
import '../../../base/body_gradient_color.dart';
import '../../../base/custom_page_loading.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import 'innerWidget/feed_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCtrl = TextEditingController();

  AddToCartControllar addTocartCtrl = Get.put(AddToCartControllar());
  HomeController _homeCtrl=Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  //  NotificationHelper.notificationPermission();
    NotificationHelper.firebaseListenNotification(context: context);
    _homeCtrl.shopperHomeFirsLoad();
    _homeCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_homeCtrl.scrollController.position.pixels ==
        _homeCtrl.scrollController.position.maxScrollExtent ) {
       _homeCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _homeCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('ddd${addTocartCtrl.cart.length}');
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          AppString.homeScreenHaderText.tr,
          style: AppStyles.customSize(
              size: 14, color: AppColors.secandaryTextColor),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.notificationScreen);
              },
              child: SvgPicture.asset(
                AppIcons.notificationIcon,
                height: 32.h,
                width: 32.w,
              )),
          SizedBox(
            width: 5.w,
          ),

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Obx((){
          switch (_homeCtrl.rxRequestStatus.value) {
            case Status.loading:
              return const CustomPageLoading();
            case Status.internetError:
              return NoInternetScreen(onTap:(){
                _homeCtrl.shopperHomeFirsLoad();
              });
            case Status.error:
              return GeneralErrorScreen(onTap: (){
                _homeCtrl.shopperHomeFirsLoad();
              });
            case Status.completed:
              return _body(context);
            default:
              return Container();
          }
        }),
      ),
    );
  }

   _body(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.exploreNewBoutiques.tr,
              style: AppStyles.h1(color: Get.theme.primaryColor),
            ),

            ///>>>>>>>>>>>>>>>>>> SearchBar>>>>>>>>>>>>>>>>>>>>>>>>>

            SizedBox(height: Dimensions.paddingSizeDefault.h),

            InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.shoppeSearchBoxScreen);
                },
              child: Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.borderColor.withOpacity(0.1))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.searchIcon),
                          SizedBox(width: 15),
                          Text('${AppString.search.tr}',style: TextStyle(color:AppColors.subTextColor.withOpacity(0.5), fontSize: 16.sp),),
                        ],
                      ),
                    InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.filterScreen);
                      },
                      child: Padding(
                          padding: EdgeInsets.all(15.w),
                         child: SvgPicture.asset(AppIcons.filterIcon),
                        ),
                    ),

                    ],
                  ),
                ),
              ),
            ),

            // CustomTextField(
            //   contentPaddingHorizontal: 0,
            //
            //   controller: searchCtrl,
            //
            //   filColor: AppColors.whiteColor,
            //   hintText: AppString.search.tr,
            //   contentPaddingVertical: 15.h,
            //   onTap: (){
            //     Get.toNamed(AppRoutes.shoppeSearchBoxScreen);
            //   },
            //   hindStyle:
            //       TextStyle(color: AppColors.dividerColor.withOpacity(0.3)),
            //   prefixIcon: Padding(
            //     padding: EdgeInsets.all(15.w),
            //     child: SvgPicture.asset(AppIcons.searchIcon),
            //   ),
            //   suffixIcon: GestureDetector(
            //     onTap: () {
            //       //Get.toNamed(AppRoutes.filterScreen);
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.all(15.w),
            //       child: SvgPicture.asset(AppIcons.filterIcon),
            //     ),
            //   ),
            // ),

            SizedBox(height: Dimensions.paddingSizeSmall),

            ///>>>>>>>>>>>>>>>>>> ProductCar>>>>>>>>>>>>>>>>>>>>>>>>>

            Expanded(
              child: RefreshIndicator( onRefresh:()async{
                _homeCtrl.refressLoad();
              },
                child:  ListView.builder(
                  itemCount: _homeCtrl.homeModel.value.length + 1,
                  controller: _homeCtrl.scrollController,
                  shrinkWrap: true,
                  primary: false,
               //   scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (index >=  _homeCtrl.homeModel.value.length) {
                      return _homeCtrl.firstLoading.value
                          ? CustomPageLoading()
                          : SizedBox();
                    } else {
                      var data =  _homeCtrl.homeModel.value[index];
                      return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: FeedCart(
                              onTap: (){
                                _homeCtrl.addWishlist(data.id!, index);
                              },
                              homeModel: data,),
                          ),
                      );
                    }
                  },
              
                ),
              ),
            ),

          ],
        );
  }
}
