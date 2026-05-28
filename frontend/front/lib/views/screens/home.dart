import 'package:flutter/material.dart';
import 'package:front/viewmodels/category_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../widgets/home_header.dart';
import '../widgets/home_footer.dart';
import '../widgets/product_card.dart';
import '../widgets/brand_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _menuOpen = false;

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<ProductViewModel>().fetchProducts();
    // Pedimos las categorías a MariaDB:
    context.read<CategoryViewModel>().fetchCategories(); 
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              HeaderWidget(
                onCategoryTap: () => setState(() => _menuOpen = !_menuOpen),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TÍTULO: Novedades
                        Text(
                          'Novedades',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ), // H2
                        ),
                        const SizedBox(height: 24),

                      // CARRUSEL (Separación 64px)
                      SizedBox(
                        height: 336, // Altura exacta de tu card
                        child: Consumer<ProductViewModel>(
                          builder: (context, viewModel, child) {
                            if (viewModel.state == ViewState.loading)
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            if (viewModel.products.isEmpty) {
                              // <-- AJUSTE: Mensaje vacío con diseño
                              return Center(
                                child: Text(
                                  'No hay productos',
                                  style: GoogleFonts.leagueSpartan(
                                    fontSize: 32, // h2
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryColorDark,
                                  ),
                                ),
                              );
                            }

                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.products.length,
                              separatorBuilder: (_, __) => const SizedBox(
                                width: 64,
                              ), // Regla: 64px de separación
                              itemBuilder: (context, index) {
                                final p = viewModel.products[index];
                                return ProductCard(
                                  title: p.name,
                                  price: '${p.price} €',
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Controles del Carrusel (Flechas y Puntos)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.settings,
                            color: AppColors.primaryColorDark,
                            size: 24,
                          ), // Punto 1 (Activo)
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.settings,
                            color: AppColors.secondaryColorDark,
                            size: 24,
                          ), // Punto 2
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.settings,
                            color: AppColors.secondaryColorDark,
                            size: 24,
                          ), // Punto 3
                        ],
                      ),

                      const SizedBox(height: 64),

                      // TÍTULO: Nuestras Marcas
                      Text(
                        'Nuestras marcas',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ), // H2
                      ),
                      const SizedBox(height: 24),

                      // BANNER MARCAS (Separación 128px)
                      const Wrap(
                        spacing: 128,
                        children: [
                          BrandCard(
                            brandName: 'Logitech',
                            imageName: 'logitech.png',
                          ),
                          BrandCard(
                            brandName: 'HP',
                            imageName: 'HP.png',
                          ),
                          BrandCard(
                            brandName: 'primux',
                            imageName: 'primux.png',
                          ),
                          BrandCard(
                            brandName: 'Dell',
                            imageName: 'HP.png',
                          ),
                          BrandCard(
                            brandName: 'ASUS',
                            imageName: 'logitech.png',
                          ),
                        ],
                      ),
                        ],
                    ),
                  ),
                ),
              ),
              const FooterWidget(),
            ],
          ),
          _buildExactSideMenu(),
        ],
      ),
    );
  }

  // MENÚ LATERAL (312px)
 Widget _buildExactSideMenu() {
  return AnimatedPositioned(
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeInOut,
    left: _menuOpen ? 0 : -312,
    top: 0,
    bottom: 0,
    child: Container(
      width: 312,
      color: AppColors.secondaryColorLight,
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.whiteColor),
            onPressed: () => setState(() => _menuOpen = false),
          ),
          Expanded(
            child: Consumer<CategoryViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.state == CategoryViewState.loading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.whiteColor));
                }
                
                if (viewModel.categories.isEmpty) {
                  return const Center(child: Text('Sin categorías', style: TextStyle(color: AppColors.whiteColor)));
                }

                return ListView.builder(
                  itemCount: viewModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = viewModel.categories[index];
                    
                    // Widget nativo de Flutter para listas desplegables
                    return Theme(
                      // Quitamos las líneas divisorias feas por defecto
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: AppColors.whiteColor,
                        collapsedIconColor: AppColors.whiteColor,
                        // Icono base (Puedes hacer un switch según el nombre de la categoría si quieres iconos distintos)
                        leading: const Icon(Icons.memory, color: AppColors.whiteColor), 
                        title: Text(
                          category.name,
                          style: GoogleFonts.leagueSpartan(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Aquí pintamos los hijos (Placas base, procesadores...)
                        children: category.subCategories.map((subCategory) {
                          return ListTile(
                            contentPadding: const EdgeInsets.only(left: 72), // Sangría
                            title: Text(
                              subCategory.name,
                              style: GoogleFonts.roboto(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () {
                              // Aquí en el futuro filtraremos los productos por subcategoría
                              setState(() => _menuOpen = false); 
                            },
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
}
