
import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/controllers/Role/Shopper_Controllar/home_controller.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:aidaly/views/base/cache_network_image.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/style.dart';
import '../../../base/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
   SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchCtrl = TextEditingController();

  HomeController _searchCtrl=Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
       backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
       padding: EdgeInsets.only(left: 10.w),
         child: Text(
         AppString.search.tr,
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
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(()=>SingleChildScrollView(
          child: Column(

            children: [
              TextFormField(
                controller: searchCtrl,
                maxLines:1,
                cursorColor: AppColors.primaryColor,
                style: TextStyle(color:Get.theme.hintColor, fontSize: 16.sp),
                onChanged:(value){
                  _searchCtrl.searchProduct(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical:  15.w),
                  fillColor:AppColors.whiteColor,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15.w),
                    child: SvgPicture.asset(AppIcons.searchIcon),
                  ),
          
                  prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
                  suffixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
                  hintText: AppString.search.tr,
                ),
              ),
          
              SizedBox(height: 30.h),
             _searchCtrl.searchLoading.value?CustomPageLoading(): _searchCtrl.profileListModel.isNotEmpty?  ListView.builder(
                 shrinkWrap: true,
                 primary: false,
                 itemCount: _searchCtrl.profileListModel.length,
                 itemBuilder: (context,index){
                   var data=_searchCtrl.profileListModel[index];
                   return   Padding(
                     padding:  EdgeInsets.symmetric(vertical: 8.h),
                     child: InkWell(
                       onTap: (){

                         Get.toNamed(AppRoutes.boutiqueScreen,
                             arguments: data.id!);
                        // Get.toNamed(AppRoutes.productDetailsScreen,arguments: data.id!,parameters: {"size":data.variants![0].size!});
                       },
                       child: Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8).r,
                               color: Get.theme.cardColor
                           ),
                           child: ListTile(
                             contentPadding: EdgeInsets.all(8),
                             leading: CustomNetworkImage(
                               imageUrl:"${ApiConstant.imageBaseUrl}${data.image!.publicFileUrl}",
                               height: 48.h,
                               width: 48.w,
                              boxShape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(8.r),
                             ),
                             title: Text('${data.name}',style: AppStyles.h4(color: AppColors.textColor),),
                             subtitle:Text('${data.email}',style: AppStyles.h6(color: AppColors.primaryColor),),
          
          
                           )
                       ),
                     ),
                   );
                 }):Text('No Data')
          
            ],
          ),
        ))

      ),
    );
  }
}
