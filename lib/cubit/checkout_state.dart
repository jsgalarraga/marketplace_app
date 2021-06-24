part of 'checkout_cubit.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final bool success;

  CheckoutSuccess({required this.success});
}
