import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Customer {
  final int customerId;
  final String customerName;
  final String customerDetail;
  Customer({
    @required this.customerId,
    @required this.customerName,
    @required this.customerDetail,
  });

  Customer copyWith({
    int customerId,
    String customerName,
    String customerDetail,
  }) {
    return Customer(
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerDetail: customerDetail ?? this.customerDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerDetail': customerDetail,
    };
  }

  factory Customer.fromMap(Map<dynamic, dynamic> map) {
    return Customer(
      customerId: map['customerId'],
      customerName: map['customerName'],
      customerDetail: map['customerDetail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() =>
      'Customer(customerId: $customerId, customerName: $customerName, customerDetail: $customerDetail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Customer &&
        other.customerId == customerId &&
        other.customerName == customerName &&
        other.customerDetail == customerDetail;
  }

  @override
  int get hashCode =>
      customerId.hashCode ^ customerName.hashCode ^ customerDetail.hashCode;
}
