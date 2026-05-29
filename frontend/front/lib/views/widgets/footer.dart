import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.blackColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('© 2026 Kainfo', style: AppTypography.colorWhite.labelSmall),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFooterItem(Icons.phone, '981 97 66 01'),
              _buildFooterItem(Icons.email, 'info@kainfo.es'),
              _buildFooterItem(Icons.location_on, 'Av. Acea da Ma, 43, BJ, 15174 Culleredo, A Coruña'),
              _buildFooterItem(Icons.schedule, 'L-V: 09:00-14:00 y 16:00-20:30, S: 09:00-14:00'),
            ],
          ),
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
        Text(text, style: AppTypography.colorWhite.titleLarge),
      ],
    );
  }
}