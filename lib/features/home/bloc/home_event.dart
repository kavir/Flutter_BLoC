part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}
class HomeProductWishlistButtonClickedEvent extends HomeEvent{

}

class HomeProductCartButtonClickedEvent extends HomeEvent{

}
class HomeWishlistButtonlNavigateEvent extends HomeEvent{

}

class HomeCartButtonlNavigateEvent extends HomeEvent{

}