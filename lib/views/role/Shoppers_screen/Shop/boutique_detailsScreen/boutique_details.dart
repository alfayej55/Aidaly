
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/dimensions.dart';
import 'package:aidaly/utils/enamdata.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../controllers/Role/Shopper_Controllar/shopper_boutique_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../service/api_constants.dart';
import '../../../../base/cache_network_image.dart';
import '../innerWidget/product_cart.dart';

class BoutiqueDetails extends StatefulWidget {
   BoutiqueDetails({super.key});

  @override
  State<BoutiqueDetails> createState() => _BoutiqueDetailsState();
}

class _BoutiqueDetailsState extends State<BoutiqueDetails> {


  ShopperBoutiqueDetailsControllar boutiqueDetailsCtrl=Get.put(ShopperBoutiqueDetailsControllar());

  ScrollController scrollCtrl=ScrollController();
  var boutiqueId =Get.arguments;

  @override
  void initState() {
     boutiqueDetailsCtrl.firstLoad(boutiqueId);

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
      ),
      body: Obx(() => boutiqueDetailsCtrl.isFirstLoadRunning.value? Center(child:CustomPageLoading()):
      _body(context),),
    );
  }

   _body(BuildContext context) {
    return Column(
        children: [

          ///>>>>>>>>>>>>>>>>>>>>>>>>>>>  Boutique Cart >>>>>>>>>>>>>>>>>>>>>>>>>

          Padding(
            padding:  EdgeInsets.only(left: 15.w,right: 15.w,top: 20.h),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [

                ///===================== Boutique Detaile Cart ===================>
                Container(
                  height: 196.h,
                  width: 369.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Get.theme.cardColor,
                      boxShadow: [
                        AppStyles.boxShadow
                      ]
                  ),

                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,

                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 54.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.shareIcon,height: 16.h,width: 16.w,color:AppColors.textColor,),
                            SizedBox(width:20.w,),
                            Text(

                              boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.boutiqueUser!.name!,
                              style: AppStyles.customSize(
                                  size: 18.2,
                                  fontWeight: FontWeight.w700,
                                  color: Get.theme.primaryColor
                              ),

                            ),
                            SizedBox(width:15.w,),
                            SvgPicture.asset(AppIcons.star,height: 18.h,width: 18.w,),
                            SizedBox(width:15.w,),
                            Text(
                              boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.boutiqueUser!.rating!,
                              style:AppStyles.h6(),)

                          ],
                        ),
                      ),
                      ///===================== Boutique Detaile Text ===================>
                      Text(
                        "${boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.boutiqueUser!.description}",
                        //AppString.waitlistText.tr,
                        textAlign: TextAlign.center,
                        maxLines: 9,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.customSize(size: 12,fontWeight: FontWeight.w400,color:Get.theme.disabledColor),
                      )
                    ],
                  ),
                ),
                ///===================== Boutique Circle Image ===================>
                Positioned(
                  bottom: 150.h,
                  child: CustomNetworkImage(
                    width: 86.w,
                    height: 86.h,
                    boxShape: BoxShape.circle,
                    border:Border.all(
                        color: Get.theme.primaryColor,
                        width: 2
                    ),
                    imageUrl:'${ApiConstant.imageBaseUrl}${boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.boutiqueUser!.image!.publicFileUrl}??""',
                    //borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ],
            ),
          ),

          // Stack(
          //   //alignment: Alignment.bottomCenter,
          //   clipBehavior: Clip.none,
          //   children: [
          //     // Container(
          //     //   child:CustomNetworkImage(
          //     //     width: 390.w,
          //     //     height: 232.h,
          //     //     imageUrl:'${ApiConstant.imageBaseUrl}${boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.boutiqueUser!.image!.publicFileUrl}??""',
          //     //     //borderRadius: BorderRadius.circular(12.r),
          //     //   ),
          //     // ),
          //     ///===================== Back Button ===================>
          //     Positioned(
          //       //top: 20.h,
          //       left: 15.w,
          //       child: InkWell(
          //         onTap: (){
          //           Get.back();
          //         },
          //         child: CircleAvatar(
          //             radius: 20,
          //             backgroundColor: Colors.transparent,
          //             child: Icon(Icons.arrow_back,size: 25,color: AppColors.whiteColor,)),
          //       ),
          //     ),
          //
          //
          //
          //
          //
          //   ],
          // ),

          SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),

          ///===================== Boutique Categoric  ===================>


          boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.products!.isNotEmpty?  Expanded(
            child: MasonryGridView.count(
              physics: AlwaysScrollableScrollPhysics(),
              padding:EdgeInsets.symmetric(horizontal:24.w),
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              mainAxisSpacing: 30.h,
              crossAxisSpacing: 22.w,
              itemCount:boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.products!.length,
              itemBuilder: (context, index) {
                var productInfo=boutiqueDetailsCtrl.boutiqueDetailsModel.value.data!.attributes!.products![index];
                return  ProductCart(
                  onTab: (){
                    Get.toNamed(AppRoutes.productDetailsScreen,arguments: productInfo.id!,parameters: {"size":productInfo.variants![0].size!});
                    // Get.toNamed(AppRoutes.productDetailsScreen,
                    //     arguments: '${productInfo.id}');
                  },
                  wishListOnTab: (){
                    boutiqueDetailsCtrl.addWishList(productInfo.id??"", index);
                  },
                  isWishList:productInfo.wishlist,
                  product:productInfo,);
              },
            ),
          ):SizedBox()

        ],
      );
  }
}
