import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      height: 336,
      color: AppColors.whiteColor, // Fondo base
      padding: const EdgeInsets.all(8), // Deja los 232 interiores libres
      child: Column(
        children: [
          // Contenedor Imagen (232x232)
          Container(
            width: 232,
            height: 232,
            color: AppColors.neutralColorLight,
            child: imageUrl != null
                ? Image.network(imageUrl!, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 64, color: AppColors.neutralColorDark),
          ),
          const SizedBox(height: 4),
          
          // Contenedor Texto (232x24)
          Container(
            width: 232,
            height: 24,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(color: AppColors.blackColor, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 4),

          // Contenedor Precio (232x24)
          Container(
            width: 232,
            height: 24,
            color: AppColors.secondaryColorLight,
            alignment: Alignment.center,
            child: Text(
              price,
              style: GoogleFonts.roboto(color: AppColors.whiteColor, fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 4),

          // Botón Añadir (232x24)
          _AddCartButton(),
        ],
      ),
    );
  }
}

class _AddCartButton extends StatefulWidget {
  @override
  State<_AddCartButton> createState() => _AddCartButtonState();
}

class _AddCartButtonState extends State<_AddCartButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() { _hovered = false; _pressed = false; }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: _pressed ? 228 : 232, // Reducir 4px
          height: _pressed ? 20 : 24,  // Reducir 4px
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primaryColorLight60 : AppColors.primaryColorLight,
            border: _pressed ? Border.all(color: AppColors.secondaryColorDark, width: 2) : null,
            boxShadow: _pressed ? [] : const [
              BoxShadow(color: AppColors.blackColor, offset: Offset(4, 4), spreadRadius: 2, blurRadius: 8)
            ],
          ),
          child: Text(
            'AÑADIR',
            style: GoogleFonts.roboto(color: AppColors.whiteColor, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}