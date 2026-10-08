import 'package:baraka_pos/shared/aplication/types/json.dart';

final class WorkerPermissions {
  final bool canDiscount;
  final double maxDiscountPercent;
  final bool canEditPrice;
  final bool canRefund;

  const WorkerPermissions({
    this.canDiscount = false,
    this.maxDiscountPercent = 0,
    this.canEditPrice = true,
    this.canRefund = true,
  });

  WorkerPermissions copyWith({
    bool? canDiscount,
    double? maxDiscountPercent,
    bool? canEditPrice,
    bool? canRefund,
  }) {
    return WorkerPermissions(
      canDiscount: canDiscount ?? this.canDiscount,
      maxDiscountPercent: maxDiscountPercent ?? this.maxDiscountPercent,
      canEditPrice: canEditPrice ?? this.canEditPrice,
      canRefund: canRefund ?? this.canRefund,
    );
  }

  Json toJson() => {
        "can_discount": canDiscount,
        "max_discount_percent": canDiscount ? maxDiscountPercent : 0,
        "can_edit_price": canEditPrice,
        "can_refund": canRefund,
      };

  @override
  bool operator ==(Object other) =>
      other is WorkerPermissions &&
      other.canDiscount == canDiscount &&
      other.maxDiscountPercent == maxDiscountPercent &&
      other.canEditPrice == canEditPrice &&
      other.canRefund == canRefund;

  @override
  int get hashCode =>
      Object.hash(canDiscount, maxDiscountPercent, canEditPrice, canRefund);

  @override
  String toString() => "WorkerPermissions(${toJson()})";
}
