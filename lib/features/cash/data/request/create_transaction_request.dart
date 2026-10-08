import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class CreateTransactionRequest
    extends RemoteRequest<CreateTransactionPayload> {
  final String paymentMethod;
  final int customer;
  final int paidAmount;
  final String deadline;
  final String description;
  final int discount;
  final CreateItemCollection items;

  CreateTransactionRequest.fromPayload(super.payload)
      : paymentMethod = payload.paymentMethod,
        customer = payload.customer,
        paidAmount = payload.paidAmount,
        deadline = payload.deadline,
        description = payload.description,
        discount = payload.discount,
        items = payload.items,
        super.fromPayload();

  @override
  Json data() => {
        "payment_method": paymentMethod,
        if (customer != 0) "customer": customer,
        if (paidAmount != 0) "paid_amount": paidAmount,
        if (deadline.isNotEmpty) "deadline": deadline,
        if (description.isNotEmpty) "description": description,
        if (discount > 0) "discount": discount,
        "items": items.models.map((e) => e.toJson()).toList(),
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
