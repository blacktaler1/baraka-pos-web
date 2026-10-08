import 'package:flutter/material.dart';

import 'app_colors.dart';
import '../../design/tokens.dart';

const _fontFamily = 'Onest';
const _tabular = [FontFeature.tabularFigures()];

class AppThemeConfig {
  ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: _fontFamily,
        colorScheme: _colorScheme,
        textTheme: _textTheme,
        scaffoldBackgroundColor: AppColors.canvas,
        canvasColor: AppColors.surface,
        hoverColor: AppColors.surfaceSunken,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        dividerColor: AppColors.border,
        visualDensity: VisualDensity.standard,
        appBarTheme: _appBar,
        elevatedButtonTheme: _elevatedButtonTheme,
        filledButtonTheme: _filledButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textButtonTheme: _textButtonTheme,
        iconButtonTheme: _iconButtonTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: _cardTheme,
        dialogTheme: _dialogTheme,
        bottomSheetTheme: _bottomSheetTheme,
        snackBarTheme: _snackBarTheme,
        dividerTheme: const DividerThemeData(
          color: AppColors.border,
          thickness: 1,
          space: 1,
        ),
        checkboxTheme: _checkboxTheme,
        radioTheme: _radioTheme,
        switchTheme: _switchTheme,
        chipTheme: _chipTheme,
        tooltipTheme: _tooltipTheme,
        popupMenuTheme: _popupMenuTheme,
        dropdownMenuTheme: _dropdownMenuTheme,
        tabBarTheme: _tabBarTheme,
        dataTableTheme: _dataTableTheme,
        listTileTheme: const ListTileThemeData(
          iconColor: AppColors.textSecondary,
          textColor: AppColors.ink,
          selectedColor: AppColors.primary,
          selectedTileColor: AppColors.primarySoft,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primary,
          linearTrackColor: AppColors.surfaceSunken,
          circularTrackColor: Colors.transparent,
        ),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(AppColors.borderStrong),
          radius: const Radius.circular(8),
          thickness: WidgetStateProperty.all(6),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: AppColors.primaryMuted,
          selectionHandleColor: AppColors.primary,
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          headerBackgroundColor: AppColors.primary,
          headerForegroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
}

final ColorScheme _colorScheme = ColorScheme.fromSeed(
  seedColor: AppColors.primary,
  primary: AppColors.primary,
  onPrimary: Colors.white,
  primaryContainer: AppColors.primarySoft,
  onPrimaryContainer: AppColors.primaryPressed,
  secondary: AppColors.ink,
  onSecondary: Colors.white,
  tertiary: AppColors.success,
  error: AppColors.danger,
  errorContainer: AppColors.dangerSoft,
  onError: Colors.white,
  surface: AppColors.surface,
  onSurface: AppColors.ink,
  onSurfaceVariant: AppColors.textSecondary,
  surfaceTint: Colors.transparent,
  outline: AppColors.borderStrong,
  outlineVariant: AppColors.border,
  scrim: AppColors.ink,
);

TextTheme get _textTheme => TextTheme(
      displaySmall: AppText.display,
      headlineSmall: AppText.h1,
      bodyLarge: AppText.h1,
      bodyMedium: AppText.body,
      bodySmall: AppText.small,
      titleLarge: AppText.h2,
      titleMedium: AppText.body,
      titleSmall: AppText.caption,
      labelLarge: AppText.h3,
      labelMedium: AppText.bodyMedium,
      labelSmall: AppText.caption,
    );

const AppBarTheme _appBar = AppBarTheme(
  backgroundColor: AppColors.surface,
  foregroundColor: AppColors.ink,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  scrolledUnderElevation: 0,
  centerTitle: false,
  shape: Border(bottom: BorderSide(color: AppColors.border)),
);

OutlinedBorder get _buttonShape =>
    const RoundedRectangleBorder(borderRadius: AppRadius.control);

EdgeInsetsGeometry get _buttonPadding =>
    const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10);

WidgetStateProperty<Size> get _buttonMinSize =>
    WidgetStateProperty.all(const Size(0, AppSizes.controlHeight));

WidgetStateProperty<TextStyle> get _buttonText =>
    WidgetStateProperty.all(AppText.bodyStrong.copyWith(letterSpacing: -0.1));

ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        animationDuration: const Duration(milliseconds: 150),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.surfaceSunken;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryPressed;
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.primaryHover;
          }
          return AppColors.primary;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textTertiary;
          }
          return Colors.white;
        }),
        padding: WidgetStateProperty.all(_buttonPadding),
        minimumSize: _buttonMinSize,
        shape: WidgetStateProperty.all(_buttonShape),
        textStyle: _buttonText,
      ),
    );

FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        animationDuration: const Duration(milliseconds: 150),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.surfaceSunken;
          }
          if (states.contains(WidgetState.pressed)) {
            return AppColors.primaryMuted;
          }
          if (states.contains(WidgetState.hovered)) {
            return const Color(0xFFDDEBE5);
          }
          return AppColors.primarySoft;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textTertiary;
          }
          return AppColors.primaryPressed;
        }),
        padding: WidgetStateProperty.all(_buttonPadding),
        minimumSize: _buttonMinSize,
        shape: WidgetStateProperty.all(_buttonShape),
        textStyle: _buttonText,
      ),
    );

