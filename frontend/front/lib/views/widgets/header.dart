import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../core/routes/app_routes.dart';

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
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: AppColors.secondaryColorLight,
      child: Row(
        children: [
          // 1. Logo
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.home),
            mouseCursor: SystemMouseCursors.click,
            child: Image.asset(
              'assets/images/logo.png', 
              height: 40, 
              errorBuilder: (_,__,___) => const Text('LOGO', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))
            ),
          ),
          const SizedBox(width: 40),
          
          // 2. Botón Categorías
          _CategoryButton(onTap: widget.onCategoryTap),
          
          // 3. Buscador
          Expanded(
            child: Center(
              child: Container(
                width: 450,
                height: 40,
                decoration: BoxDecoration(color: AppColors.neutralColorLight, borderRadius: BorderRadius.circular(32)),
                child: Focus(
                  onFocusChange: (focus) => setState(() => _searchFocused = focus),
                  child: TextField(
                    cursorColor: AppColors.primaryColorLight,
                    decoration: InputDecoration(
                      hintText: 'Que estás buscando?',
                      filled: true,
                      fillColor: AppColors.neutralColorLight,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      suffixIcon: const Icon(Icons.search, color: AppColors.neutralColorDark),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(color: AppColors.primaryColorLight, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // 4. Switch
          Switch(value: false, onChanged: (v) {}, activeColor: AppColors.primaryColorLight),
          const SizedBox(width: 24),
          
          // 5. Usuario (Login)
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.login),
            mouseCursor: SystemMouseCursors.click,
            child: const Icon(Icons.person, color: AppColors.whiteColor, size: 28),
          ),
          const SizedBox(width: 24),

          // 6. Carrito con Badge de Engranaje (Rojo primaryColorLight)
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart, color: AppColors.whiteColor, size: 28),
              Positioned(
                top: -8,
                right: -8,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.settings, color: AppColors.primaryColorLight, size: 22),
                    const Text('0', style: TextStyle(color: AppColors.whiteColor, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() { _hovered = false; _pressed = false; }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _hovered && !_pressed ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: _pressed ? Color.alphaBlend(Colors.black.withOpacity(0.2), AppColors.primaryColorDark) : AppColors.primaryColorDark,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu, color: AppColors.whiteColor),
                const SizedBox(width: 8),
                Text('Categorías', style: AppTypography.colorWhite.titleLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}