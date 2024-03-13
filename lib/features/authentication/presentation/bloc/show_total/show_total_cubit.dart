import 'package:bloc/bloc.dart';

class ShowTotalCubit extends Cubit<bool> {
  ShowTotalCubit() : super(true);
  void showBalance(bool isVisible) => emit(isVisible);
}
