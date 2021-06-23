import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_app/cubit/cart_cubit.dart';
import 'package:marketplace_app/data/models/cart_item.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (!(state is CartUpdated) || state.cart.length == 0) {
            return Center(child: Text('Cart is empty'));
          }

          final List<CartItem> cart = state.cart;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartTile(item: cart[index]);
                  },
                ),
              ),
              CheckoutButton(),
            ],
          );
        },
      ),
    );
  }
}

class CartTile extends StatelessWidget {
  // Cart item tile with its image, name and quantity
  final CartItem item;

  const CartTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CartTileLeading(item: item),
      title: Text(item.product.name),
      trailing: CartTileTrailing(item: item),
    );
  }
}

class CartTileLeading extends StatelessWidget {
  // Leading widget with the image of the product or the first letter
  // in case it doesn't have an image url
  final CartItem item;
  const CartTileLeading({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.product.imageUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(item.product.imageUrl!),
      );
    }
    return CircleAvatar(
      child: Text(item.product.name[0]),
    );
  }
}

class CartTileTrailing extends StatelessWidget {
  // Trailing widget with the options to increment, decrement quantity
  // and remove the item from the cart
  final CartItem item;
  const CartTileTrailing({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            BlocProvider.of<CartCubit>(context).decrementProduct(item.product);
          },
          icon: Icon(Icons.remove),
        ),
        Text('${item.quantity}'),
        IconButton(
          onPressed: () {
            BlocProvider.of<CartCubit>(context).addProduct(item.product);
          },
          icon: Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            BlocProvider.of<CartCubit>(context).removeProduct(item.product);
          },
          icon: Icon(Icons.delete),
        ),
      ],
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text('Checkout'),
    );
  }
}
