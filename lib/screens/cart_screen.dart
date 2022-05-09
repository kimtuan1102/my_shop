import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart' show Cart;
import 'package:flutter_complete_guide/providers/orders.dart';
import 'package:flutter_complete_guide/widgets/cart_item.dart';
import 'package:provider/provider.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 2:53 PM
 */
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/your-cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: [
            Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total"),
                      Spacer(),
                      Chip(
                        label: Text(
                          '\$ ${cart.totalAmount()}',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      OrderButton(cart: cart)
                    ],
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, idx) => CartItem(
                id: cart.items.values.toList()[idx].id,
                price: cart.items.values.toList()[idx].price,
                quantity: cart.items.values.toList()[idx].quantity,
                title: cart.items.values.toList()[idx].title,
              ),
              itemCount: cart.itemCount(),
            ))
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : TextButton(
      onPressed: (widget.cart.items.length <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount());
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      child: Text(
        'ORDER NOW',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
