part of 'cart_bloc.dart';

class CartState {
  final List<MockOrder> orders;
  final int selectedOrderId;
  final String selectedPaymentMethod;

  // Qarz ma'lumotlari
  final CustomerModel? selectedCustomer;
  final DateTime? debtDeadline;
  final String debtComment;
  final String paidAmount; // UI'da yozish oson bo'lishi uchun String

  CartState({
    required this.orders,
    required this.selectedOrderId,
    this.selectedPaymentMethod = "cash",
    this.selectedCustomer,
    this.debtDeadline,
    this.debtComment = "",
    this.paidAmount = "",
  });

  MockOrder? get selectedOrder {
    if (orders.isEmpty) return null;
    try {
      return orders.firstWhere((e) => e.transactionId == selectedOrderId);
    } catch (_) {
      return null;
    }
  }

  CartState copyWith({
    List<MockOrder>? orders,
    int? selectedOrderId,
    String? selectedPaymentMethod,
    // Bu yerda o'zgarish:
    CustomerModel? Function()? selectedCustomer,
    DateTime? Function()? debtDeadline,
    String? debtComment,
    String? paidAmount,
  }) {
    return CartState(
      orders: orders ?? this.orders,
      selectedOrderId: selectedOrderId ?? this.selectedOrderId,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      // Agar funksiya berilgan bo'lsa uni chaqiramiz (null bo'lsa ham), aks holda eskisini olamiz
      selectedCustomer:
          selectedCustomer != null ? selectedCustomer() : this.selectedCustomer,
      debtDeadline: debtDeadline != null ? debtDeadline() : this.debtDeadline,
      debtComment: debtComment ?? this.debtComment,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  // Reset uchun maxsus metod
  CartState resetDebt() {
    return copyWith(
      selectedCustomer: null,
      debtDeadline: null,
      debtComment: "",
      paidAmount: "",
    );
  }
}
