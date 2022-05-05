import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/orders_screen.dart';
/**
 * Created by Trinh Kim Tuan.
 * Date:  5/4/2022
 * Time: 8:52 PM
 */

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('xxxx'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () => Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName),
          )
        ],
      ),
    );
  }
}
