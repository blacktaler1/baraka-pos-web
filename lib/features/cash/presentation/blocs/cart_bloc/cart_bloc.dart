import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../debtors/domain/model/customer_model.dart';
import '../../../domain/model/cash_product_model.dart';
import '../../../data/source/local_source/cart_local_source.dart';
import '../../../domain/model/mock_order.dart';

// Kerakli importlarni qo'shing (MockOrder, CashProductModel va h.k.)

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartLocalSource? storage;

  CartBloc({this.storage}) : super(CartState(orders: [], selectedOrderId: 0)) {
    on<InitializeCart>(_onInitialize);
    on<AddNewOrderEvent>(_onAddNewOrder);
    on<SelectOrderEvent>(_onSelectOrder);
    on<DeleteOrderEvent>(_onDeleteOrder);
    on<AddProductToOrderEvent>(_onAddProduct);
    on<RemoveProductFromOrderEvent>(_onRemoveProduct);
    on<UpdateItemQuantityEvent>(_onUpdateQuantity);
    on<ResetOrderEvent>(_onResetOrder);
    on<ChangePaymentMethodEvent>(_onChangePaymentMethod);
    on<UpdateDebtDetailsEvent>(_onUpdateDebtDetails);
    on<UpdateItemPriceEvent>(_onUpdatePrice);
    on<ToggleWholesaleEvent>(_onToggleWholesale);
    on<UpdateDiscountEvent>(_onUpdateDiscount);
  }

  @override
  void onChange(Change<CartState> change) {
    super.onChange(change);
    final next = change.nextState;
    storage?.save(next.orders, next.selectedOrderId);
  }

  Future<void> _onInitialize(
      InitializeCart event, Emitter<CartState> emit) async {
    final saved = await storage?.load();
    if (saved != null) {
      emit(CartState(
        orders: saved.orders,
        selectedOrderId:
            saved.orders.any((o) => o.transactionId == saved.selectedOrderId)
                ? saved.selectedOrderId
                : saved.orders.first.transactionId,
        selectedPaymentMethod: 'cash',
      ));
      return;
    }

    final order = MockOrder(
      transactionId: 1,
      items: [],
    );

    emit(
      CartState(
        orders: [order],
        selectedOrderId: order.transactionId,
        selectedPaymentMethod: 'cash',
      ),
    );
  }

  void _onAddNewOrder(AddNewOrderEvent event, Emitter<CartState> emit) {
    int newTransactionId = (state.orders.isNotEmpty
            ? state.orders
                .map((e) => e.transactionId)
                .reduce((a, b) => a > b ? a : b)
            : 0) +
        1;

    final newOrder = MockOrder(
      transactionId: newTransactionId,
      items: [],
    );

    // Listni yangilaymiz (yangi nusxa yaratish muhim)
    final updatedOrders = List<MockOrder>.from(state.orders)
      ..insert(0, newOrder);

    emit(state.copyWith(
      orders: updatedOrders,
      selectedOrderId: newTransactionId,
    ));
  }

  void _onSelectOrder(SelectOrderEvent event, Emitter<CartState> emit) {
    emit(state.copyWith(selectedOrderId: event.transactionId));
  }

  void _onDeleteOrder(DeleteOrderEvent event, Emitter<CartState> emit) {
    final updatedOrders = List<MockOrder>.from(state.orders)
      ..removeWhere((e) => e.transactionId == event.transactionId);

    int newSelectedId = state.selectedOrderId;

    // Agar o'chirilayotgan order tanlangan bo'lsa, boshqasini tanlaymiz
    if (state.selectedOrderId == event.transactionId) {
      newSelectedId =
          updatedOrders.isNotEmpty ? updatedOrders.first.transactionId : 0;
    }

    emit(state.copyWith(
      orders: updatedOrders,
      selectedOrderId: newSelectedId,
    ));

    // Agar hammasi o'chib ketsa, yangisini yaratish kerak yoki pop qilish kerak (UI da hal qilinadi)
    if (updatedOrders.isEmpty) {
      // UI logic: odatda bo'sh qolganda avtomatik yangi ochiladi yoki ekran yopiladi
      add(AddNewOrderEvent());
    }
  }

  void _onAddProduct(AddProductToOrderEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    // Orderni nusxalaymiz (items listini ham yangi list qilamiz)
    final newItems = List<OrderItem>.from(currentOrder.items);
    int itemIndex = newItems.indexWhere((e) => e.productId == event.product.id);

    if (itemIndex == -1) {
      final item = OrderItem(
        productId: event.product.id,
        title: event.product.title,
        price: event.product.price,
        wholesalePrice: event.product.wholesalePrice,
        unit: event.product.unit,
        quantity: double.parse(event.product.stock) < 1
            ? double.parse(event.product.stock)
            : 1,
        stock: event.product.stock,
      );
      item.price = item.priceFor(wholesale: currentOrder.wholesale);
      newItems.add(item);
    } else {
      if (newItems[itemIndex].quantity <
          double.parse(newItems[itemIndex].stock)) {
        newItems[itemIndex].quantity++;
      }
    }

    _updateOrderAndEmit(currentOrder.transactionId, newItems, emit);
  }

  void _onRemoveProduct(
      RemoveProductFromOrderEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    final newItems = List<OrderItem>.from(currentOrder.items)
      ..removeWhere((e) => e.productId == event.productId);

    _updateOrderAndEmit(currentOrder.transactionId, newItems, emit);
  }

  void _onUpdateQuantity(
      UpdateItemQuantityEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    final newItems = List<OrderItem>.from(currentOrder.items);
    int itemIndex = newItems.indexWhere((e) => e.productId == event.productId);

    if (itemIndex != -1) {
      newItems[itemIndex].quantity = event.newQuantity; // double
      _updateOrderAndEmit(currentOrder.transactionId, newItems, emit);
    }
  }

  void _onResetOrder(ResetOrderEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    final updatedOrders = state.orders.map((order) {
      if (order.transactionId == currentOrder.transactionId) {
        return MockOrder(
          transactionId: order.transactionId,
          items: [], // Savatni tozalash
        );
      }
      return order;
    }).toList();

    emit(CartState(
      orders: updatedOrders,
      selectedOrderId: state.selectedOrderId,
      selectedPaymentMethod: 'cash',
      selectedCustomer: null,
      debtDeadline: null,
      debtComment: '',
      paidAmount: '',
    ));
  }

  void _onChangePaymentMethod(
      ChangePaymentMethodEvent event, Emitter<CartState> emit) {
    if (event.method == 'cash') {
      emit(
        state.copyWith(
          selectedPaymentMethod: 'cash',
          selectedCustomer: null,
          debtDeadline: null,
          debtComment: '',
          paidAmount: '',
        ),
      );
    } else {
      // debt tanlandi
      emit(state.copyWith(selectedPaymentMethod: event.method));
    }
  }

  void _updateOrderAndEmit(
      int transactionId, List<OrderItem> newItems, Emitter<CartState> emit) {
    _replaceOrder(
      transactionId,
      (order) => order.copyWith(items: newItems),
      emit,
    );
  }

  void _replaceOrder(int transactionId, MockOrder Function(MockOrder) update,
      Emitter<CartState> emit) {
    final updatedOrders = state.orders
        .map((order) =>
            order.transactionId == transactionId ? update(order) : order)
        .toList();

    emit(state.copyWith(orders: updatedOrders));
  }

  void _onToggleWholesale(ToggleWholesaleEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    final newItems = currentOrder.items.map((item) {
      item.price = item.priceFor(wholesale: event.wholesale);
      return item;
    }).toList();

    _replaceOrder(
      currentOrder.transactionId,
      (order) => order.copyWith(items: newItems, wholesale: event.wholesale),
      emit,
    );
  }

  void _onUpdateDiscount(UpdateDiscountEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    _replaceOrder(
      currentOrder.transactionId,
      (order) => order.copyWith(
        discountValue: event.value < 0 ? 0 : event.value,
        discountIsPercent: event.isPercent,
      ),
      emit,
    );
  }

  void _onUpdateDebtDetails(
      UpdateDebtDetailsEvent event, Emitter<CartState> emit) {
    emit(state.copyWith(
      selectedCustomer: event.customer != null ? () => event.customer : null,
      debtDeadline: event.deadline != null ? () => event.deadline : null,
      debtComment: event.comment,
      paidAmount: event.paidAmount,
    ));
  }

  void _onUpdatePrice(UpdateItemPriceEvent event, Emitter<CartState> emit) {
    final currentOrder = state.selectedOrder;
    if (currentOrder == null) return;

    final newItems = List<OrderItem>.from(currentOrder.items);
    int itemIndex = newItems.indexWhere((e) => e.productId == event.productId);

    if (itemIndex != -1) {
      newItems[itemIndex].price = event.newPrice;
      _updateOrderAndEmit(currentOrder.transactionId, newItems, emit);
    }
  }
}
