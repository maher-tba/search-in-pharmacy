class Product {
  late int id;
  late String product;
  late String qty;
  late String source;
  late String onHand;
  late String expDate;

  Product({
    required this.id,
    required this.product,
    required this.expDate,
    required this.qty,
    required this.source,
    required this.onHand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      product: json['Product'].toString(),
      expDate: json['ExpDate'].toString(),
      qty: json['Qty'].toString(),
      source: json['source'].toString(),
      onHand: json['OnHand'].toString(),
    );
  }
}
