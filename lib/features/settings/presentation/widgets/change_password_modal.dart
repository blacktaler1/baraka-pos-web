import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/aplication/configs/di/injection_container.dart';
import '../blocs/blocs.dart';

Future<void> showChangePasswordPanel(BuildContext context) {
  return showAppSidePanel(
    context,
    builder: (_) => BlocProvider(
      create: (_) => sl<ChangePassBloc>(),
      child: const ChangePasswordModal(),
    ),
  );
}

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({super.key});

  @override
  State<ChangePasswordModal> createState() => _ChangePasswordModalState();
}

class _ChangePasswordModalState extends State<ChangePasswordModal> {
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool get _isChanged =>
      oldCtrl.text.isNotEmpty ||
      newCtrl.text.isNotEmpty ||
      confirmCtrl.text.isNotEmpty;

  @override
  void dispose() {
    oldCtrl.dispose();
    newCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  String? _validate(String? v, {bool confirm = false}) {
    if (v == null || v.isEmpty) return "required_field".tr();
    if (v.length < 8) return "password_min_length".tr();
    if (confirm && v != newCtrl.text) return "passwords_not_match".tr();
    return null;
  }

  void _submit() {
    if (!formKey.currentState!.validate()) return;
    context.read<ChangePassBloc>().add(
          ChangePassEvent(
            oldPassword: oldCtrl.text.trim(),
            newPassword: newCtrl.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePassBloc, ChangePassState>(
      listener: (context, state) {
        if (state is ChangePassSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.model.detail)));
        }
        if (state is ChangePassFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error.message)));
        }
      },
      builder: (context, state) {
        return AppSidePanel(
          title: "change_password".tr(),
          subtitle: "change_password_hint".tr(),
          icon: Icons.lock_reset_rounded,
          iconColor: AppColors.info,
          body: Form(
            key: formKey,
            child: Column(
              children: [
                AppTextField(
                  label: "old_password".tr(),
                  required: true,
                  controller: oldCtrl,
                  prefix: const Icon(Icons.lock_open_rounded, size: 18),
                  obscure: true,
                  validator: _validate,
                  onChanged: (_) => setState(() {}),
                ),
                const AppFormGap(),
                AppTextField(
                  label: "new_password".tr(),
                  required: true,
                  controller: newCtrl,
                  prefix: const Icon(Icons.lock_rounded, size: 18),
                  obscure: true,
                  validator: _validate,
                  onChanged: (_) => setState(() {}),
                ),
                const AppFormGap(),
                AppTextField(
                  label: "confirm_new_password".tr(),
                  required: true,
                  controller: confirmCtrl,
                  prefix: const Icon(Icons.verified_user_rounded, size: 18),
                  obscure: true,
                  validator: (v) => _validate(v, confirm: true),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
          actions: [
            AppButton.secondary(
              label: tr("cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            AppButton(
              label: "save_changes".tr(),
              icon: Icons.check_circle_rounded,
              loading: state is ChangePassPrepare,
              onPressed: _isChanged ? _submit : null,
            ),
          ],
        );
      },
    );
  }
}
