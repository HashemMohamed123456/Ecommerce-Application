import 'package:awesome_icons/awesome_icons.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_form_field_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/Login/login_screen.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/Auth/auth_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/show_text/show_or_hide_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/data/local/shared_preference/keys.dart';
import 'package:ecommerce_eraasoft/view_model/data/local/shared_preference/shared_preferences.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../HomeLayout/home_layout.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit,AuthState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is RegistrationSuccessState){
      if(state.status==true){
        var snackBar=Constructions.constructSnackBar(num: 1, title:'Sign Up Success', message:state.message);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigation.pushAndRemove(context, const HomeLayOutScreen());
        LocalData.set(key: 'token', value:state.token);
      }else{
        var snackBar=Constructions.constructSnackBar(num: 0, title:'Sign Up Failed', message:state.message);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children:[
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.04),
                  child: Column(
                      children: [
                        const TextCustom(text: 'Register',fontSize: 70,color: AppColors.textColor,),
                        SizedBox(height: height*0.02,),
                        const TextCustom(text: 'Welcome to our App Store',fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.textColor,),
                        SizedBox(height: height*0.05,),]),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: width*0.04),
                  child: Form(
                    key: AuthCubit.get(context).registerFormKey,
                    child: Column(
                      children: [
                        TextFormFieldCustom(hintText: 'Name',prefixIcon:const Icon(Icons.person,),textInputAction: TextInputAction.next,
                          controller:AuthCubit.get(context).nameController ,
                          validator: (value){
                            if((value??"").isEmpty){
                              return 'You must Enter Your Name';
                            }
                            return null;
                          },),
                        SizedBox(height: height*0.02,),
                        TextFormFieldCustom(hintText: 'Phone',prefixIcon: const Icon(Icons.phone_android,),textInputAction: TextInputAction.next,
                            controller:AuthCubit.get(context).phoneController,
                            validator: (value){
                              if((value??"").isEmpty){
                                return 'You must Enter Your Phone Number';
                              }
                              return null;
                            }),
                        SizedBox(height: height*0.02,),
                        TextFormFieldCustom(hintText: 'Email',prefixIcon: const Icon(Icons.email,),textInputAction: TextInputAction.next,
                            controller:AuthCubit.get(context).emailController,
                            validator: (value){
                              if((value??"").isEmpty){
                                return 'You must Enter Your Email';
                              }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value??'')){
                                return "invalid Email";
                              }
                              return null;
                            }),
                        SizedBox(height: height*0.02,),
                        BlocConsumer<ShowOrHideCubit,ShowOrHideState>(listener: (context,state){},builder:(context,state){ return TextFormFieldCustom(
                          controller: AuthCubit.get(context).passwordController,
                          validator: (value){
                            if((value??"").isEmpty){
                              return 'You must Enter Your Password';
                            }else if(!RegExp(r'(?=.*[a-z])').hasMatch(value??'')){
                              return 'Password needs at least one lower case letter';
                            }else if(!RegExp(r'(?=.*[A-Z])' ).hasMatch(value??'')){
                              return 'Password needs at least one upper case letter';
                            }else if(!RegExp(r'(?=.*?[0-9])').hasMatch(value??"")){
                              return'Password needs at least one digit';
                            }else if(!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(value??'')){
                              return'Password needs at least one special character ';
                            }else if(!RegExp(r'.{6,}').hasMatch(value??'')){
                              return 'Password length at least Six characters';
                            }
                            return null;
                          },
                          obscureText: ShowOrHideCubit.get(context).obscureText,
                          hintText: 'Password',
                          prefixIcon:const Icon(Icons.password),textInputAction: TextInputAction.done,suffixIcon:InkWell(
                            onTap:(){
                              ShowOrHideCubit.get(context).hidePassword();

                            } ,
                            child: Icon(ShowOrHideCubit.get(context).showPassword?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,size:15 ,)),);}
                        ),
                        SizedBox(height: height*0.07,),
                        state is RegistrationLoadingState?Constructions.constructLoadingProgressIndicator():ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textColor,
                              minimumSize: const Size(double.infinity,60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)
                              )
                          ),
                          onPressed: (){
                            if(AuthCubit.get(context).registerFormKey .currentState!.validate()){
                              AuthCubit.get(context).register();
                            }
                          },
                          child: const TextCustom
                            (text: 'Sign Up',color:AppColors.backgroundColor,fontSize: 20,fontWeight: FontWeight.bold,),),
                        SizedBox(height: height*0.01,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextCustom(text: 'Already have an account?',color: AppColors.textColor,),
                            TextButton(onPressed: (){
                              Navigation.push(context, const LoginScreen());
                            }, child:const TextCustom(text: 'Login',color: Colors.blue,))

                          ],
                        )],
                    ),


                  ),
                ),
              ]),
        ),
      ),
    );
  },
);
  }
}
