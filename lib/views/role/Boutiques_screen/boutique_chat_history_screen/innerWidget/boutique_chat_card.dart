import 'package:aidaly/views/base/divaider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../helpers/route.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/style.dart';
import '../../../../base/cache_network_image.dart';


class BoutiqueChatCard extends StatelessWidget {

  final String? userName;
  final String? userImage;
  final String? lastMsg;

  const BoutiqueChatCard({super.key,this.userName,this.lastMsg,this.userImage});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
            titleTextStyle: AppStyles.customSize(
                size: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor),
            subtitleTextStyle:
            AppStyles.h6(color: AppColors.secandaryTextColor),
            leading: CustomNetworkImage(
              imageUrl:userImage!,
              //borderRadius: BorderRadius.circular(12.r),
              height: 60.h,
              width: 60.w,
              boxShape: BoxShape.circle,
            ),
            title: Text(userName!),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lastMsg!),
                Text('11:00 PM',style: TextStyle(color: AppColors.subTextColor),),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios_sharp,color:Colors.black,size:22,)),

        CustomDivaider()
      ],
    );
  }
}
