part of 'create_loan_bloc.dart';

sealed class CreateLoanEvent extends Equatable {
  const CreateLoanEvent();

  @override
  List<Object> get props => [];
}

final class CreateLoanStarted extends CreateLoanEvent {
  final String title;
  final int paid;
  final int debt;
  final int firmaId;

  const CreateLoanStarted({
    required this.title,
    required this.paid,
    required this.debt,
    required this.firmaId,
  });

  @override
  List<Object> get props => [
        "title: $title",
        "paid: $paid",
        "debt: $debt",
        "id: $firmaId",
      ];
}
