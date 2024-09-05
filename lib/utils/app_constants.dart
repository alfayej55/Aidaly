
import 'package:intl/intl.dart';

import '../models/language_model.dart';
import 'app_Image.dart';

class AppConstants{

  static String APP_NAME="aidaly";

 // static String googleApiKey="AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ";


  // share preference Key
  static String THEME ="theme";

  static String bearerToken="bearerToken";
  static String eventMassage="message";

  static String userId="userId";
  static String userImage="userId";

  static String userRoles="userRole";
  static String shopperLat="shopperLat";
  static String shopperLag="shopperLag";

  static String boutiqueLat="boutiqueLat";
  static String boutiqueLog="boutiqueLag";
  static String boutiqueId="boutiqueId";

  static String fcmToken="fcmToken";

  static String driverId="driverId";

  static String  isProfileCompleted='isProfileCompleted';



  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");

  static String timeAgoFormat(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return DateFormat('MMM d, y H:mm a').format(time);
    }
  }



  static List<LanguageModel> languages = [
    LanguageModel( languageName: 'English', countryCode: 'US', languageCode: 'en',countryFlag:AppImages.englishflagimage),
    LanguageModel( languageName: 'Urdu', countryCode: 'SA', languageCode: 'ar',countryFlag: AppImages.urduflagimage),
    LanguageModel( languageName: 'Spanish', countryCode: 'ES', languageCode: 'es',countryFlag: AppImages.spanishflagimage),
    LanguageModel( languageName: 'Arabic', countryCode: 'AE', languageCode: 'at',countryFlag: AppImages.arabic_flagimage),
    LanguageModel( languageName: 'Afghani', countryCode: 'AF', languageCode: 'ps',countryFlag: AppImages.afghaniflagimage),
    LanguageModel( languageName: 'Australian', countryCode: 'Au', languageCode: 'au',countryFlag: AppImages.australianflagimage),
    LanguageModel( languageName: 'Bangladeshi', countryCode: 'BD', languageCode: 'bn',countryFlag: AppImages.bangladeshflagimage),
    LanguageModel( languageName: 'German', countryCode: 'DE', languageCode: 'de',countryFlag: AppImages.germanflagimage),
    LanguageModel( languageName: 'Italian', countryCode: 'IT', languageCode: 'it',countryFlag: AppImages.italianflagimage),
  ];
}

