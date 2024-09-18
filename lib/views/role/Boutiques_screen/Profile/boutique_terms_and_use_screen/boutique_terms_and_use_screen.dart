import 'package:aidaly/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/privecyPolicy_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';

class BoutiqueTermsAndUseScreen extends StatefulWidget {
  BoutiqueTermsAndUseScreen({super.key});

  @override
  State<BoutiqueTermsAndUseScreen> createState() => _BoutiqueTermsAndUseScreenState();
}

class _BoutiqueTermsAndUseScreenState extends State<BoutiqueTermsAndUseScreen> {
  PrivecyPolicyController _privecyCtrl = Get.put(PrivecyPolicyController());
  var _isChecked=false;
  var _isCheckedPrivacy=false;

  @override
  void initState() {
    _privecyCtrl.privecyPolicyGet();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.termsofUseText.tr,
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

      body: Obx(
              () => _privecyCtrl.privecyLoading.value
              ? CustomPageLoading()
              : SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///Privacy policy of DapperDriver
              Text(
                AppString.privacypolicyofDapperDriverText.tr,
                style: AppStyles.h7(),
              ),
              SizedBox(height: Dimensions.paddingSizeminiSmall.h,),
              Text(
                '${_privecyCtrl.privecyModel.value.privacypolicyDroperDriver}',
                maxLines: 30,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.customSize(
                    size: 13,
                    fontWeight: FontWeight.w400,
                    color: Get.theme.disabledColor),
              ),
              SizedBox(height: Dimensions.paddingSizeminiSmall.h,),

              ///Other policies of DapperDriver

              Text(
                AppString.otherpoliciesofDapperDriverText.tr,
                style: AppStyles.h7(),
              ),
              SizedBox(height: Dimensions.paddingSizeminiSmall.h,),

              Text(
                '${_privecyCtrl.privecyModel.value.otherPolicyDroperDriver}',
                maxLines: 30,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.customSize(
                    size: 13,
                    fontWeight: FontWeight.w400,
                    color: Get.theme.disabledColor),
              ),
              SizedBox(height: Dimensions.paddingSizeminiSmall.h,),

        //      ///I agree with this Terms of Use
        //
        //       Row(
        //         children: [
        //           Checkbox(
        //               value:_isChecked,
        //
        //               side: BorderSide(width: 1.5, color: AppColors.primaryColor.withOpacity(0.1)),
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(7)),
        //               splashRadius: 5,
        //               checkColor: AppColors.whiteColor,
        //               activeColor:AppColors.secandaryTextColor,
        //               onChanged: (value){
        //                 setState(() {
        //                   _isChecked = value!;
        //                 });
        //               }),
        //
        //           Text(
        //             'I agree with this ',
        //             overflow: TextOverflow.ellipsis,
        //             style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w400,color: Get.theme.disabledColor),
        //           ),
        //
        //           Text(
        //             'Terms of Use',
        //             overflow: TextOverflow.ellipsis,
        //             style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w400,color: Get.theme.primaryColor),
        //           ),
        //
        //         ],
        //       ),
        //
        //       ///I agree with this Terms of Use
        //
        //       Row(
        //         children: [
        //           Checkbox(
        //               value:_isCheckedPrivacy,
        //
        //               side: BorderSide(width: 1.5, color: AppColors.primaryColor.withOpacity(0.1)),
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(7)),
        //               splashRadius: 5,
        //               checkColor: AppColors.whiteColor,
        //               activeColor:AppColors.secandaryTextColor,
        //               onChanged: (value){
        //                 setState(() {
        //                   _isCheckedPrivacy = value!;
        //                 });
        //               }),
        //
        //           Text(
        //             'I agree with',
        //             overflow: TextOverflow.ellipsis,
        //             style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w400,color: Get.theme.disabledColor),
        //           ),
        //
        //           Text(
        //             ' Privacy Policy',
        //             overflow: TextOverflow.ellipsis,
        //             style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w400,color: Get.theme.primaryColor),
        //           ),
        //
        //         ],
        //       ),
        //
        //
        //       ///Button
        //
        //        SizedBox(height: Dimensions.paddingSizeDefault.h,),
        //        Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //
        //         /// Decline Button
        //
        //          OutlinedButton(
        //          style: ElevatedButton.styleFrom(
        //            shape: RoundedRectangleBorder(
        //                borderRadius: BorderRadius.circular(18.r),
        //               side: BorderSide(color:Get.theme.primaryColor,width: 2)
        //            ),
        //            minimumSize:Size(166.w, 58.h),
        //          ),
        //           onPressed: (){},
        //            child:Text(AppString.declineText.tr,style: AppStyles.h3(fontWeight: FontWeight.w600,color:Get.theme.primaryColor),)),
        //
        //    ///Accept Button
        //
        //     CustomButton(
        //   height: 58.h,
        //   loading: _privecyCtrl.termOffUsersLoading.value,
        //   width: 166.w,
        //   onTap: (){
        //
        //     _privecyCtrl.termsOffUseAccept(_privecyCtrl.privecyModel.value.id!, _isChecked, _isCheckedPrivacy);
        //   },
        //   text: AppString.acceptText.tr)
        //
        //   ],
        // ),
        //
        //       SizedBox(height: Dimensions.paddingSizeDefault.h,),

            ],
          ),
        ),
      )),
    );
  }
}
