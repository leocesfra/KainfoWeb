import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../screens/home.dart'; // Ajusta la ruta a tu HomeScreen

class AdminHeaderWidget extends StatefulWidget {
  final VoidCallback onCategoryTap;

  const AdminHeaderWidget({super.key, required this.onCategoryTap});

  @override
  State<AdminHeaderWidget> createState() => _AdminHeaderWidgetState();
}

class _AdminHeaderWidgetState extends State<AdminHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: AppColors.secondaryColorLight,
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 40, errorBuilder: (_,__,___) => const Text('LOGO', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(width: 40),
          
          AnimatedHoverButton(
            onTap: widget.onCategoryTap, // <-- CONECTADO AL MENÚ
            baseColor: AppColors.primaryColorDark,
            borderRadius: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.menu, color: AppColors.whiteColor),
                  const SizedBox(width: 8),
                  Text('Categorías', style: AppTypography.colorWhite.titleLarge),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Container(
                width: 450, // <-- MÁS GRANDE
                height: 40,
                decoration: BoxDecoration(color: AppColors.neutralColorLight, borderRadius: BorderRadius.circular(32)),
                child: TextField(
                  cursorColor: AppColors.primaryColorLight,
                  // El TextField usa el cursor de texto ("escribiendo") por defecto
                  decoration: InputDecoration(
                    hintText: 'Que estás buscando?',
                    filled: true,
                    fillColor: AppColors.neutralColorLight,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    suffixIcon: const Icon(Icons.search, color: AppColors.neutralColorDark),
                    // Borde normal invisible
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    // Borde al seleccionar
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(color: AppColors.primaryColorLight, width: 1), // <-- BORDE FOCUS
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Switch(value: false, onChanged: (v) {}, activeColor: AppColors.primaryColorLight),
          const SizedBox(width: 24),
          AnimatedHoverButton(
            onTap: () {
              // <-- LOGOUT TE LLEVA AL HOME
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            }, 
            baseColor: Colors.transparent,
            child: const Icon(Icons.logout, color: AppColors.whiteColor, size: 28),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// COMPONENTE UNIVERSAL DE ANIMACIÓN (Hover & Click)
// (Puedes dejarlo en este archivo para que otros lo importen)
// ==========================================
class AnimatedHoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color baseColor;
  final double borderRadius;

  const AnimatedHoverButton({
    super.key,
    required this.child,
    this.onTap,
    required this.baseColor,
    this.borderRadius = 0,
  });

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color finalColor = widget.baseColor;
    if (widget.baseColor != Colors.transparent) {
      if (_isPressed) {
        finalColor = Color.alphaBlend(Colors.black.withOpacity(0.2), widget.baseColor);
      } else if (_isHovered) {
        finalColor = Color.alphaBlend(Colors.white.withOpacity(0.1), widget.baseColor);
      }
    }

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() { _isHovered = false; _isPressed = false; }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          if (widget.onTap != null) widget.onTap!();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isHovered && !_isPressed ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: finalColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}