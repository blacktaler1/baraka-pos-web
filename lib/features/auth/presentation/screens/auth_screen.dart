import 'dart:math';

import 'package:baraka_pos/shared/design/design.dart';
import 'package:baraka_pos/features/auth/auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  void dispose() {
    idController.dispose();
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
            LoginStarted(
              code: idController.text.trim(),
              phoneNumber: numberController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  /// Webda qurilma ID si yo'q — birinchi kirishda tasodifiy ID yaratib,
  /// brauzer xotirasida saqlaymiz (shu telefon/brauzer uchun doimiy)
  Future<(String deviceId, String deviceName)> _getWebDeviceInfo(
    String role,
  ) async {
    const key = 'baraka_pos_device_id';
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(key);
    if (id == null) {
      final rnd = Random.secure();
      id = List.generate(16, (_) => rnd.nextInt(16).toRadixString(16)).join();
      await prefs.setString(key, id);
    }

    var browser = 'Browser';
    try {
      final info = await _deviceInfo.webBrowserInfo;
      browser = "${info.browserName.name} ${info.platform ?? ''}".trim();
    } catch (_) {}

    return ("Web $browser $id", "${role.toUpperCase()} (Web)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CreateDeviceBloc, CreateDeviceState>(
            listener: (context, state) {
              state.whenOrNull(
                failure: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        error.message ?? "Device yaratilmadi",
                      ),
                      backgroundColor: AppColors.warning,
                    ),
                  );
                },
              );
            },
          ),
        ],
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            await state.whenOrNull(
              success: (model) async {
                final role = globalUser?.role;

                if (role != null) {
                  final deviceInfo = await _getWebDeviceInfo(role);

                  context.read<CreateDeviceBloc>().add(
                        CreateDeviceEvent(
                          deviceId: deviceInfo.$1,
                          name: deviceInfo.$2,
                        ),
                      );
                }

                /// NAVIGATION
                if (role == "admin") {
                  context.go("/home");
                } else if (role == "manager") {
                  context.go("/store");
                } else if (role == "cashier") {
                  context.go("/cash");
                }
              },
              failure: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      error.message ?? tr("login_failed"),
                    ),
                    backgroundColor: AppColors.danger,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              inPrepare: () => true,
              orElse: () => false,
            );

            return LayoutBuilder(
              builder: (context, constraints) {
                final showBrandPanel = constraints.maxWidth >= 960;
                return Row(
                  children: [
                    if (showBrandPanel) const Expanded(child: _BrandPanel()),
                    Expanded(
                      child: Container(
                        color: AppColors.surface,
                        alignment: Alignment.center,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 40,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 400),
                            child: _buildForm(context, isLoading,
                                showLogo: !showBrandPanel),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    bool isLoading, {
    required bool showLogo,
  }) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showLogo) ...[
            const Align(
              alignment: Alignment.centerLeft,
              child: BrandLogo(size: 36),
            ),
            const SizedBox(height: 40),
          ],
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_person_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            tr("login"),
            style: AppText.display,
          ),
          const SizedBox(height: 8),
          Text(
            tr("auth_subtitle"),
            style: AppText.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          AuthTextFieldWidget(
            label: tr("id_code"),
            controller: idController,
            icon: Icons.tag_rounded,
            validator: (value) =>
                value == null || value.isEmpty ? tr("id_code_must") : null,
          ),
          const SizedBox(height: 20),
          AuthTextFieldWidget(
            label: tr("number"),
            controller: numberController,
            icon: Icons.call_rounded,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return tr("number_must");
              }
              if (value.length < 3) {
                return tr("number_short");
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          AuthTextFieldWidget(
            label: tr("password"),
            controller: passwordController,
            icon: Icons.lock_rounded,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return tr("password_must");
              }
              if (value.length < 4) {
                return tr("password_short");
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: isLoading ? null : () => _onLoginPressed(context),
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: AppColors.primary,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tr("login")),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandPanel extends StatelessWidget {
  const _BrandPanel();

  @override
  Widget build(BuildContext context) {
    Widget feature(IconData icon, String label) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppText.bodyStrong.copyWith(color: Colors.white),
              ),
            ],
          ),
        );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E8A66), Color(0xFF0B3D2E)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -120,
            top: -120,
            child: _circle(380, 0.06),
          ),
          Positioned(
            left: -80,
            bottom: -100,
            child: _circle(300, 0.05),
          ),
          Padding(
            padding: const EdgeInsets.all(48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BrandLogo(size: 40, inverse: true),
                const Spacer(),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("brand_tagline"),
                        style: const TextStyle(
                          fontFamily: 'Onest',
                          fontSize: 40,
                          height: 1.1,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tr("brand_description"),
                        style: TextStyle(
                          fontFamily: 'Onest',
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.white.withValues(alpha: 0.72),
                        ),
                      ),
                      const SizedBox(height: 32),
                      feature(Icons.point_of_sale_rounded, tr("sales")),
                      feature(Icons.warehouse_rounded, tr("warehouse")),
                      feature(Icons.groups_rounded, tr("debtor_customers")),
                      feature(Icons.analytics_rounded, tr("dashboard")),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, double alpha) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: alpha),
        ),
      );
}
