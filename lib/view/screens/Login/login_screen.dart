import 'package:awesome_icons/awesome_icons.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/constructions.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_form_field_widget.dart';
import 'package:ecommerce_eraasoft/view/screens/HomeLayout/home_layout.dart';
import 'package:ecommerce_eraasoft/view/screens/register/register.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/Auth/auth_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/bloc/show_text/show_or_hide_cubit.dart';
import 'package:ecommerce_eraasoft/view_model/data/local/shared_preference/shared_preferences.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit,AuthState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is LoginSuccessState){
    if(state.status==true){
      var snackBar=Constructions.constructSnackBar(num: 1, title:'Login Success', message:state.message);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigation.pushAndRemove(context, const HomeLayOutScreen());
      LocalData.set(key: 'token', value:state.token);
    }else{
      var snackBar=Constructions.constructSnackBar(num: 0, title:'Login Failed', message:state.message);
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
                   const TextCustom(text: 'Login',fontSize: 70,color: AppColors.textColor,),
                    SizedBox(height: height*0.02,),
                    const TextCustom(text: 'Welcome to our App Store',fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.textColor,),
                    SizedBox(height: height*0.05,),
                  ]
                  ),
                ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width*0.04),
                    child: Form(
                      key:AuthCubit.get(context).loginFormKey,
                      child: Column(
                        children: [
                           TextFormFieldCustom(hintText: 'Email',prefixIcon: const Icon(Icons.email,),
                               controller:AuthCubit.get(context).emailController,textInputAction: TextInputAction.next,validator: (value){
                             if((value??"").isEmpty){
                               return 'You must Enter Your Email';
                             }
                             return null;
                           }),
                          SizedBox(height: height*0.02,),
                          BlocConsumer<ShowOrHideCubit,ShowOrHideState>(listener: (context,state){},builder:(context,state){ return TextFormFieldCustom(
                            obscureText: ShowOrHideCubit.get(context).obscureText,controller: AuthCubit.get(context).passwordController,
                            hintText: 'Password',
                            validator: (value){
                            if((value??"").isEmpty){
                              return 'You must Enter Your Password';
                            }
                            return null;
                          },
                            prefixIcon:const Icon(Icons.password),textInputAction: TextInputAction.done,suffixIcon:InkWell(
                              onTap:(){
                                ShowOrHideCubit.get(context).hidePassword();

                              } ,
                              child: Icon(ShowOrHideCubit.get(context).showPassword?FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,size:15 ,)),);}
                          ),
                          SizedBox(height: height*0.07,),
                          state is LoginLoadingState?Constructions.constructLoadingProgressIndicator():ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.textColor,
                                minimumSize: const Size(double.infinity,60),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            onPressed: (){
                              if(AuthCubit.get(context).loginFormKey.currentState!.validate()){
                                AuthCubit.get(context).login();
                              }
                            },
                            child: const TextCustom
                              (text: 'Login',color:AppColors.backgroundColor,fontSize: 20,fontWeight: FontWeight.bold,),),
                          SizedBox(height: height*0.01,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextCustom(text: 'Create an account?',color: AppColors.textColor,),
                            TextButton(onPressed: (){
                              Navigation.push(context,  const RegistrationScreen());
                            }, child:const TextCustom(text: 'Register',color: Colors.blue,))

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
