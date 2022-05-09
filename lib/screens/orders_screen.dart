import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/orders.dart' show Orders;
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/order_item.dart';
import 'package:provider/provider.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 6:05 PM
 */
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }
  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('building');

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapShot.error != null) {
            return Center(
              child: Text('An error occurred'),
            );
          } else {
            return Consumer<Orders>(
              builder: (BuildContext context, value, Widget? child) =>
                  ListView.builder(
                itemBuilder: (ctx, idx) => OrderItem(
                  order: value.orders[idx],
                ),
                itemCount: value.orders.length,
              ),
            );
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
