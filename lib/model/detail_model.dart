import 'dart:convert';

import 'package:kaikhong/model/customer_model.dart';
import 'package:kaikhong/model/product_model.dart';

class Detail {
  Customer customer;
  Product product;
  static int detailNo = 0;

  Detail(
    this.customer,
    this.product,
  ) {
    this.customer = customer;
    this.product = product;
    detailNo++;
  }

  Detail copyWith({
    Customer customer,
    Product product,
  }) {
    return Detail(
      customer ?? this.customer,
      product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customer': customer.toMap(),
      'product': product.toMap(),
    };
  }

  factory Detail.fromMap(Map<dynamic, dynamic> map) {
    return Detail(
      Customer.fromMap(map['customer']),
      Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Detail.fromJson(String source) => Detail.fromMap(json.decode(source));

  @override
  String toString() => 'Detail(customer: $customer, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Detail &&
      other.customer == customer &&
      other.product == product;
  }

  @override
  int get hashCode => customer.hashCode ^ product.hashCode;
}
