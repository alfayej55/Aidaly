import 'package:aidaly/Utils/app_constants.dart';
import 'package:aidaly/views/base/custom_text_field.dart';
import 'package:aidaly/views/base/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/custom_button.dart';

class SuggestedTipsWidget extends StatefulWidget {
  SuggestedTipsWidget({super.key});

  @override
  State<SuggestedTipsWidget> createState() => _SuggestedTipsWidgetState();
}

class _SuggestedTipsWidgetState extends State<SuggestedTipsWidget> {
  final List<double> tips = [0.05, 0.10, 0.15];

  AddToCartControllar productAddtoCartCtrl = Get.put(AddToCartControllar());

  @override
  Widget build(BuildContext context) {
    // return Obx(() => Row(
    //   children: List.generate(
    //     tips.length,
    //         (index) => InkWell(
    //       onTap: () {
    //         // Check if the tip is already selected
    //         bool isSelected = productAddtoCartCtrl.selectedtips.value == tips[index];
    //         // Toggle selection
    //         if (isSelected) {
    //           // Deselect if already selected
    //           productAddtoCartCtrl.selectedtips.value = 0;
    //           productAddtoCartCtrl.totalPriceCalculation();
    //         } else {
    //           productAddtoCartCtrl.selectedtips.value = tips[index];
    //           productAddtoCartCtrl.totalPriceCalculation();
    //         }
    //         print('Tips ${productAddtoCartCtrl.selectedtips.value}');
    //       },
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 5.w),
    //         child: Container(
    //           height: 55.h,
    //           width: 55.w,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(16).r,
    //             border: Border.all(
    //               color: productAddtoCartCtrl.selectedtips.value == tips[index]
    //                   ? Get.theme.primaryColor
    //                   : Get.theme.primaryColor.withOpacity(0.2),
    //               width: 1.5,
    //             ),
    //           ),
    //           child: Center(
    //             child: Text(
    //               '${(tips[index]*100).toInt()}%', // Convert to percentage format
    //               style: AppStyles.customSize(size: 18, fontWeight: FontWeight.w500),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ));


    return SizedBox(
      height: 60.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tips.length + 1,
        itemBuilder: (context, index) {
          if (index < tips.length) {
            return InkWell(
              onTap: () {
                // Check if the tip is already selected
                bool isSelected = productAddtoCartCtrl.selectedtips.value == tips[index];
                // Toggle selection
                if (isSelected) {
                  // Deselect if already selected
                  productAddtoCartCtrl.selectedtips.value = 0;
                  productAddtoCartCtrl.totalPriceCalculation();
                } else {
                  productAddtoCartCtrl.selectedtips.value = tips[index];
                  productAddtoCartCtrl.totalPriceCalculation();
                }
                print('Tips ${productAddtoCartCtrl.selectedtips.value}');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 55.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16).r,
                    border: Border.all(
                      color: productAddtoCartCtrl.selectedtips.value == tips[index]
                          ? Get.theme.primaryColor
                          : Get.theme.primaryColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${(tips[index] * 100).toInt()}%', // Convert to percentage format
                      style: AppStyles.customSize(size: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                showTipsDialoag(context);
                print('Add new tip');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: 55.h,
                  width: 55.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16).r,
                    border: Border.all(
                      color: Get.theme.primaryColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Edit',
                      style: AppStyles.customSize(size: 18, fontWeight: FontWeight.w500, color: AppColors.textColor),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );



  }

  showTipsDialoag(BuildContext context) {
    TextEditingController tipsCont = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add A New Tip',
            style: AppStyles.h3(color: AppColors.textColor),
          ),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: tipsCont,

              ),
              SizedBox(height: 20.h),
              CustomButton(
                onTap: () {
                  var demoTips = double.parse(tipsCont.text) / 100;
                  // Check if the input is a valid number
                  if (!tips.contains(demoTips)) {

                    setState(() {
                      tips.add(demoTips);
                      print("ajdkha>>${tips.length}");
                    });
                    Get.back();
                    // Optionally, update any related controllers or state here
                  } else {
                    showToastMessage.showMessage("Tip already exists .Please Select This Tips");
                    print("Tip already exists");
                  }
                },
                text: 'Add',
              ),
            ],
          ),
        );
      },
    );
  }
}
