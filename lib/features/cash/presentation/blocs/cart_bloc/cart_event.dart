part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class InitializeCart extends CartEvent {}

class AddNewOrderEvent extends CartEvent {}

class SelectOrderEvent extends CartEvent {
  final int transactionId;
  SelectOrderEvent(this.transactionId);
}

class DeleteOrderEvent extends CartEvent {
  final int transactionId;
  DeleteOrderEvent(this.transactionId);
}

class AddProductToOrderEvent extends CartEvent {
  final CashProductModel product;
  AddProductToOrderEvent(this.product);
}

class RemoveProductFromOrderEvent extends CartEvent {
  final int productId;
  RemoveProductFromOrderEvent(this.productId);
}

class UpdateItemQuantityEvent extends CartEvent {
  final int productId;
  final double newQuantity;
  UpdateItemQuantityEvent(this.productId, this.newQuantity);
}

class UpdateItemPriceEvent extends CartEvent {
  final int productId;
  final String newPrice;
  UpdateItemPriceEvent(this.productId, this.newPrice);
}

class ResetOrderEvent extends CartEvent {}

/// Rulon qatorini metr / dona rejimiga o'tkazish
class ToggleItemByPieceEvent extends CartEvent {
  final int productId;
  final bool byPiece;
  ToggleItemByPieceEvent(this.productId, this.byPiece);
}

class ToggleWholesaleEvent extends CartEvent {
  final bool wholesale;
  ToggleWholesaleEvent(this.wholesale);
}

class UpdateDiscountEvent extends CartEvent {
  final double value;
  final bool isPercent;
  UpdateDiscountEvent({required this.value, required this.isPercent});
}

class ChangePaymentMethodEvent extends CartEvent {
  final String method;
  ChangePaymentMethodEvent(this.method);
}

class UpdateDebtDetailsEvent extends CartEvent {
  final CustomerModel? customer;
  final DateTime? deadline;
  final String? comment;
  final String? paidAmount;

  UpdateDebtDetailsEvent({
    this.customer,
    this.deadline,
    this.comment,
    this.paidAmount,
  });
}
