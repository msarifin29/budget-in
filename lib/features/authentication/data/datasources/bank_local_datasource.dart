// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: one_member_abstracts

import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import 'package:budget_in/core/core.dart';

abstract class BankLocaleDataSource {
  FutureOr<List<BankModel>> getBank();
}

class BankLocaleDataSourceImpl implements BankLocaleDataSource {
  @override
  FutureOr<List<BankModel>> getBank() async {
    final jsonStr = await rootBundle.loadString('${BaseAsset.other}bank.json');
    final jsonData = json.decode(jsonStr) as List<dynamic>;

    final banks = jsonData.map((e) => BankModel.fromJson(e)).toList();
    return banks;
  }
}

class BankModel extends Equatable {
  final String name;
  final String code;
  const BankModel({
    required this.name,
    required this.code,
  });
  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }
  @override
  List<Object?> get props => [name, code];
}
