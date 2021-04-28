import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Product {
  final int productID;
  final String productName;
  final String productTransportType;
  final int productTotal;
  final int productTotalPrice;
  final String productPaidType;
  final String productPaidStatus;
  Product({
    @required this.productID,
    @required this.productName,
    @required this.productTransportType,
    @required this.productTotal,
    @required this.productTotalPrice,
    @required this.productPaidType,
    @required this.productPaidStatus,
  });

  Product copyWith({
    int productID,
    String productName,
    String productTransportType,
    int productTotal,
    String productTotalPrice,
    String productPaidType,
    bool productPaidStatus,
  }) {
    return Product(
      productID: productID ?? this.productID,
      productName: productName ?? this.productName,
      productTransportType: productTransportType ?? this.productTransportType,
      productTotal: productTotal ?? this.productTotal,
      productTotalPrice: productTotalPrice ?? this.productTotalPrice,
      productPaidType: productPaidType ?? this.productPaidType,
      productPaidStatus: productPaidStatus ?? this.productPaidStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'productName': productName,
      'productTransportType': productTransportType,
      'productTotal': productTotal,
      'productTotalPrice': productTotalPrice,
      'productPaidType': productPaidType,
      'productPaidStatus': productPaidStatus,
    };
  }

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
      productID: map['productID'],
      productName: map['productName'],
      productTransportType: map['productTransportType'],
      productTotal: map['productTotal'],
      productTotalPrice: map['productTotalPrice'],
      productPaidType: map['productPaidType'],
      productPaidStatus: map['productPaidStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(productID: $productID, productName: $productName, productTransportType: $productTransportType, productTotal: $productTotal, productTotalPrice: $productTotalPrice, productPaidType: $productPaidType, productPaidStatus: $productPaidStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.productID == productID &&
        other.productName == productName &&
        other.productTransportType == productTransportType &&
        other.productTotal == productTotal &&
        other.productTotalPrice == productTotalPrice &&
        other.productPaidType == productPaidType &&
        other.productPaidStatus == productPaidStatus;
  }

  @override
  int get hashCode {
    return productID.hashCode ^
        productName.hashCode ^
        productTransportType.hashCode ^
        productTotal.hashCode ^
        productTotalPrice.hashCode ^
        productPaidType.hashCode ^
        productPaidStatus.hashCode;
  }
}
