part of 'home_bloc.dart';

@immutable
sealed class HomeState {}
abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

//to fetch data from server loading dekhaunaw ko lagi
class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessStatee extends HomeState{
  final List<ProductDataModel>products;

  HomeLoadedSuccessStatee({required this.products});

}

//if kehi error encounter vayo vaney yo state call garaunaey
class HomeErrorStatee extends HomeState{}

class HomeNavigateToWhishListpageActionState extends HomeActionState{}
class HomeNavigateToCartpageActionState extends HomeActionState{}