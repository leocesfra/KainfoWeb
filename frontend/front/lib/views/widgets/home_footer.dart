import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.secondaryColorDark,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contacto',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text('981 97 66 01', style: TextStyle(color: AppColors.whiteColor.withAlpha(230))),
          const SizedBox(height: 4),
          Text('info@kainfo.es', style: TextStyle(color: AppColors.whiteColor.withAlpha(230))),
          const SizedBox(height: 12),
          Text('Avenida Acea da Ma, 43, BJ, 15174 Culleredo, A Coruña', style: TextStyle(color: AppColors.whiteColor.withAlpha(204))),
          const SizedBox(height: 16),
          Text('Horario', style: TextStyle(color: AppColors.whiteColor.withAlpha(230), fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('L - V: 09:00–14:00 y 16:00–20:30', style: TextStyle(color: AppColors.whiteColor.withAlpha(204))),
          Text('S: 09:00–14:00', style: TextStyle(color: AppColors.whiteColor.withAlpha(204))),
        ],
      ),
    );
  }
}
