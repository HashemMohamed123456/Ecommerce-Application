import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_eraasoft/view/components/widgets/text_custom_widget.dart';
import 'package:ecommerce_eraasoft/view_model/utilis/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../view_model/bloc/EcommerceCubit/ecommerce_cubit.dart';

class Constructions {
  static ClipRRect constructImage(
      {double radius = 0, required imageUrl, required String fit}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: fit == 'fill' ? BoxFit.fill : fit == 'cover'
            ? BoxFit.cover
            : BoxFit.contain,
        imageUrl: imageUrl,
        placeholder: (context, url) => constructLoadingProgressIndicator(),
        errorWidget: (context, url, error) =>
        (const Icon(Icons.error, color: Colors.red,)),
      ),
    );
  }

  static Center constructLoadingProgressIndicator({double size = 50}) {
    return Center(child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.textColor, size: size));
  }

  static SnackBar constructSnackBar(
      {required int num, required String title, required String message, milSeconds = 3000}) {
    return SnackBar(
        duration: Duration(milliseconds: milSeconds),
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: num == 0 ?
          ContentType.failure :
          num == 1 ? ContentType.success :
          ContentType.warning,
        ));
  }

  static Container constructSlider({required double width,
    required double height,
    required CarouselController carouselController,
    required EcommerceCubit cubit,
    List<String>? items,
    required int length,}) {
    return Container(width: width, height: height,
      child: CarouselSlider.builder(carouselController: carouselController,
          itemCount: length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Constructions.constructImage(
                  imageUrl: items != null ? items[index] : cubit.homeModel!
                      .data!.banners![index].image,
                  fit: 'fill',
                  radius: 10),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              if (items != null) {
                cubit.changeSmoothIndicatorSliderIndex(index);
              }
            },
            aspectRatio: 16 / 10,
            viewportFraction: 0.90,
            initialPage: 0,
            enableInfiniteScroll: true,
            //reverse: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
          )),);
  }

  static  buildProductItem(double height,
      double width,
      {
        required String image,
        required String name,
        required String price,
        required int index,
        required String from,
        required isFavourite,
        required int id,
        required EcommerceCubit cubit,

      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.textColor,),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.02,
          ),
          SizedBox(
            child: Constructions.constructImage(
              fit: 'contain',
              imageUrl: image,
            ),
            height: height * 0.2,
            width: width,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            height: height * 0.07,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextCustom(
                text: name,
                maxLines: 2,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                TextCustom(
                  text:
                  '$price EGP',
                  color: AppColors.backgroundColor,
                  fontSize: 20,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (from == 'home') {
                      cubit.changeFavoriteStatusInHomeProducts(
                          index: index);
                      cubit.changeFavoritesStatus(id: id);
                    }
                    else {
                      cubit.changeFavoritesStatus(id: id).then((value) {
                        cubit.getHomeData();
                      });
                      cubit.changeFavoriteStatusInCategoryProducts(index: index);
                    }
                  },
                  child: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : Colors.grey,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
