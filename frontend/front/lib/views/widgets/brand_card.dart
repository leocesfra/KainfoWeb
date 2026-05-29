import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

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
            color: AppColors.neutralColorLight, // Placeholder si no hay imagen
            child: Image.asset(
              'images/brands/$imageName',
              fit: BoxFit.contain,
              errorBuilder: (_,_,_) => const Icon(Icons.business, color: AppColors.neutralColorDark),
            ),
          ),
          const SizedBox(height: 8),
          
          // Texto 88x24
          Container(
            width: 88,
            height: 24,
            alignment: Alignment.center,
            child: Text(
              brandName,
              style: GoogleFonts.roboto(
                color: AppColors.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}