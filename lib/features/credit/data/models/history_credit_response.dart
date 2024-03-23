// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_credit_response.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryResponse extends Equatable {
  final HistoryCreditData data;
  const HistoryResponse({
    required this.data,
  });
  static HistoryResponse fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$HistoryResponseToJson(this);
  @override
  List<Object?> get props => [];
  @override
  String toString() {
    return 'HistoryResponse{}';
  }
}

@JsonSerializable(explicitToJson: true)
class HistoryCreditData extends Equatable {
  final int page;
  @JsonKey(name: "total_page")
  final int totalPage;
  @JsonKey(name: "last_page")
  final int lastPage;
  final int total;
  final List<HistoryCredit> data;
  const HistoryCreditData({
    required this.page,
    required this.totalPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });
  static HistoryCreditData fromJson(Map<String, dynamic> json) =>
      _$HistoryCreditDataFromJson(json);
  Map<String?, dynamic> toJson() => _$HistoryCreditDataToJson(this);
  @override
  List<Object?> get props => [
        page,
        totalPage,
        lastPage,
        total,
        data,
      ];
  @override
  String toString() {
    return 'HistoryCreditData{}';
  }
}

@JsonSerializable(explicitToJson: true)
class HistoryCredit extends Equatable {
  final int id;
  final int th;
  final int total;
  final String status;
  @JsonKey(name: "type_payment")
  final String typePayment;

  @JsonKey(name: "created_at")
  final String createdAt;
  const HistoryCredit({
    required this.id,
    required this.th,
    required this.total,
    required this.status,
    required this.typePayment,
    required this.createdAt,
  });

  static HistoryCredit fromJson(Map<String, dynamic> json) =>
      _$HistoryCreditFromJson(json);
  Map<String?, dynamic> toJson() => _$HistoryCreditToJson(this);
  @override
  List<Object?> get props => [
        id,
        th,
        total,
        status,
        typePayment,
        createdAt,
      ];
  @override
  String toString() {
    return 'HistoryCredit{}';
  }
}
