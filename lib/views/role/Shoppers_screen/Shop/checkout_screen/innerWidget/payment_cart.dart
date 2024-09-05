

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_Image.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/style.dart';

class PaymentCart extends StatelessWidget {
   PaymentCart({super.key});

  var data=[
    {
      'image':AppImages.creditcartImage,
      'name':AppString.creditcardText.tr
    },
    // {
    //   'image':AppImages.paypalImage,
    //   'name':AppString.payPalText.tr
    // }
  ];
  var selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ListView.builder(
        itemCount: data.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context,index)
          {
        return   ListTile(
          leading: SvgPicture.asset(data[index]['image']!,width: 30.w,height: 18.h,),
          title: Text(data[index]['name']!,style: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: AppColors.textColor),),
          trailing: Radio<int>(
            value: 1,
            groupValue: selectedOption,
            activeColor: Get.theme.primaryColor, // Change the active radio button color here
            fillColor: MaterialStateProperty.all(Get.theme.primaryColor), // Change the fill color when selected
            splashRadius: 25, // Change the splash radius when clicked
            onChanged: (int? value) {
              selectedOption = value!;
            },
          ),
        );
      }),
    );
  }
}
