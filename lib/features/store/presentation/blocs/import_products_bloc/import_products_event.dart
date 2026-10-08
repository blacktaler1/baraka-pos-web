part of 'import_products_bloc.dart';

sealed class ImportProductsEvent extends Equatable {
  const ImportProductsEvent();

  @override
  List<Object> get props => [];
}

final class ImportProductsStarted extends ImportProductsEvent {
  final XFile file;

  const ImportProductsStarted({
    required this.file,
  });

  @override
  List<Object> get props => [
        "file: ${file.name}",
      ];
}
