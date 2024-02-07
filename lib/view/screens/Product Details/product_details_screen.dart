import 'package:ecommerce_eraasoft/model/Home%20Model/home_model.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/HomeLayout/home_layout.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ProductDetailsScreen extends StatefulWidget {
   ProductDetailsScreen({super.key,required this.product});
late Products product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
      appBar: AppBar(leading: IconButton(onPressed:(){
        Navigation.push(context, const HomeLayOutScreen());
      } ,icon: const Icon(Icons.arrow_back,color: AppColors.textColor,),),backgroundColor: AppColors.backgroundColor,elevation: 0,
        title: const TextCustom(text: 'Your Product Details',fontSize: 30,color:AppColors.textColor,),
      ),
      body:Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.05),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.01),
            SizedBox(height: height*0.3,
              child: Constructions.constructSlider(width: width, height: height*0.3, carouselController:EcommerceCubit.get(context).secondCarouselController , cubit:EcommerceCubit.get(context),
                  length:widget.product.images!.length,items:widget.product.images),
            ),
          SizedBox(height: height*0.02,),
          Center(child: AnimatedSmoothIndicator(activeIndex:EcommerceCubit.get(context).currentSmoothIndicatorSliderIndex, count:widget.product.images!.length)),
          SizedBox(height: height*0.02,),
          TextCustom(text: '${widget.product.name}',fontSize: 20,color: AppColors.textColor,),
            SizedBox(height: height*0.02,),
            const TextCustom(text: 'Description:',fontSize: 20,color: AppColors.textColor,),
            SizedBox(height: height*0.01,),
            TextCustom(text: '${widget.product.description}',fontSize: 13,maxLines: 8,color: AppColors.textColor,),
          SizedBox(height: height*0.02,),
            TextCustom(text: 'Price: ${widget.product.price} EGP',fontSize: 20,color: AppColors.textColor,),
            SizedBox(height: height*0.02,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textColor,
                  minimumSize: const Size(double.infinity,60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                  )
              ),
              onPressed: (){
               setState(() {
                 widget.product.inCart=!widget.product.inCart!;
               });
                EcommerceCubit.get(context).changeProductCartStatus(id:widget.product.id!).then((value){
                  EcommerceCubit.get(context).getAllCartProducts();
                });
              },
              child: widget.product.inCart!?const TextCustom
                (text: 'Remove From Cart',color:AppColors.backgroundColor,fontSize: 20,fontWeight: FontWeight.bold,):const TextCustom
                (text: 'Add to Cart',color:AppColors.backgroundColor,fontSize: 20,fontWeight: FontWeight.bold,),),],
        ),
      )
    );
  },
);
  }
}
