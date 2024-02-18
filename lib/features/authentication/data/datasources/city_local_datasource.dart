// ignore_for_file: one_member_abstracts

import 'dart:async';
import 'dart:convert';

import 'package:budget_in/core/core.dart';
import 'package:flutter/services.dart';

abstract class CityLocaleDataSource {
  FutureOr<List<String>> getCities();
}

class CityLocaleDataSourceImpl implements CityLocaleDataSource {
  @override
  FutureOr<List<String>> getCities() async {
    final jsonStr = await rootBundle.loadString('${BaseAsset.other}city.json');
    final jsonData = json.decode(jsonStr) as Map<String, dynamic>;
    final cities = List<String>.from(jsonData['data'] as Iterable<dynamic>);

    return cities;
  }
}
