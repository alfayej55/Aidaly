class ApiConstant{
/// google maps

  static String googleBaseUrl="https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String estimatedTimeUrl="https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&";

    static String baseUrl="http://192.168.10.168:3030/api/v1";// local

  //static String baseUrl="http://dapperdriver.com:3030/api/v1";// live

  static String  imageBaseUrl="http://192.168.10.168:3030"; //Local

 // static String  imageBaseUrl="http://dapperdriver.com:3030"; //LIVE

  static String googleApiKey="AIzaSyAszXC1be8aJ37eHuNcBm_-O1clWkPUwV4";


///>>>>>>>>>>>>>>>>>>>>>>>>>>> Shopper End Point>>>>>>>>>>>>>>>>>>>


  static String  profileEndPoint='/user/ProfileOfUser';
  static String  changePasswordEndPoint="/user/changePasswordUseingOldPassword";
  static String  helpSupportEndPoint="/user/supportOfUsers";
  static String  privecyPolicyEndPoint="/user/privecyPolicy";
  static String  messageListEndPoint="/message/getAllChats";

  static String  socialLoginEndPoint="/user/signInWithGoogle";


  static String  shopperSignUpEndPoint="/user/sign-up";
  static String  shopperOtpVerificationPoint="/user/verify-code";
  static String  shopperResentOtpEndPoint="/user/resend";
  static String  shopperSignInEndPoint="/user/sign-in";
  static String  shopperFilterCategoriEndPoint="/product/forFilterCategory";

  static String  shopperSetLocationEndPoint="/user/locations";
  static String  shopperforgotpasswordEndPoint="/user/forgot-password";
  static String  shopperChangeEndPoint="/user/change-password";

  static String  shopCategoriEndPoint="/product/getallCategoryWithProductImage";
  static String  shopSubCategoriEndPoint="/product/showProductByCategory";
  static String  shopProductDetailsiEndPoint="/product/ProductDetails?id=";
  static String  shopProductboutiqueEndPoint="/product/showProductByUserId";
  static String  shopProductCommentEndPoint="/review/getReviewForProduct/";
  static String  shopProductAddCommentEndPoint="/review/createReview";
  static String  paymentCheckoutEndPoint="/order/makeOrder";
 // static String  shopperHomeEndPoint="/product/allProducts"; // old end point
  static String  shopperHomeEndPoint="/admin/showBoutiqueForpromation";
  static String  shopperSearchEndPoint="/admin/showBoutiqueForpromation";
  static String  myOrderEndPoint="/order/showOrderedOfShoper";
  static String  wishListAddEndPoint="/iswish/addwishlist";
  static String  allWishListGetEndPoint="/iswish/getAllWishlist";
  static String  createWishListCollectionEndPoint="/iswish/createWishListCollection";
  static String  wishListFolderNameEndPoint="/iswish/getFoldername";
  static String  wishListFolderEndPoint="/iswish/showWishlistFolderByName";
  static String  orderQuntityCheckEndPoint="/notifaction/createOrderItmes";
  static String  commentLikeEndPoint="/review/makeLike";
  static String  commentReplayEndPoint="/review/makeComment";
  static String  commentReplayShowEndPoint="/review/showComments";

///>>>>>>>>>>>>>>>>>>>>>>>>>>> Boutiquee End Point >>>>>>>>>>>>>>>>>>>

  static String  boutiqueSignUpEndPoint="/user/signUp-Boutique";
  static String  boutiqeAddProductEndPoint="/product/createProduct";
  static String  boutiqueMyProdyctEndPoint="/product/showProductByUser";
  static String  boutiqueallCategoryEndPoint="/product/getallCategory";
  static String  boutiquenewOrderEndPoint="/order/newOrder";
  static String  boutiqueOrderDetailsEndPoint="/order/orderDetails";
  static String  boutiqueNewOrderAcceptEndPoint="/order/orderInprogres";
  static String  boutiqueInProgressOrderEndPoint="/order/orderInprogresShow";
  static String  boutiqueInProgressDetailsOrderEndPoint="/order/inprogresOrderDetails";
  static String  boutiqueAllDriverEndPoint="/order/findNearByDriver";
  static String  boutiqueDriverAssignEndPoint="/order/assignedDriver";
  static String  boutiqueOrderAssignEndPoint="/order/assignedOrderedShow";
  static String  boutiqueDashBoardEndPoint="/order/allOrdersOfBoutique";
  static String  boutiqueOrderTrackEndPoint="/orderTracking/boutiqueTrackingDriver";
  static String  boutiqueOrderDeliveryEndPoint="/order/deliveriedOrder";
  static String  boutiqueShopperReviewEndPoint="/review/showAllReviewOfbotique";
  static String  boutiqueAddNewBankEndPoint="/withdrow/addBankAccount";
  static String  boutiqueShowBankOfuserEndPoint="/withdrow/showBankOfuser";
  static String  boutiquMyProductDeletEndPoint="/product/deleteProduct";


  ///>>>>>>>>>>>>>>>>>>>>>>>>>>> Driver End Point >>>>>>>>>>>>>>>>>>>

  static String  vehicalDetailsEndPoint="/user/vehicalDetails";
  static String  drivernewOrderEndPoint="/order/showNewOrderForDriver";
  static String  driverDashBoardEndPoint="/order/showDriverDashBored";
  static String  driverInprogressEndPoint="/order/getAllinprogressOrderForDriver";
  static String  drivernewOrderDetailsEndPoint="/order/accpetOrderDetails";
  static String  drivernewOrderAcceptEndPoint="/order/newOrderToProgress";
  static String  drivernewOrderCencellEndPoint="/order/cancelledOrderedAsDriver";
  static String  driverinProgressDetailsEndPoint="/order/inprogressDetailsForOrderTrac";
  static String  driverCancelOrderEndPoint="/order/showAllCancellOrder";
  static String  driverCancelOrderDetailsEndPoint="/order/cnacleOrderDetails";
  static String  driverDeliveryEndPoint="/order/deliveriedOrderForDriver";
  static String  driverDeliveryDetailsEndPoint="/order/showDeliveryOrderDetailsForDriver";
  static String  driverTrackOrderDetailsEndPoint="/orderTracking/openTrackerOfGet";
  static String  driverProfileEditEndPoint="/user/updateProfile";
  static String driverOrderTrackingUpdate(String orderId)=> "/orderTracking/openTracker/$orderId";
  static String driverVehicleUpdate = "/user/updatedVehical";
  static String driverGetVehicleEndPoint = "/user/vehicalDetails";



  static String  boutiqueEarnEndPoint="/card/boutiqueEarned";
  static String  withdroEndPoint="/withdrow/createWithdrowRequest";
  static String  showAllWithdrowEndPoint="/withdrow/showWithdrow";
  static String  driverEarnEndPoint="/card/driverEarned";


  static String  firstMassageEndPoint="/message/createChat";
  static String  massageListEndPoint="/message/showChat";
  static String  inboxChatListEndPoint="/message/showMessageOfUser";
  static String  imageSentEndPoint="/message/createMessageByImage";
  static String  notificationEndPoint="/notifaction/getNotifaction";

  static String  acceptTermUserEndPoint="/privecy/acceptPrivecyPolicy";


}