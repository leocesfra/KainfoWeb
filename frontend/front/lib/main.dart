import 'package:flutter/material.dart';
import 'package:front/core/routes/app_routes.dart';
import 'package:front/data/repositories/category_repository.dart';
import 'package:front/viewmodels/category_viewmodel.dart';
import 'package:provider/provider.dart';

import 'core/constants/colors.dart';
import 'core/constants/typography.dart';
import 'core/network/api_client.dart';
import 'data/repositories/product_repository.dart';
import 'viewmodels/product_viewmodel.dart';
import 'views/screens/home.dart';

void main() {
  // 1. Instanciamos el cliente y repositorio
  final apiClient = ApiClient();
  final productRepository = ProductRepository(apiClient);
  final categoryRepository = CategoryRepository(apiClient);

  runApp(
    // 2. Inyectamos el ViewModel
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(productRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(categoryRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kainfo Web',
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.whiteColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColorDark)
            .copyWith(
              primary: AppColors.primaryColorDark,
              secondary: AppColors.secondaryColorDark,
              onPrimary: AppColors.whiteColor,
            ),
        textTheme: AppTypography.colorBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.secondaryColorDark,
          foregroundColor: AppColors.whiteColor,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
