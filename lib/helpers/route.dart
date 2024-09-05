import 'package:aidaly/views/Onboarding/onboarding_screen.dart';
import 'package:aidaly/views/RoleSelectScreen/role_select.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/all_drivers_Screen/all_drivers_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/all_order_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/boutique_track_order_screen/boutique_track_order.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/canceled_Screen/canceled_details_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/All_Order/inProgress_Screen/inProgress_Screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Boutique_Auth_section/verification_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Home_screen/boutique_home_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/MyProducts/Add_New_Product/add_new_product.dart';
import 'package:aidaly/views/role/Boutiques_screen/MyProducts/my_Product_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/MyProducts/under_review_screen/under_review_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_change_password_screen/boutique_change_password_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_edit_profile_screen/boutique_edit_profile.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_help_screen/boutique_help_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_language_screen/boutique_language_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_notification_setting/boutique_notification_setting.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_privacy_screen/boutique_privacy_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_terms_and_use_screen/boutique_terms_and_use_screen.dart';
import 'package:aidaly/views/role/Boutiques_screen/Profile/boutique_profile_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Driver_Auth_section/forgot_password/driver_forgot_otp_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Driver_Auth_section/login_screen/login_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Driver_Auth_section/vehicle_detail_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Driver_Auth_section/verification_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Driver_Order_tracking/driver_order_completed_success_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Driver_chat_history_screen/driver_chat_history_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Drivers_AssignOrder_Screen/delivered_Screen/delivered_details_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Drivers_AssignOrder_Screen/drivers_assign_orders_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Drivers_AssignOrder_Screen/drivers_canceled_Screen/canceled_details_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Drivers_AssignOrder_Screen/drivers_inProgress_screen/drivers_inProgress_details_screen.dart';
import 'package:aidaly/views/role/Drivers_screen/Drivers_HomeScreen/drivers_home_screen.dart';
import 'package:aidaly/views/role/Shoppers_screen/Home/search_screen.dart';
import 'package:aidaly/views/role/Shoppers_screen/Profile/chat_history_screen/shopper_chat_inbox_screen.dart';
import 'package:aidaly/views/role/Shoppers_screen/Profile/my_order/my_order_screen.dart';
import 'package:aidaly/views/role/Shoppers_screen/WishList/wishlist_folder_screen.dart';
import 'package:aidaly/views/role/Shoppers_screen/Shop/checkout_screen/innerWidget/delivery_location.dart';
import 'package:aidaly/views/role/Shoppers_screen/Shopper_Auth_section/login_screen/login_screen.dart';
import 'package:aidaly/views/role/Shoppers_screen/Shopper_Auth_section/verification_screen/verification_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/change_password_screen/change_password_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/chat_history_screen/chat_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/edit_profile_screen/edit_profile.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/help_screen/help_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/language_screen/language_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/notification_setting/notification_setting.dart';
import 'package:aidaly/views/role/shoppers_screen/Profile/privacy_screen/privacy_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Shop/add_rating_screen/add_rating_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Shop/add_to_cart_screen/add_to_cart_screen.dart';
// import 'package:aidaly/views/role/shoppers_screen/Shop/boutique_detailsScreen/%20boutique_details.dart';
import 'package:aidaly/views/role/shoppers_screen/Shop/checkout_screen/checkout_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Shop/order_booking_screen/order_booking_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Shop/product_details_screen/product_details_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/Shop/shop_screen/shop_sceen.dart';

import 'package:aidaly/views/role/shoppers_screen/notification_screen/notification_screen.dart';
import 'package:aidaly/views/role/shoppers_screen/order_track_screen/order_track_screen.dart';
import 'package:get/get.dart';
import '../views/Splash/splash_screen.dart';

import '../views/role/Boutiques_screen/All_Order/delivered_Screen/delivered_details_screen.dart';

