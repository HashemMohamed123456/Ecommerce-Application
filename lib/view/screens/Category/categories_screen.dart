import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/screens/Category/category_details_screen.dart';
import 'package:ecommerce_eraasoft/view/screens/Product%20Details/product_details_screen.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view_model/utilis/colors/colors.dart';
import '../../components/widgets/text_custom_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
          body: EcommerceCubit.get(context).categoriesModel==null?Constructions.constructLoadingProgressIndicator():ListView.builder(
              itemCount:EcommerceCubit.get(context).categoriesModel!.data!.myData!.length ,
              itemBuilder:(context,index){
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
                  child: InkWell(onTap: (){
                    EcommerceCubit.get(context).getCategoryProducts(id:EcommerceCubit.get(context).categoriesModel!.data!.myData![index].id! );
                    Navigation.push(context, CategoryProductsDetailsScreen(title:EcommerceCubit.get(context).categoriesModel!.data!.myData![index].name!));
                  },
                    child: Container(clipBehavior: Clip.antiAliasWithSaveLayer,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: SizedBox(
                        height:height*0.2,
                        child: Stack(
                          children: [
                            SizedBox(height: height*0.2,width: width,
                                child: InkWell(onTap: (){

                                },child: Constructions.constructImage(imageUrl:EcommerceCubit.get(context).categoriesModel!.data!.myData![index].image, fit: 'cover'))),
                          Container(height:height*0.2,color: Colors.black54,),
                          Center(child: TextCustom(text: '${EcommerceCubit.get(context).categoriesModel!.data!.myData![index].name}',color:AppColors.textColor,fontSize: 30,))],
                        ),
                      ),
                    ),
                  ),
                );
          }),
        );
      },
    );
  }
}
