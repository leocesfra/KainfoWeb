import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';

class BrandCard extends StatelessWidget {
  final String imageName;
  final String brandName;

  const BrandCard({super.key, required this.imageName, required this.brandName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      height: 136,
      child: Column(
        children: [
          // Imagen 88x88
          Container(
            width: 88,
            height: 88,
            color: AppColors.neutralColorLight,
            child: Image.asset(
              'assets/images/brands/$imageName', // <-- RUTA CORREGIDA
              fit: BoxFit.contain,
              errorBuilder: (_,_,_) => const Center(
                child: Text('Sin imagen', textAlign: TextAlign.center, style: TextStyle(color: AppColors.neutralColorDark, fontSize: 12, fontWeight: FontWeight.bold))
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Texto
          Container(
            width: 88,
            alignment: Alignment.center,
            child: Text(
              brandName, 
              textAlign: TextAlign.center, 
              style: AppTypography.colorBlack.bodyLarge?.copyWith(fontWeight: FontWeight.w500)
            ),
          ),
        ],
      ),
    );
  }
}