import 'package:baraka_pos/shared/domain/domain.dart';

final class CreateCustomerPayload extends Payload {
  final String fullName;
  final String phone;
  final String address;

  const CreateCustomerPayload({
    required this.fullName,
    required this.phone,
    required this.address,
  });

  @override
  List<String> get props => [
        "full_name: $fullName",
        "phone: $phone",
        "address: $address",
      ];
}
