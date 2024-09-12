import 'dart:io';

import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:aidaly/views/base/show_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/dimensions.dart';
import 'controllar/add_new_product_controllar.dart';
import 'innterWidget/drop_button.dart';
import 'innterWidget/images_select_widget.dart';
import 'innterWidget/size_select_widget.dart';

class AddNewProductScreen extends StatefulWidget {
   AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
   AddNewProductControllar addProductCtrl=Get.put(AddNewProductControllar());

   final formKey = GlobalKey<FormState>();

   @override
  void initState() {
       addProductCtrl.productCategori();
       print('jhaldsfkjhahd');
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
          AppString.addProducts.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formKey,
            child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child:    Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Product  Name

              SizedBox(height: Dimensions.paddingSizeLarge.h,),
              Text(
                AppString.productsnameText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              CustomTextField(
                controller:addProductCtrl.productnameCtrl,
                filColor: Colors.white.withOpacity(0.3),
                contentPaddingVertical: 15.h,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Product name';
                  }
                  return null;
                },

              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              /// Product Category

              Text(
                AppString.productcategoryText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              /// dropButton

              DropButton(),

              // /// Product  Price
              //
              // SizedBox(height: Dimensions.paddingSizeLarge.h,),
              // Text(
              //   AppString.productsPriceText.tr,
              //   style: AppStyles.h8(),
              // ),
              // SizedBox(height: Dimensions.paddingSizeSmall.h,),
              // CustomTextField(
              //   controller:addProductCtrl.priceCtrl,
              //   filColor: Colors.white.withOpacity(0.3),
              //   contentPaddingVertical: 15.h,
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Enter Product Price';
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(height: Dimensions.paddingSizeSmall.h,),
              //
              // /// Inventory Quantity
              //
              // SizedBox(height: Dimensions.paddingSizeLarge.h,),
              // Text(
              //   AppString.inventoryQuantityText.tr,
              //   style: AppStyles.h8(),
              // ),
              // SizedBox(height: Dimensions.paddingSizeSmall.h,),
              // CustomTextField(
              //   controller:addProductCtrl.inventoryCtrl,
              //   filColor: Colors.white.withOpacity(0.3),
              //   contentPaddingVertical: 15.h,
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Enter Product Quantity';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              /// Color
              Text(
                AppString.colorText.tr,
                style: AppStyles.h8(),
              ),

              /// Add Color

              Container(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: addProductCtrl.colorList.value.length + 1,
                    itemBuilder:(context,index){
                      if(addProductCtrl.colorList.value.length > index){
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5.w),
                          child: Stack(
                            alignment:Alignment.topRight,
                            clipBehavior: Clip.none,
                            children: [

                              Container(
                                height: 45.h,
                                width: 45.w,
                                decoration:BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(int.parse("0xff${addProductCtrl.colorList.value[index]}"))
                                ),
                              ),

                              GestureDetector(
                                  onTap: (){
                                    addProductCtrl.removeColor(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 1,),
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.white,
                                      child: Center(child: Icon(Icons.close,color: Colors.red,size: 15,),),
                                    ),
                                  )
                              )
                            ],
                          ),
                        );
                      }