OutlinedButtonThemeData get _outlinedButtonTheme => OutlinedButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        animationDuration: const Duration(milliseconds: 150),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.surfaceSunken;
          }
          if (states.contains(WidgetState.hovered)) {
            return AppColors.surfaceMuted;
          }
          return AppColors.surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textTertiary;
          }
          return AppColors.ink;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return const BorderSide(color: AppColors.borderStrong);
          }
          return const BorderSide(color: AppColors.border);
        }),
        padding: WidgetStateProperty.all(_buttonPadding),
        minimumSize: _buttonMinSize,
        shape: WidgetStateProperty.all(_buttonShape),
        textStyle: _buttonText,
      ),
    );

TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(AppColors.primarySoft),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.textTertiary;
          }
          return AppColors.primary;
        }),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        shape: WidgetStateProperty.all(_buttonShape),
        textStyle: _buttonText,
      ),
    );

IconButtonThemeData get _iconButtonTheme => IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.textSecondary),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) return AppColors.border;
          if (states.contains(WidgetState.hovered)) {
            return AppColors.surfaceSunken;
          }
          return Colors.transparent;
        }),
        shape: WidgetStateProperty.all(_buttonShape),
      ),
    );

OutlineInputBorder _inputBorder(Color color, [double width = 1]) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: width),
    );

InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      hoverColor: AppColors.surfaceMuted,
      isDense: true,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 11.5),
      hintStyle: TextStyle(
        fontFamily: _fontFamily,
        color: AppColors.textTertiary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        color: AppColors.textSecondary,
        fontSize: 14,
      ),
      floatingLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        color: AppColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: TextStyle(
        fontFamily: _fontFamily,
        color: AppColors.danger,
        fontSize: 12,
      ),
      prefixIconColor: AppColors.textTertiary,
      prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 20),
      suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 20),
      suffixIconColor: AppColors.textTertiary,
      border: _inputBorder(AppColors.border),
      enabledBorder: _inputBorder(AppColors.border),
      disabledBorder: _inputBorder(AppColors.border),
      focusedBorder: _inputBorder(AppColors.primary, 1.5),
      errorBorder: _inputBorder(AppColors.danger),
      focusedErrorBorder: _inputBorder(AppColors.danger, 1.5),
    );

CardThemeData get _cardTheme => CardThemeData(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
    );

DialogThemeData get _dialogTheme => DialogThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shadowColor: AppColors.shadow,
      barrierColor: const Color(0x591C1B18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: AppColors.border),
      ),
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        letterSpacing: -0.3,
        color: AppColors.ink,
      ),
      contentTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        height: 1.5,
        color: AppColors.textSecondary,
      ),
    );

BottomSheetThemeData get _bottomSheetTheme => BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalBarrierColor: const Color(0x591C1B18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
    );

SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.ink,
      elevation: 0,
      insetPadding: EdgeInsets.all(20),
      contentTextStyle: TextStyle(
        fontFamily: _fontFamily,
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );

CheckboxThemeData get _checkboxTheme => CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(color: AppColors.borderStrong, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );

RadioThemeData get _radioTheme => RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.borderStrong;
      }),
    );

SwitchThemeData get _switchTheme => SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        return AppColors.borderStrong;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    );

ChipThemeData get _chipTheme => ChipThemeData(
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primarySoft,
      disabledColor: AppColors.surfaceSunken,
      side: const BorderSide(color: AppColors.border),
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.ink,
      ),
      secondaryLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryPressed,
      ),
      checkmarkColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

TooltipThemeData get _tooltipTheme => TooltipThemeData(
      waitDuration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        fontFamily: _fontFamily,
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );

PopupMenuThemeData get _popupMenuTheme => PopupMenuThemeData(
      color: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 6,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
      textStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: AppColors.ink,
      ),
    );

DropdownMenuThemeData get _dropdownMenuTheme => DropdownMenuThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.surface),
        surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(6),
        shadowColor: WidgetStateProperty.all(AppColors.shadow),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
    );

TabBarThemeData get _tabBarTheme => TabBarThemeData(
      labelColor: AppColors.ink,
      unselectedLabelColor: AppColors.textSecondary,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: AppColors.border,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );

DataTableThemeData get _dataTableTheme => DataTableThemeData(
      headingRowHeight: AppSizes.tableHeaderHeight,
      dataRowMinHeight: AppSizes.tableRowHeight + 6,
      dataRowMaxHeight: AppSizes.tableRowHeight + 6,
      horizontalMargin: AppSpacing.lg,
      columnSpacing: AppSpacing.xl,
      headingRowColor: WidgetStateProperty.all(AppColors.surfaceMuted),
      dataRowColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) return AppColors.primarySoft;
        return AppColors.surface;
      }),
      dividerThickness: 1,
      headingTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: AppColors.textTertiary,
      ),
      dataTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 14,
        color: AppColors.ink,
        fontFeatures: _tabular,
      ),
    );
