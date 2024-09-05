import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/Role/BoutiquesControllar/my_product_controllar.dart';
import '../../../../service/api_constants.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../base/add_product_button.dart';
import '../../../base/cache_network_image.dart';
import '../../../base/general_error_screen.dart';
import '../../../base/no_internet_screen.dart';
import '../bottomMenu_screen/bottom_menu_screen.dart';

class MyProductScreen extends StatefulWidget {
   MyProductScreen({super.key});

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  BoutiqueMyProductControllar myproductCtrl=Get.put(BoutiqueMyProductControllar());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  const BoutiqueBottomMenu(2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          AppString.myProducts.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),

        floatingActionButton: GestureDetector(
          onTap: (){
            Get.toNamed(AppRoutes.addNewProductScreen);
          },
          child: Container(
            height: 65.h,
            width: 65.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.cardColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 57.79,
                      offset: const Offset(0,0),
                      color:Color(0xFF000000).withOpacity(0.15),
                      spreadRadius:3.72)
                ]
            ),
            child: Center(child:Icon(Icons.add,color: Get.theme.secondaryHeaderColor,size: 28,)),
          ),
        ),

      body:Obx((){
        switch (myproductCtrl.rxRequestStatus.value) {
          case Status.loading:
            return const CustomPageLoading();
          case Status.internetError:
            return NoInternetScreen(onTap:(){
              myproductCtrl.boutiquemyProduct();
            });
          case Status.error:
            return GeneralErrorScreen(onTap: (){
              myproductCtrl.boutiquemyProduct();
            });
          case Status.completed:
            return _body(context);
          default:
            return Container();
        }
      }));
  }

  _body(BuildContext context) {
    return myproductCtrl.myProductModel.value.data!.attributes!.isNotEmpty?
    MasonryGridView.count(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount:myproductCtrl.myProductModel.value.data!.attributes!.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 2,
      mainAxisSpacing: 30.h,
      crossAxisSpacing: 22.w,
      itemBuilder: (context, index) {

        var data=myproductCtrl.myProductModel.value.data!.attributes![index];

        return Container(

          width:160,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// .................. Product Image.................>

                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomNetworkImage(
                        imageUrl:'${ApiConstant.imageBaseUrl}${data.firstImage!.publicFileUrl}',
                        //borderRadius: BorderRadius.circular(12.r),
                        height: 211.h,
                        width:160.w,
                      ),
                      Positioned(
                        top: 10.h,
                        right: 16.w,
                        child: AddProductButton(
                          icon: AppIcons.editIcon,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeExtraSmall,),

                  /// .................. Product Name .................>

                  Text(data.name!,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.customSize(
                        size: 14),
                  ),


                  /// .................. Product Price .................>

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${data.variants![0].price}',
                        style: AppStyles.customSize(
                            size: 14,
                            fontWeight:FontWeight.w700,
                            color: Get.theme.primaryColor
                        ),),

                      /// .................. Product Rating .................>

                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.star,height: 18.h,width: 18.w,),
                          SizedBox(width: 10.w,),
                          Text(data.rating!,style:AppStyles.h6(),)
                        ],
                      )
                    ],
                  )


                ],
              )
            ],
          ),
        );
      },
    ):  Center(child: Text('No Product',style: AppStyles.h1(color: Get.theme.primaryColor),));
  }
}