import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_android_bloc/data/Guitar_data.dart';
import 'package:my_android_bloc/data/cart_items.dart';
import 'package:my_android_bloc/data/wishlist_items.dart';
import 'package:my_android_bloc/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonlNavigateEvent>(homeWishlistButtonlNavigateEvent);
    on<HomeCartButtonlNavigateEvent>(homeCartButtonlNavigateEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds:3));
    emit(HomeLoadedSuccessStatee(products: GuitarData.guitarProducts.map((e) => ProductDataModel(
      id: e['id'], 
      name: e['name'], 
      description: e['description'], 
      price: e['price'], 
      imageUrl: e['imageUrl'])).toList())) ;
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
    HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {

      print("Wishlist product clicked");
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWishListedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
      print("Cart product clicked");
      cartItems.add(event.clickedProduct);
      emit(HomeProductItemWcartedActionState());
  }
  

 FutureOr<void> homeWishlistButtonlNavigateEvent(
  HomeWishlistButtonlNavigateEvent event, Emitter<HomeState> emit) {
    print("Wishlist Navigate clicked");
    emit(HomeNavigateToWhishListpageActionState());
    
    
 }

 FutureOr<void> homeCartButtonlNavigateEvent(
  HomeCartButtonlNavigateEvent event, Emitter<HomeState> emit) {
    print("Cart Navigate clicked");
    emit(HomeNavigateToCartpageActionState());
 }

  
}