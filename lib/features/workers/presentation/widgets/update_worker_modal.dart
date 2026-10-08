import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/auth.dart';
import '../../../media/media.dart';
import '../presentation.dart';

Future<void> showUpdateWorkerPanel(BuildContext context, UserModel user) {
  return showAppSidePanel(
    context,
    builder: (_) => UpdateWorkerPanel(user: user),
  );
}

class UpdateWorkerPanel extends StatefulWidget {
  final UserModel user;

  const UpdateWorkerPanel({super.key, required this.user});

  @override
  State<UpdateWorkerPanel> createState() => _UpdateWorkerPanelState();
}

class _UpdateWorkerPanelState extends State<UpdateWorkerPanel> {
  late final nameCtrl = TextEditingController(text: widget.user.name);
  late final phoneCtrl = TextEditingController(text: widget.user.phone);
  final passCtrl = TextEditingController();
  late WorkerPermissions permissions = widget.user.permissions;

  XFile? pickedImage;
  int? newImageId;
  bool isUploading = false;

  int? get _originalImageId => widget.user.images.models.isNotEmpty
      ? widget.user.images.models.first.id
      : null;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  bool get _isChanged =>
      nameCtrl.text.trim() != widget.user.name ||
      phoneCtrl.text.trim() != widget.user.phone ||
      passCtrl.text.trim().isNotEmpty ||
      pickedImage != null ||
      permissions != widget.user.permissions;

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submit() {
    final imageId = newImageId ?? _originalImageId;
    context.read<UpdateUserBloc>().add(
          UpdateUserStarted(
            payload: UpdateWorkerPayload(
              id: widget.user.id,
              name: nameCtrl.text.trim(),
              phone: phoneCtrl.text.trim(),
              password: passCtrl.text.trim(),
              image: [if (imageId != null) imageId],
              permissions: permissions,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.user.images.models.isNotEmpty
        ? widget.user.images.models.first.file
        : null;

    return MultiBlocListener(
      listeners: [
        BlocListener<PostMediaBloc, PostMediaState>(
          listener: (context, state) {
            state.whenOrNull(
              inPrepare: () => setState(() => isUploading = true),
              success: (media) => setState(() {
                newImageId = media.id;
                isUploading = false;
              }),
              failure: (err) {
                setState(() => isUploading = false);
                _snack(err.message);
              },
            );
          },
        ),
        BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (_) {
                context
                    .read<GetWorkerListBloc>()
                    .add(const GetWorkerListStarted());
                Navigator.pop(context);
                _snack(tr("worker_updated"));
              },
              failure: (error) => _snack(error.message),
            );
          },
        ),
      ],
      child: BlocBuilder<UpdateUserBloc, UpdateUserState>(
        builder: (context, state) {
          final isLoading = state is UpdateUserPrepare;
          return AppSidePanel(
            title: tr("update_worker"),
            icon: Icons.manage_accounts_rounded,
            iconColor: AppColors.info,
            subtitle: widget.user.name,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFieldLabel(tr("photo")),
                AppImagePicker(
                  circle: true,
                  file: pickedImage,
                  imageUrl: imageUrl,
                  uploading: isUploading,
                  placeholderIcon: Icons.person_outline_rounded,
                  onPicked: (file) {
                    setState(() => pickedImage = file);
                    context
                        .read<PostMediaBloc>()
                        .add(PostMediaStarted(image: file));
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                AppTextField(
                  label: tr("full_name"),
                  controller: nameCtrl,
                  onChanged: (_) => setState(() {}),
                ),
                const AppFormGap(),
                AppTextField(
                  label: tr("phone"),
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  onChanged: (_) => setState(() {}),
                ),
                const AppFormGap(),
                AppTextField(
                  label: tr("new_password"),
                  helper: tr("new_password_hint"),
                  controller: passCtrl,
                  obscure: true,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.xl),
                WorkerPermissionsSection(
                  value: permissions,
                  onChanged: (p) => setState(() => permissions = p),
                ),
              ],
            ),
            actions: [
              AppButton.secondary(
                label: tr("cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              AppButton(
                label: tr("save_changes"),
                loading: isLoading,
                onPressed: (!_isChanged || isUploading) ? null : _submit,
              ),
            ],
          );
        },
      ),
    );
  }
}
