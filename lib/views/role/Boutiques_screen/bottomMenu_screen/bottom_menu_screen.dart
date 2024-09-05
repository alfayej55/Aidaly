import 'package:aidaly/helpers/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';

class BoutiqueBottomMenu extends StatelessWidget {
  final int menuIndex;

  const BoutiqueBottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.primaryColor :  AppColors.subTextColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: const EdgeInsets.only(top:8),
          child: SvgPicture.asset(
            image,
            height: 24.0,
            width: 24.0,
            color: colorByIndex(theme, index),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(AppIcons.homeIcon, 'Home', theme, 0),
      getItem(AppIcons.allOrderIcon, 'All Orders', theme, 1),
      getItem(AppIcons.myProductIcon, 'My Products', theme, 2),
      getItem(AppIcons.profileIcon, 'Profile', theme, 3),
    ];

    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 25,
            offset: Offset(8, 21), // Adjust the offset to match the curvature
          ),

        ],
      ),
      child: ClipPath(
        clipper: ClipPathClass(),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor:Theme.of(context).primaryColor,
          currentIndex: menuIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Get.offAndToNamed(AppRoutes.homeBoutique);
                break;
              case 1:
                Get.offAndToNamed(AppRoutes.allOrdertBoutiqueScreen);
                break;
              case 2:
                Get.offAndToNamed(AppRoutes.myProductBoutiqueScreen);
                break;
              case 3:
                Get.offAndToNamed(AppRoutes.boutiqueProfileScreen);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
    // return Container(
    //
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.only(
    //           topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)
    //       ),
    //
    //       boxShadow: const [
    //         BoxShadow(color:Colors.black38,spreadRadius:0,blurRadius: 10)
    //       ]
    //   ),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.only(
    //         topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)
    //
    //     ),
    //     child: BottomNavigationBar(
    //       type: BottomNavigationBarType.fixed,
    //
    //       selectedItemColor:Theme.of(context).primaryColor,
    //       currentIndex: menuIndex,
    //
    //       onTap: (value) {
    //         switch (value) {
    //           case 0:
    //             Get.offAndToNamed(AppRoutes.homeScreen);
    //             break;
    //           case 1:
    //             Get.offAndToNamed(AppRoutes.walletScreen);
    //             break;
    //           case 2:
    //             Get.offAndToNamed(AppRoutes.profileScreen);
    //             break;
    //         }
    //       },
    //       items: menuItems,
    //     ),
    //   ),
    // );
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