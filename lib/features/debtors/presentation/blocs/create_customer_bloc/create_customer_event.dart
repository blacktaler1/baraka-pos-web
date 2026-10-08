part of 'create_customer_bloc.dart';

sealed class CreateCustomerEvent extends Equatable {
  const CreateCustomerEvent();

  @override
  List<Object> get props => [];
}

final class CreateCustomerStarted extends CreateCustomerEvent {
  final String fullName;
  final String phone;
  final String address;

  const CreateCustomerStarted({
    required this.fullName,
    required this.phone,
    required this.address,
  });

  @override
  List<Object> get props => [
        "full_name: $fullName",
        "phone: $phone",
        "address: $address",
      ];
}
