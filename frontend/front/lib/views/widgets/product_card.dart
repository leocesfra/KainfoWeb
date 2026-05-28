import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? imageUrl; // Ahora aceptamos URL real

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Lógica de imagen: Network vs Asset (Placeholder)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                  )
                : _buildPlaceholder(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Usamos maxLines y ellipsis por si el título es muy largo
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.blackColor),
                ),
                const SizedBox(height: 6),
                Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primaryColorDark)),
                const SizedBox(height: 12),
                AddButton(onPressed: () {}, label: 'Añadir al carrito'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget extraído para mantener el código limpio
  Widget _buildPlaceholder() {
    return Container(
      height: 150,
      color: AppColors.neutralColorLight,
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: AppColors.neutralColorDark),
      ),
    );
  }
}

class AddButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;

  const AddButton({super.key, required this.onPressed, required this.label});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
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
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          transform: Matrix4.translationValues(0, _pressed ? 2 : 0, 0),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.primaryColorLight60 : AppColors.secondaryColorDark,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _pressed
                ? const [
                    BoxShadow(
                      color: AppColors.secondaryColorDark,
                      offset: Offset(0, 1),
                      blurRadius: 6,
                      spreadRadius: -1,
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: AppColors.secondaryColorDark,
                      offset: Offset(-4, 4),
                      blurRadius: 12,
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              widget.label,
              style: const TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}