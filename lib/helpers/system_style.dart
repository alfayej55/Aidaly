import 'package:flutter/services.dart';

class SystemStyle{


  static dark(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.dark, // Change this to Brightness.dark to set it to light color
    ));

  }
}