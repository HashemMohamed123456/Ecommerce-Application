import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'show_or_hide_state.dart';
class ShowOrHideCubit extends Cubit<ShowOrHideState> {
  ShowOrHideCubit() : super(ShowOrHideInitial());
  static ShowOrHideCubit get(context) => BlocProvider.of<ShowOrHideCubit>(context);
  bool showPassword=false;
  bool obscureText=true;
  void hidePassword(){
    showPassword=!showPassword;
    obscureText=!obscureText;
    emit(ShowPasswordSuccess());
  }
}
