import 'package:carousel_slider/carousel_controller.dart';
import 'package:ecommerce_eraasoft/model/Cart/cart_model.dart';
import 'package:ecommerce_eraasoft/model/Cart/cart_status_model.dart';
import 'package:ecommerce_eraasoft/model/Categories/categories_model.dart';
import 'package:ecommerce_eraasoft/model/Categories/category_details.dart';
import 'package:ecommerce_eraasoft/model/Favorites/favorites_model.dart';
import 'package:ecommerce_eraasoft/model/Favorites/favorites_status_model.dart';
import 'package:ecommerce_eraasoft/model/Home%20Model/home_model.dart';
import 'package:ecommerce_eraasoft/view/screens/Cart/cart_screen.dart';
import 'package:ecommerce_eraasoft/view/screens/Category/categories_screen.dart';
import 'package:ecommerce_eraasoft/view/screens/Favories/favorites_screen.dart';
import 'package:ecommerce_eraasoft/view/screens/Home/home_screen.dart';
import 'package:ecommerce_eraasoft/view_model/data/local/shared_preference/keys.dart';
import 'package:ecommerce_eraasoft/view_model/data/network/DioHelper/dio_helper.dart';
import 'package:ecommerce_eraasoft/view_model/data/network/DioHelper/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/shared_preference/shared_preferences.dart';
part 'ecommerce_state.dart';

class EcommerceCubit extends Cubit<EcommerceState> {
  EcommerceCubit() : super(EcommerceInitial());

  static EcommerceCubit get(context) =>
      BlocProvider.of<EcommerceCubit>(context);
  List<Widget>screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const FavoritesScreen(),
  ];
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  CategoryProductsDetails? categoryProductsDetails;
  FavoritesStatusModel? favoritesStatusModel;
  FavoritesModel? favoritesModel;
  CartStatusModel? cartStatusModel;
  CartModel? cartModel;
  int currentScreenIndex = 0;
  int currentIndexSlider = 0;
  CarouselController carouselController = CarouselController();
  CarouselController secondCarouselController = CarouselController();
  int currentProductIndex=0;
  int currentSmoothIndicatorSliderIndex=0;


void changeSmoothIndicatorSliderIndex(int index){
  currentSmoothIndicatorSliderIndex=index;
  emit(ChangedSmoothIndicatorIndexSliderState());
}
  void changeScreenIndex(index) {
    currentScreenIndex = index;
    emit(ChangedScreenIndexState());
    if(index==3){
      getAllFavoriteProducts();
    }else if(index==2){
      getAllCartProducts();
    }
  }

  Future<void> getHomeData() async {
    emit(GettingHomeDataLoadingState());
    await DioHelper.get(endpoint: Endpoints.home,token:LocalData.get(key:SharedKeys.token)).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(value.data);
      emit(GettingHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GettingHomeDataErrorState());
    });
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    await DioHelper.get(endpoint: Endpoints.categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(value.data);
      emit(GetCategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoriesErrorState());
    });
  }
  Future<void>getCategoryProducts({required int id})async{
    emit(GetCategoryProductsLoadingState());
    await DioHelper.get(endpoint: Endpoints.categoryProducts,params: {
      'category_id':id
    }).then((value){
      categoryProductsDetails=CategoryProductsDetails.fromJson(value.data);
      emit(GetCategoryProductsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoryProductsErrorState());
    });
  }
  Future<void>changeFavoritesStatus({required int id})async{
  emit(ChangeFavoritesStatusLoadingState());
  await DioHelper.post(endpoint:Endpoints.favorites,
      body: {'product_id':id },token: LocalData.get(key: SharedKeys.token)).then((value){
  favoritesStatusModel=FavoritesStatusModel.fromJson(value.data);
  emit(ChangeFavoritesStatusSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(ChangeFavoritesStatusErrorState());
  });
  }
  void changeFavoriteStatusInSales({required int index}){
  if(homeModel!.data!.salesProducts[index].inFavorites!){
    homeModel!.data!.salesProducts[index].inFavorites=false;
  }else{
    homeModel!.data!.salesProducts[index].inFavorites=true;
  }
  emit(ChangeFavoriteStatusInSalesSuccess());
  }
  void changeFavoriteStatusInHomeProducts({required int index}){
    if(homeModel!.data!.products![index].inFavorites!){
      homeModel!.data!.products![index].inFavorites=false;
    }else{
      homeModel!.data!.products![index].inFavorites=true;
    }
    emit(ChangeFavoriteStatusInHomeProductsSuccess());
  }
  void changeFavoriteStatusInCategoryProducts({required int index}){
    if(categoryProductsDetails!.data!.products![index].inFavorites!){
      categoryProductsDetails!.data!.products![index].inFavorites=false;
    }else{
      categoryProductsDetails!.data!.products![index].inFavorites=true;
    }
    emit(ChangeFavoriteStatusInHomeProductsSuccess());
  }
  Future<void>getAllFavoriteProducts()async{
emit(GetAllFavoriteProductsLoadingState());
await DioHelper.get(endpoint: Endpoints.favorites,token: LocalData.get(key:SharedKeys.token)).then((value){
  favoritesModel=FavoritesModel.fromJson(value.data);
  print(value.data);
  emit(GetAllFavoriteProductsSuccessState());
}).catchError((error){
  print(error.toString());
  emit(GetAllFavoriteProductsErrorState());
});
  }
  Future<void>changeProductCartStatus({required int id})async{
  emit(ChangeProductCartStatusLoadingState());
  await DioHelper.post(endpoint:Endpoints.carts,body: {
    'product_id':id
  },token:LocalData.get(key: SharedKeys.token)).then((value){
    cartStatusModel=CartStatusModel.fromJson(value.data);
    print(value.data);
    emit(ChangeProductCartStatusSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(ChangeProductCartStatusErrorState());
  });
  }
  Future<void>getAllCartProducts()async{
  emit(GetAllCartProductsLoadingState());
  await DioHelper.get(endpoint:Endpoints.carts,token:LocalData.get(key:SharedKeys.token)).then((value){
    cartModel=CartModel.fromJson(value.data);
    print(value.data);
    emit(GetAllCartProductsSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(GetAllCartProductsErrorState());
  });
  }
}

