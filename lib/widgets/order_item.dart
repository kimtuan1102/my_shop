import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' as orderProvider;
import 'package:intl/intl.dart';
/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 6:06 PM
 */

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final orderProvider.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.all(5),
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView.builder(
                itemBuilder: (ctx, idx) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.order.products[idx].title),
                    Spacer(),
                    Text('${widget.order.products[idx].quantity.toString()}x'),
                    Text('\$${widget.order.products[idx].price.toString()}')
                  ],
                ),
                itemCount: widget.order.products.length,
              ),
            )
        ],
      ),
    );
  }
}
