import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _seed = Color(0xFF1A1A1A);
  static const _accent = Color(0xFFE85D04);
  static const _hairline = 1.0;

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
      primary: _accent,
    );
    final base = ThemeData(colorScheme: scheme, useMaterial3: true, brightness: brightness);

    final outline = isDark
        ? const Color(0xFF2A2A2A)
        : const Color(0xFFE5E5E5);
    final onSurface = isDark ? const Color(0xFFEDEDED) : const Color(0xFF1A1A1A);
    final onSurfaceVariant = isDark ? const Color(0xFF9A9A9A) : const Color(0xFF6E6E6E);
    final surface = isDark ? const Color(0xFF0F0F0F) : Colors.white;

    final tweakedScheme = scheme.copyWith(
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outline,
    );

    final textTheme = GoogleFonts.interTextTheme(base.textTheme).apply(
      bodyColor: onSurface,
      displayColor: onSurface,
    ).copyWith(
      displayLarge: GoogleFonts.jetBrainsMono(
        textStyle: base.textTheme.displayLarge,
        fontWeight: FontWeight.w300,
        color: onSurface,
        height: 1,
      ),
      displayMedium: GoogleFonts.jetBrainsMono(
        textStyle: base.textTheme.displayMedium,
        fontWeight: FontWeight.w300,
        color: onSurface,
        height: 1,
      ),
    );

    return base.copyWith(
      colorScheme: tweakedScheme,
      scaffoldBackgroundColor: surface,
      textTheme: textTheme,
      dividerColor: outline,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        iconTheme: IconThemeData(color: onSurface, size: 22),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: outline, width: _hairline),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: outline,
        thickness: _hairline,
        space: _hairline,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        titleTextStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        subtitleTextStyle: textTheme.bodySmall?.copyWith(color: onSurfaceVariant),
        iconColor: onSurface,
        minLeadingWidth: 24,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: outline, width: _hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: outline, width: _hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _accent, width: _hairline),
        ),
        labelStyle: TextStyle(color: onSurfaceVariant),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.3),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          side: BorderSide(color: outline, width: _hairline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          textStyle: const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.2),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: onSurface,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: outline, width: _hairline),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(10),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: surface,
        foregroundColor: _accent,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _accent, width: 1.2),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 60,
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? _accent : onSurfaceVariant,
            size: 22,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            color: selected ? _accent : onSurfaceVariant,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            letterSpacing: 0.4,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.transparent,
        side: BorderSide(color: outline, width: _hairline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        labelStyle: textTheme.labelSmall?.copyWith(color: onSurface, letterSpacing: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  static Color accent(BuildContext _) => _accent;
  static Color outlineColor(BuildContext context) =>
      Theme.of(context).colorScheme.outline;
}
