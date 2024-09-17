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
import '../../../../../base/custom_text_field.dart';
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

  var revirewShow=false;


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
        List<bool> revirewShowList = List.generate(productDetailsCtrl.productCommentModel.value.length, (index) => false);

        if (index >=
            productDetailsCtrl.productCommentModel.value.length) {
          return productDetailsCtrl.loadMoreLoadign.value
              ? CustomPageLoading()
              : SizedBox();
        } else {
          var data = productDetailsCtrl.productCommentModel.value[index];
          return  Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// ..................  Review parson Image.................>

                    CustomNetworkImage(
                      width: 45.w,
                      height: 45.h,
                      imageUrl:
                      "${ApiConstant.imageBaseUrl}${data.userId!.image!.publicFileUrl}",
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
                                InkWell(
                                  onTap: (){
                                    _showBottomSheet(context,data.id!);
                                  },
                                    child: SvgPicture.asset(AppIcons.massegeIcon,height: 25,width: 25,)),
                                SizedBox(width: 8,),
                                Text('${data.commentCount}',style: AppStyles.customSize(size: 15,fontWeight: FontWeight.w500,color: Get.theme.disabledColor),),
                              ],
                            )
                          ],
                        )

                      ],
                    ),
                  ],

                ),

              ],
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return Divider(color: Get.theme.dividerColor.withOpacity(0.2));
      },
    ));


  }
  void _showBottomSheet(BuildContext context,String id) {
    productDetailsCtrl.showReplay(id);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (BuildContext context) {
        return Obx(()=>Padding(
          padding: EdgeInsets.only(top:24.h),
          child: Container(
            padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.r),topLeft: Radius.circular(15.r)),
              color: Colors.white,
            ),

            child:Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 55.h,),
                  productDetailsCtrl.showReplayLoading.value?Center(child: CustomPageLoading()): productDetailsCtrl.commentReplayModel.isEmpty?Center(child: Align(
                     alignment: Alignment.center,
                      child: Text('No Replay',style: AppStyles.h3(),)),) :
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: productDetailsCtrl.commentReplayModel.length,
                      itemBuilder: (context,index){
                    var data=productDetailsCtrl.commentReplayModel[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ..................  Review parson Image.................>
                            CustomNetworkImage(
                              width: 45.w,
                              height: 45.h,
                              imageUrl:
                              "${ApiConstant.imageBaseUrl}${data.userId!.image!.publicFileUrl}",
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: Dimensions.paddingSizeDefault.h,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// ..................  Review parson Title.................>

                                Text(
                                  data.userId!.name!,
                                  style: AppStyles.customSize(size: 14,fontWeight: FontWeight.w600),
                                ),

                                Text(
                                  data.comment!,
                                  style: AppStyles.h5(),
                                ),

                                /// Comment  Text

                              ],
                            ),
                          ],

                        ),
                      ),
                    );
                  },
                    separatorBuilder: (context,index){
                      return Divider(color: Get.theme.dividerColor.withOpacity(0.2));
                    },
                  ),

                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [

                        ///>>>>>>>>>>>>>>>>>> Text Field >>>>>>>>>>>>>>>>>>>>
                        Expanded(
                            child: CustomTextField(
                                contentPaddingVertical: 15.h,
                                hintText: 'Type Replay',
                                controller: productDetailsCtrl.replayCntrl
                            )),

                        ///>>>>>>>>>>>>>>>>>> Sent Button >>>>>>>>>>>>>>>>>>>>
                        InkWell(
                          onTap: (){
                            productDetailsCtrl.commentReplay(id);

                          },
                          child: Container(

                            height: 55.h,
                            width: 52.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10).r,
                              border: Border.all(
                                  color: Get.theme.primaryColor.withOpacity(0.2)),
                            ),
                            child: productDetailsCtrl.replayLoading.value?CustomPageLoading(): Center(
                              child: SvgPicture.asset(
                                AppIcons.sentIcon,
                                height: 24.h,
                                width: 24,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

}



