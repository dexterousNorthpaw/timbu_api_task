import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbu_api_task/providers/products_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<ProductsProvider>(context, listen: false);
      provider.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("RayCooks"),
        ),
        body: (provider.isLoading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: provider.items.length,
                itemBuilder: (context, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image(
                          image: NetworkImage(provider.items[index].imgUrl),
                        ),
                      ),
                      title: Text(provider.items[index].name),
                      subtitle:
                          Text(provider.items[index].description.toString()),
                      trailing: Text(
                        'N ${provider.items[index].price.toString()}',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                }));
  }
}
