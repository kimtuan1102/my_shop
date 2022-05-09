import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

/**
 * Created by Trinh Kim Tuan.
 * Date:  5/5/2022
 * Time: 10:51 AM
 */
class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key, required this.title, required this.imageUrl, required this.id})
      : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id),
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false).deleteProduct(id);
                  }
                  catch (error) {
                    _scaffold.showSnackBar(SnackBar(content: Text('Delete failed', textAlign: TextAlign.center,)));
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
