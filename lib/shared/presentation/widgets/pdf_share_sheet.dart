import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../aplication/utils/share_utils.dart';
import '../../design/design.dart';

/// Pastdan chiqadigan oyna: PDF oldindan tayyorlanadi, "Yuborish" bosilganda
/// telefonning ulashish menyusi ochiladi (Telegram, WhatsApp, saqlash...).
Future<void> showPdfShareSheet(
  BuildContext context, {
  required String title,
  String? subtitle,
  required String fileName,
  required Future<Uint8List> Function() build,
  IconData icon = Icons.receipt_long_rounded,
}) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    builder: (_) => _PdfShareSheet(
      title: title,
      subtitle: subtitle,
      fileName: fileName,
      build: build,
      icon: icon,
    ),
  );
}

class _PdfShareSheet extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String fileName;
  final Future<Uint8List> Function() build;
  final IconData icon;

  const _PdfShareSheet({
    required this.title,
    required this.subtitle,
    required this.fileName,
    required this.build,
    required this.icon,
  });

  @override
  State<_PdfShareSheet> createState() => _PdfShareSheetState();
}

class _PdfShareSheetState extends State<_PdfShareSheet> {
  Uint8List? _bytes;
  Object? _error;
  bool _sharing = false;

  @override
  void initState() {
    super.initState();
    widget.build().then(
      (bytes) {
        if (mounted) setState(() => _bytes = bytes);
      },
      onError: (Object e) {
        if (mounted) setState(() => _error = e);
      },
    );
  }

  Future<void> _share() async {
    final bytes = _bytes;
    if (bytes == null) return;
    setState(() => _sharing = true);
    try {
      // Tugma bosilgan zahoti chaqiriladi — brauzer talabi
      await sharePdfBytes(bytes, widget.fileName);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _sharing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${tr("error")}: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ready = _bytes != null;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderStrong,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                AppSoftIcon(icon: widget.icon, color: AppColors.success),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: AppText.h2),
                      if (widget.subtitle != null)
                        Text(widget.subtitle!, style: AppText.small),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf_rounded,
                      color: AppColors.danger, size: 28),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      widget.fileName,
                      style: AppText.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (_error != null)
                    const Icon(Icons.error_outline_rounded,
                        color: AppColors.danger)
                  else if (!ready)
                    const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    const Icon(Icons.check_circle_rounded,
                        color: AppColors.success),
                ],
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text("${tr("error")}: $_error",
                  style: AppText.small.copyWith(color: AppColors.danger)),
            ],
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: tr("send_pdf"),
              icon: Icons.ios_share_rounded,
              expand: true,
              loading: _sharing,
              onPressed: ready && !_sharing ? _share : null,
            ),
            const SizedBox(height: AppSpacing.xs),
            AppButton.secondary(
              label: tr("close"),
              expand: true,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
