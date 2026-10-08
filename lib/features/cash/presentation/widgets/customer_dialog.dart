import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../debtors/domain/model/customer_model.dart';
import '../../../debtors/presentation/blocs/create_customer_bloc/create_customer_bloc.dart';
import '../../../debtors/presentation/blocs/get_customer_bloc/get_customer_bloc.dart';
import '../blocs/cart_bloc/cart_bloc.dart';

void showCustomerDialog(BuildContext context) {
  final cartBloc = context.read<CartBloc>();
  final getCustomerBloc = context.read<GetCustomerBloc>()
    ..add(const GetCustomerStarted(search: "", pageSize: "all", cursor: ""));

  showAppSidePanel(
    context,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: cartBloc),
        BlocProvider.value(value: getCustomerBloc),
      ],
      child: const _CustomerPickerPanel(),
    ),
  );
}

class _CustomerPickerPanel extends StatelessWidget {
  const _CustomerPickerPanel();

  void _search(BuildContext context, String value) {
    context
        .read<GetCustomerBloc>()
        .add(GetCustomerStarted(search: value, pageSize: "all", cursor: ""));
  }

  @override
  Widget build(BuildContext context) {
    return AppSidePanel(
      title: tr("select_customer"),
      icon: Icons.person_search_rounded,
      iconColor: AppColors.info,
      scrollable: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: AppSearchField(
                  width: double.infinity,
                  onChanged: (v) => _search(context, v),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppButton.secondary(
                label: tr("add_customer"),
                icon: Icons.person_add_alt_rounded,
                onPressed: () => showAddCustomerDialog(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: BlocBuilder<GetCustomerBloc, GetCustomerState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  inPrepare: () => const AppLoading(),
                  failure: (error) => AppErrorState(message: error.toString()),
                  success: (model) {
                    final customers = model.data.models;
                    if (customers.isEmpty) {
                      return EmptyState(
                        icon: Icons.people_outline_rounded,
                        message: tr("not_found"),
                      );
                    }
                    return ListView.separated(
                      itemCount: customers.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.xs),
                      itemBuilder: (context, index) =>
                          _customerTile(context, customers[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _customerTile(BuildContext context, CustomerModel customer) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      onTap: () {
        context
            .read<CartBloc>()
            .add(UpdateDebtDetailsEvent(customer: customer));
        Navigator.pop(context);
      },
      child: Row(
        children: [
          AppAvatar(name: customer.fullName, size: 40),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customer.fullName, style: AppText.bodyStrong),
                Text(
                  [customer.phone, customer.address]
                      .where((e) => e.isNotEmpty)
                      .join(" · "),
                  style: AppText.caption,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

void showAddCustomerDialog(BuildContext context) {
  final createBloc = context.read<CreateCustomerBloc>();
  final getCustomerBloc = context.read<GetCustomerBloc>();
  showAppSidePanel(
    context,
    builder: (_) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: createBloc),
        BlocProvider.value(value: getCustomerBloc),
      ],
      child: const _AddCustomerPanel(),
    ),
  );
}

class _AddCustomerPanel extends StatefulWidget {
  const _AddCustomerPanel();

  @override
  State<_AddCustomerPanel> createState() => _AddCustomerPanelState();
}

class _AddCustomerPanelState extends State<_AddCustomerPanel> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? tr("field_required") : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<CreateCustomerBloc>().add(
          CreateCustomerStarted(
            fullName: _name.text,
            phone: _phone.text,
            address: _address.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateCustomerBloc, CreateCustomerState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(tr("customer_added"))));
            context.read<GetCustomerBloc>().add(const GetCustomerStarted(
                search: "", pageSize: "all", cursor: ""));
            Navigator.pop(context);
          },
          failure: (error) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString()))),
        );
      },
      builder: (context, state) {
        return AppSidePanel(
          title: tr("add_customer"),
          icon: Icons.person_add_alt_1_rounded,
          iconColor: AppColors.primary,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  label: tr("full_name"),
                  required: true,
                  hint: tr("enter_full_name"),
                  controller: _name,
                  validator: _required,
                ),
                const AppFormGap(),
                AppTextField(
                  label: tr("phone"),
                  required: true,
                  hint: tr("enter_phone_number"),
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  validator: _required,
                ),
                const AppFormGap(),
                AppTextField(
                  label: tr("address"),
                  required: true,
                  controller: _address,
                  validator: _required,
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
              label: tr("add_customer"),
              loading: state is CreateCustomerPrepare,
              onPressed: _submit,
            ),
          ],
        );
      },
    );
  }
}
