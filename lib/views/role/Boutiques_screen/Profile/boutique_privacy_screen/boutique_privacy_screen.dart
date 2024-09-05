import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/Role/privecyPolicy_controller.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';
class BoutiquePrivacyScreen extends StatefulWidget {
   BoutiquePrivacyScreen({super.key});

  @override
  State<BoutiquePrivacyScreen> createState() => _BoutiquePrivacyScreenState();
}

class _BoutiquePrivacyScreenState extends State<BoutiquePrivacyScreen> {

  PrivecyPolicyController _privecyCtrl = Get.put(PrivecyPolicyController());

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
            AppString.privacyPolicyText.tr,
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
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(()=> _privecyCtrl.privecyLoading.value
            ? Center(child: CustomPageLoading()): SingleChildScrollView(

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
                    
                    
                    
                        ],
                      ),
            )),
      
      ),
    );
  }
}
