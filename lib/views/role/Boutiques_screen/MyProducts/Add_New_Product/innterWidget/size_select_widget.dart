

import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllar/add_new_product_controllar.dart';

class SizeSelector extends StatelessWidget {

  SizeSelector({super.key});

  final List<String> sizes= ['XS','S', 'M', 'L','XL'];

  AddNewProductControllar addNewProductCtrl=Get.put(AddNewProductControllar());
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: List.generate(
          sizes.length,
              (index) => InkWell(
            onTap: (){
              addNewProductCtrl.selectedSize.value= (sizes[index]);
              addNewProductCtrl.toggleSize(sizes[index]);
              print('ddddd  ${ addNewProductCtrl.selectedSizes.value}');
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: addNewProductCtrl.selectedSizes.value.contains(sizes[index]) ? Get.theme.primaryColor :Get.theme.primaryColor.withOpacity(0.2)
                ),
                child: Center(
                  child: Text(
                      sizes[index],
                      style: AppStyles.customSize(size: 18,
                          fontWeight: FontWeight.w500, color:addNewProductCtrl.selectedSizes.value.contains(sizes[index]) ? Colors.white :Colors.black)
                  ),
                ),
              ),
            ),
          )

      ),
    ));
  }
}