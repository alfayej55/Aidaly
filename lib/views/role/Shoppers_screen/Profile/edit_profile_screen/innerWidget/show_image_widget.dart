import 'dart:io';

import 'package:aidaly/views/role/shoppers_screen/Profile/edit_profile_screen/innerWidget/show_image_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/Shopper_Controllar/shopper_profile_controller.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_Image.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../base/cache_network_image.dart';
import '../edit_profile_controllar/edit_controllar.dart';

class ShopperShowImage extends StatelessWidget {

   ShopperShowImage({super.key});

   ShopperProfileController _profileCtrl=Get.put(ShopperProfileController());

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: (){
          ShopperShowImagePicker().showImagePickerOption(context);
        },

        child: Obx(() => Stack(
          alignment: Alignment.bottomRight,
          children: [

            /// Profile Image

            _profileCtrl.imagePath.value.isNotEmpty? Container(
              height: 90.h,
              width: 90.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: FileImage(
                    File(_profileCtrl.imagePath.value),
                  ),fit: BoxFit.cover ),
                  border: Border.all(
                    color:AppColors.subTextColor.withOpacity(0.1),

                  )
              ),

            ):CustomNetworkImage(
              imageUrl: "${ApiConstant.imageBaseUrl}${_profileCtrl.profilModel.value.image!.publicFileUrl!}",
              //borderRadius: BorderRadius.circular(12.r),
              height: 90.h,
              width: 90.w,
              boxShape: BoxShape.circle,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Get.theme.primaryColor,
                child: Center(
                  child: Icon(Icons.add,color: AppColors.whiteColor,size: 15,),
                ),
              ),
            )

          ],

        ),)
    );
  }
}
