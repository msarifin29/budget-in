// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bank_bloc.dart';

class BankState extends Equatable {
  const BankState({required this.bank});

  final List<BankModel> bank;

  @override
  List<Object> get props => [bank];
}
