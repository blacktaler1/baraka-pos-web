import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../media/presentation/blocs/post_media_bloc/post_media_bloc.dart';
import '../blocs/blocs.dart';
import '../widgets/worker_permissions_section.dart';

Future<void> showCreateWorkerPanel(BuildContext context) {
  return showAppSidePanel(context, builder: (_) => const CreateWorkerPanel());
}

class CreateWorkerPanel extends StatefulWidget {
  const CreateWorkerPanel({super.key});

  @override
  State<CreateWorkerPanel> createState() => _CreateWorkerPanelState();
}

class _CreateWorkerPanelState extends State<CreateWorkerPanel> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    context.read<CreateWorkerBloc>().add(CreateWorkerReset());
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<CreateWorkerBloc>();
    if (bloc.state.role.isEmpty) {
      _snack(tr("role_required"));
      return;
    }
    bloc.add(CreateWorkerStarted());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateWorkerBloc>();

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateWorkerBloc, CreateWorkerState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context
                  .read<GetWorkerListBloc>()
                  .add(const GetWorkerListStarted());
              Navigator.of(context).pop();
              _snack(tr("worker_created_successfully"));
            } else if (state.errorMessage != null) {
              _snack(state.errorMessage!);
            }
          },
        ),
        BlocListener<PostMediaBloc, PostMediaState>(
          listener: (context, state) {
            state.whenOrNull(
              inPrepare: () => setState(() => _uploading = true),
              success: (model) {
                setState(() => _uploading = false);
                bloc.add(CreateWorkerImageChanged(model.id));
              },
              failure: (error) {
                setState(() => _uploading = false);
                _snack(error.message);
              },
            );
          },
        ),
      ],
      child: BlocBuilder<CreateWorkerBloc, CreateWorkerState>(
        builder: (context, state) {
          return AppSidePanel(
            title: tr("create_worker"),
            icon: Icons.person_add_alt_1_rounded,
            iconColor: AppColors.primary,
            subtitle: tr("workers_information"),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppFieldLabel(tr("photo")),
                  AppImagePicker(
                    circle: true,
                    file: _image,
                    uploading: _uploading,
                    placeholderIcon: Icons.person_outline_rounded,
                    onPicked: (file) {
                      setState(() => _image = file);
                      context
                          .read<PostMediaBloc>()
                          .add(PostMediaStarted(image: file));
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    label: tr("full_name"),
                    required: true,
                    hint: tr("enter_full_name"),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? tr("name_required")
                        : null,
                    onChanged: (v) => bloc.add(CreateWorkerNameChanged(v)),
                  ),
                  const AppFormGap(),
                  AppTextField(
                    label: tr("phone"),
                    required: true,
                    hint: tr("enter_phone_number"),
                    keyboardType: TextInputType.phone,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? tr("phone_required")
                        : null,
                    onChanged: (v) => bloc.add(CreateWorkerPhoneChanged(v)),
                  ),
                  const AppFormGap(),
                  AppTextField(
                    label: tr("password"),
                    required: true,
                    hint: tr("enter_password"),
                    obscure: true,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? tr("password_required")
                        : null,
                    onChanged: (v) => bloc.add(CreateWorkerPasswordChanged(v)),
                  ),
                  const AppFormGap(),
                  AppDropdown<String>(
                    label: tr("role"),
                    required: true,
                    hint: tr("select"),
                    value: state.role.isEmpty ? null : state.role,
                    items: [
                      DropdownMenuItem(
                        value: "manager",
                        child: Text(tr("manager")),
                      ),
                      DropdownMenuItem(
                        value: "cashier",
                        child: Text(tr("cashier")),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) bloc.add(CreateWorkerRoleChanged(v));
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  WorkerPermissionsSection(
                    value: state.permissions,
                    onChanged: (p) =>
                        bloc.add(CreateWorkerPermissionsChanged(p)),
                  ),
                ],
              ),
            ),
            actions: [
              AppButton.secondary(
                label: tr("cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              AppButton(
                label: tr("create_worker"),
                loading: state.isLoading,
                onPressed: _uploading ? null : _submit,
              ),
            ],
          );
        },
      ),
    );
  }
}
