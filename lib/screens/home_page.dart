import 'package:flutter/material.dart';
import 'package:search_in_pharmacy/modules/product.dart';
import 'package:search_in_pharmacy/services/locator.dart';
import 'package:search_in_pharmacy/services/pharmacy_service.dart';
import 'package:search_in_pharmacy/utilities/search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Product> products = [];

  getProducts() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    products = await locator<Pharmacy>().getProducts();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductsSearchDelegate(products),
              );
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => getProducts(),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product item = products[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(item.product),
                    trailing: Text(
                      item.onHand,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Source: ${item.source} , Total: ${item.qty}, Exp: ${item.expDate}"),
                  );
                },
              ),
            ),
    );
  }
}
