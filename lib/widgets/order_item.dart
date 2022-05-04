import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' as orderProvider;
import 'package:intl/intl.dart';
/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 6:06 PM
 */

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final orderProvider.OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyy hh:mm').format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
