import 'package:ecommerce_eraasoft/model/Authentication/auth_model.dart';
import 'package:ecommerce_eraasoft/view_model/data/network/DioHelper/dio_helper.dart';
import 'package:ecommerce_eraasoft/view_model/data/network/DioHelper/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/shared_preference/keys.dart';
import '../../data/local/shared_preference/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
 static AuthCubit get(context)=>BlocProvider.of<AuthCubit>(context);
  TextEditingController nameController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  AuthModel? authModel;
  Future<void>register()async{
   emit(RegistrationLoadingState());
   await DioHelper.post(endpoint: Endpoints.register,body: {
    "name":nameController.text,
    "phone":phoneController.text,
    "email":emailController.text,
    "password":passwordController.text,
   }).then((value){
    authModel =AuthModel.fromJson(value.data);
    print(value.data);
    LocalData.set(key:SharedKeys.token,value:authModel!.data!.token);
    emit(RegistrationSuccessState(
     message: authModel!.message!,
     status: authModel!.status!,
     token: authModel!.status!?authModel!.data!.token!:null
    ));
   }).catchError((error){
    print(error.toString());
    emit(RegistrationErrorState());
   });
  }

  Future<void>login()async{
   emit(LoginLoadingState());
   DioHelper.post(endpoint: Endpoints.login,body: {
    "email":emailController.text,
    "password":passwordController.text,
   }).then((value){
    authModel=AuthModel.fromJson(value.data);
    print(value.data);
    emit(LoginSuccessState(
        message: authModel!.message!,
        status: authModel!.status!,
        token: authModel!.status!?authModel!.data!.token!:null
    ));
   }).catchError((error){
    print(error.toString());
    emit(LoginErrorState());
   });
  }
}