import '../views/role/Boutiques_screen/All_Order/inProgress_Screen/order_details.dart';
import '../views/role/Boutiques_screen/All_Order/newOrder_Screen/new_order_details_screen/new_order_details_screen.dart';
import '../views/role/Boutiques_screen/All_Order/orde_success_screen/orde_assigned_screen.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/forgot_password_verification.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/waitlist_screen.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/account_successfull.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/forgot_password_screen.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/set_new_password_sceen.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/login_screen/login_screen.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/set_location_screen.dart';
import '../views/role/Boutiques_screen/Boutique_Auth_section/singup_screen/singup_screen.dart';
import '../views/role/Boutiques_screen/boutique_chat_history_screen/boutique_chat_inbox_screen.dart';
import '../views/role/Boutiques_screen/Profile/Withdrawal_screen/withdrawal_screen.dart';
import '../views/role/Boutiques_screen/Profile/boutique_bank_info_screen/add_new_bank_screen.dart';
import '../views/role/Boutiques_screen/Profile/boutique_bank_info_screen/boutique_bank_info_screen.dart';
import '../views/role/Boutiques_screen/Profile/boutique_review_screen/boutique_review_screen.dart';
import '../views/role/Boutiques_screen/boutique_chat_history_screen/boutique_chat_history_screen.dart';
import '../views/role/Drivers_screen/Driver_Auth_section/waitlist_screen.dart';
import '../views/role/Drivers_screen/Driver_Auth_section/account_successfull.dart';
import '../views/role/Drivers_screen/Driver_Auth_section/forgot_password/forgot_password_screen.dart';
import '../views/role/Drivers_screen/Driver_Auth_section/forgot_password/set_new_password_sceen.dart';
import '../views/role/Drivers_screen/Driver_Auth_section/set_location_screen.dart';
import '../views/role/Drivers_screen/Driver_Auth_section/singup_screen/singup_screen.dart';
import '../views/role/Drivers_screen/Driver_Order_tracking/driver_Order_tracking_screen.dart';
import '../views/role/Drivers_screen/Driver_chat_history_screen/driver_caht_inbox.dart';
import '../views/role/Drivers_screen/Drivers_HomeScreen/new_order_details_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/Withdrawal_screen/withdrawal_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_bank_info_screen/add_new_bank_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_bank_info_screen/driver_bank_info_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_change_password_screen/driver_change_password_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_edit_profile_screen/driver_edit_profile.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_edit_vehicle_screen/driver_edit_vehicle_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_help_screen/driver_help_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_language_screen/driver_language_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_notification_setting/driver_notification_setting.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_privacy_screen/driver_privacy_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_terms_and_use_screen/driver_terms_and_use_screen.dart';
import '../views/role/Drivers_screen/Drivers_ProfileScreen/driver_profile_screen.dart';
import '../views/role/Boutiques_screen/Profile/boutique_terms_and_use_screen/terms_accept_screen.dart';
import '../views/role/Shoppers_screen/Shop/boutique_detailsScreen/boutique_details.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/WaitlistScreen/waitlist_screen.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/account_successfull_screen/account_successfull.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/forgot_password/forgot_otp_screen.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/forgot_password/forgot_password_screen.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/forgot_password/set_new_password_sceen.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/set_location/set_location_screen.dart';
import '../views/role/Shoppers_screen/Shopper_Auth_section/singup_screen/singup_screen.dart';
import '../views/role/Shoppers_screen/WishList/wishlist_screen.dart';
import '../views/role/Shoppers_screen/filter_screen/filter_screen.dart';
import '../views/role/shoppers_screen/Home/home_screen.dart';
import '../views/role/shoppers_screen/Profile/profile_screen.dart';
import '../views/role/shoppers_screen/Profile/terms_and_use_screen/terms_and_use_screen.dart';
import '../views/role/shoppers_screen/Shop/addNewCart_screen/add_new_cart_screen.dart';
import '../views/role/shoppers_screen/Shop/product_screen/product_screen.dart';



class AppRoutes{


  /// ................................Shopper ................................

  static String splashScreen="/splash_screen";
  static String homeScreen="/home_screen";
  static String profileScreen="/profile_screen";
  static String wishListScreen="/wishlist_screen";
  static String shopScreen="/shop_screen";
  static String onBoardingScreen="/onboarding_screen";
  static String  roleSelectScreen="/roleSelect_screen";

  static String  loginScreen="/login_screen";
  static String  singUpScreen="/singUp_screen";
  static String  waitListScreen="/waitList_screen";
  static String  locationScreen="/location_screen";
  static String  shopperverificationScreen="/shopperverification_screen";
  static String  accountSuccessScreen="/accountSuccess_screen";
  static String  forgotScreen="/forgotpassword_screen";
  static String  setNewPasswordScreen="/setNewPassword_screen";
  static String  forgotPassOtpScreen="/forgotPassOtp_screen";

