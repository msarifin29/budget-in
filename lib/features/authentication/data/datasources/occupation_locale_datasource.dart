// ignore_for_file: one_member_abstracts

import 'dart:async';
import 'dart:convert';

import 'package:budget_in/core/core.dart';
import 'package:flutter/services.dart';

abstract class OccupationLocaleDataSource {
  FutureOr<List<String>> getOccupations();
}

class OccupationLocaleDataSourceImpl implements OccupationLocaleDataSource {
  @override
  FutureOr<List<String>> getOccupations() async {
    final jsonStr =
        await rootBundle.loadString('${BaseAsset.other}occupation_id.json');
    // ignore: lines_longer_than_80_chars
    final jsonData = json.decode(jsonStr) as Map<String, dynamic>;

    final occupations =
        List<String>.from(jsonData['data'] as Iterable<dynamic>);

    return occupations;
  }
}
