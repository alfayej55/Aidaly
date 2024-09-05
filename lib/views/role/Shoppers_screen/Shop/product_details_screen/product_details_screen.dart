import 'dart:convert';
import 'dart:ui';
import 'package:aidaly/controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import 'package:aidaly/helpers/prefs_helper.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/models/add_to_cart_model.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../../Utils/app_constants.dart';
import '../../../../../controllers/Role/Shopper_Controllar/product_details_controller.dart';
import '../../../../../helpers/db_helpers.dart';
import '../../../../../models/Role/ShopperModel/product_details_model.dart';
import '../../../../../service/api_constants.dart';
import '../../../../../utils/app_Image.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/enamdata.dart';
import '../../../../../utils/style.dart';
import '../../../../base/add_product_button.dart';
import '../../../../base/cache_network_image.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/general_error_screen.dart';
import '../../../../base/no_internet_screen.dart';
import '../innerWidget/Add_button.dart';
import 'innerWidget/category_image.dart';
import 'innerWidget/comment_screen.dart';
import 'innerWidget/size_select.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var id = Get.arguments;
  // var size=Get.arguments;

//  var id=Get.parameters['id'];

  AddToCartControllar addTocartCtrl = Get.put(AddToCartControllar());
  ProduceDetailsController productDetailsCtrl =
      Get.put(ProduceDetailsController());
  DBHelper dbHelper = DBHelper();

  ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    productDetailsCtrl.shopProductDetails(id, Get.parameters['size']!);
    // productDetailsCtrl.shopProduComment(id);
    // scrollCtrl.addListener(() {
    //   if (scrollCtrl.position.maxScrollExtent ==
    //       scrollCtrl.position.extentBefore) {
    //     productDetailsCtrl.loadMore(id);
    //     print('Load More Call');
    //   }
    // });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   body:  Obx(() => productDetailsCtrl.productDetailsLoading.value
        //       ?  const Center(child: CustomPageLoading())
        //       :SingleChildScrollView(
        //     child: _body(context)),
        //   ),
        // );

        body: Obx(() {
          switch (productDetailsCtrl.rxRequestStatus.value) {
          case Status.loading:
          return const CustomPageLoading();
          case Status.internetError:
          return NoInternetScreen(onTap: () {
            productDetailsCtrl.shopProductDetails(id, Get.parameters['size']!);
          });
           case Status.error:
          return GeneralErrorScreen(onTap: () {
            productDetailsCtrl.shopProductDetails(id, Get.parameters['size']!);
          });
           case Status.completed:
           return _body(context);
           default:return Container();
      }
    }));
  }

  _body(BuildContext context) {
    var data =
        productDetailsCtrl.productDetailsModel.value.data!.attributes!.product;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
            child: CustomNetworkImage(
              width: double.infinity.w,
              height: 412.h,
              imageUrl:
                  '${ApiConstant.imageBaseUrl}${productDetailsCtrl.productFirstImage.value}',
              borderRadius: BorderRadius.circular(14.r),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ///>>>>>>>>>>>>>>>>>> Back And Save Option>>>>>>>>>>>>>>>>>>>>>>>>>

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.arrow_back,
                                size: 28,
                                color: AppColors.whiteColor,
                              )),
                        ),
                        // AddProductButton(
                        //   height: 42.h,
                        //   width: 42.w,
                        //   iconheight: 30.h,
                        //   iconwidth: 30.w,
                        //   icon: AppIcons.wishListIcon,
                        // ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  ///>>>>>>>>>>>>>>>>>> Categoric Image >>>>>>>>>>>>>>>>>>>>>>>>>

                  Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15).r,
                          color: const Color(0xffDFDFDF)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                            data!.images!.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    productDetailsCtrl.productFirstImage.value =
                                        data.images![index].publicFileUrl
                                            .toString();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 5.h),
                                    child: CustomNetworkImage(
                                      width: 54.w,
                                      height: 54.h,
                                      imageUrl:
                                          '${ApiConstant.imageBaseUrl}${data.images![index].publicFileUrl}?? ""',
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          color: AppColors.whiteColor,
                                          width: 2),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  )
                  // CategoricImages(productimage:data.images?? [])
                ],
              ),
            ),
          ),

          SizedBox(
            height: Dimensions.paddingSizeSmall,
          ),

          /// .................. Product Title .................>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.addToCartScreen);
                      },
                      child: Container(
                        width: 230.w,
                        child: Text('${data.name}',
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.h1()),
                      ),
                    ),

                    /// .................. Share Button .................>

                    SvgPicture.asset(
                      AppIcons.shareIcon,
                      color: AppColors.textColor,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.boutiqueScreen,arguments: data.userId!.id);
                      },
                      child: Row(
                        children: [
                          CustomNetworkImage(
                            width: 25.w,
                            height: 25.h,
                            imageUrl:
                                '${ApiConstant.imageBaseUrl}${data.userId!.image!.publicFileUrl}?? ""',
                            boxShape: BoxShape.circle,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            data.userId!.name!,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w400,
                                underlineColor:AppColors.secandaryTextColor,
                                fontstyle: FontStyle.italic,
                                underline:TextDecoration.underline,color:AppColors.secandaryTextColor),
                          ),
                          SizedBox(
                            width: Dimensions.paddingSizeSmall.w,
                          ),
                          SvgPicture.asset(
                            AppIcons.star,
                            height: 18.h,
                            width: 18.w,
                          ),
                          Text(
                            '${data.rating}',
                            style: AppStyles.h6(),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '\$${data.price}',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.customSize(
                          size: 18,
                          fontWeight: FontWeight.w700,
                          color: Get.theme.primaryColor),
                    )
                  ],
                )
              ],
            ),
          ),

          /// .................. Product Color and Size .................>

          SizedBox(
            height: Dimensions.paddingSizeDefault.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: AppStyles.h5(),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: Dimensions.paddingSizeSmall.h,
                      ),
                      ShopperColorlector(
                        productColor: data.color!,
                      )
                      // CircleAvatar(
                      //   radius: 20.r,
                      //   backgroundColor: AppColors.textColor,
                      // )
                    ],
                  ),
                ),

                /// Product Size
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.sizeText.tr,
                      style: AppStyles.h5(),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall.h,
                    ),
                    ShopperSizeSelector(
                      productSize: data.variants!,
                      id: data.id!,
                      // productSize: data.size!,
                    )
                  ],
                )
              ],
            ),
          ),

          /// .................. Product Add to cart .................>

          SizedBox(
            height: Dimensions.paddingSizeExtraLarge.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /// .................. Product Add Button .................>
                    AddButton(
                      ontap: () {
                        addTocartCtrl.productQuantity.value++;
                      },
                      icon: Icons.add,
                    ),
                    SizedBox(
                      width: Dimensions.paddingSizeDefault.h,
                    ),

                    /// .................. Product quantity  .................>

                    Text(
                      '${addTocartCtrl.productQuantity.value}',
                      style: AppStyles.customSize(
                          size: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: Dimensions.paddingSizeDefault.h,
                    ),

                    /// .................. Product remove Button .................>

                    AddButton(
                      ontap: () {
                        if (addTocartCtrl.productQuantity.value <= 1) {
                          addTocartCtrl.productQuantity.value == 1;
                        } else {
                          addTocartCtrl.productQuantity.value--;
                        }
                      },
                      icon: Icons.remove,
                    ),
                  ],
                ),

                /// .................. Product Add to cart Button .................>

                CustomButton(
                  height: 50.h,
                  width: 145.w,
                  onTap: () async {
                    var boutiqueData = await PrefsHelper.getString(AppConstants.boutiqueId);
                    if(addTocartCtrl.selectedSize.isNotEmpty && addTocartCtrl.selectedColor.isNotEmpty ){
                      var boutiqueLat = productDetailsCtrl
                          .productDetailsModel
                          .value
                          .data!
                          .attributes!
                          .product!
                          .userId!
                          .currentLocation!
                          .latitude!;
                      var boutiqueLong = productDetailsCtrl
                          .productDetailsModel
                          .value
                          .data!
                          .attributes!
                          .product!
                          .userId!
                          .currentLocation!
                          .longitude!;

                      if (boutiqueData.isEmpty) {
                        //   await dbHelper.insertBoutiqueInfo(productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!);
                        saveData(data);
                        await PrefsHelper.setString(AppConstants.boutiqueId,productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!.id);
                        await PrefsHelper.setDouble(AppConstants.boutiqueLat, boutiqueLat);
                        await PrefsHelper.setDouble(AppConstants.boutiqueLog, boutiqueLong);
                        Get.toNamed(AppRoutes.addToCartScreen);
                      } else {
                        print("BoutiQueId>>>>$boutiqueData");
                        print("NewBoutiQueId>>>>${productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!.id}");
                        // String userId = json.decode(boutiqueData);
                        String userId=boutiqueData;
                        if (userId !=
                            productDetailsCtrl.productDetailsModel.value.data!
                                .attributes!.product!.userId!.id.toString()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(AppString.addtoCartAlertText.tr),
                                backgroundColor: Colors.white,
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('No'),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(),
                                    ),
                                    onPressed: () async {
                                      await dbHelper.deleteTable("cart");
                                      await PrefsHelper.setString(AppConstants.boutiqueId,productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!.id);
                                      saveData(data);
                                      await PrefsHelper.setDouble(
                                          AppConstants.boutiqueLat, boutiqueLat);
                                      await PrefsHelper.setDouble(
                                          AppConstants.boutiqueLog, boutiqueLong);
                                      Get.toNamed(AppRoutes.addToCartScreen);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          saveData(data);
                          await PrefsHelper.setDouble(
                              AppConstants.boutiqueLat, boutiqueLat);
                          await PrefsHelper.setDouble(
                              AppConstants.boutiqueLog, boutiqueLong);
                          await PrefsHelper.setString(AppConstants.boutiqueId,productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!.id);
                          Get.toNamed(AppRoutes.addToCartScreen);
                        }
                      }
                    }else{
                      showToastMessage.showMessage("Please Select Size Or Color");

                    }

                  },
                  text: AppString.addtocartText.tr,
                  textStyle: AppStyles.h8(color: AppColors.whiteColor),
                ),



                // CustomButton(
                //   height: 50.h,
                //   width: 145.w,
                //   onTap: () async {
                //     var boutiqueData = await PrefsHelper.getString(AppConstants.boutiqueId);
                //     print('jhajksdb>>>>$boutiqueData');
                //     var boutiqueLat = productDetailsCtrl.productDetailsModel
                //         .value
                //         .data!
                //         .attributes!
                //         .product!
                //         .userId!
                //         .currentLocation!
                //         .latitude!;
                //     var boutiqueLong = productDetailsCtrl
                //         .productDetailsModel
                //         .value
                //         .data!
                //         .attributes!
                //         .product!
                //         .userId!
                //         .currentLocation!
                //         .longitude!;
                //
                //     if (boutiqueData.isEmpty) {
                //       print('ADD Data');
                //       //   await dbHelper.insertBoutiqueInfo(productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!);
                //       saveData(data);
                //       await PrefsHelper.setString(AppConstants.boutiqueId, json.encode(productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!.id));
                //       await PrefsHelper.setDouble(AppConstants.boutiqueLat, boutiqueLat);
                //       await PrefsHelper.setDouble(AppConstants.boutiqueLog, boutiqueLong);
                //       Get.toNamed(AppRoutes.addToCartScreen);
                //     } else {
                //       UserId userId = UserId.fromJson(json.decode(boutiqueData));
                //      // print('gajsdghkja$userId');
                //
                //       if (userId != productDetailsCtrl.productDetailsModel.value.data!.attributes!.product!.userId!.id) {
                //         showDialog(
                //           context: context,
                //           builder: (BuildContext context) {
                //             return AlertDialog(
                //               content: Text(AppString.addtoCartAlertText.tr),
                //               backgroundColor: Colors.white,
                //               actions: <Widget>[
                //                 TextButton(
                //                   child: const Text('No'),
                //                   onPressed: () {
                //                     Get.back();
                //                   },
                //                 ),
                //                 TextButton(
                //                   child: const Text(
                //                     'Yes',
                //                     style: TextStyle(),
                //                   ),
                //                   onPressed: () async {
                //                     await dbHelper.deleteTable("cart");
                //                     await PrefsHelper.setString(
                //                         AppConstants.boutiqueId,
                //                         json.encode(productDetailsCtrl
                //                             .productDetailsModel
                //                             .value
                //                             .data!
                //                             .attributes!
                //                             .product!
                //                             .userId!.id));
                //                     saveData(data);
                //                     await PrefsHelper.setDouble(
                //                         AppConstants.boutiqueLat, boutiqueLat);
                //                     await PrefsHelper.setDouble(
                //                         AppConstants.boutiqueLog, boutiqueLong);
                //                     Get.toNamed(AppRoutes.addToCartScreen);
                //                   },
                //                 ),
                //               ],
                //             );
                //           },
                //         );
                //       }
                //       else {
                //         saveData(data);
                //         await PrefsHelper.setDouble(
                //             AppConstants.boutiqueLat, boutiqueLat);
                //         await PrefsHelper.setDouble(
                //             AppConstants.boutiqueLog, boutiqueLong);
                //         await PrefsHelper.setString(
                //             AppConstants.boutiqueId,
                //             json.encode(productDetailsCtrl.productDetailsModel
                //                 .value.data!.attributes!.product!.userId!.id));
                //         Get.toNamed(AppRoutes.addToCartScreen);
                //       }
                //     }
                //   },
                //   text: AppString.addtocartText.tr,
                //   textStyle: AppStyles.h8(color: AppColors.whiteColor),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.paddingSizeDefault.h,
          ),
          Divider(
            thickness: 2,
            indent: 34.w,
            endIndent: 34.w,
            color: AppColors.textColor.withOpacity(0.4),
          ),

          /// .................. Product Reviews .................>

          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.ratingScreen, arguments: id);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.reviewsText.tr,
                    style: AppStyles.customSize(
                        size: 20, fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '+',
                        style: AppStyles.h6(color: Get.theme.primaryColor)),
                    TextSpan(
                        text: AppString.addreviewText.tr,
                        style: AppStyles.h6(color: Get.theme.primaryColor))
                  ]))
                ],
              ),
            ),
          ),

          SizedBox(
            height: Dimensions.paddingSizeDefault.h,
          ),

          CommentSection(id: id),

          /// .................. Comment Section   .................>

          // Obx(()=>  ListView.separated(
          //   itemCount: productDetailsCtrl.productCommentModel.value.length + 1,
          //   shrinkWrap: true,
          //   primary: false,
          //   controller: scrollCtrl,
          //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          //   itemBuilder: (context, index) {
          //     if (index >=
          //         productDetailsCtrl.productCommentModel.value.length) {
          //       return productDetailsCtrl.loadMoreLoadign.value
          //           ? CustomPageLoading()
          //           : SizedBox();
          //     } else {
          //       var data = productDetailsCtrl.productCommentModel.value[index];
          //       return CommentSection(
          //         reviews: data,
          //         index: index,
          //       );
          //     }
          //   },
          //   separatorBuilder: (context, index) {
          //     return Divider(color: Get.theme.dividerColor.withOpacity(0.2));
          //   },
          // ),),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  /// Save to Database
  void saveData(Product data) async {
    try {
      Cart newCartItem = Cart(
        productId: data.id,
        productName: data.name,
        productSize: addTocartCtrl.selectedSize.value,
        productColor: addTocartCtrl.selectedColor.value,
        productPrice: int.parse(data.price!),
        quantity: RxInt(addTocartCtrl.productQuantity.value),
        image: '${ApiConstant.imageBaseUrl}${data.firstImage!.publicFileUrl}',
      );
      await dbHelper.insert(newCartItem);
    } catch (e, stackTrace) {
      print('Error adding product to cart: $e');
      print('StackTrace: $stackTrace');
    }
  }
}
