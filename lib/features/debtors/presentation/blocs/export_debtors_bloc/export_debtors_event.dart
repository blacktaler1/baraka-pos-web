part of 'export_debtors_bloc.dart';

sealed class ExportDebtorsEvent extends Equatable {
  const ExportDebtorsEvent();

  @override
  List<Object> get props => [];
}

final class ExportDebtorsStarted extends ExportDebtorsEvent {
  const ExportDebtorsStarted();
}
