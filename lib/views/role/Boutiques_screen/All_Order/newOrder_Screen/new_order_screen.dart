import 'package:aidaly/controllers/Role/BoutiquesControllar/new_ordercontroller.dart';
import 'package:aidaly/helpers/route.dart';
import 'package:aidaly/views/base/custom_page_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Utils/app_Image.dart';
import '../../../../../utils/enamdata.dart';
import '../../../../../utils/style.dart';
import '../../../../base/general_error_screen.dart';
import '../../../../base/no_internet_screen.dart';
import '../../Widget/order_card.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  NewOrderController _newOrderCtrl = Get.put(NewOrderController());

  @override
  void initState() {
    super.initState();
    _newOrderCtrl.boutiqueNewOrderFirsLoad();
    _newOrderCtrl.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_newOrderCtrl.scrollController.position.pixels ==
        _newOrderCtrl.scrollController.position.maxScrollExtent ) {
      _newOrderCtrl.loadMore();
      print('Load More Check');
    }
  }

  @override
  void dispose() {
    _newOrderCtrl.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      switch (_newOrderCtrl.rxRequestStatus.value) {
        case Status.loading:
          return const CustomPageLoading();
        case Status.internetError:
          return NoInternetScreen(onTap:(){
            _newOrderCtrl.boutiqueNewOrderFirsLoad();
          });
        case Status.error:
          return GeneralErrorScreen(onTap: (){
            _newOrderCtrl.boutiqueNewOrderFirsLoad();
          });
        case Status.completed:
          return _body(context);
        default:
          return Container();
      }
    });
  }

   _body(BuildContext context) {
    return _newOrderCtrl.newOrderModel.value.isEmpty ?Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(AppImages.addToCartEmptyImage),height: 120.h),
          SizedBox(height: 15.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w),
            child: Text("You Have Not Received Any New Orders Yet",
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
              itemCount: _newOrderCtrl.newOrderModel.value.length + 1,
              controller: _newOrderCtrl.scrollController,
              // scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index >= _newOrderCtrl.newOrderModel.value.length) {
                  return _newOrderCtrl.firstLoading.value
                      ? CustomPageLoading()
                      : SizedBox();
                } else {
                  var data = _newOrderCtrl.newOrderModel.value[index];
                  return GestureDetector(
                      onTap: () {Get.toNamed(AppRoutes.orderDetailsScreen,arguments: data.id);},
                      child: BoutiquesOrderCard(
                        status: 'New Order',
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
