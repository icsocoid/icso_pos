import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:icso_pos/data/models/response/product_response_model.dart';

class ProductQuantity {
  final Product product;
  int quantity;

  ProductQuantity({
    required this.product,
    required this.quantity
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductQuantity &&
        product == other.product &&
        quantity == other.quantity;
  }


  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  Map<String, dynamic> toMap() {
    return {
      "product": product.toMap(),
      "quantity": quantity,
    };
  }

  Map<String, dynamic> toLocalMap(int orderId) {
    return {
      "id_order": orderId,
      "id_product": product.id,
      "quantity": quantity,
      "price": product.price,
    };
  }

  factory ProductQuantity.fromMap(Map<String, dynamic> map) {
    return ProductQuantity(
      product: Product.fromMap(map["product"]),
      quantity: map["quantity"]?.toInt() ?? 0,
    );
  }

  factory ProductQuantity.fromLocalMap(Map<String, dynamic> map) {
    return ProductQuantity(
      product: Product.fromOrderMap(map),
      quantity: map["quantity"]?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
  factory ProductQuantity.fromJson(String source) => ProductQuantity.fromMap(json.decode(source));
}