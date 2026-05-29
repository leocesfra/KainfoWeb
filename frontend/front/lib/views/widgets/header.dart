import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class HeaderWidget extends StatefulWidget {
  final VoidCallback onCategoryTap;

  const HeaderWidget({super.key, required this.onCategoryTap});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool _searchFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 128,
      color: AppColors.secondaryColorLight,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Contenedor Logo (128x64)
          Container(
            width: 128,
            height: 64,
            alignment: Alignment.center,
            child: const Text(
              'LOGO',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 32),

          // 2. Botón Categorías
          _CategoryButton(onTap: widget.onCategoryTap),
          const SizedBox(width: 32),

          // 3. Barra de búsqueda (máx 350px, flexible)
          Expanded(
            child: Center(
              // <-- Centrado
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 450,
                ), // <-- Limita expansión
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (focus) =>
                        setState(() => _searchFocused = focus),
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.neutralColorLight,
                        borderRadius: BorderRadius.circular(32),
                        border: _searchFocused
                            ? Border.all(
                                color: AppColors.primaryColorLight,
                                width: 1,
                              )
                            : null,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: AppColors.primaryColorLight,
                              style: GoogleFonts.roboto(
                                color: AppColors.neutralColorDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Que estás buscando?',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(bottom: 12),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.search,
                            color: AppColors.neutralColorDark,
                            size: 20,
                          ), // Lupa en extremo derecho
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 32),

          // 5. Usuario
          const Icon(
            Icons.person,
            color: AppColors.whiteColor,
            size: 28,
          ), // e7fd
          const SizedBox(width: 24),

          // 6. Carrito + Toggle (Notificación/Modo)
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.shopping_cart,
                color: AppColors.whiteColor,
                size: 28,
              ), // e8cc
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColorLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '2',
                      style: GoogleFonts.roboto(
                        color: AppColors.whiteColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// BOTÓN CATEGORÍAS ANIMADO
class _CategoryButton extends StatefulWidget {
  final VoidCallback onTap;
  const _CategoryButton({required this.onTap});

  @override
  State<_CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<_CategoryButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: _pressed ? 262 : 264, // Reduce 2px al click
          height: _pressed ? 62 : 64,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          decoration: BoxDecoration(
            color: _pressed
                ? AppColors.primaryColorDark
                : (_hovered
                      ? AppColors.primaryColorLight60
                      : AppColors.primaryColorDark),
            borderRadius: BorderRadius.circular(2),
            border: _pressed
                ? Border.all(color: AppColors.secondaryColorDark, width: 2)
                : null, // Simula Sombra Interior
            boxShadow: _pressed
                ? []
                : const [
                    BoxShadow(
                      color: AppColors.blackColor,
                      offset: Offset(-4, 4), // 4px left, 4px down
                      spreadRadius: 4,
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.menu,
                color: AppColors.whiteColor,
                size: 24,
              ), // e5d2
              const SizedBox(width: 8),
              Text(
                'Categorías',
                style: GoogleFonts.leagueSpartan(
                  color: AppColors.whiteColor,
                  fontSize: 20, // h3
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
