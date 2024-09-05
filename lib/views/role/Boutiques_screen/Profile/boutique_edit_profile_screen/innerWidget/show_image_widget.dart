import 'dart:io';


import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_edit_profile_screen/innerWidget/show_image_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/BoutiquesControllar/profile_controllar.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_Image.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../base/cache_network_image.dart';
import '../edit_profile_controllar/edit_controllar.dart';

class BoutiqueShowImage extends StatelessWidget {

   BoutiqueShowImage({super.key});

   BoutiqueProfileControllar profileEditControllart=Get.put(BoutiqueProfileControllar());

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
        onTap: (){
          BoutiqueShowImagePicker().showImagePickerOption(context);
          debugPrint('dddddddd${profileEditControllart.imagePath.value}');
        },

        child: Obx(() => Stack(
          alignment: Alignment.bottomRight,
          children: [

            /// Profile Image

            profileEditControllart.imagePath.value.isNotEmpty? Container(
              height: 90.h,
              width: 90.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: FileImage(
                    File(profileEditControllart.imagePath.value),
                  ),fit: BoxFit.cover ),
                  border: Border.all(
                    color:AppColors.subTextColor.withOpacity(0.1),
                  )
              ),

            ):CustomNetworkImage(
              imageUrl: "${ApiConstant.imageBaseUrl}${profileEditControllart.profilModel.value.image!.publicFileUrl!}",
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
