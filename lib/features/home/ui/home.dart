import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_android_bloc/features/cart/ui/cart.dart';
import 'package:my_android_bloc/features/home/bloc/home_bloc.dart';
import 'package:my_android_bloc/features/home/ui/product_tile_widget.dart';
import 'package:my_android_bloc/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc=HomeBloc();
  @override
  void initState(){
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  Widget build(BuildContext context) {
    //BLoC consumer is going to listen to state and event both where scaffold is not useful
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current)=> current is HomeActionState,
      buildWhen: (previous,current)=>current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToCartpageActionState){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Cart()));
        }
        else if(state is HomeNavigateToWhishListpageActionState){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Wishlist()));
        }
        else if(state is HomeProductItemWcartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("item listed in a cart")));
        }
        else if(state is HomeProductItemWishListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("item listed in a wishlist")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body:Center(
                child: CircularProgressIndicator()) ,);
            
          case HomeLoadedSuccessStatee:
          final successState=state as HomeLoadedSuccessStatee;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text("Organo Agora"),
              actions: [
                IconButton(onPressed: (){
                  homeBloc.add(HomeWishlistButtonlNavigateEvent());
                }, icon: Icon(Icons.favorite_border)),
                IconButton(onPressed: (){
                  homeBloc.add(HomeCartButtonlNavigateEvent());
                }, icon: Icon(Icons.shopping_bag_outlined)),

              ],

            ),

            body:ListView.builder(
              itemCount: successState.products.length,
              itemBuilder: (context,index){
              return ProductTileWidget(
                homeBloc: homeBloc,
                productDataModel: successState.products[index]);
            }),
          );
        
          
        case HomeErrorStatee:
        return Scaffold(body: Center(child: Text('error')));

          default:
          return SizedBox();
        }
        
      },
    );
  }
}

