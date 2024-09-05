import 'package:aidaly/models/Role/withdrow_model.dart';
import 'package:aidaly/utils/app_colors.dart';
import 'package:aidaly/utils/app_icons.dart';
import 'package:aidaly/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WithdrawalHistory extends StatelessWidget {
  WithdeowModel? withdeowModel;
   WithdrawalHistory({super.key,this.withdeowModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      titleTextStyle: AppStyles.customSize(size: 16,color: AppColors.textColor),
      subtitleTextStyle:AppStyles.customSize(size: 18,fontWeight:FontWeight.w500,color:Get.theme.secondaryHeaderColor),
      leading: SvgPicture.asset(AppIcons.withdrowhistoryIcon),
      title: Text('${withdeowModel!.bankName}'),
      subtitle: Text('\$${withdeowModel!.withdrowAmount}'),
      trailing: Column(

        mainAxisSize: MainAxisSize.min,
        children: [
          withdeowModel!.status=="pending" ?Text('Pending',style: AppStyles.h4(color: Colors.red),) : withdeowModel!.status=="aproved" ?Text('Aproved',style: AppStyles.h4(color: Get.theme.primaryColor),)
              :Text('${withdeowModel!.status}',style: AppStyles.h6(color: Get.theme.disabledColor),),
          Text('${ DateFormat("dd-MM-yyyy").format(DateTime.parse("${withdeowModel!.createdAt}"))}',style: AppStyles.h6(color: Get.theme.disabledColor))

        ],
      )
    );
  }
}
