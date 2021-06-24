import 'package:bloc/bloc.dart';
import 'package:marketplace_app/data/repository.dart';
import 'package:meta/meta.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final Repository repository;
  CheckoutCubit({required this.repository}) : super(CheckoutInitial());

  void checkout() {
    if (repository.cartCheckout()) {
      repository.emptyCart();
      emit(CheckoutSuccess(success: true));
    } else {
      emit(CheckoutSuccess(success: false));
    }
  }
}
