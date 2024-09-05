import 'package:aidaly/controllers/Role/BoutiquesControllar/in_progress_controller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/utils/app_string.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/style.dart';
import '../../../../base/cache_network_image.dart';
import '../../../../base/custom_button.dart';
import 'inner_widget/driver_section.dart';

class AllDriversScreen extends StatefulWidget {

   AllDriversScreen({super.key});
  @override
  State<AllDriversScreen> createState() => _AllDriversScreenState();

}

class _AllDriversScreenState extends State<AllDriversScreen> {

  InProgressController inprogressCtrl=Get.put(InProgressController());
  var isChecked;

  var inprogressId=Get.arguments;

  @override
  void initState() {
    inprogressCtrl.allDriverList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        // centerTitle: true,
        title: Text(
          AppString.allDriversText.tr,
          style: AppStyles.h2(color: Get.theme.primaryColor),
        ),
      ),

      body:Obx(() => inprogressCtrl.driverLoading.value?Center(child: CustomPageLoading()): SingleChildScrollView(
        child: Column(
          children: [
        
            /// Driver Section
        
            ListView.separated(
              itemCount: inprogressCtrl.allDriverModel.value.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 15.h),
              itemBuilder: (context,index){
                var data=inprogressCtrl.allDriverModel.value[index];
                return Obx(() => ListTile(
                  contentPadding: EdgeInsets.zero,
                  titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
                  subtitleTextStyle: AppStyles.customSize(size: 14,fontWeight: FontWeight.w500,color: AppColors.secandaryTextColor),
        
                  /// Driver Images
                  leading: CustomNetworkImage(
                    imageUrl:"${ApiConstant.imageBaseUrl}${data.image!.publicFileUrl}",
                    //borderRadius: BorderRadius.circular(12.r),
                    height: 55.h,
                    width:55.w,
                    boxShape: BoxShape.circle,
        
                  ),
        
                  /// Driver Name
                  title: Text(data.name!.toUpperCase()),
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
                          Text('${data.rating}',style: AppStyles.customSize(size: 10,fontWeight: FontWeight.w500,color: AppColors.textColor),),
                        ],
                      ),
                    ],
                  ),
                  trailing: Checkbox(
                      value:inprogressCtrl.currentIndex.value==index?true:false,
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
                    inprogressCtrl.currentIndex.value=index;
                    inprogressCtrl.drivarId.value=data.id.toString();
                    print('Index>>${inprogressCtrl.currentIndex.value}');
                    print('Driver id>>${inprogressCtrl.drivarId.value}');
                  },
        
                ));
              }, separatorBuilder: (context,index){
        
              return Divider(
                color: Get.theme.dividerColor.withOpacity(0.2),
              );
            },
        
            ),
        
            Align(
              alignment: Alignment.bottomCenter,
              child:inprogressCtrl.assignToDriverLoading.value ?CustomPageLoading(): CustomButton(
                padding: EdgeInsets.only(bottom: 15.h),
                onTap: (){
                 inprogressCtrl.ordertAssignToDriver(inprogressId);
                },
                height: 58.h,
                width: 342.w,
                text:AppString.doneText.tr,
                textStyle: AppStyles.h7(
                    color: AppColors.whiteColor,
                    letterSpacing: 2
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
