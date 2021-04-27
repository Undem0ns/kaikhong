import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Custommer {
  final String name;
  final String transportType;
  final String detial;
  final int itemNumber;
  final String price;
  final String paidType;
  final bool paid;
  final int no;
  Custommer({
    @required this.name,
    @required this.transportType,
    @required this.detial,
    @required this.itemNumber,
    @required this.price,
    @required this.paidType,
    @required this.paid,
    @required this.no,
  });

  Custommer copyWith({
    String name,
    String transportType,
    String detial,
    int itemNumber,
    String price,
    String paidType,
    bool paid,
    int no,
  }) {
    return Custommer(
      name: name ?? this.name,
      transportType: transportType ?? this.transportType,
      detial: detial ?? this.detial,
      itemNumber: itemNumber ?? this.itemNumber,
      price: price ?? this.price,
      paidType: paidType ?? this.paidType,
      paid: paid ?? this.paid,
      no: no ?? this.no,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'transportType': transportType,
      'detial': detial,
      'itemNumber': itemNumber,
      'price': price,
      'paidType': paidType,
      'paid': paid,
      'no': no,
    };
  }

  factory Custommer.fromMap(Map<dynamic, dynamic> map) {
    return Custommer(
      name: map['name'],
      transportType: map['transportType'],
      detial: map['detial'],
      itemNumber: map['itemNumber'],
      price: map['price'],
      paidType: map['paidType'],
      paid: map['paid'],
      no: map['no'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Custommer.fromJson(String source) =>
      Custommer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Custommer(name: $name, transportType: $transportType, detial: $detial, itemNumber: $itemNumber, price: $price, paidType: $paidType, paid: $paid, no: $no)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Custommer &&
        other.name == name &&
        other.transportType == transportType &&
        other.detial == detial &&
        other.itemNumber == itemNumber &&
        other.price == price &&
        other.paidType == paidType &&
        other.paid == paid &&
        other.no == no;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        transportType.hashCode ^
        detial.hashCode ^
        itemNumber.hashCode ^
        price.hashCode ^
        paidType.hashCode ^
        paid.hashCode ^
        no.hashCode;
  }
}
