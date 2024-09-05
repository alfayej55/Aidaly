

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:aidaly/helpers/route.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../models/Role/BoutiqueModel/product_categori_model.dart';
import '../../../../../../service/api_check.dart';
import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_constants.dart';

class AddNewProductControllar extends GetxController{

  TextEditingController productnameCtrl=TextEditingController();
  TextEditingController priceCtrl=TextEditingController();
  TextEditingController inventoryCtrl=TextEditingController();

    RxList<AllCatagoryModel> allCategoriModel=<AllCatagoryModel>[].obs;

     RxString selectedValue=''.obs;
    RxList colorList=[].obs;
    RxList<String> selectedSizes=<String>[].obs;
    RxString selectedSize='M'.obs;
     ImagePicker picker=ImagePicker();
    RxList<String> images = <String>[].obs;
    RxString selectType=''.obs;
    var loading=false.obs;

  RxList<Map<String,dynamic>> productSizes=<Map<String,dynamic>>[].obs;




@override
  void onInit() {
  productCategori();
    // TODO: implement onInit
    super.onInit();
  }

  /// Product Categori Get
  var categoriloading=false.obs;
  productCategori()async{
    categoriloading.value=true;
    var response=await ApiClient.getData(ApiConstant.boutiqueallCategoryEndPoint);
    if(response.statusCode==200){
      allCategoriModel.value= List<AllCatagoryModel>.from(response.body['data']['attributes']['allCatagory'].map((x) => AllCatagoryModel.fromJson(x)));

       allCategoriModel.refresh();
      categoriloading.value=false;
      update();
    }
    else{
      ApiChecker.checkApi(response);
      categoriloading.value=false;
      update();

    }
  }

  /// Add Product
  void addproduct()async{

    loading.value=true;

    // Map<String, String> body =
    // {
    //
    //   'productName':productnameCtrl.text,
    //   'category':selectedValue.value,
    //   'inventoryQuantity':inventoryCtrl.text,
    //   'price':priceCtrl.text,
    //   'size':jsonEncode(selectedSizes.value),
    //   'color':jsonEncode(colorList.value),
    //
    // };

    Map<String, String> body =
    {
      'productName':productnameCtrl.text,
       'category':selectedValue.value,
      // 'inventoryQuantity':inventoryCtrl.text,
      // 'price':priceCtrl.text,
      'variants':jsonEncode(productSizes),
      'color':jsonEncode(colorList),

    };

    List<MultipartBody> multipartList = [];
    // Add multiple images to multipartList
    for (String imagePath in images.value) {
      multipartList.add(
          MultipartBody(
              "productImage1",File(imagePath)
          )
      );
    };

    Response response=await ApiClient.postMultipartData(
        ApiConstant.boutiqeAddProductEndPoint,
        body,multipartBody:images.value.isEmpty?[]:multipartList,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg:response.body['message']);
      priceCtrl.clear();
      priceCtrl.clear();
      inventoryCtrl.clear();
      colorList.clear();
      selectedSizes.close();
      images.clear();
       Get.offAllNamed(AppRoutes.myProductBoutiqueScreen);
      loading.value=false;
      update();

    } else {

      ApiChecker.checkApi(response);
      loading.value=false;
      update();
    }

  }

  /// Image Color Picar

  void openColorPicker(BuildContext context) async {
    ColorPicker(
      onColorChanged: (Color color){
      String colorString = "${color.value.toRadixString(16).substring(2)}"; // Adding "0xFF" before the color value
      colorList.add(colorString);
      update();

    },
      onColorChangeEnd: (Color color) {
      },
      actionButtons: ColorPickerActionButtons(

      ),
      width: 40,
      height: 40,
      borderRadius: 20,
      spacing: 5,
      runSpacing: 5,
    ).showPickerDialog(context);
  }

  ///Product Image Picar
  Future pickImageFromCamera( ) async {
    final  List<XFile>  returnImage =  await picker.pickMultiImage();
    if (returnImage == null) return;
    for (var img in returnImage){
      images.value.add(img.path);
    }
      images.refresh();

  }

  ///Product Size Select

  void toggleSize(String size) {
    if (selectedSizes.contains(size)) {
      selectedSizes.remove(size);
      selectedSizes.refresh();
    } else {
      selectedSizes.add(size);
      selectedSizes.refresh();
    }
  }

  void removeSize(int index) {
    productSizes.removeAt(index);
    print('Remove>>>>${productSizes}');
    productSizes.refresh();
  }

  ///Product Image Remove
  removeImage(int index){
    images.removeAt(index);
    refresh();
  }
  removeColor(int index){
    colorList.removeAt(index);
    refresh();
  }

}