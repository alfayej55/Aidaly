

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../models/Role/ShopperModel/product_details_model.dart';
import '../../../models/Role/ShopperModel/product_details_review_model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';
import '../../../utils/enamdata.dart';

class ProduceDetailsController extends GetxController{

  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  TextEditingController heightCtrl = TextEditingController();
  TextEditingController widthCtrl = TextEditingController();
  TextEditingController reviewCtrl = TextEditingController();
     var loading =false.obs;
  ImagePicker picker=ImagePicker();
  RxList<String> images = <String>[].obs;
  RxDouble rating=0.0.obs;


  var productDetailsLoading=false.obs;
  var loadMoreLoadign=false.obs;
  RxString productFirstImage=''.obs;

  int page=1;
  var currentPage=0;
  var totalPage=0;



  Rx<ProductDetailsModel> productDetailsModel=ProductDetailsModel().obs;
  RxList<ProductCommentModel> productCommentModel=<ProductCommentModel>[].obs;

/// Shopper Product Details
   shopProductDetails(String productId,String size)async{

     print(' ProdutId>>>>>>${productId}');
    var response=await ApiClient.getData('${ApiConstant.shopProductDetailsiEndPoint}$productId&size=$size');
    if(response.statusCode==200){

      productDetailsModel.value=ProductDetailsModel.fromJson(response.body);
      productFirstImage.value= productDetailsModel.value.data!.attributes!.product!.firstImage!.publicFileUrl ?? "";
      setRxRequestStatus(Status.completed);
      update();
    }
    else{
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else
      {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      update();

    }
  }


  /// Shopper Product Comment
  shopProduComment(String productId)async{

    var response=await ApiClient.getData('${ApiConstant.shopProductCommentEndPoint}$productId?page=$page&limit=8');
    if(response.statusCode==200){
      productCommentModel.value= List<ProductCommentModel>.from(response.body['data']['attributes'].map((x) => ProductCommentModel.fromJson(x)));
      currentPage=response.body['pagination']['attributes']['currentPage'];
      totalPage=response.body['pagination']['attributes']['totalPages'];
      productCommentModel.refresh();
      setRxRequestStatus(Status.completed);
      update();
    }
    else if(response.statusCode==404){

    }
    else{
      if (ApiClient.noInternetMessage == response.statusText) {
        setRxRequestStatus(Status.internetError);
      } else
      {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
      update();

    }
  }

  loadMore(String productId)async{
    if(
       productDetailsLoading !=true &&
        loadMoreLoadign==false &&
       currentPage!=totalPage){

      loadMoreLoadign.value=true;
      page += 1;
      var response=await ApiClient.getData('${ApiConstant.shopProductCommentEndPoint}$productId?page=$page&limit=8');
      if(response.statusCode==200){
        var result= List<ProductCommentModel>.from(response.body['data']['attributes'].map((x) => ProductCommentModel.fromJson(x)));
        currentPage=response.body['pagination']['attributes']['currentPage'];
        totalPage=response.body['pagination']['attributes']['totalPages'];
        productCommentModel.value.addAll(result);
        productCommentModel.refresh();
        loadMoreLoadign.value=false;
        update();
      }
      else{
        ApiChecker.checkApi(response);
        loadMoreLoadign.value=false;
        update();

      }
    }

  }


  /// Product Add Comment
  addComment(String productId)async{

    loading.value=true;
      Map<String, String> body =
      {
        'rating':rating.value.toString(),
        'height':heightCtrl.text,
        'weight':widthCtrl.text,
        'reviews':reviewCtrl.text,
      };

      List<MultipartBody> multipartList = [];

      // Add multiple images to multipartList
      for (String imagePath in images.value) {
        multipartList.add(
            MultipartBody(
                "reviewImage",File(imagePath)
            )
        );
      };

      Response response=await ApiClient.postMultipartData(
        '${ApiConstant.shopProductAddCommentEndPoint}/$productId',
        body,
        multipartBody:images.value.isEmpty?[]:multipartList,
      );

      if (response.statusCode == 200) {
        shopProduComment(productId);
        Get.back();

        images.clear();
        reviewCtrl.clear();
        widthCtrl.clear();
        heightCtrl.clear();
         rating.value=0.0;
        loading.value=false;
        update();

      } else {

        ApiChecker.checkApi(response);
        loading.value=false;
        update();
      }

  }
  
  
  commentLike(int index,String id,String productId)async{
     var body={
       "reviewId":id
     };
     var response=await ApiClient.postData(ApiConstant.commentLikeEndPoint, jsonEncode(body));
     if(response.statusCode==200){
       productCommentModel[index].isLiked =! productCommentModel[index].isLiked;
       shopProduComment(productId);
       productCommentModel.refresh();
       update();
       print("TotlaLike>>>>${productCommentModel[index].likeCount}");
     }else{
       ApiChecker.checkApi(response);
     }
  }
  
  

  /// Get Multiple Image

  Future pickImageFromCamera( ) async {
    final  List<XFile>  returnImage =  await picker.pickMultiImage();

    if (returnImage == null) return;

    for (var img in returnImage){

      images.value.add(img.path);
      images.refresh();
      print('ImagesPath>>>>:${img.path}');

    }

    print('ImagesPath:${images}');
    update();

  }

  sizeUpdate(String productId,String size)async{
      var response=await ApiClient.getData('${ApiConstant.shopProductDetailsiEndPoint}$productId&size=$size');
    if(response.statusCode==200){
      productDetailsModel.value.data!.attributes!.product!.price = productDetailsModel.value.data!.attributes!.product!.price;
      print('Size>>>${ productDetailsModel.value.data!.attributes!.product!.price}');
      update();
    }


  }
}