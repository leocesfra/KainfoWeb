import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String? imageUrl;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.title, required this.price, this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 248,
          height: 380, // <-- ALTURA AMPLIADA PARA EVITAR EL OVERFLOW DE 16px
          color: AppColors.whiteColor,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Imagen Cuadrada con placeholder de texto
              Container(
                width: 232,
                height: 232,
                color: AppColors.neutralColorLight,
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : const Center(child: Text('Sin imagen', style: TextStyle(color: AppColors.neutralColorDark, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 8),
              
              // Nombre (Usa Expanded para rellenar hueco sin romper la columna)
              Expanded(
                child: Container(
                  width: 232,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 2, // Permite 2 líneas si es largo
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.colorBlack.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Precio con barra oscura y cinta de advertencia (Amarillo/Negro)
              Column(
                children: [
                  Container(
                    width: 232,
                    height: 28,
                    color: AppColors.secondaryColorDark, // Barra oscura
                    alignment: Alignment.center,
                    child: Text(price, style: AppTypography.colorWhite.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Botón Añadir redondeado a 4px
              Container(
                width: 232,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight,
                  borderRadius: BorderRadius.circular(4), // Borde 4px
                ),
                child: Text('AÑADIR', style: AppTypography.colorWhite.titleLarge?.copyWith(fontSize: 14)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}