
import 'dart:convert';
import 'dart:io';

import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/Role/DriverModel/driver_vehicle_details.model.dart';
import '../../../service/api_check.dart';
import '../../../service/api_client.dart';
import '../../../service/api_constants.dart';

class VehicleUpdateControllar extends GetxController{


  TextEditingController makeCtrl=TextEditingController();
  TextEditingController modelCtrl=TextEditingController();
  TextEditingController yearCtrl=TextEditingController();
  TextEditingController registerCtrl=TextEditingController();

  RxString driverLicenseImage=''.obs;
  RxString driverRegistrationImage=''.obs;
  RxString driverPoliceCheckImage=''.obs;
  var vechicleLoading = false.obs;

  Rx<DriverVehicleModel> vehicleModelList= DriverVehicleModel().obs;


  var getVechicleLoading=false.obs;



  vehicleDetails()async{
    getVechicleLoading(true);
    var responce=await ApiClient.getData(ApiConstant.driverGetVehicleEndPoint);  
    
    if(responce.statusCode==200){
      vehicleModelList.value=DriverVehicleModel.fromJson(responce.body["data"]["attributes"][0]);
      var data=vehicleModelList.value;
      makeCtrl.text=data.make !=null?data.make!:"123";
      modelCtrl.text=data.model!;
      yearCtrl.text=data.year!;
      registerCtrl.text= data.registrationNumber!;

      // driverLicenseImage.value="${data.driverLicense!.destination}/${data.driverLicense!.filename}";
      // driverRegistrationImage.value="${data.registration!.destination}/${data.registration!.filename}";
      // driverPoliceCheckImage.value="${data.policeCheck!.destination}/${data.policeCheck!.filename}";


      getVechicleLoading(false);
      update();
    }
    else{
      ApiChecker.checkApi(responce);
      getVechicleLoading(false);
      update();
    }
  }

  


  ///  Vehicle Update

  void driverVehicleUpdate() async {
    vechicleLoading.value = true;

    Map<String, String> body = {
      'model': modelCtrl.text,
      'year': yearCtrl.text,
      'make': makeCtrl.text,
      'registrationNumber': registerCtrl.text
    };

    List<MultipartBody> multipartList = [];

    if (driverLicenseImage.value.isNotEmpty) {
      multipartList.add(MultipartBody("driverLicense", File(driverLicenseImage.value)));
    }
    if (driverRegistrationImage.value.isNotEmpty) {
      multipartList.add(MultipartBody("registration", File(driverRegistrationImage.value)));
    }
    if (driverPoliceCheckImage.value.isNotEmpty) {
      multipartList.add(MultipartBody("policeCheck", File(driverPoliceCheckImage.value)));
    }

    var response = await ApiClient.patchMultipartData(
      ApiConstant.driverVehicleUpdate,
      body,
      multipartBody: multipartList,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      Get.offAllNamed(AppRoutes.driversProfileScreen);
      vechicleLoading.value = false;
      update();
    } else {
      print('checkvehicalDetails>> ${response.body}');
      ApiChecker.checkApi(response);
      vechicleLoading.value = false;
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