import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import '../../../view_model/utilis/colors/colors.dart';
import '../../components/widgets/constructions.dart';
import '../../components/widgets/text_custom_widget.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<EcommerceCubit,EcommerceState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: EcommerceCubit.get(context).cartModel==null?Constructions.constructLoadingProgressIndicator():
          EcommerceCubit.get(context).cartModel!.data!.cartItems!.isEmpty? Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              const Icon(Icons.add_shopping_cart_outlined,size: 70,color: AppColors.textColor,),
              SizedBox(height: height*0.03,),
              const TextCustom(text: 'Add Cart',fontSize: 25,color: AppColors.textColor,)
            ],),
          ):
          ListView.builder(itemBuilder:(context,index){
            return SizedBox(height: height*0.29,width: width,
              child: Card(clipBehavior:Clip.antiAliasWithSaveLayer,color: AppColors.textColor,elevation: 0,
                child: Row(
                  children: [
                    SizedBox(
                        width: width*0.35,
                        height: height*0.25,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: width*0.03),
                          child: Constructions.constructImage(
                            imageUrl:EcommerceCubit.get(context).cartModel!.data!.cartItems![index].product!.image!,
                            fit:'contain',
                          ),
                        )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextCustom(text:'${EcommerceCubit.get(context).cartModel!.data!.cartItems![index].product!.name}',
                              color: AppColors.backgroundColor,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,),
                            SizedBox(height: height*0.02,),
                            TextCustom(text:'${EcommerceCubit.get(context).cartModel!.data!.cartItems![index].product!.description}',
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.backgroundColor,
                              maxLines: 3,),
                            SizedBox(height: height*0.02,),
                            Row(
                              children: [
                                TextCustom(text:'${EcommerceCubit.get(context).cartModel!.data!.cartItems![index].product!.price} EGP',
                                  color: AppColors.backgroundColor,
                                  fontSize:20,),
                                const Spacer(),
                                IconButton(onPressed:(){
                                 EcommerceCubit.get(context).changeProductCartStatus
                                   (id: EcommerceCubit.get(context).cartModel!.data!.cartItems![index].product!.id!).then((value){
                                     EcommerceCubit.get(context).getHomeData();
                                 });
                                 setState(() {
                                   EcommerceCubit.get(context).cartModel!.data!.cartItems!.removeAt(index);
                                 });
                                 }, icon:const Icon(Icons.delete,color: AppColors.backgroundColor,))],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },itemCount:EcommerceCubit.get(context).cartModel!.data!.cartItems!.length ,),
        );
      },
    )
    ;
  }
}

