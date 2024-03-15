part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent extends Equatable {
  const GetExpensesEvent();

  @override
  List<Object> get props => [];
}

final class OnGetInitialExpenses extends GetExpensesEvent {
  final GetExpensesparams params;
  const OnGetInitialExpenses({required this.params});
  @override
  List<Object> get props => [params];
  @override
  String toString() {
    return 'OnGetInitialExpenses{params:$params}';
  }
}
