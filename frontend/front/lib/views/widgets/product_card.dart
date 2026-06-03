import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? imageUrl;
  final VoidCallback? onTap; // Para abrir el detalle
  final VoidCallback? onAddToCart; // <-- NUEVO: Para añadir al carrito

  const ProductCard({
    super.key, 
    required this.title, 
    required this.price, 
    this.imageUrl, 
    this.onTap,
    this.onAddToCart, // <-- Añadido al constructor
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 248,
          height: 380,
          color: AppColors.whiteColor,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Imagen Cuadrada
              Container(
                width: 232,
                height: 216,
                color: AppColors.neutralColorLight,
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : const Center(child: Text('Sin imagen', style: TextStyle(color: AppColors.neutralColorDark, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 8),
              
              // Nombre
              Expanded(
                child: Container(
                  width: 232,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.colorBlack.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Precio
              Column(
                children: [
                  Container(
                    width: 232,
                    height: 28,
                    color: AppColors.secondaryColorDark,
                    alignment: Alignment.center,
                    child: Text(price, style: AppTypography.colorWhite.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: 232,
                    height: 6,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.yellow, Colors.black, Colors.yellow, Colors.black, Colors.yellow, Colors.black],
                        stops: [0.16, 0.33, 0.5, 0.66, 0.83, 1.0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // BOTÓN AÑADIR (Ahora es clickeable)
              InkWell(
                onTap: onAddToCart, // <-- CONECTADO AQUÍ
                child: Container(
                  width: 232,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColorLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('AÑADIR', style: AppTypography.colorWhite.titleLarge?.copyWith(fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}