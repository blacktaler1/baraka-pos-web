import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../media/media.dart';
import '../../global.dart';

/// Yangi kategoriya yaratilsa, o'sha kategoriya qaytariladi
Future<CategoryModel?> showCategoryPanel(BuildContext context,
    {CategoryModel? category}) {
  return showAppSidePanel<CategoryModel>(
    context,
    builder: (_) => CategoryFormPanel(category: category),
  );
}

class CategoryFormPanel extends StatefulWidget {
  final CategoryModel? category;

  const CategoryFormPanel({super.key, this.category});

  @override
  State<CategoryFormPanel> createState() => _CategoryFormPanelState();
}

class _CategoryFormPanelState extends State<CategoryFormPanel> {
  late final _titleController =
      TextEditingController(text: widget.category?.title ?? '');
  XFile? _selectedImage;

  bool get _isEdit => widget.category != null;
  String get _title => _titleController.text.trim();
  bool get _titleChanged => _title != (widget.category?.title ?? '');
  bool get _canSave =>
      _title.isNotEmpty &&
      (!_isEdit || _titleChanged || _selectedImage != null);

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _save() {
    if (_selectedImage != null) {
      context
          .read<PostMediaBloc>()
          .add(PostMediaStarted(image: _selectedImage!));
    } else {
      _submit([]);
    }
  }

  void _submit(List<int> imageIds) {
    if (_isEdit) {
      context.read<UpdateCategoryBloc>().add(
            UpdateCategoryStarted(
              pk: widget.category!.id,
              title: _titleChanged ? _title : "",
              list: _selectedImage != null ? imageIds : [],
            ),
          );
    } else {
      context
          .read<CreateCategoryBloc>()
          .add(CreateCategoryEvent(title: _title, list: imageIds));
    }
  }

  void _done([CategoryModel? created]) {
    context
        .read<GetCategoryPagBloc>()
        .add(GetCategoryStarted(cursor: "", pageSize: "10"));
    Navigator.pop(context, created);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<PostMediaBloc>().state is PostMediaPrepare ||
        context.watch<CreateCategoryBloc>().state is CreateCategoryPrepare ||
        context.watch<UpdateCategoryBloc>().state is UpdateCategoryPrepare;

    return MultiBlocListener(
      listeners: [
        BlocListener<PostMediaBloc, PostMediaState>(
          listener: (context, state) {
            if (state is PostMediaSuccess) _submit([state.model.id]);
          },
        ),
        BlocListener<CreateCategoryBloc, CreateCategoryState>(
          listener: (context, state) {
            if (state is CreateCategorySuccess) _done(state.model);
          },
        ),
        BlocListener<UpdateCategoryBloc, UpdateCategoryState>(
          listener: (context, state) {
            if (state is UpdateCategorySuccess) _done();
          },
        ),
      ],
      child: AppSidePanel(
        title: _isEdit ? tr("edit") : tr("new_category"),
        subtitle: widget.category?.title,
        icon:
            _isEdit ? Icons.edit_note_rounded : Icons.create_new_folder_rounded,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFieldLabel(tr("photo")),
            AppImagePicker(
              file: _selectedImage,
              imageUrl: widget.category?.image,
              placeholderIcon: Icons.add_photo_alternate_rounded,
              onPicked: (file) => setState(() => _selectedImage = file),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: tr("category_name"),
              required: true,
              controller: _titleController,
              prefix: const Icon(Icons.label_rounded, size: 18),
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
        actions: [
          AppButton.secondary(
            label: tr("cancel"),
            onPressed: loading ? null : () => Navigator.pop(context),
          ),
          AppButton(
            label: tr("save"),
            icon: Icons.check_circle_rounded,
            loading: loading,
            onPressed: _canSave ? _save : null,
          ),
        ],
      ),
    );
  }
}
