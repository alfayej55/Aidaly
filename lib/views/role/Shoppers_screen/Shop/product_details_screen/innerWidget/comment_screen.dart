import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/Shopper_Controllar/product_details_controller.dart';
import '../../../../../../models/Role/ShopperModel/product_details_review_model.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/cache_network_image.dart';
import '../../../../../base/custom_page_loading.dart';
class CommentSection extends StatefulWidget {
    // ProductCommentModel reviews;
    // int index;
   String id;
   CommentSection({super.key,required this.id});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  ProduceDetailsController productDetailsCtrl =
  Get.put(ProduceDetailsController());

  ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    productDetailsCtrl.shopProduComment(widget.id);
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.maxScrollExtent ==
          scrollCtrl.position.extentBefore) {
        productDetailsCtrl.loadMore(widget.id);
        print('Load More Call');
      }
    });

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Obx(()=>  ListView.separated(
      itemCount: productDetailsCtrl.productCommentModel.value.length + 1,
      shrinkWrap: true,
      primary: false,
      controller: scrollCtrl,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      itemBuilder: (context, index) {
        if (index >=
            productDetailsCtrl.productCommentModel.value.length) {
          return productDetailsCtrl.loadMoreLoadign.value
              ? CustomPageLoading()
              : SizedBox();
        } else {
          var data = productDetailsCtrl.productCommentModel.value[index];
          print("Imagee>>>>>>>>>>>${ApiConstant.imageBaseUrl}${data.userId!.image!.publicFileUrl}");
          return  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ..................  Review parson Image.................>

              CustomNetworkImage(
                width: 45.w,
                height: 45.h,
                imageUrl:
                '${ApiConstant.imageBaseUrl}${data.userId!.image!.publicFileUrl} ?? ""',
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
                        data.userId!.name!,
                        style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: Dimensions.paddingSizeExtraSmall.w,),

                      SvgPicture.asset(AppIcons.star,height: 18.h,width: 18.w,),

                      SizedBox(width: Dimensions.paddingSizeExtraSmall.w,),
                      /// Star Rating Text
                      Text(data.rating.toString(),style:AppStyles.h5(
                          color: AppColors.primaryColor
                      ),)
                    ],
                  ),

                  /// Comment  Text

                  Container(
                    width: 249.w,
                    child: Text(
                      data.reviews.toString() ,
                      textAlign: TextAlign.start,
                      maxLines: 9,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.customSize(size: 12,fontWeight: FontWeight.w400,color:Get.theme.disabledColor),
                    ),
                  ),

                  SizedBox(height: Dimensions.paddingSizeExtraSmall.h,),


                  /// .................. Comment and favorite .................>



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children:List.generate(data.reviewImage!.length, (index) =>
                          data.reviewImage!.isNotEmpty? Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 3.w),
                            child: CustomNetworkImage(
                              width:30.w,
                              height: 30.h,
                              imageUrl:'${ApiConstant.imageBaseUrl}${data.reviewImage![index].publicFileUrl}',
                              borderRadius: BorderRadius.circular(10.r),

                            ),
                          ):Container(),
                          )
                      ),

                      SizedBox(width: 20.w,),
                      Row(
                        children: [
                          InkWell(
                              onTap: (){
                                setState(() {
                                  productDetailsCtrl.commentLike(index,data.id!,widget.id);
                                });
                              },
                              child: SvgPicture.asset(AppIcons.favoritIcon,height: 25,width: 25,color:data.isLiked? Colors.redAccent: Get.theme.dividerColor.withOpacity(0.2))),
                          SizedBox(width: 8,),
                          Text('${data.likeCount}',style: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),
                          SizedBox(width: 15.w,),
                          SvgPicture.asset(AppIcons.massegeIcon,height: 25,width: 25,),
                          SizedBox(width: 8,),
                          Text('${data.commentCount}',style: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),
                        ],
                      )
                    ],
                  )

                ],
              ),
            ],

          );
        }
      },
      separatorBuilder: (context, index) {
        return Divider(color: Get.theme.dividerColor.withOpacity(0.2));
      },
    ));



  }
}