  static String  productScreen="/product_screen";
  static String  boutiqueScreen="/boutique_screen";
  static String  productDetailsScreen="/productDetails_screen";
  static String  addToCartScreen="/addToCart_screen";
  static String  checkoutScreen="/checkout_screen";
  static String  addCartScreen="/addcart_screen";
  static String  orderBookingScreen="/orderbooking_screen";
  static String  ratingScreen="/rating_screen";

  static String  notificationScreen="/notification_screen";
  static String  filterScreen="/filter_screen";
  static String  orderTrackScreen="/orderTrack_screen";
  static String  editprofileScreen="/editProfile_screen";
  static String  notificationSettingScreen="/notificationSetting_screen";
  static String  privacyScreen="/privacy_screen";
  static String  termsAndUseScreen="/termsAndUse_screen";
  static String  helpScreen="/help_screen";
  static String  passwordCheangeScreen="/passwordCheange_screen";
  static String  chatHistoryScreen="/chatHistory_screen";
  static String  languageScreen="/languages_screen";
  static String  deliveryLocationScreen="/deliveryLocation_screen";
  static String   myOrderScreen="/myOrder_screen";
  static String   wishListFolderScreen="/wishlist_folder_screen";
  static String   shopperInboxScreen="/shopperInbox_screen";
  static String   shoppeSearchBoxScreen="/shopperInbox_screen";


  /// ................................ Boutique  ................................



  static String  boutiqueloginScreen="/boutiquelogin_screen";
  static String  boutiquesingUpScreen="/boutiquesingUp_screen";
  static String  boutiquewaitListScreen="/boutiquewaitList_screen";
  static String  boutiquelocationScreen="/boutiquelocation_screen";
  static String  boutiqueaccountSuccessScreen="/boutiqueaccountSuccess_screen";
  static String  boutiqueforgotScreen="/boutiqueforgotpassword_screen";
  static String  boutiquesetNewPasswordScreen="/boutiquesetNewPassword_screen";
  static String  boutiquevarificationScreen="/boutiquevarification_screen";
  static String  boutiqueForgotvarificationScreen="/boutiqueForgotvarification_screen";

  static String  homeBoutique="/homeBoutique_screen";
  static String  myProductBoutiqueScreen="/myProductBoutique_screen";
  static String  allOrdertBoutiqueScreen="/allOrdertBoutique_screen";
  static String  boutiqueProfileScreen="/boutiqueProfile_screen";
  static String  addNewProductScreen="/addNewProduct_screen";
  static String  underReviewScreen="/underReview_screen";
  static String  orderDetailsScreen="/orderDetails_screen";
  static String  orderinprogressScreen="/orderinprogress_screen";
  static String  inProgressDetailsScreen="/inProgressDetails_screen";
  static String  orderAssignScreen="/orderAssign_screen";
  static String  allDriversScreen="/allDrivers_screen";
  static String  canceledDetailsScreen="/cancledDetaile_screen";
  static String  deliveredDetailsScreen="/deliveredDetails_screen";
  static String  boutiquesTrackOrderScreen="/boutiquesTrackOrder_screen";
  static String  boutiqueChatHistoryScreen="/boutiqueChatHistory_screen";
  static String  boutiqueChatScreen="/boutiqueChatScreen_screen";

  static String  boutiqueChangePasswordScreen="/boutiqueChangePassword_screen";
  static String  boutiqueEditProfileScreen="/boutiqueEditProfile_screen";
  static String  boutiqueHelpScreenScreen="/boutiqueHelpScreen_screen";
  static String  boutiqueLanguageScreen="/boutiqueLanguage_screen";
  static String  boutiqueNotificationSettingScreen="/boutiqueNotificationSetting_screen";
  static String  boutiquePrivacyScreen="/boutiquePrivacy_screen";
  static String  boutiqueTermAndUseScreen="/boutiqueTermAndUse_screen";
  static String  boutiqueWithdrawalScreen="/boutiqueWithdrawal_screen";
  static String  boutiqueBankInfoScreen="/boutiqueBankInfo_screen";
  static String  boutiqueAddNewBankScreen="/boutiqueAddNewBank_screen";
  static String  boutiqueShopperReviewScreen="/boutiqueShopperReview_screen";
  static String  boutiqueTermAcceptSuccessScreen="/boutiqueTermAcceptSuccess_screen";



  ///.......................... Drivers..........................................


