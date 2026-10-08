import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/data/sources/pdf_receipt_service.dart';
import '../../../../shared/presentation/widgets/pdf_share_sheet.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../../domain/model/daily_checks_model.dart';
import 'package:baraka_pos/shared/design/design.dart';

class DailyChecks extends StatelessWidget {
  // Modelni constructor orqali qabul qilamiz
  final DailyChecksModel dailyCheckModel;

  const DailyChecks({
    super.key,
    required this.dailyCheckModel,
  });

  Future<void> _handlePrint(BuildContext context) {
    return showPdfShareSheet(
      context,
      title: tr("daily_receipt"),
      subtitle: dailyCheckModel.user.name,
      fileName:
          "kunlik_hisobot_${DateFormat('dd_MM_yyyy').format(DateTime.now())}.pdf",
      icon: Icons.summarize_rounded,
      build: () => PdfReceiptService.buildDailyCheck(
        dailyCheck: dailyCheckModel,
        user: globalUser,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppButton.secondary(
      label: tr("daily_receipt"),
      icon: Icons.ios_share_rounded,
      onPressed: () => _handlePrint(context),
    );
  }
}

class DailyCheckDialogs {
  static Future<bool?> showConfirmDialog(BuildContext context) {
    return showAppConfirm(
      context,
      title: "print".tr(),
      message: "confirm_daily_check_print".tr(),
      confirmLabel: "confirm".tr(),
    );
  }

  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
                const SizedBox(width: AppSpacing.md),
                Text("please_wait".tr(), style: AppText.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${"error_occurred".tr()}: $message")),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
