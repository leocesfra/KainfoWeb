import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../data/models/product_model.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../widgets/admin_header.dart'; // <-- IMPORT DEL NUEVO HEADER
import 'catalog.dart'; // Ajusta la ruta a tu catalog screen

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool _isWarehouseTab = true;
  bool _menuOpen = false; // <-- ESTADO PARA EL MENÚ

  int _currentPage = 1;
  final int _itemsPerPage = 20;
  final Set<int> _selectedProductIds = {};

  String _sortColumn = '';
  int _sortState = 0; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
      context.read<CategoryViewModel>().fetchCategories(); // Carga las categorías para el menú
    });
  }

  void _handleSort(String column) {
    setState(() {
      if (_sortColumn == column) {
        _sortState = (_sortState + 1) % 3;
        if (_sortState == 0) _sortColumn = '';
      } else {
        _sortColumn = column;
        _sortState = 1;
      }
      _currentPage = 1; 
    });
  }

  List<ProductModel> _getSortedAndPaginatedProducts(List<ProductModel> products) {
    List<ProductModel> sorted = List.from(products);

    if (_sortState != 0) {
      sorted.sort((a, b) {
        int comparison = 0;
        if (_sortColumn == 'Nombre') {
          comparison = a.name.compareTo(b.name);
        } else if (_sortColumn == 'Precio') {
          comparison = a.price.compareTo(b.price);
        } else if (_sortColumn == 'Stock') {
          comparison = a.stock.compareTo(b.stock);
        }
        return _sortState == 1 ? comparison : -comparison;
      });
    }

    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (startIndex >= sorted.length) return [];
    if (endIndex > sorted.length) endIndex = sorted.length;
    
    return sorted.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProductViewModel>();
    final allProducts = viewModel.products;
    final displayProducts = _getSortedAndPaginatedProducts(allProducts);
    final totalPages = (allProducts.length / _itemsPerPage).ceil().clamp(1, 9999);

    bool? masterCheckboxState;
    if (displayProducts.isNotEmpty) {
      final allVisibleSelected = displayProducts.every((p) => _selectedProductIds.contains(p.id));
      final someVisibleSelected = displayProducts.any((p) => _selectedProductIds.contains(p.id));
      if (allVisibleSelected) masterCheckboxState = true;
      else if (someVisibleSelected) masterCheckboxState = null;
      else masterCheckboxState = false;
    } else {
      masterCheckboxState = false;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack( // <-- STACK PARA SUPERPONER EL MENÚ LATERAL
        children: [
          Column(
            children: [
              // HEADER IMPORTADO
              AdminHeaderWidget(
                onCategoryTap: () => setState(() => _menuOpen = !_menuOpen),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Bienvenido, Admin', style: AppTypography.colorBlack.headlineLarge?.copyWith(fontSize: 28)),
                      const SizedBox(height: 32),
                      
                      // TABS
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
                        ),
                        child: Row(
                          children: [
                            _buildTab('Almacén', true),
                            _buildTab('Pedidos', false),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // CONTENIDO TABS
                      if (_isWarehouseTab) ...[
                        AnimatedHoverButton(
                          onTap: () {},
                          baseColor: AppColors.primaryColorLight,
                          borderRadius: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            child: Text('Añadir producto', style: AppTypography.colorWhite.titleLarge),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // TABLA RESPONSIVE
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Obligamos a que la tabla mida al menos 1000px o el ancho de la pantalla
                        final double tableWidth = constraints.maxWidth > 1000 ? constraints.maxWidth : 1000.0;

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: tableWidth, // <-- ANCHO FINITO (Soluciona el crash)
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Cabecera Tabla
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 48,
                                        child: Checkbox(
                                          value: masterCheckboxState,
                                          tristate: true,
                                          activeColor: AppColors.primaryColorDark,
                                          onChanged: (val) {
                                            setState(() {
                                              // Si todos están seleccionados (true), los deseleccionamos.
                                              // Si están a medias (null) o vacíos (false), seleccionamos todos.
                                              if (masterCheckboxState == true) {
                                                _selectedProductIds.removeAll(displayProducts.map((p) => p.id));
                                              } else {
                                                _selectedProductIds.addAll(displayProducts.map((p) => p.id));
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(flex: 3, child: _buildSortableHeader('Nombre')),
                                      Expanded(flex: 1, child: _buildSortableHeader('Precio')),
                                      Expanded(flex: 1, child: _buildSortableHeader('Stock')),
                                      const SizedBox(width: 80, child: Text('Editar', style: TextStyle(fontWeight: FontWeight.bold))),
                                      const SizedBox(width: 80, child: Text('Eliminar', style: TextStyle(fontWeight: FontWeight.bold))),
                                    ],
                                  ),
                                ),
                                // Filas
                                ...displayProducts.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final product = entry.value;
                                  final isSelected = _selectedProductIds.contains(product.id);
                                  final bgColor = index % 2 == 0 ? AppColors.whiteColor : AppColors.neutralColorLight;

                                  return Container(
                                    color: isSelected ? AppColors.primaryColorLight.withOpacity(0.1) : bgColor,
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 48,
                                          child: Checkbox(
                                            value: isSelected,
                                            activeColor: AppColors.primaryColorDark,
                                            onChanged: (val) {
                                              setState(() {
                                                if (val == true) _selectedProductIds.add(product.id);
                                                else _selectedProductIds.remove(product.id);
                                              });
                                            },
                                          ),
                                        ),
                                        Expanded(flex: 3, child: Text(product.name, style: AppTypography.colorBlack.bodyLarge)),
                                        Expanded(flex: 1, child: Text('${product.price.toStringAsFixed(2)} €', style: AppTypography.colorBlack.bodyLarge)),
                                        Expanded(flex: 1, child: Text(product.stock.toString(), style: AppTypography.colorBlack.bodyLarge)),
                                        
                                        // Botón Editar
                                        SizedBox(
                                          width: 80,
                                          child: AnimatedHoverButton(
                                            onTap: () {},
                                            baseColor: Colors.transparent,
                                            child: const Icon(Icons.edit, color: AppColors.blackColor),
                                          ),
                                        ),
                                        // Botón Eliminar
                                        SizedBox(
                                          width: 80,
                                          child: AnimatedHoverButton(
                                            onTap: () {},
                                            baseColor: Colors.transparent,
                                            child: const Icon(Icons.delete, color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 24),
                        
                        // PAGINACIÓN
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mostrando ${displayProducts.isEmpty ? 0 : ((_currentPage - 1) * _itemsPerPage) + 1}-${((_currentPage - 1) * _itemsPerPage) + displayProducts.length} de ${allProducts.length} productos',
                              style: AppTypography.colorBlack.bodyMedium,
                            ),
                            Row(
                              children: [
                                AnimatedHoverButton(
                                  onTap: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
                                  baseColor: AppColors.neutralColorLight,
                                  borderRadius: 4,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0), 
                                    child: Icon(Icons.keyboard_arrow_left, color: AppColors.blackColor), // <-- ICONO
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text('$_currentPage / $totalPages', style: AppTypography.colorBlack.titleLarge),
                                const SizedBox(width: 16),
                                AnimatedHoverButton(
                                  onTap: _currentPage < totalPages ? () => setState(() => _currentPage++) : null,
                                  baseColor: AppColors.neutralColorLight,
                                  borderRadius: 4,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0), 
                                    child: Icon(Icons.keyboard_arrow_right, color: AppColors.blackColor), // <-- ICONO
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ] else ...[
                        const Center(child: Text('Panel de Pedidos en construcción')),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildExactSideMenu(), // <-- MENÚ LATERAL CONECTADO
        ],
      ),
    );
  }

  Widget _buildSortableHeader(String title) {
    IconData? icon;
    if (_sortColumn == title) {
      if (_sortState == 1) icon = Icons.arrow_drop_up;
      else if (_sortState == 2) icon = Icons.arrow_drop_down;
    }

    return InkWell(
      onTap: () => _handleSort(title),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blackColor)),
          if (icon != null) Icon(icon, size: 20, color: AppColors.blackColor),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isWarehouse) {
    final isActive = _isWarehouseTab == isWarehouse;
    return InkWell(
      onTap: () => setState(() => _isWarehouseTab = isWarehouse),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondaryColorLight : Colors.transparent,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        child: Text(
          title,
          style: isActive ? AppTypography.colorWhite.titleLarge : AppTypography.colorBlack.titleLarge,
        ),
      ),
    );
  }

  // --- MENÚ LATERAL (Igual que el resto de la App) ---
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
                            color: Colors.transparent,
                            child: ExpansionTile(
                              iconColor: AppColors.whiteColor,
                              collapsedIconColor: AppColors.whiteColor,
                              leading: const Icon(Icons.memory, color: AppColors.whiteColor),
                              title: Text(
                                category.name,
                                style: GoogleFonts.leagueSpartan(color: AppColors.whiteColor, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              children: category.subCategories.map((subCategory) {
                                return Material( // <-- ENVOLVER AQUÍ
                                  color: Colors.transparent, // <-- COLOR TRANSPARENTE
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.only(left: 72),
                                    title: Text(subCategory.name, style: AppTypography.colorWhite.bodyLarge),
                                    onTap: () {
                                      setState(() => _menuOpen = false);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CatalogScreen(categoryId: subCategory.id.toString(), categoryName: subCategory.name),
                                        ),
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