import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('INTEL CORE ULTRA', style: TextStyle(color: AppColors.whiteColor, fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: 2)),
                const SizedBox(height: 12),
                const Text('Poder más allá de los límites', style: TextStyle(color: AppColors.whiteColor, fontSize: 24, fontWeight: FontWeight.w500)),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor, foregroundColor: AppColors.primaryColorDark,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Comprar Ahora', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Image.asset(
            'assets/images/intel_banner.png', 
            height: 250,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.computer, size: 150, color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}