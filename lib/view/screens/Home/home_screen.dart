import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/Product%20Details/product_details_screen.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/utilis/colors/colors.dart';
class HomeScreen extends StatelessWidget {
   const HomeScreen({super.key});

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
      body: EcommerceCubit.get(context).homeModel==null?Constructions.constructLoadingProgressIndicator():SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height*0.01),
          Constructions.constructSlider(width: width, height: height*0.3, carouselController:EcommerceCubit.get(context).carouselController , cubit:EcommerceCubit.get(context),
              length:EcommerceCubit.get(context).homeModel!.data!.banners!.length),
          SizedBox(height: height*0.02,),
           Padding(
             padding:  EdgeInsets.symmetric(horizontal: width*0.04),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  const TextCustom(text: 'Hot Sales',color: AppColors.textColor,fontSize: 20,),
                const Spacer(),
                InkWell(onTap: (){},child: const TextCustom(text: 'See All',color:Colors.blue,fontSize: 17,fontWeight: FontWeight.bold,)),
              ],
          ),
           ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: height*0.38,
              child: ListView.builder(scrollDirection: Axis.horizontal,
                  itemCount: EcommerceCubit.get(context).homeModel!.data!.salesProducts.length,
                  itemBuilder:(context,index){
                return SizedBox(height: height*0.4,
                  width: width*0.5,
                  child:Card(color:AppColors.textColor,elevation: 0,
                    child: Column(
                      children: [
                        SizedBox(height: height*0.2,
                          child:Stack(
                            children: [
                              SizedBox(height: height*0.2,
                                  child: InkWell(onTap: (){
                                    Navigation.push(context, ProductDetailsScreen(
                                      product: EcommerceCubit.get(context).homeModel!.data!.salesProducts[index],
                                    ));
                                  },child: Constructions.constructImage(
                                      imageUrl:EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].image,
                                      fit:'contain')
                                  )
                              ),
                              Positioned(right: 0,
                                child: Container(padding:const  EdgeInsets.symmetric(horizontal:5,vertical:5),decoration:  BoxDecoration(color: Colors.green
                                ,borderRadius: BorderRadius.circular(5)
                                ),
                                  child:TextCustom(text: '${EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].discount} %',color: AppColors.textColor,fontWeight: FontWeight.bold,)
                                ),
                              )
                            ],
                          ) ,
                        ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: width*0.04),
                        child: TextCustom(text: '${EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].name}'
                          ,overflow: TextOverflow.ellipsis,
                          maxLines:2,
                          color:
                          AppColors.backgroundColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: height*0.01,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width*0.02),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextCustom(text: '${EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].price}',
                            fontWeight:FontWeight.bold,
                            color: AppColors.backgroundColor,fontSize: 20,),
                          SizedBox(width: width*0.01,),
                          TextCustom(text: '${EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].oldPrice}',
                            fontWeight:FontWeight.bold,
                            color: Colors.red,fontSize:10,),

                        const Spacer(),
                         IconButton(onPressed:(){
                          EcommerceCubit.get(context).changeFavoriteStatusInSales(index: index);
                          EcommerceCubit.get(context).changeFavoritesStatus(id: EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].id!);
                         },icon:EcommerceCubit.get(context).homeModel!.data!.salesProducts[index].inFavorites!?const Icon(Icons.favorite,color: Colors.red,):
                         const Icon(Icons.favorite_border))
                        ],
                        ),
                      ),
                      ],
                    ),
                  ) ,);

              })
            ),
          ),
          SizedBox(height:height*0.02,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const TextCustom(text: 'Products',color: AppColors.textColor,fontSize: 20,),
                  const Spacer(),
                  InkWell(onTap: (){},child: const TextCustom(text: 'See All',color:Colors.blue,fontSize: 17,fontWeight: FontWeight.bold,)),
                ],
              ),
            ),
    GridView.builder(physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:EcommerceCubit.get(context).homeModel!.data!.products!.length,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing:1,
    mainAxisSpacing:1,
      mainAxisExtent: height * 0.4,
    ),
    itemBuilder:(context,index){
      return Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: (){
            Navigation.push(context, ProductDetailsScreen(product: EcommerceCubit.get(context).homeModel!.data!.products![index]));
          },
          child: Constructions.buildProductItem(cubit: EcommerceCubit.get(context),height, width,
              from: 'home',
              isFavourite:EcommerceCubit.get(context).homeModel!.data!.products![index].inFavorites,
              image:EcommerceCubit.get(context).homeModel!.data!.products![index].image!,
              name: EcommerceCubit.get(context).homeModel!.data!.products![index].name!,
              price: '${EcommerceCubit.get(context).homeModel!.data!.products![index].price!}',
    index: index,
              id:EcommerceCubit.get(context).homeModel!.data!.products![index].id!),
        ),
      );
    }
    )
          ],
        ),
      ),
    );
  },
);
  }
}
