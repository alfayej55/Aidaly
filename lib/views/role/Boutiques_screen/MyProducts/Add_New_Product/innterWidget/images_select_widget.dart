import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllar/add_new_product_controllar.dart';

class ProductImagesSelect extends StatelessWidget {
   ProductImagesSelect({super.key});

  AddNewProductControllar addProductCtrl=Get.put(AddNewProductControllar());

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 130.h,
      child:Obx(() => ListView.builder(
          itemCount: addProductCtrl.images.value.length+1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            if(addProductCtrl.images.value.length>index){
              return  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 5.w),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height:130.h,
                      width: 130.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30).r,
                          image: DecorationImage(image: FileImage(File(addProductCtrl.images.value[index])),fit: BoxFit.cover),
                          color: Get.theme.primaryColor.withOpacity(0.1)
                      ),

                    ),
                    GestureDetector(
                      onTap: (){
                        addProductCtrl.removeImage(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8,right: 5),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Get.theme.primaryColor.withOpacity(0.4),
                          child: Center(child: Icon(Icons.close,color: Colors.red,),),
                        ),
                      )
                    )
                  ],
                ),
              );
            }else{
              return GestureDetector(
                onTap: (){
                  addProductCtrl.pickImageFromCamera();
                },
                child: Container(
                  height:130.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30).r,
                      color: Get.theme.primaryColor.withOpacity(0.1)
                  ),
                  child: Center(child: Icon(Icons.camera_alt),),
                ),
              );
            }
          })),
    );
  }
}
