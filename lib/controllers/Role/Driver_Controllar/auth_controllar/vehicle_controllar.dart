import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../helpers/route.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_constants.dart';

 class VehicleControllar extends GetxController{


   TextEditingController makeCtrl=TextEditingController();
   TextEditingController modelCtrl=TextEditingController();
   TextEditingController yearCtrl=TextEditingController();
   TextEditingController registerCtrl=TextEditingController();

   RxString driverLicenseImage=''.obs;
   RxString driverRegistrationImage=''.obs;
   RxString driverPoliceCheckImage=''.obs;
   var vechicleLoading = false.obs;


   ///  Driver  sign up
   void driverVehicleDetails()async{

     vechicleLoading.value=true;

     Map<String, String> body =
     {
       'model':modelCtrl.text,
       'year':yearCtrl.text,
       'make':makeCtrl.text,
       'registrationNumber':registerCtrl.text
     };

     List<MultipartBody> multipartList=[
       MultipartBody("driverLicense",File(driverLicenseImage.value),),
       MultipartBody("registration",File(driverRegistrationImage.value),),
       MultipartBody("policeCheck",File(driverPoliceCheckImage.value),)
     ];

     Response response=await ApiClient.postMultipartData(
         ApiConstant.vehicalDetailsEndPoint,
         body,
         multipartBody:multipartList,
     );

     if (response.statusCode == 200) {

       Fluttertoast.showToast(msg:response.body['message']);
       Get.toNamed(AppRoutes.driverslocationScreen);
       vechicleLoading.value=false;
       modelCtrl.clear();
       yearCtrl.clear();
       makeCtrl.clear();
       update();

     } else {

       print('checkvehicalDetails>> ${response.body}');
       ApiChecker.checkApi(response);
       vechicleLoading.value=false;
       update();
     }

   }

   Future<void> pickImageFromCamera(String docType) async {
     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
     if (pickedImage == null) return;

     // Convert picked image to File
     File pickedFile = File(pickedImage.path);

     // Store image based on document type
     switch (docType) {
       case 'licenseImage':
         driverLicenseImage.value = pickedFile.path;
         update();
         print('driverLicenseImage >>${driverLicenseImage.value}');
         break;
       case 'registrationImage':
         driverRegistrationImage.value = pickedFile.path;
         update();
         print('driverRegistrationImage >>${driverRegistrationImage.value}');
         break;

       case 'policeCheckImage':
         driverPoliceCheckImage.value = pickedFile.path;
         update();
         print('driverRegistrationImage >>${driverRegistrationImage.value}');
         break;
     }

   }

 }