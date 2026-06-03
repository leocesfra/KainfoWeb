import 'package:flutter/material.dart';
import 'package:front/viewmodels/cart_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../core/routes/app_routes.dart';
import '../../data/models/product_model.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../viewmodels/category_viewmodel.dart';

import '../widgets/header.dart';
import '../widgets/footer.dart';
import '../widgets/product_card.dart';
import '../widgets/brand_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _menuOpen = false;
  final PageController _carouselController = PageController();
  int _currentCarouselPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
      context.read<CategoryViewModel>().fetchCategories();
    });
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculamos dinámicamente cuántas tarjetas caben en el monitor
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 180; // Restamos márgenes y flechas
    final itemsPerPage = (availableWidth / 260).floor().clamp(1, 6);

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
                        // TÍTULO: Novedades (INICIO DIRECTO SIN BANNER)
                        Text(
                          'Novedades',
                          style: AppTypography.colorBlack.headlineLarge,
                        ),
                        const SizedBox(height: 24),

                        // CARRUSEL (Altura ampliada a 380 para evitar overflow)
                        Consumer<ProductViewModel>(
                          builder: (context, viewModel, child) {
                            if (viewModel.state == ViewState.loading) {
                              return const SizedBox(
                                height: 380,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            if (viewModel.products.isEmpty) {
                              return const SizedBox(
                                height: 380,
                                child: Center(
                                  child: Text(
                                    'No hay productos',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              );
                            }

                            // Agrupar productos dinámicamente
                            final products = viewModel.products;
                            List<List<ProductModel>> chunks = [];
                            for (
                              var i = 0;
                              i < products.length;
                              i += itemsPerPage
                            ) {
                              chunks.add(
                                products.sublist(
                                  i,
                                  i + itemsPerPage > products.length
                                      ? products.length
                                      : i + itemsPerPage,
                                ),
                              );
                            }

                            if (chunks.length > 3)
                              chunks = chunks.sublist(
                                0,
                                3,
                              ); // Límite de 3 páginas para los 3 iconos

                            return Column(
                              children: [
                                Row(
                                  children: [
                                    // Flecha Izquierda
                                    IconButton(
                                      icon: const Icon(
                                        Icons.keyboard_double_arrow_left,
                                        size: 40,
                                        color: AppColors.neutralColorDark,
                                      ),
                                      onPressed: () {
                                        if (_currentCarouselPage > 0) {
                                          _carouselController.previousPage(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                    ),
                                    // Viewport Carrusel
                                    Expanded(
                                      child: SizedBox(
                                        height: 380, // <-- ALTURA AMPLIADA AQUÍ
                                        child: PageView.builder(
                                          controller: _carouselController,
                                          onPageChanged: (index) => setState(
                                            () => _currentCarouselPage = index,
                                          ),
                                          itemCount: chunks.length,
                                          itemBuilder: (context, pageIndex) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: chunks[pageIndex].map((
                                                p,
                                              ) {
                                                return ProductCard(
                                                  title: p.name,
                                                  price: '${p.price} €',
                                                  imageUrl: p.primaryImageUrl,
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                        context,
                                                        AppRoutes.productDetail,
                                                        arguments: p,
                                                      ),

                                                  // <-- AÑADE ESTO:
                                                  onAddToCart: () {
                                                    context
                                                        .read<CartViewModel>()
                                                        .addItem(
                                                          p,
                                                        ); // 'p' es el ProductModel
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '${p.name} añadido a la cesta',
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                        duration:
                                                            const Duration(
                                                              seconds: 1,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    // Flecha Derecha
                                    IconButton(
                                      icon: const Icon(
                                        Icons.keyboard_double_arrow_right,
                                        size: 40,
                                        color: AppColors.neutralColorDark,
                                      ),
                                      onPressed: () {
                                        if (_currentCarouselPage <
                                            chunks.length - 1) {
                                          _carouselController.nextPage(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Paginación: 3 Engranajes
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(3, (index) {
                                    bool isActive =
                                        _currentCarouselPage == index;
                                    if (index >= chunks.length &&
                                        chunks.isNotEmpty)
                                      return const SizedBox.shrink();

                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          _carouselController.animateToPage(
                                            index,
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Icon(
                                            Icons.settings,
                                            size: 24,
                                            color: isActive
                                                ? AppColors.primaryColorLight
                                                : AppColors.neutralColorDark,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 64),

                        // TÍTULO: Nuestras Marcas
                        Text(
                          'Nuestras marcas',
                          style: AppTypography.colorBlack.headlineLarge,
                        ),
                        const SizedBox(height: 24),

                        // FILA MARCAS (Usamos Wrap por si la pantalla se hace pequeña, no de error)
                        const Wrap(
                          spacing: 40,
                          runSpacing: 24,
                          alignment: WrapAlignment.spaceEvenly,
                          children: [
                            BrandCard(
                              brandName: 'Logitech',
                              imageName:
                                  'frontend/front/assets/images/logitech.png',
                            ),
                            BrandCard(
                              brandName: 'Primux',
                              imageName:
                                  'frontend/front/assets/images/primux.png',
                            ),
                            BrandCard(
                              brandName: 'HP',
                              imageName:
                                  'frontend/front/assets/images/hp.png',
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

  // MENÚ LATERAL
  Widget _buildExactSideMenu() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      left: _menuOpen ? 0 : -312,
      top: 0,
      bottom: 0,
      child: Material(
        color: AppColors.secondaryColorLight,
        child: Container(
          width: 312,
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
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.whiteColor,
                        ),
                      );
                    }
                    if (viewModel.categories.isEmpty) {
                      return const Center(
                        child: Text(
                          'Sin categorías',
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: viewModel.categories.length,
                      itemBuilder: (context, index) {
                        final category = viewModel.categories[index];
                        return Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            iconColor: AppColors.whiteColor,
                            collapsedIconColor: AppColors.whiteColor,
                            leading: const Icon(
                              Icons.memory,
                              color: AppColors.whiteColor,
                            ),
                            title: Text(
                              category.name,
                              style: GoogleFonts.leagueSpartan(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            children: category.subCategories.map((subCategory) {
                              return Material(
                                color: Colors.transparent,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: 72,
                                  ),
                                  title: Text(
                                    subCategory.name,
                                    style: AppTypography.colorWhite.bodyLarge,
                                  ),
                                  onTap: () {
                                    setState(() => _menuOpen = false);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.catalog,
                                      arguments: {
                                        'categoryId': subCategory.id.toString(),
                                        'categoryName': subCategory.name,
                                      },
                                    );
                                  },
                                ),
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
      ),
    );
  }
}
