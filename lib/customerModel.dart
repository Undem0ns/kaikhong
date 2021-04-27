import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kaikhong/customer.dart';

class CustomerModel {
  final Custommer custommer;
  CustomerModel({
    @required this.custommer,
  });

  CustomerModel copyWith({
    Custommer custommer,
  }) {
    return CustomerModel(
      custommer: custommer ?? this.custommer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'custommer': custommer.toMap(),
    };
  }

  factory CustomerModel.fromMap(Map<dynamic, dynamic> map) {
    return CustomerModel(
      custommer: Custommer.fromMap(map['custommer']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() => 'CustomerModel(custommer: $custommer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel && other.custommer == custommer;
  }

  @override
  int get hashCode => custommer.hashCode;
}
