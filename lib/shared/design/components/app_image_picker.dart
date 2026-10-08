import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

import '../../aplication/utils/excel_file_utils.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';

class AppImagePicker extends StatefulWidget {
  final XFile? file;
  final String? imageUrl;
  final bool uploading;
  final ValueChanged<XFile> onPicked;
  final double size;
  final bool circle;
  final IconData placeholderIcon;

  const AppImagePicker({
    super.key,
    required this.onPicked,
    this.file,
    this.imageUrl,
    this.uploading = false,
    this.size = 96,
    this.circle = false,
    this.placeholderIcon = Icons.add_photo_alternate_rounded,
  });

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  XFile? _shownFile;
  Uint8List? _bytes;

  XFile? get file => widget.file;
  String? get imageUrl => widget.imageUrl;
  bool get uploading => widget.uploading;
  double get size => widget.size;
  bool get circle => widget.circle;
  IconData get placeholderIcon => widget.placeholderIcon;

  Future<void> _pick() async {
    final picked = await pickImageFile();
    if (picked != null) widget.onPicked(picked);
  }

  // Tanlangan rasm baytlarini oldindan o'qib qo'yamiz (webda FileImage yo'q)
  void _syncBytes() {
    final f = widget.file;
    if (identical(f, _shownFile)) return;
    _shownFile = f;
    _bytes = null;
    f?.readAsBytes().then((b) {
      if (mounted && identical(_shownFile, f)) setState(() => _bytes = b);
    });
  }

  @override
  Widget build(BuildContext context) {
    _syncBytes();
    ImageProvider? provider;
    if (_bytes != null) {
      provider = MemoryImage(_bytes!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    }

    final shape = circle
        ? const CircleBorder()
        : RoundedRectangleBorder(borderRadius: AppRadius.card);

    return MouseRegion(
      cursor: uploading ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: uploading ? null : _pick,
        child: Container(
          width: size,
          height: size,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.surfaceMuted,
            shape: shape.copyWith(
              side: const BorderSide(color: AppColors.borderStrong),
            ),
            image: provider == null
                ? null
                : DecorationImage(image: provider, fit: BoxFit.cover),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (provider == null)
                Icon(
                  placeholderIcon,
                  size: AppSizes.iconLg + 4,
                  color: AppColors.textTertiary,
                ),
              if (uploading)
                const ColoredBox(
                  color: Color(0x991C1B18),
                  child: Center(
                    child: SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (provider != null && !uploading)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      size: 14,
                      color: AppColors.ink,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
