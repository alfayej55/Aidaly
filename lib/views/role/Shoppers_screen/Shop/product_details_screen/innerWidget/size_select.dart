import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../../../controllers/Role/Shopper_Controllar/product_details_controller.dart';
import '../../../../../../models/Role/ShopperModel/product_details_model.dart';

class ShopperSizeSelector extends StatelessWidget {
 // List<String> productSize;
  List<Variant> productSize;
  String id;
  ShopperSizeSelector({super.key, required this.productSize,required this.id});

  AddToCartControllar productAddtoCartCtrl = Get.put(AddToCartControllar());
  ProduceDetailsController _detailstCtrl = Get.put(ProduceDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: List.generate(
          productSize.length,
              (index) => InkWell(
            onTap: () {
              productAddtoCartCtrl.selectedSize.value = productSize[index].size!;
              _detailstCtrl.shopProductDetails(id, productAddtoCartCtrl.selectedSize.value);
              print(
                  'Selected size: ${productAddtoCartCtrl.selectedSize.value}');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 35.h,
                width: 35.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: productAddtoCartCtrl.selectedSize.value ==
                        productSize[index].size
                        ? Get.theme.primaryColor
                        : Get.theme.primaryColor.withOpacity(0.2)),
                child: Center(
                  child: Text(
                    productSize[index].size!,
                    style: AppStyles.customSize(
                        size: 15,
                        fontWeight: FontWeight.w500,
                        color: productAddtoCartCtrl.selectedSize.value ==
                            productSize[index].size
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
          )),
    ));
  }

    // return Obx(() => Row(
    //       children: List.generate(
    //           productSize.length,
    //           (index) => InkWell(
    //                 onTap: () {
    //                   productAddtoCartCtrl.selectedSize.value =
    //                       (productSize[index]);
    //                   print(
    //                       'ddddd  ${productAddtoCartCtrl.selectedSize.value}');
    //                 },
    //                 child: Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 5.w),
    //                   child: Container(
    //                     height: 35.h,
    //                     width: 35.w,
    //                     decoration: BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: productAddtoCartCtrl.selectedSize.value ==
    //                                 productSize[index]
    //                             ? Get.theme.primaryColor
    //                             : Get.theme.primaryColor.withOpacity(0.2)),
    //                     child: Center(
    //                       child: Text(productSize[index],
    //                           style: AppStyles.customSize(
    //                               size: 15,
    //                               fontWeight: FontWeight.w500,
    //                               color: productAddtoCartCtrl.selectedSize.value ==
    //                                           productSize[index]
    //                                       ? Colors.white
    //                                       : Colors.black)),
    //                     ),
    //                   ),
    //                 ),
    //               )),
    //     ));

}

/// Product Color Select

class ShopperColorlector extends StatelessWidget {
  List<String> productColor;
  ShopperColorlector({super.key, required this.productColor});

  AddToCartControllar productAddtoCartCtrl = Get.put(AddToCartControllar());
  int maxColorsToShow = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130.w,
        height: 40.h,
        child: ListView.builder(
            itemCount: productColor.length,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(() => InkWell(
                onTap: () {
                  productAddtoCartCtrl.selectedColor.value=productColor[index];
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(int.parse('0xff${productColor[index]}')),
                        border: Border.all(
                          width: 2,
                            color:productAddtoCartCtrl.selectedColor.value ==
                            productColor[index]
                            ? Colors.black
                            : Colors.transparent)
                    ),
                  ),
                ),
              ));
            }));
  }}

    //   Container(
    //   width: 130.w,
    //   height: 40.h,
    //   child: ListView.builder(
    //     controller: _scrollController,
    //     itemCount: productColor.length > maxColorsToShow
    //         ? productColor.length
    //         : productColor.length,
    //     shrinkWrap: true,
    //     primary: false,
    //     scrollDirection: Axis.horizontal,
    //     itemBuilder: (context, index) {
    //       if (index < maxColorsToShow) {
    //         // Display the color circles
    //         return Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 5.w),
    //           child: Container(
    //             height: 35.h,
    //             width: 35.w,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: Color(int.parse('0xff${productColor[index]}')),
    //             ),
    //           ),
    //         );
    //       } else if (index == maxColorsToShow) {
    //         // Display the + icon
    //         return Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 5.w),
    //           child: GestureDetector(
    //             onTap: () {
    //               // Scroll to show the rest of the colors
    //               _scrollController.animateTo(
    //                 _scrollController.position.maxScrollExtent,
    //                 duration: Duration(seconds: 1),
    //                 curve: Curves.easeInOut,
    //               );
    //             },
    //             child: CircleAvatar(
    //               radius: 17.5.h,
    //               backgroundColor: Colors.grey,
    //               child: Text(
    //                 '+${productColor.length - maxColorsToShow}',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ),
    //         );
    //       } else {
    //         // Display the remaining color circles
    //         return Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 5.w),
    //           child: Container(
    //             height: 35.h,
    //             width: 35.w,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: Color(int.parse('0xff${productColor[index]}')),
    //             ),
    //           ),
    //         );
    //       }
    //     },
    //   ),
    // );
 // }





