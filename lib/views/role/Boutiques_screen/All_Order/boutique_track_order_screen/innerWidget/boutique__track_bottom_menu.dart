import 'package:aidaly/helpers/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/massage_controller/inbox_massage_controller.dart';
import '../../../../../../models/Role/BoutiqueModel/boutique_order_track_model.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/cache_network_image.dart';


class TrackOrderBottomMenu extends StatelessWidget {
  AssignedDriver? driverInfo;
   TrackOrderBottomMenu({super.key,this.driverInfo});

  InboxMassageControlelr _chatController = Get.put(InboxMassageControlelr());

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipPathClass(),
      child: Container(
          height: 115.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15).r,topRight: Radius.circular(15).r),
              color: Get.theme.cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 0,
                blurRadius: 25,
                offset: Offset(8, 21), // Adjust the offset to match the curvature
              ),

            ],
          ),
          child:Center(
            child: Padding(
              padding:  EdgeInsets.only(top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
        ///>>>>>>>>>>>>>>>>> Driver Image >>>>>>>>>>>>>>

                  CustomNetworkImage(
                    imageUrl:"${ApiConstant.imageBaseUrl}${driverInfo!.image!.publicFileUrl}",
                    //borderRadius: BorderRadius.circular(12.r),
                    height: 55.h,
                    width:55.w,
                    boxShape: BoxShape.circle,

                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                   ///>>>>>>>>>>>>>>>>> Driver Image >>>>>>>>>>>>>>

                      Text('${driverInfo!.name}',
                        style: AppStyles.customSize(size: 16),),
                      Text('${driverInfo!.email}',
                          style:  AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.secondaryHeaderColor)
                      ),

                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.star,height: 18.h,width: 18.w,),
                          SizedBox(width: 5.w,),
                          Text('${driverInfo!.rating}',style:AppStyles.h6(),)
                        ],
                      )
                    ],
                  ),
                 ///>>>>>>>>>>>>>>>>> massege Button>>>>>>>>>>>>>>

                  GestureDetector(
                    onTap: (){
                      _chatController.firstCreeateMassage(driverInfo!.id!);
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          color: Get.theme.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle
                      ),
                      child: Center(child: SvgPicture.asset(AppIcons.massegeIcon,color: Get.theme.primaryColor,),),
                    ),
                  )

                ],
              ),
            ),
          )

      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height - (size.height * 8 / 11));
    var secondControlPoint = Offset(size.width / 2, 0);
    var secondPoint = Offset(size.width, size.height - (size.height * 6 / 8));
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