  static String  driversloginScreen="/driverslogin_screen";
  static String  driverssingUpScreen="/driverssingUp_screen";
  static String  driverswaitListScreen="/driverswaitList_screen";
  static String  driverslocationScreen="/driverslocation_screen";
  static String  driversaccountSuccessScreen="/driversaccountSuccess_screen";
  static String  driversforgotScreen="/driversforgotpassword_screen";
  static String  driververificationScreen="/driververification_screen";
  static String  driverssetNewPasswordScreen="/driverssetNewPassword_screen";
  static String  driverVehicleScreenScreen="/driverVehicleScreen_screen";
  static String  driverforgotOtpScreen="/driverforgotOtpScreen_screen";

  static String  driversHomeScreen="/driversHome_screen";
  static String  driversnewOrderDetails="/newOrderDetails_screen";
  static String  driversAssignOrdersScreen="/driversAssignOrders_screen";
  static String  driversProfileScreen="/driversProfile_screen";
  static String  driversInProgressDetailsScreen="/driversInProgressDetails_screen";
  static String  driversCancledDetailsScreen="/driversdriversCancledDetails_screen";
  static String  driversDeliveredDetailsScreen="/driversDeliveredDetails_screen";
  static String  driversOrderTrackingScreen="/driversOrderTracking_screen";
  static String  driversOrderSuccessFullScreen="/driversOrderSuccessFull_screen";


