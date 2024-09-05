// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../utils/app_colors.dart';
// import '../../../../../base/cache_network_image.dart';
// class CategoricImages extends StatelessWidget {
//     List<Image>? productimage;
//    CategoricImages({super.key,required this.productimage});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: EdgeInsets.only(bottom: 15.h),
//       child: Container(
//         height: 64.h,
//         width: 190.w,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15).r,
//             color: Color(0xffDFDFDF)
//         ),
//         child: Center(
//           child: Row(children:List.generate(productimage.length, (index) => CustomNetworkImage(
//             width:54.w,
//             height: 54.h,
//             imageUrl:'',
//
//             borderRadius: BorderRadius.circular(10.r),
//             border: Border.all(color: AppColors.whiteColor,width: 2),
//           )),)
//
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //   children: [
//           //
//           //
//           //
//           //     // CustomNetworkImage(
//           //     //   width:54.w,
//           //     //   height: 54.h,
//           //     //   imageUrl:
//           //     //   "https://images.unsplash.com/photo-1513094735237-8f2714d57c13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob3BwaW5nfGVufDB8fDB8fHww",
//           //     //   borderRadius: BorderRadius.circular(10.r),
//           //     //   border: Border.all(color: AppColors.whiteColor,width: 2),
//           //     // ),
//           //     // CustomNetworkImage(
//           //     //   width:54.w,
//           //     //   height: 54.h,
//           //     //   imageUrl:
//           //     //   "https://images.unsplash.com/photo-1513094735237-8f2714d57c13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob3BwaW5nfGVufDB8fDB8fHww",
//           //     //   borderRadius: BorderRadius.circular(10.r),
//           //     //   border: Border.all(color: AppColors.whiteColor,width: 2),
//           //     // )
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }
