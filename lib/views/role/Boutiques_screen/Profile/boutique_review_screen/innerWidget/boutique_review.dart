import 'package:aidaly/models/Role/BoutiqueModel/boutique_shopper_review_model.dart';
import 'package:aidaly/service/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/cache_network_image.dart';


class BoutiqueShopperReview extends StatelessWidget {
  BoutiqueAllShopperReviewModel? revirewInfo;
   BoutiqueShopperReview({super.key,this.revirewInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// ..................  Review parson Image.................>

        CustomNetworkImage(
          width: 45.w,
          height: 45.h,
          imageUrl:
          "${ApiConstant.imageBaseUrl}${revirewInfo!.userId!.image!.publicFileUrl}",
          boxShape: BoxShape.circle,
        ),
        SizedBox(width: Dimensions.paddingSizeDefault.h,),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ..................  Review parson Title.................>

            Row(
              children: [


                Text(
                  '${revirewInfo!.userId!.name}',
                  style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w600),
                ),
                SizedBox(width: Dimensions.paddingSizeExtraSmall.w,),

                SvgPicture.asset(AppIcons.star,height: 18.h,width: 18.w,),

                SizedBox(width: Dimensions.paddingSizeExtraSmall.w,),
          /// Star Rating Text
                Text('${revirewInfo!.rating}',style:AppStyles.h5(
                    color: AppColors.primaryColor
                ),)
              ],
            ),

            /// Comment  Text

            Container(
              width: 249.w,
              child: Text(
                '${revirewInfo!.reviews}',
                textAlign: TextAlign.start,
                maxLines: 9,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.customSize(size: 12,fontWeight: FontWeight.w400,color:Get.theme.disabledColor),
              ),
            ),
            
            SizedBox(height: Dimensions.paddingSizeExtraSmall.h,),


            // /// .................. Comment and favorite .................>

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    children:List.generate(revirewInfo!.reviewImage!.length, (index) =>
                    revirewInfo!.reviewImage!.isNotEmpty? Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 3.w),
                      child: CustomNetworkImage(
                        width:30.w,
                        height: 30.h,
                        imageUrl:'${ApiConstant.imageBaseUrl}${revirewInfo!.reviewImage![index].publicFileUrl}',
                        borderRadius: BorderRadius.circular(10.r),

                      ),
                    ):Container(),
                    )
                ),

                SizedBox(width: 20.w,),
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.favoritIcon,height: 18,width: 18,),
                    SizedBox(width: 5,),
                    Text('${revirewInfo!.likeCount}',style: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),
                    SizedBox(width: 20.w,),
                    SvgPicture.asset(AppIcons.massegeIcon,height: 18,width: 18,),
                    SizedBox(width: 5,),
                    Text('${revirewInfo!.commentCount}',style: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),

                  ],
                )
              ],
            ),



            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     revirewInfo!.reviewImage!.isNotEmpty? SizedBox(
            //       height: 40.h,
            //       child: ListView.builder(
            //           itemCount: revirewInfo!.reviewImage!.length,
            //           itemBuilder: (context,index){
            //             var data=revirewInfo!.reviewImage![index];
            //             return  CustomNetworkImage(
            //               width:30.w,
            //               height: 30.h,
            //               imageUrl: "${ApiConstant.imageBaseUrl}${data.publicFileUrl}",
            //               borderRadius: BorderRadius.circular(10.r),
            //
            //             );
            //           }),
            //     ):SizedBox(),
            //
            //
            //
            //     SizedBox(width: 20.w,),
            //     Expanded(
            //       child: Row(
            //         children: [
            //           SvgPicture.asset(AppIcons.favoritIcon,height: 18,width: 18,),
            //           SizedBox(width: 2,),
            //           Text('101',style: AppStyles.customSize(size: 10,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),
            //          SizedBox(width: 5.w,),
            //           SvgPicture.asset(AppIcons.massegeIcon,height: 18,width: 18,),
            //           SizedBox(width: 2,),
            //           Text('101',style: AppStyles.customSize(size: 10,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),
            //
            //         ],
            //       ),
            //     )
            //
            //   ],
            // ),
          ],
        )

      ],
    );
  }
}
