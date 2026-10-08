part of 'export_products_bloc.dart';

sealed class ExportProductsEvent extends Equatable {
  const ExportProductsEvent();

  @override
  List<Object> get props => [];
}

final class ExportProductsStarted extends ExportProductsEvent {
  const ExportProductsStarted();
}
