

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class BoutiqueProfileEditControllart extends GetxController{

TextEditingController fullNameCtrl=TextEditingController();
TextEditingController emailCtrl=TextEditingController();
TextEditingController phoneCtrl=TextEditingController();
TextEditingController addressCtrl=TextEditingController();
TextEditingController cityCtrl=TextEditingController();
TextEditingController stateCtrl=TextEditingController();

  File? selectedIMage;
  var imagePath=''.obs;
  DateTime? selectedDate;

  Future pickImageFromCamera(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    selectedIMage = File(returnImage.path);
    imagePath.value=selectedIMage!.path;
    //  image = File(returnImage.path).readAsBytesSync();
    update();
    print('ImagesPath:${imagePath}');
    Get.back(); //
  }
}