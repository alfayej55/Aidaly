import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/utils/style.dart';
import 'package:aidaly/views/base/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_Image.dart';
import '../../../../utils/dimensions.dart';
class BoutiqueWaitListScreen extends StatefulWidget {
  const BoutiqueWaitListScreen({super.key});

  @override
  State<BoutiqueWaitListScreen> createState() => _BoutiqueWaitListScreenState();
}

class _BoutiqueWaitListScreenState extends State<BoutiqueWaitListScreen> {

  @override
  void initState() {
    //Future.delayed(Duration(seconds: 5),()=>Get.toNamed(AppRoutes.loginScreen));
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.waitlistImage),
          SizedBox(height: Dimensions.fontSizeExtraSmall),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AppIcons.starIcon),
                SvgPicture.asset(AppIcons.starIcon),
              ],
            ),
          ),
          SizedBox(height: Dimensions.fontSizeExtraSmall),
          CustomText(
            left: 20,
            right: 20,
            text: AppString.waitlistText.tr,
            textStyle: AppStyles.h4(),
            maxline: 9,
          )
        ],
      )
    );
  }
}
