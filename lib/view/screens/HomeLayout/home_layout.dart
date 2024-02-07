import 'package:awesome_icons/awesome_icons.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/Price/price_screen.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:badges/badges.dart' as badges;
class HomeLayOutScreen extends StatelessWidget {
  const HomeLayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<EcommerceCubit, EcommerceState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        leading: IconButton(onPressed: (){},icon:const Icon(Icons.menu,color: AppColors.textColor,size: 30,)),
        backgroundColor: AppColors.backgroundColor,
        title: const TextCustom(text: 'Your Market',fontWeight: FontWeight.bold,color: AppColors.textColor,fontSize: 30,),
        centerTitle: true,
        actions: [
     badges.Badge(badgeStyle: const badges.BadgeStyle(badgeColor: Colors.lightBlueAccent,),
            position: badges.BadgePosition.bottomStart(bottom: -2,start: -3),
            badgeContent: EcommerceCubit.get(context).cartModel==null?const Padding(
              padding:  EdgeInsets.all(2),
              child:  TextCustom(text: '0',color: AppColors.backgroundColor,fontSize: 15,),
            ):
             Padding(
               padding: const EdgeInsets.all(2),
               child: TextCustom(text: '${EcommerceCubit.get(context).cartModel!.data!.cartItems!.length}',color: AppColors.backgroundColor,fontSize: 15,),
             ),
            child:IconButton(onPressed: (){
              Navigation.push(context, const PriceScreen());
            },icon:const Icon(Icons.shopping_cart,color: AppColors.textColor,size: 30,)),
          )
        ],
      ),
      body: EcommerceCubit.get(context).screens[EcommerceCubit.get(context).currentScreenIndex],
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
        child: GNav(
          selectedIndex: 0,
          backgroundColor: AppColors.backgroundColor,
          hoverColor: Colors.grey.withOpacity(0.3), // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 10, // tab animation curves
          duration: const Duration(milliseconds: 400) ,// tab animation duration
          gap: width*0.03, // the tab button gap between icon and text
          color: AppColors.textColor, // unselected icon color
          activeColor: AppColors.backgroundColor, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: AppColors.textColor, // selected tab background color
          padding:  EdgeInsets.symmetric(horizontal: width*0.04, vertical: height*0.015), // navigation bar padding
          tabs: const [
            GButton(
              icon: FontAwesomeIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: FontAwesomeIcons.shoppingBag,
              text: 'Category',
            ),
            GButton(
              icon: FontAwesomeIcons.shoppingBasket,
              text: 'Cart',
            ),
            GButton(
              icon: FontAwesomeIcons.heart,
              text: 'Favorite',
            ),
          ],
          onTabChange: (index){
            EcommerceCubit.get(context).changeScreenIndex(index);
          },
        ),
      ),
    );
  },
);
  }
}
