import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      color: AppColors.blackColor,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildFooterItem(Icons.phone, '981 97 66 01'), // e0b0
          _buildFooterItem(Icons.email, 'info@kainfo.es'), // e158
          _buildFooterItem(Icons.location_on, 'Av. Acea da Ma, 43'), // e0c8
          _buildFooterItem(Icons.schedule, 'L-V: 09:00-20:30'), // ebcc
        ],
      ),
    );
  }

  Widget _buildFooterItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.whiteColor, size: 24),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.leagueSpartan(
            color: AppColors.whiteColor,
            fontSize: 18, // h3 aprox
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}