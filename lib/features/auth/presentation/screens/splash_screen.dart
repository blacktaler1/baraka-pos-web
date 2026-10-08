import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/data/sources/local_sources.dart';
import 'package:baraka_pos/shared/aplication/configs/app_colors.dart';
import 'package:baraka_pos/shared/presentation/widgets/brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

UserTableData? globalUser;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final db = PosLocalDatabase.instance;
    final local = AuthLocalSource(db);

    final auth = await local.getCurrentAuth();
    final user = await local.getCurrentUser();
    if (!mounted) return;

// agar user null bo‘lsa
    if (user == null) {
      globalUser = null;
      context.go('/auth');
      return;
    }

    globalUser = user;

    /// 🔄 Refresh token
    context.read<RefreshBloc>().add(
          RefreshStarted(refresh: auth!.refreshToken),
        );

    /// 🔀 Role bo‘yicha routing
    switch (user.role) {
      case 'admin':
        context.go('/home');
        break;
      case 'manager':
        context.go('/store');
        break;
      case 'cashier':
        context.go('/cash');
        break;
      default:
        context.go('/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E8A66), Color(0xFF0B3D2E)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BrandLogo(size: 56, inverse: true),
              SizedBox(height: 28),
              SizedBox.square(
                dimension: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