                      else{
                        return  GestureDetector(
                          onTap: (){
                            addProductCtrl.openColorPicker(context);
                          },
                          child: DottedBorder(
                              borderType: BorderType.Circle,
                              color: Get.theme.secondaryHeaderColor,
                              padding: EdgeInsets.all(5),
                              child:Center(child: Icon(Icons.add,color: Get.theme.secondaryHeaderColor,))
                          ),
                        );
                      }

                    } ),
              ),

              ///  Size Select
              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              Text(
                  '${AppString.sizeText.tr}',
              //  '${AppString.sizeText.tr} Provide (${addProductCtrl.selectType.value})',
                  style: AppStyles.h8(),
              ),

              SizedBox(height: Dimensions.paddingSizeSmall.h,),
              ///  Size Select Widget
             // SizeSelector(),

              Container(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: addProductCtrl.productSizes.value.length + 1,
                    itemBuilder:(context,index){
                      if(addProductCtrl.productSizes.value.length> index){
                        return Stack(
                          alignment:Alignment.topRight,
                          clipBehavior: Clip.none,
                          children: [

                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 5.w),
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primaryColor )
                                    //color: addNewProductCtrl.selectedSizes.value.contains(sizes[index]) ? Get.theme.primaryColor :Get.theme.primaryColor.withOpacity(0.2)
                                ),
                                child: Center(
                                  child: Text(
                                      addProductCtrl.productSizes.value[index]['size'],
                                      style: AppStyles.customSize(size: 18,
                                          fontWeight: FontWeight.w500, color:Colors.black)
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                                onTap: (){
                                  addProductCtrl.removeSize(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1,),
                                  child: CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.white,
                                    child: Center(child: Icon(Icons.close,color: Colors.red,size: 15,),),
                                  ),
                                )
                            )
                          ],
                        );
                      }

                      else{
                        return  GestureDetector(
                          onTap: (){
                            showSizeInflo(addProductCtrl.selectType.value);
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(left: 5.w,bottom: 13.h),
                            child: DottedBorder(
                                borderType: BorderType.Circle,
                                color: Get.theme.secondaryHeaderColor,
                               padding: EdgeInsets.all(5),
                                child:Center(child: Icon(Icons.add,color: Get.theme.secondaryHeaderColor,))
                            ),
                          ),
                        );
                      }

                    } ),
              ),

              ///  Product Image
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              Text(
                AppString.ProductImageText.tr,
                style: AppStyles.h8(),
              ),
              SizedBox(height: Dimensions.paddingSizeSmall.h,),

              ///  Image Select Widget

              ProductImagesSelect(),

              /// Add Button

              SizedBox(height: Dimensions.paddingSizeExtraLarge.h,),
              CustomButton(
                  loading: addProductCtrl.loading.value,
                  onTap: (){

                    if(formKey.currentState!.validate()
                        && addProductCtrl.colorList.isNotEmpty)
                      {
                        addProductCtrl.addproduct();
                      }
                    else{
                      print('Product Add Text');
                    }

                  },
                  text: AppString.addText.tr),

              SizedBox(height: Dimensions.paddingSizeDefault.h,),
            ],
          )),
        )
        ),
      ),

    );
  }

  showSizeInflo(String type){

      TextEditingController _sizeCtrl=TextEditingController();
      TextEditingController _quntityCtrl=TextEditingController();
      TextEditingController _priceCtrl=TextEditingController();

     return showDialog(
         context: context,
         builder: (conntext){
           return AlertDialog(
             backgroundColor: Colors.white,
             content: SingleChildScrollView(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Align(
                     alignment: Alignment.topCenter,
                     child: Text(
                       'Add Product Size',
                       style: AppStyles.h2(),
                     ),
                   ),
                SizedBox(height: 15.h,),
                   Text(
                     "Size",
                    // 'Size (${type=="numeric"?"Numeric Size":"Alphabet Size"})',
                     style: AppStyles.h8(),
                   ),
                   SizedBox(height: Dimensions.paddingSizeSmall.h,),
                   CustomTextField(
                     controller:_sizeCtrl,
                     filColor: Colors.white.withOpacity(0.3),
                     contentPaddingVertical: 15.h,
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Please Enter Product Size';
                       }
                       return null;
                     },
                   ),
                   SizedBox(height: 15.h,),
                   Text(
                     AppString.inventoryQuantityText.tr,
                     style: AppStyles.h8(),
                   ),
                   SizedBox(height: Dimensions.paddingSizeSmall.h,),
                   CustomTextField(
                     controller:_quntityCtrl,
                     filColor: Colors.white.withOpacity(0.3),
                     contentPaddingVertical: 15.h,
                     keyboardType: TextInputType.number,
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Please Enter Product Quantity';
                       }
                       return null;
                     },
                   ),
               
                   SizedBox(height: 15.h,),
                   Text(
                     'Price',
                     style: AppStyles.h8(),
                   ),
                   SizedBox(height: Dimensions.paddingSizeSmall.h,),
                   CustomTextField(
                     controller:_priceCtrl,
                     filColor: Colors.white.withOpacity(0.3),
                     contentPaddingVertical: 15.h,
                     keyboardType: TextInputType.number,
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         return 'Please Enter Product Quantity';
                       }
                       return null;
                     },
                   ),
               
                 ],
               ),
             ),

             actions: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment as needed
                 children: [
                   OutlinedButton(
                       style: ElevatedButton.styleFrom(
                         foregroundColor: Colors.black,
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(18.r),
                             side: BorderSide(color:Get.theme.primaryColor,width: 2)
                         ),
                         minimumSize:Size(166.w, 58.h),
                       ),
                       onPressed: (){
                         Get.back();
                       },
                       child:Text(AppString.declineText.tr,style: AppStyles.h3(fontWeight: FontWeight.w600,color:Get.theme.primaryColor),)),
                   Expanded(
                     child: CustomButton(
                       width: 100.w,
                         height: 50.h,
                         onTap: () {

                           addProductCtrl.productSizes.add({
                             "size": _sizeCtrl.text,
                             "inventoryQuantity": _quntityCtrl.text,
                             "price": _priceCtrl.text
                           });
                           addProductCtrl.productSizes.refresh();
                           Get.back();

                           // print(' Match ${getType(
                           //     _sizeCtrl.text)}>>${addProductCtrl.selectType}');
                           // if (getType(_sizeCtrl.text) ==
                           //     addProductCtrl.selectType.value) {
                           //   addProductCtrl.productSizes.add({
                           //     "size": _sizeCtrl.text,
                           //     "inventoryQuantity": _quntityCtrl.text,
                           //     "price": _priceCtrl.text
                           //   });
                           //   addProductCtrl.productSizes.refresh();
                           //   print('Add Size>>>>>>${addProductCtrl
                           //       .productSizes}');
                           //   Get.back();
                           // } else {
                           //   showToastMessage.showMessage(
                           //       'No Match ${addProductCtrl.selectType}');
                           //   print('No Match ${addProductCtrl.selectType}');
                           // }
                         }, text: AppString.addText.tr),
                   ),
                 ],
               ),
             ],
           );
         });

  }

   String getType(String value) {
     if (value.isEmpty) return "unknown";
     final numericRegex = RegExp(r'^-?[0-9]+$');
     return numericRegex.hasMatch(value) ? "numeric" : "alphabet";
   }

}




