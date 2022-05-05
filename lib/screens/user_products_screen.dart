import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/5/2022
 * Time: 10:39 AM
 */
class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [IconButton(onPressed: () => {}, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, idx) => UserProductItem(
              title: productsData.items[idx].title,
              imageUrl: productsData.items[idx].imageUrl),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
