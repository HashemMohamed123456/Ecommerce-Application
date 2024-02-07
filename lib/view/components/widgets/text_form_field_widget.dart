import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextFormFieldCustom extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  const TextFormFieldCustom({super.key,
    this.controller,
    this.onTap,
    this.validator,
    this.hintText,
    this.textInputAction,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(cursorColor: AppColors.backgroundColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator:validator,
      controller:controller ,
      textInputAction:textInputAction,
      onTap: onTap,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: AppColors.backgroundColor
      ),
      obscureText:obscureText??false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
          fillColor: AppColors.textColor,
          errorStyle: GoogleFonts.openSans(
        color: Colors.red,
        fontSize: 15,
              fontWeight: FontWeight.bold,
      ),
        hintText: hintText,
        hintStyle: GoogleFonts.openSans(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.backgroundColor,
        ),
        prefixIcon: prefixIcon,
          prefixIconColor:AppColors.backgroundColor ,
        suffixIcon: suffixIcon,
          suffixIconColor:AppColors.backgroundColor ,

      enabledBorder: const OutlineInputBorder(
        borderSide:  BorderSide(width: 1,color: AppColors.backgroundColor),


      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 3)
      ),
      focusedBorder:const  OutlineInputBorder(
          borderSide:  BorderSide(width: 3),
      ),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.backgroundColor,width: 1)
      )),
    );
  }
}