  static String  driversChangePasswordScreen="/driversChangePassword_screen";
  static String  driversEditProfileScreen="/driversEditProfile_screen";
  static String  driversHelpScreenScreen="/driversHelpScreen_screen";
  static String  driversLanguageScreen="/driversLanguage_screen";
  static String  driversNotificationSettingScreen="/driversNotificationSetting_screen";
  static String  driversPrivacyScreen="/driversPrivacy_screen";
  static String  driversTermAndUseScreen="/driversTermAndUse_screen";
  static String  driversWithdrawalScreen="/driversWithdrawal_screen";
  static String  driversBankInfoScreen="/driversBankInfo_screen";
  static String  driversAddNewBankScreen="/driverseAddNewBank_screen";
  static String  driverEditVehicleScreen="/driversdriverEditVehicle_screen";
  static String  driverChatHistoryScreen="/driverChatHistory_screen";
  static String  driverChatInboxScreen="/driverChatInbox_screen";


 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=> SplashScreen()),
    GetPage(name:homeScreen, page: ()=> HomeScreen(),transition:Transition.noTransition),
    GetPage(name:shopScreen, page: ()=> ShopScreen(),transition:Transition.noTransition),
    GetPage(name:wishListScreen, page: ()=> WishListScreen(),transition:Transition.noTransition),
    GetPage(name:profileScreen, page: ()=> ProfileScreen(),transition: Transition.noTransition),
    GetPage(name:onBoardingScreen, page: ()=> OnboardingScreen()),
    GetPage(name:roleSelectScreen, page: ()=> RoleSelectPage()),


   /// ................................Shopper ................................

    GetPage(name:loginScreen, page: ()=> ShopperLoginScreen()),
    GetPage(name:singUpScreen, page: ()=> ShopperSingUpScreen()),
    GetPage(name:waitListScreen, page: ()=> ShopperWaitListScreen()),
    GetPage(name:locationScreen, page: ()=> ShopperSetLocationScreen()),
    GetPage(name:accountSuccessScreen, page: ()=> ShopperAccountSuccessFullScreen()),
    GetPage(name:forgotScreen, page: ()=> ShopperForgotPasswortScreen()),
    GetPage(name:shopperverificationScreen, page: ()=> ShopperVerificationScreen()),
    GetPage(name:setNewPasswordScreen, page: ()=> ShopperSetNewPasswordScreen()),
    GetPage(name:forgotPassOtpScreen, page: ()=> ShopperForgotOtpScreen()),
    GetPage(name:productScreen, page: ()=> ProductScreen()),
    GetPage(name:boutiqueScreen, page: ()=> BoutiqueDetails()),
    GetPage(name:productDetailsScreen, page: ()=> ProductDetailsScreen()),
    GetPage(name:addToCartScreen, page: ()=> AddToCartScreen()),
    GetPage(name:checkoutScreen, page: ()=> CheckOutScreen()),
    GetPage(name:addCartScreen, page: ()=> AddCartScreen()),
    GetPage(name:orderBookingScreen, page: ()=> OrderBookedSuccessScreen()),
    GetPage(name:orderTrackScreen, page: ()=> OrderTrackScreen()),
    GetPage(name:myOrderScreen, page: ()=> ShopperMyOrderScreen()),
    GetPage(name:shoppeSearchBoxScreen, page: ()=> SearchScreen()),
    GetPage(name:ratingScreen, page: ()=> RatingAndReivewScreen()),

    GetPage(name:notificationScreen, page: ()=> NotificationScreen()),
    GetPage(name:filterScreen, page: ()=> FilterScreen()),

    GetPage(name:editprofileScreen, page: ()=> EditProfileScreen()),
    GetPage(name:notificationSettingScreen, page: ()=> NotificationSettingScreen()),
    GetPage(name:privacyScreen, page: ()=> PrivacyScreen()),
    GetPage(name:termsAndUseScreen, page: ()=> TermsAndUseScreen()),
    GetPage(name:passwordCheangeScreen, page: ()=> ChangepassWordScreen()),
    GetPage(name:helpScreen, page: ()=> HelpAndSupportScreen()),
    GetPage(name:chatHistoryScreen, page: ()=> ChatHistoryScreen()),
    GetPage(name:languageScreen, page: ()=> LanguageScreen()),
    GetPage(name:deliveryLocationScreen, page: ()=> DeliveryLocation()),
    GetPage(name:wishListFolderScreen, page: ()=> WishListFolderScreen(),transition:Transition.noTransition),
    // GetPage(name:wishListFolderScreen, page: ()=> WishListFolderScreen()),
    GetPage(name:shopperInboxScreen, page: ()=> ShopperInboxScreen()),

   /// ................................ Boutique  ................................


   GetPage(name:boutiqueloginScreen, page: ()=> BoutiqueLoginScreen()),
   GetPage(name:boutiquesingUpScreen, page: ()=> BoutiqueSingUpScreen()),
   GetPage(name:boutiquewaitListScreen, page: ()=> BoutiqueWaitListScreen()),
   GetPage(name:boutiquelocationScreen, page: ()=> BoutiqueSetLocationScreen()),
   GetPage(name:boutiqueaccountSuccessScreen, page: ()=> BoutiqueAccountSuccessFullScreen()),
   GetPage(name:boutiqueforgotScreen, page: ()=> BoutiqueForgotPasswortScreen()),
   GetPage(name:boutiquesetNewPasswordScreen, page: ()=> BoutiqueSetNewPasswordScreen()),
   GetPage(name:boutiquevarificationScreen, page: ()=> BoutiqueVerificationScreen()),
   GetPage(name:boutiqueForgotvarificationScreen, page: ()=> BoutiqueForgotOtpScreen()),
   GetPage(name:boutiqueTermAcceptSuccessScreen, page: ()=> TermAcceptSuccesscScreen()),

   GetPage(name:homeBoutique, page: ()=> BoutiqueHomeScreen(),transition:Transition.noTransition),
   GetPage(name:allOrdertBoutiqueScreen, page: ()=> AllOrderScreen(),transition:Transition.noTransition),
   GetPage(name:myProductBoutiqueScreen, page: ()=> MyProductScreen(),transition:Transition.noTransition),
   GetPage(name:boutiqueProfileScreen, page: ()=> BoutiqueProfileScreen(),transition:Transition.noTransition),
   GetPage(name:addNewProductScreen, page: ()=> AddNewProductScreen(),transition:Transition.noTransition),
   GetPage(name:underReviewScreen, page: ()=> UnderReviewScreen()),
   GetPage(name:orderDetailsScreen, page: ()=> NewOrderDetailsScreen()),
   GetPage(name:orderinprogressScreen, page: ()=> InProgressScreen()),
   GetPage(name:inProgressDetailsScreen, page: ()=> InProgressOrderDetails()),
   GetPage(name:orderAssignScreen, page: ()=> OrderAssignedScreen()),
   GetPage(name:allDriversScreen, page: ()=> AllDriversScreen()),
   GetPage(name:canceledDetailsScreen, page: ()=> CanceledDetails()),
   GetPage(name:deliveredDetailsScreen, page: ()=> DeliveredDetails()),
   GetPage(name:boutiquesTrackOrderScreen, page: ()=> BoutiqueOrderTrackScreen()),
   GetPage(name:boutiqueChatHistoryScreen, page: ()=> BoutiqueChatHistoryScreen()),
   GetPage(name:boutiqueChatScreen, page: ()=> BoutiqueChatInboxScreen()),

   GetPage(name:boutiqueChangePasswordScreen, page: ()=> BoutiqueChangepasswordScreen()),
   GetPage(name:boutiqueEditProfileScreen, page: ()=> BoutiqueEditProfileScreen()),
   GetPage(name:boutiqueHelpScreenScreen, page: ()=> BoutiqueHelpAndSupportScreen()),
   GetPage(name:boutiqueLanguageScreen, page: ()=> BoutiqueLanguageScreen()),
   GetPage(name:boutiqueNotificationSettingScreen, page: ()=> BoutiqueNotificationSettingScreen()),
   GetPage(name:boutiquePrivacyScreen, page: ()=> BoutiquePrivacyScreen()),
   GetPage(name:boutiqueTermAndUseScreen, page: ()=> BoutiqueTermsAndUseScreen()),
   GetPage(name:boutiqueWithdrawalScreen, page: ()=> WithdrawalScreen()),
   GetPage(name:boutiqueBankInfoScreen, page: ()=> BoutiqueBankInfoScreen()),
   GetPage(name:boutiqueAddNewBankScreen, page: ()=> BoutiqueAddNewBank()),
   GetPage(name:boutiqueShopperReviewScreen, page: ()=> BoutiqueShopperReviewScreen()),


