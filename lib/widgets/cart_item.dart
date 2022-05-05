import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:provider/provider.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 3:32 PM
 */
class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.id,
      required this.price,
      required this.quantity,
      required this.title})
      : super(key: key);
  final String id;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want remove item in the cart?'),
                actions: [
                  TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text('No')),
                  TextButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text('Yes'))
                ],
              )),
      onDismissed: (direction) => cart.removeItem(id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            title: Text(title),
            subtitle: Text('Total: \$ ${price * quantity}'),
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(title),
                ),
              ),
            ),
            trailing: Text('${quantity.toString()}x'),
          ),
        ),
      ),
    );
  }
}
