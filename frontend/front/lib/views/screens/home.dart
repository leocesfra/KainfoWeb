import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../widgets/home_header.dart';
import '../widgets/home_footer.dart';
import '../widgets/product_card.dart';
import '../widgets/promo_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _menuOpen = false;
  String _selectedLanguage = 'ES';
  
  // Variables del menú lateral
  int _expandedIndex = -1;
  int _hoveredCategory = -1;
  int _hoveredChild = -1;

  final List<Map<String, List<String>>> _categories = [
    {'Componentes': ['Placas base', 'Procesadores', 'Memorias', 'Almacenamiento']},
    {'Periféricos': ['Monitor', 'Teclados', 'Ratones', 'Auriculares']},
    {'Portátiles': ['Ultrabooks', 'Gaming', 'Oficina']},
  ];

  @override
  void initState() {
    super.initState();
    // 💡 INYECCIÓN: Le decimos al ViewModel que cargue los productos al iniciar la pantalla
    // Usamos WidgetsBinding para esperar a que termine el primer renderizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 1000;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(
                  isMenuOpen: _menuOpen,
                  onCategoryTap: () => setState(() => _menuOpen = !_menuOpen),
                  currentLanguage: _selectedLanguage,
                  onLanguageChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLanguage = value);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40), // Márgenes más amplios como en Figma
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      // 💡 AÑADIDO: El banner promocional
                      const PromoBannerWidget(),
                      const SizedBox(height: 48),
                      
                      Text('Novedades', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.blackColor)),
                      const SizedBox(height: 24),
                      
                      // 💡 INYECCIÓN: Consumer para reaccionar a los datos de MariaDB
                      SizedBox(
                        height: 330,
                        child: Consumer<ProductViewModel>(
                          builder: (context, viewModel, child) {
                            // Estado: Cargando
                            if (viewModel.state == ViewState.loading || viewModel.state == ViewState.initial) {
                              return const Center(child: CircularProgressIndicator(color: AppColors.primaryColorDark));
                            }
                            
                            // Estado: Error
                            if (viewModel.state == ViewState.error) {
                              return Center(
                                child: Text('Error: ${viewModel.errorMessage}', style: const TextStyle(color: Colors.red)),
                              );
                            }

                            // Estado: Éxito pero lista vacía
                            if (viewModel.products.isEmpty) {
                              return const Center(child: Text('No hay productos disponibles.'));
                            }

                            // Estado: Éxito con datos
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.products.length,
                              itemBuilder: (context, index) {
                                final product = viewModel.products[index];
                                return ProductCard(
                                  title: product.name,
                                  price: '${product.price.toStringAsFixed(2)} €',
                                  // TODO: Aquí pasaremos la URL de la imagen cuando tengas Cloudinary
                                  // imageUrl: product.images.first.imageUrl, 
                                );
                              },
                            );
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 48),
                      Text('Nuestras marcas', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.blackColor)),
                      const SizedBox(height: 24),
                      
                      // Marcas (Placeholder visual)
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: List.generate(
                          5,
                          (index) => Container(
                            width: isWide ? 180 : ((size.width - 96) / 2).clamp(100.0, double.infinity),
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.neutralColorLight,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Center(
                              child: Icon(Icons.business, size: 40, color: AppColors.neutralColorDark),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
                const FooterWidget(),
              ],
            ),
          ),
          _buildSideMenu(size.width),
        ],
      ),
    );
  }

  Widget _buildSideMenu(double screenWidth) {
    final width = screenWidth * 0.75;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      left: _menuOpen ? 0 : -width,
      top: 0,
      bottom: 0,
      child: SizedBox(
        width: width,
        child: Material(
          color: AppColors.secondaryColorDark,
          elevation: 18,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Categorías', style: TextStyle(color: AppColors.whiteColor, fontSize: 22, fontWeight: FontWeight.w700)),
                      InkWell(
                        onTap: () => setState(() => _menuOpen = false),
                        hoverColor: AppColors.primaryColorDark60,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorDark60,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.close, color: AppColors.whiteColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _categories.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final parent = _categories[index].keys.first;
                        final children = _categories[index][parent] ?? [];
                        final hovered = _hoveredCategory == index;
                        final expanded = _expandedIndex == index;

                        return MouseRegion(
                          onEnter: (_) => setState(() => _hoveredCategory = index),
                          onExit: (_) => setState(() => _hoveredCategory = -1),
                          child: Container(
                            decoration: BoxDecoration(
                              color: hovered ? AppColors.primaryColorDark60 : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  title: Text(parent, style: const TextStyle(color: AppColors.whiteColor, fontWeight: FontWeight.w700, fontSize: 18)),
                                  trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more, color: AppColors.whiteColor),
                                  onTap: () => setState(() => _expandedIndex = expanded ? -1 : index),
                                ),
                                if (expanded)
                                  for (var childIndex = 0; childIndex < children.length; childIndex += 1)
                                    MouseRegion(
                                      onEnter: (_) => setState(() => _hoveredChild = childIndex),
                                      onExit: (_) => setState(() => _hoveredChild = -1),
                                      child: Container(
                                        color: _hoveredChild == childIndex && _expandedIndex == index ? AppColors.primaryColorLight60 : Colors.transparent,
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.only(left: 36, right: 16),
                                          title: Text(children[childIndex], style: const TextStyle(color: AppColors.whiteColor, fontSize: 16)),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
