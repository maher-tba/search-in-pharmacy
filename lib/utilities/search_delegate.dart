import 'package:flutter/material.dart';
import 'package:search_in_pharmacy/modules/product.dart';

class ProductsSearchDelegate extends SearchDelegate<dynamic> {
  final List<Product> products;

  ProductsSearchDelegate(this.products);
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            if (query.isNotEmpty) {
              showResults(context);
            }
          },
        ),
        const SizedBox(width: 10),
      ];

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> results = products.where((item) {
      final result = item.product.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return query.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              ListTile(
                title: Text(
                  'Results: ${results.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                visualDensity: VisualDensity.compact,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final productItem = results[index];
                    return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(productItem.product),
                        trailing: Text(
                          productItem.onHand,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            "Source: ${productItem.source} , Total: ${productItem.qty}, Exp: ${productItem.expDate}"),
                     );
                  },
                ),
              ),
            ],
          );
  }

  @override
  Widget buildSuggestions(Object context) {
    return const SizedBox.shrink();
  }
}
