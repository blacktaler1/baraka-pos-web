import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int totalItems;
  final int currentPage;
  final int totalPages;
  final int rowsPerPage;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onRowsPerPageChanged;

  const PaginationWidget({
    super.key,
    required this.totalItems,
    required this.currentPage,
    required this.totalPages,
    required this.rowsPerPage,
    required this.onPageChanged,
    required this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final from = totalItems == 0 ? 0 : (currentPage - 1) * rowsPerPage + 1;
    final to = (currentPage * rowsPerPage).clamp(0, totalItems);
    final mobile = context.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: mobile ? AppSpacing.xs : AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.table_rows_rounded,
            size: 16,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: AppSpacing.xs),
          if (!mobile) ...[
            Text(tr("rows_per_page"), style: AppText.small),
            const SizedBox(width: AppSpacing.xs),
          ],
          Container(
            height: AppSizes.controlHeightSm - 4,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.surfaceSunken,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: rowsPerPage,
                style: AppText.bodyStrong,
                borderRadius: AppRadius.control,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                items: const [5, 10, 20]
                    .map((v) => DropdownMenuItem(value: v, child: Text("$v")))
                    .toList(),
                onChanged: (v) {
                  if (v != null) onRowsPerPageChanged(v);
                },
              ),
            ),
          ),
          const Spacer(),
          Text(
            "$from–$to",
            style: AppText.bodyStrong,
          ),
          Text(
            " / $totalItems",
            style: AppText.small,
          ),
          SizedBox(width: mobile ? AppSpacing.xs : AppSpacing.md),
          _PageButton(
            icon: Icons.chevron_left_rounded,
            onTap:
                currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          ),
          Container(
            height: AppSizes.controlHeightSm - 4,
            constraints: const BoxConstraints(minWidth: 32),
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              "$currentPage",
              style: AppText.bodyStrong.copyWith(color: Colors.white),
            ),
          ),
          _PageButton(
            icon: Icons.chevron_right_rounded,
            onTap: currentPage < totalPages
                ? () => onPageChanged(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _PageButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Material(
      color: enabled ? AppColors.surfaceSunken : Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onTap,
        child: SizedBox.square(
          dimension: AppSizes.controlHeightSm - 4,
          child: Icon(
            icon,
            size: AppSizes.icon,
            color: enabled ? AppColors.ink : AppColors.borderStrong,
          ),
        ),
      ),
    );
  }
}
