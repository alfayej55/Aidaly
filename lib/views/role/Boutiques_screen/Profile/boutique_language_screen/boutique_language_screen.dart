

import 'package:aidaly/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../controllers/localization_controller.dart';
import '../../../../../utils/app_Image.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/style.dart';

class BoutiqueLanguageScreen extends StatefulWidget {
  BoutiqueLanguageScreen({super.key});

  @override
  State<BoutiqueLanguageScreen> createState() => _BoutiqueLanguageScreenState();
}

class _BoutiqueLanguageScreenState extends State<BoutiqueLanguageScreen> {
   LocalizationController localizationController=Get.find<LocalizationController>();


   var selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.languageText.tr,
            style: AppStyles.h2(color: Get.theme.primaryColor),
          ),
        ),
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
      ),

      body:  ListView.builder(
          itemCount: AppConstants.languages.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context,index)
          {
            var data=AppConstants.languages[index];
            return   ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              leading: SvgPicture.asset(data.countryFlag,width: 30.w,height: 18.h,),
              title: Text(data.languageName!,style: AppStyles.customSize(size: 16,color: AppColors.textColor),),
              trailing: Radio<int>(
                value: index,
                groupValue: selectedOption,
                activeColor: Get.theme.primaryColor, // Change the active radio button color here
                fillColor: MaterialStateProperty.all(Get.theme.primaryColor), // Change the fill color when selected
                splashRadius: 25, // Change the splash radius when clicked
                onChanged: (int? value) {
                  if (value != null) {
                    localizationController.setLanguage(
                      Locale(
                        AppConstants.languages[index].languageCode,
                        AppConstants.languages[index].countryCode,
                      )

                    );
                    localizationController.setSelectIndex(value);
                    // localizationController.loadCurrentLanguage();
                    setState(() {
                      selectedOption = value;
                    });
                  }
                },
              ),

            );
          }),
    );
  }
}
