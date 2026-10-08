import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../design/design.dart';

/// Telefon kamerasi orqali bitta shtrix-kodni o'qiydi va qiymatini qaytaradi.
/// (USB/Bluetooth skaner o'rniga)
Future<String?> scanBarcode(BuildContext context) {
  return Navigator.of(context, rootNavigator: true).push<String>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const BarcodeScannerScreen(),
    ),
  );
}

/// Kassa uchun: kamera ochiq turadi, har bir o'qilgan kod [onScanned] ga beriladi
Future<void> scanBarcodesContinuous(
  BuildContext context, {
  required void Function(String code) onScanned,
}) {
  return Navigator.of(context, rootNavigator: true).push<void>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => BarcodeScannerScreen(onScanned: onScanned),
    ),
  );
}

/// Kamera tugmasi — qidiruv maydonlari yoniga qo'yiladi
class ScanBarcodeButton extends StatelessWidget {
  final ValueChanged<String> onScanned;
  final bool continuous;

  const ScanBarcodeButton({
    super.key,
    required this.onScanned,
    this.continuous = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tr("scan_with_camera"),
      child: Material(
        color: AppColors.primary,
        borderRadius: AppRadius.control,
        child: InkWell(
          borderRadius: AppRadius.control,
          onTap: () async {
            if (continuous) {
              await scanBarcodesContinuous(context, onScanned: onScanned);
              return;
            }
            final code = await scanBarcode(context);
            if (code != null && code.isNotEmpty) onScanned(code);
          },
          child: const SizedBox.square(
            dimension: AppSizes.controlHeight,
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

class BarcodeScannerScreen extends StatefulWidget {
  /// null bo'lsa — bitta kod o'qilib, ekran yopiladi
  final void Function(String code)? onScanned;

  const BarcodeScannerScreen({super.key, this.onScanned});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    formats: const [
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.code93,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
      BarcodeFormat.itf14,
      BarcodeFormat.qrCode,
    ],
  );

  String? _lastCode;
  DateTime _lastAt = DateTime.fromMillisecondsSinceEpoch(0);
  int _count = 0;
  bool _done = false;

  bool get _continuous => widget.onScanned != null;

  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Kamera xatosi paydo bo'lsa izohni yashirish uchun
    _controller.addListener(() {
      final hasError = _controller.value.error != null;
      if (hasError != _hasError && mounted) {
        setState(() => _hasError = hasError);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_done) return;
    final code = capture.barcodes
        .map((b) => b.rawValue)
        .whereType<String>()
        .map((v) => v.trim())
        .firstWhere((v) => v.isNotEmpty, orElse: () => '');
    if (code.isEmpty) return;

    final now = DateTime.now();
    // Bir xil kod kamera oldida turganda qayta-qayta qo'shilmasin
    if (code == _lastCode && now.difference(_lastAt).inMilliseconds < 1800) {
      return;
    }
    _lastCode = code;
    _lastAt = now;

    if (!_continuous) {
      _done = true;
      Navigator.of(context).pop(code);
      return;
    }

    widget.onScanned!(code);
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final windowWidth = (size.width * 0.82).clamp(220.0, 420.0);
          final scanWindow = Rect.fromCenter(
            center: Offset(size.width / 2, size.height * 0.42),
            width: windowWidth,
            height: windowWidth * 0.6,
          );

          return Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                controller: _controller,
                scanWindow: scanWindow,
                onDetect: _onDetect,
                errorBuilder: (context, error) => _CameraError(error: error),
              ),
              // Kamera ishlamasa ramka va izoh ko'rsatilmaydi
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, state, _) => state.error != null
                    ? const SizedBox.shrink()
                    : IgnorePointer(
                        child: CustomPaint(
                          painter: _ScanWindowPainter(scanWindow),
                          child: const SizedBox.expand(),
                        ),
                      ),
              ),
              // Yuqori panel
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Row(
                      children: [
                        _RoundButton(
                          icon: Icons.close_rounded,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
                        ValueListenableBuilder(
                          valueListenable: _controller,
                          builder: (context, state, _) {
                            if (state.torchState == TorchState.unavailable) {
                              return const SizedBox.shrink();
                            }
                            return _RoundButton(
                              icon: state.torchState == TorchState.on
                                  ? Icons.flash_on_rounded
                                  : Icons.flash_off_rounded,
                              onTap: _controller.toggleTorch,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Pastki izoh
              Positioned(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: scanWindow.bottom + AppSpacing.xl,
                child: Column(
                  children: [
                    if (!_hasError)
                      Text(
                        tr("point_camera_at_barcode"),
                        textAlign: TextAlign.center,
                        style: AppText.bodyMedium.copyWith(color: Colors.white),
                      ),
                    if (_continuous && _lastCode != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                "$_lastCode  •  $_count",
                                overflow: TextOverflow.ellipsis,
                                style: AppText.bodyStrong
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (_continuous)
                Positioned(
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  bottom: 0,
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: AppButton(
                        label: tr("done"),
                        icon: Icons.check_rounded,
                        expand: true,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.45),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox.square(
          dimension: 46,
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class _CameraError extends StatelessWidget {
  final MobileScannerException error;

  const _CameraError({required this.error});

  @override
  Widget build(BuildContext context) {
    final denied = error.errorCode == MobileScannerErrorCode.permissionDenied;
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.no_photography_rounded,
                  color: Colors.white70, size: 48),
              const SizedBox(height: AppSpacing.md),
              Text(
                denied ? tr("camera_permission_denied") : tr("camera_error"),
                textAlign: TextAlign.center,
                style: AppText.bodyMedium.copyWith(color: Colors.white),
              ),
              if (error.errorDetails?.message != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  error.errorDetails!.message!,
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(color: Colors.white54),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Skanerlash oynasidan tashqarini qoraytiradi va burchak chiziqlarini chizadi
class _ScanWindowPainter extends CustomPainter {
  final Rect window;

  _ScanWindowPainter(this.window);

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(window, const Radius.circular(16));
    canvas.drawDRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.zero),
      rrect,
      Paint()..color = Colors.black.withValues(alpha: 0.55),
    );

    final corner = Paint()
      ..color = AppColors.gold
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const l = 28.0;
    final r = window;
    canvas
      ..drawLine(r.topLeft, r.topLeft + const Offset(l, 0), corner)
      ..drawLine(r.topLeft, r.topLeft + const Offset(0, l), corner)
      ..drawLine(r.topRight, r.topRight + const Offset(-l, 0), corner)
      ..drawLine(r.topRight, r.topRight + const Offset(0, l), corner)
      ..drawLine(r.bottomLeft, r.bottomLeft + const Offset(l, 0), corner)
      ..drawLine(r.bottomLeft, r.bottomLeft + const Offset(0, -l), corner)
      ..drawLine(r.bottomRight, r.bottomRight + const Offset(-l, 0), corner)
      ..drawLine(r.bottomRight, r.bottomRight + const Offset(0, -l), corner);

    // O'rtadagi "lazer" chizig'i
    canvas.drawLine(
      Offset(r.left + 16, r.center.dy),
      Offset(r.right - 16, r.center.dy),
      Paint()
        ..color = AppColors.danger.withValues(alpha: 0.8)
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(_ScanWindowPainter old) => old.window != window;
}
