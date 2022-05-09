import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
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

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.of(context).pushNamed(EditProductScreen.routeName)
                  },
              icon: Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, idx) => Column(
              children: [
                UserProductItem(
                    id: productsData.items[idx].id,
                    title: productsData.items[idx].title,
                    imageUrl: productsData.items[idx].imageUrl),
                Divider()
              ],
            ),
            itemCount: productsData.items.length,
          ),
        ),
      ),
    );
  }
}
