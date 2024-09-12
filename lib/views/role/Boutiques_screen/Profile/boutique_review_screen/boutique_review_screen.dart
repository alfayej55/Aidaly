import 'package:aidaly/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../controllers/Role/BoutiquesControllar/boutique_shopper_review_controller.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';
import 'innerWidget/boutique_review.dart';

class BoutiqueShopperReviewScreen extends StatefulWidget {
  const BoutiqueShopperReviewScreen({super.key});

  @override
  State<BoutiqueShopperReviewScreen> createState() =>
      _BoutiqueShopperReviewScreenState();
}

class _BoutiqueShopperReviewScreenState
    extends State<BoutiqueShopperReviewScreen> {
  BoutiqueReviewController _reviewCtrl = Get.put(BoutiqueReviewController());

  @override
  void initState() {
    super.initState();
    _reviewCtrl.boutiqueShopperReviewFirsLoad();
    _reviewCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_reviewCtrl.scrollController.position.pixels ==
        _reviewCtrl.scrollController.position.maxScrollExtent) {
      _reviewCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _reviewCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.boutiqueShoppersReviewsText.tr,
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
      body: Obx(() => _reviewCtrl.firstLoading.value
          ? CustomPageLoading():
      _reviewCtrl.boutiqueReviewModelList.isEmpty?
      Center(child: Text("No Reviews",style:AppStyles.h3(color:AppColors.textColor),))
          : SingleChildScrollView(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
                itemCount: _reviewCtrl.boutiqueReviewModelList.value.length + 1,
                controller: _reviewCtrl.scrollController,
                shrinkWrap: true,
                primary: false,
                // scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index >=
                      _reviewCtrl.boutiqueReviewModelList.value.length) {
                    return _reviewCtrl.firstLoading.value
                        ? CustomPageLoading()
                        : SizedBox();
                  } else {
                    var data = _reviewCtrl.boutiqueReviewModelList.value[index];
                    return BoutiqueShopperReview(
                      revirewInfo: data,
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return Divider(
                      color: Get.theme.dividerColor.withOpacity(0.4));
                },
              ),
          )),
    );
  }
}
