import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/Category/categories_screen.dart';
import 'package:ecommerce_eraasoft/view/screens/HomeLayout/home_layout.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Product Details/product_details_screen.dart';

class CategoryProductsDetailsScreen extends StatelessWidget {
   CategoryProductsDetailsScreen({super.key, required this.title});
late String title;
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<EcommerceCubit ,EcommerceState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigation.push(context, const HomeLayOutScreen());
            },icon: const Icon(Icons.arrow_back,color: AppColors.textColor,),),
            backgroundColor: AppColors.backgroundColor,
            title:TextCustom(text:title ,color: AppColors.textColor,fontSize: 30,),
          ),
          body: EcommerceCubit.get(context).categoryProductsDetails==null?Constructions.constructLoadingProgressIndicator():
          GridView.builder(
              shrinkWrap: true,
              itemCount:EcommerceCubit.get(context).categoryProductsDetails!.data!.products!.length,
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing:2,
                mainAxisSpacing:1,
                mainAxisExtent: height * 0.38,
              ), itemBuilder:(context,index){
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: (){
                   Navigation.push(context, ProductDetailsScreen(product: EcommerceCubit.get(context).categoryProductsDetails!.data!.products![index],));
                    },
                    child: Constructions.buildProductItem(cubit:EcommerceCubit.get(context) ,from:'category',height, width,
                        image:EcommerceCubit.get(context).categoryProductsDetails!.data!.products![index].image!,
                        name:EcommerceCubit.get(context).categoryProductsDetails!.data!.products![index].name!,
                        price:'${EcommerceCubit.get(context).categoryProductsDetails!.data!.products![index].price!}',
                        index: index,
                        id:EcommerceCubit.get(context).categoryProductsDetails!.data!.products![index].id!,
                        isFavourite:EcommerceCubit.get(context).categoryProductsDetails!.data!.products![index].inFavorites ),
                  ),
                );
          })
        );
      },
    );
  }
}
