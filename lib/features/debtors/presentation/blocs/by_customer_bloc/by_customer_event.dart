part of 'by_customer_bloc.dart';

final class ByCustomerEvent extends Equatable {
  final int id;

  /// unpaid, paid yoki all
  final String status;

  const ByCustomerEvent({required this.id, this.status = 'unpaid'});

  @override
  List<Object> get props => [];
}
