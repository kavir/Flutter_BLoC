import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_android_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:my_android_bloc/features/cart/ui/cart_tile_widget.dart';
import 'package:my_android_bloc/features/home/ui/product_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  void initState(){
    cartBloc.add(CartInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Item'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc:cartBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        listenWhen: (previous,current)=>current is CartActionState,
        buildWhen: (previous,current)=> current is !CartActionState,
        builder: (context, state) {
          switch(state.runtimeType){
            case CartSuccessState:
            final successState=state as  CartSuccessState;
            return ListView.builder(
              itemCount: successState.cartItems.length,
              itemBuilder: (context,index){
              return CartTileWidget(
                cartBloc: cartBloc,
                productDataModel: successState.cartItems[index]);
            });
          }
          return Container(

          );
        },
      ),
    );
  }
}
