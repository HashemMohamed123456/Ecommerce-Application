import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/HomeLayout/home_layout.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<EcommerceCubit,EcommerceState>(listener:(context,index){},builder:(context,index){
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(leading:IconButton(onPressed:(){
          Navigation.push(context,const HomeLayOutScreen());
        } ,icon:const Icon(Icons.arrow_back,color: AppColors.textColor,) ,),title:const TextCustom(text:' Your Price',fontSize: 30,color: AppColors.textColor,),centerTitle: true,
          backgroundColor: AppColors.backgroundColor,elevation: 0,
        ),
        body: EcommerceCubit.get(context).cartModel==null?Constructions.constructLoadingProgressIndicator():
        EcommerceCubit.get(context).cartModel!.data!.cartItems!.isEmpty?const SizedBox():
        Padding(
          padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: height*0.2,width: width,
            child: Card(
              color: AppColors.textColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Row(
                    children: [
                      const TextCustom(text: 'Your Total Price:',fontSize: 20,color: AppColors.backgroundColor,),
                      const Spacer(),
                       TextCustom(text: '${EcommerceCubit.get(context).cartModel!.data!.total} EGP',fontSize: 20,color: AppColors.backgroundColor,),
                    ],
                  ),
                const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        minimumSize: const Size(double.infinity,60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                    onPressed: (){
                    },
                    child: const TextCustom
                      (text: 'Done Order !!',color:AppColors.textColor,fontSize: 20,fontWeight: FontWeight.bold,),),
                ],),
              ),
            ),
            ),
          Expanded(child:ListView.builder(itemBuilder:(context,index){
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
                                      EcommerceCubit.get(context).getAllCartProducts();
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
          },itemCount:EcommerceCubit.get(context).cartModel!.data!.cartItems!.length ,),)],
        ),),
      );

    });
  }
}
