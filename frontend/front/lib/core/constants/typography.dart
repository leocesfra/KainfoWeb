import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Asumiendo que el archivo de colores se llama app_colors.dart y está en la misma carpeta constants
import 'colors.dart'; 

class AppTypography {
  AppTypography._();

  /// Variante Blanca/Clara: Optimizado para fondos oscuros (usa AppColors.whiteColor)
  static TextTheme get colorWhite => _buildWebTextTheme(AppColors.whiteColor);

  /// Variante Negra/Oscura: Optimizado para fondos claros (usa AppColors.blackColor)
  static TextTheme get colorBlack => _buildWebTextTheme(AppColors.blackColor);

  /// Método privado encargado de construir la jerarquía web aplicando las 3 reglas de oro
  /// e inyectando dinámicamente el color base para todos los textos.
  static TextTheme _buildWebTextTheme(Color textColor) {
    // 1. Cargamos Roboto como la base principal para el cuerpo de texto
    final baseTheme = GoogleFonts.robotoTextTheme();

    return baseTheme.copyWith(
      // --- TÍTULOS GIGANTES (Display) - Usan League Spartan ---
      displayLarge: GoogleFonts.leagueSpartan(
        textStyle: baseTheme.displayLarge?.copyWith(
          fontSize: 56, 
          fontWeight: FontWeight.w800, // Contraste fuerte
          color: textColor,            // Color automático
        ),
      ),

      // --- TÍTULOS WEB PRINCIPALES (H1, H2, H3) - Usan League Spartan ---
      headlineLarge: GoogleFonts.leagueSpartan(
        textStyle: baseTheme.headlineLarge?.copyWith(
          fontSize: 40, 
          fontWeight: FontWeight.bold, // H1 estándar web (Bold)
          color: textColor,
        ),
      ),
      headlineMedium: GoogleFonts.leagueSpartan(
        textStyle: baseTheme.headlineMedium?.copyWith(
          fontSize: 32, 
          fontWeight: FontWeight.w700, // H2 estándar web
          color: textColor,
        ),
      ),
      headlineSmall: GoogleFonts.leagueSpartan(
        textStyle: baseTheme.headlineSmall?.copyWith(
          fontSize: 24, 
          fontWeight: FontWeight.w600, // H3 estándar web (SemiBold)
          color: textColor,
        ),
      ),
      titleLarge: GoogleFonts.leagueSpartan(
        textStyle: baseTheme.titleLarge?.copyWith(
          fontSize: 20, 
          fontWeight: FontWeight.w600, // Títulos de tarjetas o secciones
          color: textColor,
        ),
      ),

      // --- TEXTOS DE LECTURA (Cuerpo y subtítulos) - Usan Roboto ---
      // Cuerpo principal: Estándar de 16px para accesibilidad web
      bodyLarge: baseTheme.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,       // Regla de oro: Interlineado para legibilidad
        color: textColor,
      ),
      
      // Texto secundario (Cards, descripciones breves)
      bodyMedium: baseTheme.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.4,
        color: textColor,
      ),

      // Microtexto (Copyright, pies de página, etiquetas de botones)
      labelSmall: baseTheme.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500, 
        letterSpacing: 0.5,
        color: textColor,
      ),
    );
  }
}