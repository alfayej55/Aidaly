import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../controllers/Role/BoutiquesControllar/order_delivered_controller.dart';
import '../../../../../utils/enamdata.dart';
import '../../../../../utils/style.dart';
import '../../../../base/custom_page_loading.dart';
import '../../../../base/general_error_screen.dart';
import '../../../../base/no_internet_screen.dart';
import '../../Widget/order_card.dart';
import '../assigned_Screen/innerWidget/assignet_details_screen.dart';

class DeliveredScreen extends StatefulWidget {
  const DeliveredScreen({super.key});

  @override
  State<DeliveredScreen> createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends State<DeliveredScreen> {
  BoutiqueOrderDeliveryController _deliveryController =
      Get.put(BoutiqueOrderDeliveryController());

  @override
  void initState() {
    super.initState();
    _deliveryController.deliveryOrderFirsLoad();
    _deliveryController.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_deliveryController.scrollController.position.pixels ==
        _deliveryController.scrollController.position.maxScrollExtent) {
      _deliveryController.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _deliveryController.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx((){
    //   switch (_deliveryController.rxRequestStatus.value) {
    //     case Status.loading:
    //       return const CustomPageLoading();
    //     case Status.internetError:
    //       return NoInternetScreen(onTap:(){
    //         _deliveryController.deliveryOrderFirsLoad();
    //       });
    //     case Status.error:
    //       return GeneralErrorScreen(onTap: (){
    //         _deliveryController.deliveryOrderFirsLoad();
    //       });
    //     case Status.completed:
    //       return _body(context);
    //     default:
    //       return Container();
    //   }
    // });

   return Obx(()=>_body(context));
  }
  _body(BuildContext context) {
    return _deliveryController.firstLoading.value?Center(child: CustomPageLoading()): _deliveryController.deliveryModel.value.isEmpty? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
          SizedBox(height: 15.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w),
            child: Text("You Have Not Completed Any Deliveries Yet",
              textAlign: TextAlign.center,
              style: AppStyles.h3(),),
          ),
        ],
      ),
    )
        : Padding(
               padding: EdgeInsets.symmetric(horizontal: 24.w),
           child:RefreshIndicator( onRefresh:()async{
                },
            child:  ListView.separated(
                    itemCount: _deliveryController.deliveryModel.value.length + 1,
                controller: _deliveryController.scrollController,
                 // scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                 if (index >= _deliveryController.deliveryModel.value.length) {
                  return _deliveryController.firstLoading.value
                  ? CustomPageLoading()
                  : SizedBox();
                } else {

               var data = _deliveryController.deliveryModel.value[index];

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.deliveredDetailsScreen,arguments: data.id);
                    },
                  child: BoutiquesOrderCard(
                    status: 'Delivered',
                    orderData: data,
                  ));

                }
              },
                      separatorBuilder: (context, index) {
                       return Divider(color: Get.theme.dividerColor.withOpacity(0.4));
          },
        ),
      ),
    );
  }
}
