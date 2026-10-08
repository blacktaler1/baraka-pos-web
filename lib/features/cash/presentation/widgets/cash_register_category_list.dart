import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/domain/model/category_model.dart';
import '../../../global/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import 'categories_card.dart';

class CashRegisterCategoryList extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelect;

  const CashRegisterCategoryList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: BlocBuilder<GetCategoryBloc, GetCategoryState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            inPrepare: () => const AppLoading(),
            success: (model) {
              final categories = [
                CategoryModel(id: 0, title: "", image: ""),
                ...model.collection.models
              ];
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoriesCard(
                    isSelected: categories[index].title == selectedCategory,
                    model: categories[index],
                    onTap: () {
                      onCategorySelect(categories[index].title);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: AppSpacing.xs);
                },
              );
            },
            failure: (err) => Text(err.message),
          );
        },
      ),
    );
  }
}
