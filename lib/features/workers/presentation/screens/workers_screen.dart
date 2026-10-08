import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/auth.dart';
import '../presentation.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _load() =>
      context.read<GetWorkerListBloc>().add(const GetWorkerListStarted());

  Future<void> _confirmDelete(UserModel worker) async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("delete_worker_title"),
      message: "${worker.name}. ${tr("delete_irreversible")}",
      confirmLabel: tr("yes_delete"),
      danger: true,
    );
    if (confirmed && mounted) {
      context.read<DeleteWorkerBloc>().add(DeleteWorkerEvent(id: worker.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteWorkerBloc, DeleteWorkerState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            _load();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr("worker_deleted"))),
            );
          },
          failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message)),
          ),
        );
      },
      child: AppPage(
        toolbar: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPageHeader(
              icon: Icons.badge_rounded,
              title: tr("workers"),
              actions: [
                AppButton(
                  label: tr("add_worker"),
                  icon: Icons.person_add_alt_1_rounded,
                  onPressed: () => showCreateWorkerPanel(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppToolbar(
              leading: [
                AppSearchField(
                  controller: searchController,
                  onChanged: (query) => setState(() => searchQuery = query),
                ),
              ],
            ),
          ],
        ),
        child: BlocBuilder<GetWorkerListBloc, GetWorkerListState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              inPrepare: () => const AppLoading(),
              failure: (error) =>
                  AppErrorState(message: error.message, onRetry: _load),
              success: (model) {
                final query = searchQuery.toLowerCase();
                final workers = model.userCollection.models
                    .where((w) => w.name.toLowerCase().contains(query))
                    .toList();

                if (workers.isEmpty) {
                  return AppCard(
                    child: EmptyState(
                      icon: Icons.badge_rounded,
                      message: tr("not_found"),
                    ),
                  );
                }

                return AppDataTable(
                  columns: [
                    tr("code"),
                    tr("full_name"),
                    tr("role"),
                    tr("phone"),
                    tr("actions"),
                  ],
                  rows: workers.map(_buildRow).toList(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  DataRow _buildRow(UserModel w) {
    final imageUrl =
        w.images.models.isNotEmpty ? w.images.models.first.file : null;
    return DataRow(
      cells: [
        DataCell(
          AppBadge(
            w.code,
            tone: AppTone.neutral,
            icon: Icons.tag_rounded,
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAvatar(name: w.name, imageUrl: imageUrl, size: 38),
              const SizedBox(width: AppSpacing.sm),
              Text(w.name, style: AppText.bodyStrong),
            ],
          ),
        ),
        DataCell(
          AppBadge(
            w.role.isEmpty ? '-' : tr(w.role),
            tone: switch (w.role) {
              "admin" => AppTone.primary,
              "manager" => AppTone.info,
              _ => AppTone.neutral,
            },
            icon: switch (w.role) {
              "admin" => Icons.admin_panel_settings_rounded,
              "manager" => Icons.manage_accounts_rounded,
              _ => Icons.badge_rounded,
            },
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.call_rounded,
                  size: 14, color: AppColors.textTertiary),
              const SizedBox(width: 6),
              Text(w.phone.isEmpty ? '-' : w.phone, style: AppText.body),
            ],
          ),
        ),
        DataCell(
          AppRowActions(
            onEdit: () => showUpdateWorkerPanel(context, w),
            onDelete: () => _confirmDelete(w),
          ),
        ),
      ],
    );
  }
}
