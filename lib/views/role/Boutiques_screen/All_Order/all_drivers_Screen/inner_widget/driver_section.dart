import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../models/Role/BoutiqueModel/all_driver_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/cache_network_image.dart';

class DriverSection extends StatefulWidget {

   DriverSection({super.key,});

  @override
  State<DriverSection> createState() => _DriverSectionState();
}

class _DriverSectionState extends State<DriverSection> {

  var isChecked;
  var currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 15.h),
      itemBuilder: (context,index){
        return ListTile(
          contentPadding: EdgeInsets.zero,
          titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
          subtitleTextStyle: AppStyles.customSize(size: 14,fontWeight: FontWeight.w500,color: AppColors.secandaryTextColor),

          /// Driver Images
          leading: CustomNetworkImage(
            imageUrl:"https://images.unsplash.com/photo-1513094735237-8f2714d57c13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob3BwaW5nfGVufDB8fDB8fHww",
            //borderRadius: BorderRadius.circular(12.r),
            height: 55.h,
            width:55.w,
            boxShape: BoxShape.circle,

          ),

          /// Driver Name
          title: Text('Heest Munal'),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Text('Driver'),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.star,height: 15.h,width: 15.h,),
                  SizedBox(width: 5.w,),

                  /// Reting
                  Text('5.0',style: AppStyles.customSize(size: 10,fontWeight: FontWeight.w500,color: AppColors.textColor),),
                ],
              ),
            ],
          ),
          trailing: Checkbox(
              value:currentIndex==index?true:false,

              side: BorderSide(width: 2, color: AppColors.primaryColor.withOpacity(0.1)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              splashRadius: 5,
              checkColor: AppColors.whiteColor,
              activeColor:AppColors.primaryColor,
              onChanged: (value){
                isChecked=value;
                // setState(() {
                //   _isChecked = value!;
                // });
              }),

          onTap: (){
            setState(() {
              currentIndex=index;
            });
          },

        );
      }, separatorBuilder: (context,index){

      return Divider(
        color: Get.theme.dividerColor.withOpacity(0.2),
      );
    },

    );
  }
}
