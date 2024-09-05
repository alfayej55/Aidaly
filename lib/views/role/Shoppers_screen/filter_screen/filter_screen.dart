import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/views/base/custom_button.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../../controllers/Role/Shopper_Controllar/filter_controller.dart';
import '../../../../controllers/Role/Shopper_Controllar/home_controller.dart';
import '../../../../controllers/Role/Shopper_Controllar/shop_controller.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/enamdata.dart';
import '../../../../utils/style.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  HomeController homeCtrl = Get.put(HomeController());

  bool _isChecked = false;

  // var categoric = [
  //   'All',
  //   'Dresses',
  //   'Outerwear',
  //   'Accessories',
  //   'Sales',
  //   'New Arrival '
  // ];
  @override
  void initState() {
    homeCtrl.filtertCatgegori();
    // TODO: implement initState
    super.initState();
  }

  SfRangeValues _values = SfRangeValues(0.0, 1000.0);

  double _value = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            AppString.filtersearchText.tr,
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
      body: Obx(()=>homeCtrl.filterLoading.value?CustomPageLoading(): SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            /// >>>>>>>>>>>>>>>>>>>>>>>>>> All Categories >>>>>>>>>>>>>>>>>>>>>>>>
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    AppString.allcategoriesText.tr,
                    style: AppStyles.customSize(size: 16),
                  ),
                ),

                ListView.builder(
                  itemCount: homeCtrl.filterCategoriModel.value.data!.attributes!.allProducts!.length + 1,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // "Select All" checkbox at the top
                      bool _isAllChecked = homeCtrl.selected.length == homeCtrl.filterCategoriModel.value.data!.attributes!.allProducts!.length;

                      return CheckboxListTile(
                        value: _isAllChecked,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Select All",
                          style: AppStyles.customSize(size: 14, color: AppColors.textColor),
                        ),
                        side: BorderSide(
                          color: Get.theme.disabledColor.withOpacity(0.5),
                          width: 2.w,
                        ),
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              homeCtrl.selected.clear();
                              if (value) {
                                homeCtrl.filterCategoriModel.value.data!.attributes!.allProducts!.forEach((product) {
                                  homeCtrl.selected.add(product.name);
                                });
                              }
                              print("Select Value>>${homeCtrl.selected}");
                            }
                          });
                        },
                      );
                    } else {
                      // Regular item checkboxes
                      var data = homeCtrl.filterCategoriModel.value.data!.attributes!.allProducts![index - 1];
                      bool _isChecked = homeCtrl.selected.value.contains(data.name);

                      return CheckboxListTile(
                        value: _isChecked,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "${data.name}",
                          style: AppStyles.customSize(size: 14, color: AppColors.textColor),
                        ),
                        side: BorderSide(
                          color: Get.theme.disabledColor.withOpacity(0.5),
                          width: 2.w,
                        ),
                        checkColor: Colors.white,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                homeCtrl. selected.value.add(data.name);

                              } else {
                                homeCtrl.selected.remove(data.name);
                              }
                              // No need to manually add/remove "Select All" to/from the list
                              print("Select Value>>${homeCtrl.selected}");
                            }
                          });
                        },
                      );
                    }
                  },
                )


              ],
            ),

            SizedBox(height: 30.h),
            ///>>>>>>>>>>>>>>>>> Divider >>>>>>>>>>>>>>>>>>>>>>
            Divider(
              thickness: 0.2,
              indent: 34.w,
              endIndent: 34.w,
              color: AppColors.textColor.withOpacity(0.4),
            ),

            /// >>>>>>>>>>>>>>>>>>>>>>>>>> Price Range >>>>>>>>>>>>>>>>>>>>>>>>

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    AppString.pricepangeText.tr,
                    style: AppStyles.customSize(size: 16),
                  ),
                ),
                SizedBox(
                  height: 65.h,
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.w),
                  child: SfRangeSlider(
                    min: 0.0,
                    max: 1000.0,
                    values: _values,
                    interval: 20,
                    shouldAlwaysShowTooltip: true,
                    showTicks: true,
                    showLabels: false,
                    enableTooltip: false,
                    minorTicksPerInterval: 0,
                    activeColor: Get.theme.primaryColor,
                    stepSize: 5,
                    inactiveColor: Colors.white,
                    onChanged: (dynamic value) {
                      setState(() {
                        _values = value;
                        homeCtrl.startPrice.value=_values.start;
                        homeCtrl.endPrice.value=_values.end;
                        print("Price State>>>${homeCtrl.startPrice}");
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(
              height: Dimensions.paddingSizeExtraSmall.h,
            ),

            /// >>>>>>>>>>>>>>>>>>>>>>>>>> Location >>>>>>>>>>>>>>>>>>>>>>>>

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 24.w),
            //       child: Text(
            //         AppString.locationText.tr,
            //         style: AppStyles.customSize(size: 16),
            //       ),
            //     ),
            //     SizedBox(
            //       height: Dimensions.paddingSizeExtraLarge.h,
            //     ),
            //     SfSlider(
            //       min: 0.0,
            //       max: 100.0,
            //       value: _value,
            //       interval: 10,
            //       showTicks: true,
            //       showLabels: true,
            //       shouldAlwaysShowTooltip: true,
            //       inactiveColor: Colors.grey.withOpacity(0.5),
            //       enableTooltip: true,
            //       minorTicksPerInterval: 1,
            //       onChanged: (dynamic value) {
            //         setState(() {
            //           _value = value;
            //         });
            //       },
            //     ),
            //   ],
            // ),

            SizedBox(
              height: Dimensions.paddingSizeExtraLarge.h,
            ),

            /// >>>>>>>>>>>>>>>>>>>>>>>>>> Button >>>>>>>>>>>>>>>>>>>>>>>>

            Align(
                alignment: Alignment.center,
                child: CustomButton(
                  loading: homeCtrl.firstLoading.value,
                    onTap: (){
                  homeCtrl.shopperHomeFirsLoad();
                  Get.back();
                }, text: AppString.applyText.tr)),

            SizedBox(
              height: Dimensions.paddingSizeExtraLarge.h,
            ),
          ],
        ),
      ))

    );
  }
}
