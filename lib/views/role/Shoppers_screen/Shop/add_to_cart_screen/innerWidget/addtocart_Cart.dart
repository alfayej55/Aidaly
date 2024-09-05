import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/Role/Shopper_Controllar/add_to_card_controllar.dart';
import '../../../../../../helpers/db_helpers.dart';
import '../../../../../../models/add_to_cart_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../utils/style.dart';
import '../../../../../base/cache_network_image.dart';
import '../../innerWidget/Add_button.dart';

class AddTocartCart extends StatefulWidget {


   AddTocartCart({super.key});

  @override
  State<AddTocartCart> createState() => _AddTocartCartState();
}

class _AddTocartCartState extends State<AddTocartCart> {

 final  DBHelper databasehd = DBHelper();
 AddToCartControllar addTocartCtrl=Get.put(AddToCartControllar());

 @override
  void initState() {
     addTocartCtrl.getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Obx(()=>
       ListView.builder(
          itemCount: addTocartCtrl.cart.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            var item=addTocartCtrl.cart[index];
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      CustomNetworkImage(
                        width: 70.w,
                        height: 94.h,
                        imageUrl:item.image!
                      ),
                      SizedBox(width:Dimensions.paddingSizeDefault),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// .................. Product name .................>
                          Text(
                            item.productName!,
                            style: AppStyles.customSize(size: 16),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,

                          ),
                          SizedBox(width:Dimensions.paddingSizeminiSmall),
                          /// .................. Product price .................>
                          Text(
                            '\$${item.productPrice}',
                            style: AppStyles.customSize(
                                size: 14,
                                color: Get.theme.primaryColor
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width:Dimensions.paddingSizeminiSmall),
                          Row(
                            children: [
                              /// .................. Product quantity Add Button .................>

                              AddButton(
                                ontap: (){
                                  setState(() {
                                    addTocartCtrl.addQuantity(index);
                                    databasehd.updateQuantity(item);
                                  });
                                },
                                icon: Icons.add,
                              ),
                              SizedBox(width: Dimensions.paddingSizeDefault.h,),

                              /// .................. Product quantity  .................>

                              Text(item.quantity.toString(),style: AppStyles.customSize(size: 20,fontWeight: FontWeight.w500),),
                              SizedBox(width: Dimensions.paddingSizeDefault.h,),

                              /// .................. Product quantity remove Button .................>

                              AddButton(
                                ontap: (){
                                  setState(() {
                                    addTocartCtrl.deleteQuantity(index);
                                    databasehd.updateQuantity(item);
                                  });
                                },
                                icon: Icons.remove,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      CircleAvatar(
                        radius: 15.r,
                        backgroundColor:Color(int.parse('0xff${item.productColor}')),
                        child: Center(
                          child: Text(item.productSize.toString(),
                            style: AppStyles.customSize(size: 14,color: AppColors.whiteColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h,),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              databasehd.deleteCartItem(
                                  addTocartCtrl.cart[index].id!);
                              addTocartCtrl
                                  .removeItem(index);
                            });
                          },
                          child: SvgPicture.asset(AppIcons.deletIcon))
                    ],
                  )
                ],
              ),
            );
          }),
    );

      // FutureBuilder(
      //   future: addTocartCtrl.getData(),
      //   builder: (BuildContext context,
      //       AsyncSnapshot<List<Cart>?> snapshot) {
      //
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text('Samthing is wrong'),
      //       );
      //     } else {
      //       if (snapshot.hasData) {
      //         return ListView.builder(
      //             itemCount: snapshot.data!.length,
      //             shrinkWrap: true,
      //             primary: false,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 padding: EdgeInsets.symmetric(vertical: 10.h),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         CustomNetworkImage(
      //                           width: 70.w,
      //                           height: 94.h,
      //                           imageUrl:
      //                           "https://images.unsplash.com/photo-1513094735237-8f2714d57c13?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHNob3BwaW5nfGVufDB8fDB8fHww",
      //                         ),
      //                         SizedBox(width:Dimensions.paddingSizeDefault),
      //                         Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //
      //                             /// .................. Product name .................>
      //                             Text(
      //                               snapshot.data![index].productName!,
      //                               style: AppStyles.customSize(size: 16),
      //                               textAlign: TextAlign.start,
      //                               overflow: TextOverflow.ellipsis,
      //
      //                             ),
      //                             SizedBox(width:Dimensions.paddingSizeminiSmall),
      //                             /// .................. Product price .................>
      //                             Text(
      //                               '\$${snapshot.data![index].productName}',
      //                               style: AppStyles.customSize(
      //                                   size: 14,
      //                                   color: Get.theme.primaryColor
      //                               ),
      //                               textAlign: TextAlign.start,
      //                               overflow: TextOverflow.ellipsis,
      //                             ),
      //                             SizedBox(width:Dimensions.paddingSizeminiSmall),
      //                             Row(
      //                               children: [
      //                                 /// .................. Product quantity Add Button .................>
      //
      //                                 AddButton(
      //                                   ontap: (){
      //                                   },
      //                                   icon: Icons.add,
      //                                 ),
      //                                 SizedBox(width: Dimensions.paddingSizeDefault.h,),
      //
      //                                 /// .................. Product quantity  .................>
      //
      //                                 Text(snapshot.data![index].quantity.toString(),style: AppStyles.customSize(size: 20,fontWeight: FontWeight.w500),),
      //                                 SizedBox(width: Dimensions.paddingSizeDefault.h,),
      //
      //                                 /// .................. Product quantity remove Button .................>
      //
      //                                 AddButton(
      //                                   ontap: (){
      //
      //                                   },
      //                                   icon: Icons.remove,
      //                                 ),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //
      //                     Column(
      //                       children: [
      //                         CircleAvatar(
      //                           radius: 15.r,
      //                           backgroundColor: AppColors.textColor,
      //                           child: Center(
      //                             child: Text('S',
      //                               style: AppStyles.customSize(size: 14,color: AppColors.whiteColor),
      //                             ),
      //                           ),
      //                         ),
      //                         SizedBox(height: 28.h,),
      //                         GestureDetector(
      //                             onTap: (){
      //                              setState(() {
      //                               // databasehd.removeProduct(snapshot.data![index].id!);
      //                              });
      //
      //                             },
      //                             child: SvgPicture.asset(AppIcons.deletIcon))
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //               );
      //
      //             });
      //       }
      //     }
      //     return Container();
      //   });

  }
}