///........................... Drivers..........................

   GetPage(name:driversloginScreen, page: ()=> DriverLoginScreen()),
   GetPage(name:driverssingUpScreen, page: ()=> DriverSingUpScreen()),
   GetPage(name:driverswaitListScreen, page: ()=> DriverWaitListScreen()),
   GetPage(name:driverslocationScreen, page: ()=> DriverSetLocationScreen()),
   GetPage(name:driversaccountSuccessScreen, page: ()=> DriverAccountSuccessFullScreen()),
   GetPage(name:driversforgotScreen, page: ()=> DriverForgotPasswortScreen()),
   GetPage(name:driververificationScreen, page: ()=> DriverVerificationScreen()),
   GetPage(name:driverssetNewPasswordScreen, page: ()=> DriverSetNewPasswordScreen()),
   GetPage(name:driverVehicleScreenScreen, page: ()=> DriverVehicleScreen()),
   GetPage(name:driverforgotOtpScreen, page: ()=> DriverForgotOtpScreen()),

   GetPage(name:driversHomeScreen, page: ()=> DriverHomeScreen(),transition: Transition.noTransition),
   GetPage(name:driversnewOrderDetails, page: ()=> DriverNewOrderDetailsScreen()),
   GetPage(name:driversProfileScreen, page: ()=> DriverProfileScreen(),transition: Transition.noTransition),
   GetPage(name:driversAssignOrdersScreen, page: ()=> DriverAssignOrdersScreen(),transition: Transition.noTransition),
   GetPage(name:driversInProgressDetailsScreen, page: ()=> DriversInProgressOrderDetails()),
   GetPage(name:driversCancledDetailsScreen, page: ()=> DriversCanceledDetails()),
   GetPage(name:driversDeliveredDetailsScreen, page: ()=> DriversDeliveredDetails()),
   GetPage(name:driversOrderTrackingScreen, page: ()=> DriverOrderTrackScreen()),
   GetPage(name:driversOrderSuccessFullScreen, page: ()=> DriverOrderCompletedSuccessScreen()),


   GetPage(name:driversChangePasswordScreen, page: ()=> DriverChangepasswordScreen()),
   GetPage(name:driversEditProfileScreen, page: ()=> DriverEditProfileScreen()),
   GetPage(name:driversHelpScreenScreen, page: ()=> DriverHelpAndSupportScreen()),
   GetPage(name:driversLanguageScreen, page: ()=> DriverLanguageScreen()),
   GetPage(name:driversNotificationSettingScreen, page: ()=> DriverNotificationSettingScreen()),
   GetPage(name:driversPrivacyScreen, page: ()=> DriverPrivacyScreen()),
   GetPage(name:driversTermAndUseScreen, page: ()=> DriverTermsAndUseScreen()),
   GetPage(name:driversWithdrawalScreen, page: ()=> DriverWithdrawalScreen()),
   GetPage(name:driversBankInfoScreen, page: ()=> DriverBankInfoScreen()),
   GetPage(name:driversAddNewBankScreen, page: ()=> DriverAddNewBank()),
   GetPage(name:driverEditVehicleScreen, page: ()=> DriverEditVehicleScreen()),
   GetPage(name:driverChatHistoryScreen, page: ()=> DriverChatHistoryScreen()),
   GetPage(name:driverChatInboxScreen, page: ()=> DriverChatInboxScreen()),



  ];

}