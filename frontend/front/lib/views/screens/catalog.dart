import 'package:flutter/material.dart';
import 'package:front/core/routes/app_routes.dart';
import 'package:front/views/screens/product_detail.dart';
import 'package:front/views/widgets/footer.dart';
import 'package:front/views/widgets/header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../widgets/product_card.dart';

// ==========================================
// 1. PANTALLA PRINCIPAL DEL CATÁLOGO
// ==========================================
class CatalogScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CatalogScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _menuOpen = false; // Estado del menú lateral izquierdo (Categorías)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Pide SOLO los productos de esta categoría al abrir la pantalla
      context.read<ProductViewModel>().applyFilters(categoryId: widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      endDrawer: const _FilterDrawer(), // <-- AQUÍ SE CONECTA EL DRAWER DERECHO
      body: Stack(
        children: [
          Column(
            children: [
              HeaderWidget(onCategoryTap: () => setState(() => _menuOpen = !_menuOpen)),
              
              // Título de Sección
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                child: Text(widget.categoryName, style: AppTypography.colorBlack.headlineLarge),
              ),

              // Fila de Botones (Filtros y Ordenación)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColorDark,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      icon: const Icon(Icons.filter_alt, color: AppColors.whiteColor),
                      label: Text('Filtros', style: AppTypography.colorWhite.titleLarge),
                      onPressed: () => _scaffoldKey.currentState?.openEndDrawer(), // Abre el _FilterDrawer
                    ),
                    const SizedBox(width: 16),
                    const _SortButton('Novedades'),
                    const _SortButton('Precio ascendente'),
                    const _SortButton('Precio descendente'),
                    const _SortButton('A-Z'),
                    const _SortButton('Z-A'),
                  ],
                ),
              ),

              // Grid de Productos y Paginador
              Expanded(
                child: Consumer<ProductViewModel>(
                  builder: (context, viewModel, _) {
                    if (viewModel.state == ViewState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (viewModel.products.isEmpty) {
                      return Center(child: Text('No hay productos', style: AppTypography.colorBlack.headlineMedium));
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 8,
                              childAspectRatio: 208 / 296,
                            ),
                            itemCount: viewModel.paginatedProducts.length,
                            itemBuilder: (context, index) {
                              final p = viewModel.paginatedProducts[index];
                              return ProductCard(
                                title: p.name,
                                price: '${p.price} €',
                                imageUrl: p.primaryImageUrl,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.productDetail,
                                    arguments: p,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        // Paginador
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: () => viewModel.setPage(viewModel.currentPage - 1),
                              ),
                              Text('${viewModel.currentPage} / ${viewModel.totalPages}', style: AppTypography.colorBlack.titleLarge),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: () => viewModel.setPage(viewModel.currentPage + 1),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              const FooterWidget(),
            ],
          ),
          _buildExactSideMenu(), // El menú lateral izquierdo
        ],
      ),
    );
  }

  // --- MENÚ LATERAL IZQUIERDO (Categorías) ---
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
                      return const Center(child: CircularProgressIndicator(color: AppColors.whiteColor));
                    }

                    if (viewModel.categories.isEmpty) {
                      return const Center(child: Text('Sin categorías', style: TextStyle(color: AppColors.whiteColor)));
                    }

                    return ListView.builder(
                      itemCount: viewModel.categories.length,
                      itemBuilder: (context, index) {
                        final category = viewModel.categories[index];
                        return Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: Material(
                            color: AppColors.secondaryColorLight,
                            child: ExpansionTile(
                              iconColor: AppColors.whiteColor,
                              collapsedIconColor: AppColors.whiteColor,
                              leading: const Icon(Icons.memory, color: AppColors.whiteColor),
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
                                  color: AppColors.secondaryColorLight,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.only(left: 72),
                                    title: Text(subCategory.name, style: AppTypography.colorWhite.bodyLarge),
                                    onTap: () {
                                      setState(() => _menuOpen = false);
                                      Navigator.pushReplacementNamed(
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

// ==========================================
// 2. WIDGET PANEL DE FILTROS DERECHO (EndDrawer)
// ==========================================
class _FilterDrawer extends StatefulWidget {
  const _FilterDrawer();

  @override
  State<_FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<_FilterDrawer> {
  late Set<String> _selectedFilters;

  @override
  void initState() {
    super.initState();
    // Recupera los filtros guardados en el ViewModel al abrir el Drawer
    _selectedFilters = Set.from(context.read<ProductViewModel>().activeFilters);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();

    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Column(
        children: [
          Container(
            color: AppColors.secondaryColorDark,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('FILTRAR', style: AppTypography.colorWhite.headlineSmall),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.whiteColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Marcas en Mayúsculas
                ExpansionTile(
                  title: Text('MARCAS', style: AppTypography.colorBlack.titleLarge),
                  children: viewModel.availableBrands.map((brand) {
                    final isSelected = _selectedFilters.contains(brand);
                    return CheckboxListTile(
                      activeColor: AppColors.primaryColorLight,
                      title: Text(brand.toUpperCase(), style: AppTypography.colorBlack.bodyMedium), // <-- UPPERCASE
                      value: isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedFilters.add(brand);
                          } else {
                            _selectedFilters.remove(brand);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                // Filtros Dinámicos
                ...viewModel.availableFilters.entries.map((entry) {
                  String title = entry.key.replaceAll('_', ' ').replaceAll('IINTEGRADA', 'INTEGRADA').toUpperCase();
                  
                  return ExpansionTile(
                    title: Text(title, style: AppTypography.colorBlack.titleLarge),
                    children: entry.value.map((val) {
                      final isSelected = _selectedFilters.contains(val);
                      final isBoolean = val.toLowerCase() == 'true' || val.toLowerCase() == 'false';
                      // <-- UPPERCASE en displayVal
                      final displayVal = val.toLowerCase() == 'true' ? 'SI' : (val.toLowerCase() == 'false' ? 'NO' : val.toUpperCase());

                      if (isBoolean) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedFilters.remove(val);
                              } else {
                                _selectedFilters.add(val);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: isSelected ? AppColors.primaryColorLight : Colors.transparent),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.circle, size: 8, color: isSelected ? AppColors.primaryColorLight : AppColors.blackColor),
                                const SizedBox(width: 12),
                                Text(displayVal, style: AppTypography.colorBlack.bodyMedium),
                              ],
                            ),
                          ),
                        );
                      }

                      return CheckboxListTile(
                        activeColor: AppColors.primaryColorLight,
                        title: Text(displayVal, style: AppTypography.colorBlack.bodyMedium),
                        value: isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _selectedFilters.add(val);
                            } else {
                              _selectedFilters.remove(val);
                            }
                          });
                        },
                      );
                    }).toList(),
                  );
                }),
              ],
            ),
          ),
          // Botones Guardar y Limpiar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.neutralColorLight,
              border: Border(top: BorderSide(color: AppColors.neutralColorDark, width: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryColorDark),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      setState(() => _selectedFilters.clear());
                      context.read<ProductViewModel>().clearFilters();
                    },
                    child: Text('Limpiar', style: AppTypography.colorBlack.titleLarge),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      context.read<ProductViewModel>().applyLocalFilters(_selectedFilters);
                      Navigator.pop(context);
                    },
                    child: Text('Guardar', style: AppTypography.colorWhite.titleLarge),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 3. WIDGET BOTÓN DE ORDENACIÓN
// ==========================================
class _SortButton extends StatelessWidget {
  final String criteria;

  const _SortButton(this.criteria);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColorLight),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onPressed: () => context.read<ProductViewModel>().sortProducts(criteria),
        child: Text(criteria, style: AppTypography.colorBlack.bodyLarge),
      ),
    );
  }
}