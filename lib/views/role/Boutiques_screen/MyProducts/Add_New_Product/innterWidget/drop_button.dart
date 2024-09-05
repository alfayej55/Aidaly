import 'package:aidaly/models/Role/BoutiqueModel/product_categori_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_colors.dart';
import '../controllar/add_new_product_controllar.dart';
class DropButton extends StatelessWidget {
   DropButton({super.key});

   AddNewProductControllar addProductCtrl=Get.put(AddNewProductControllar());

  @override
  Widget build(BuildContext context) {

    return  Obx(() => DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.

        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(width: 1.5)

        ),

        // Add more decoration..
      ),

      items: addProductCtrl.allCategoriModel.value
          .map((item) => DropdownMenuItem<String>(
        value: item.name.toString(),
        child: Text(
          item.name.toString(),
          style:  TextStyle(
              fontSize: 14,
              color: AppColors.textColor
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return "";
        }
        return null;
      },
      onChanged: (value) {

        addProductCtrl.selectedValue.value = value.toString();
        final selectedItem = addProductCtrl.allCategoriModel.value.firstWhere((item) => item.name == value);
        addProductCtrl.selectType.value= selectedItem.sizeType!;
        print('Typeee>>>>>${ addProductCtrl.selectType.value}');

      },
      onSaved: (value) {
        addProductCtrl.selectedValue.value = value.toString();
      },

      buttonStyleData:  ButtonStyleData(
        padding: EdgeInsets.only(right: 12.w),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black45,
        ),
        iconSize:32,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
      ),
      menuItemStyleData:  MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
      ),
    ));

  }
}
