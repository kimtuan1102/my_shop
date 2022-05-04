import 'package:flutter/material.dart';

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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text(title),
          subtitle: Text('Total: \$ ${price* quantity}'),
          leading: CircleAvatar(
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(title),
              ),
            ),
          ),
          trailing: Text(quantity.toString()),
        ),
      ),
    );
  }
}
