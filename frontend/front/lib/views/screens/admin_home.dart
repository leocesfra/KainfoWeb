import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../data/models/product_model.dart';
import '../../viewmodels/product_viewmodel.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  bool _isWarehouseTab = true; // true: Almacén, false: Pedidos

  // Paginación y Selección
  int _currentPage = 1;
  final int _itemsPerPage = 20;
  final Set<int> _selectedProductIds = {};

  // Ordenación (0: Ninguno, 1: Ascendente, 2: Descendente)
  String _sortColumn = '';
  int _sortState = 0; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  void _handleSort(String column) {
    setState(() {
      if (_sortColumn == column) {
        _sortState = (_sortState + 1) % 3; // Ciclo: 0 -> 1 -> 2 -> 0
        if (_sortState == 0) _sortColumn = '';
      } else {
        _sortColumn = column;
        _sortState = 1;
      }
      _currentPage = 1; // Volver a pág 1 al ordenar
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

    // Paginación
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

    // Estado del Checkbox Maestro
    bool? masterCheckboxState;
    if (displayProducts.isNotEmpty) {
      final allVisibleSelected = displayProducts.every((p) => _selectedProductIds.contains(p.id));
      final someVisibleSelected = displayProducts.any((p) => _selectedProductIds.contains(p.id));
      if (allVisibleSelected) {
        masterCheckboxState = true;
      } else if (someVisibleSelected) masterCheckboxState = null; // Indeterminado
      else masterCheckboxState = false;
    } else {
      masterCheckboxState = false;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          const _AdminHeader(),
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
                    // Botón Añadir Producto
                    AnimatedHoverButton(
                      onTap: () { /* TODO: Modal añadir producto */ },
                      baseColor: AppColors.primaryColorLight,
                      borderRadius: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text('Añadir producto', style: AppTypography.colorWhite.titleLarge),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // TABLA RESPONSIVE
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 80),
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
                                          if (val == true || val == null) {
                                            _selectedProductIds.addAll(displayProducts.map((p) => p.id));
                                          } else {
                                            _selectedProductIds.removeAll(displayProducts.map((p) => p.id));
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
                              final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');

                              return Container(
                                color: isSelected ? AppColors.primaryColorLight.withValues(alpha: 0.1) : bgColor,
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
                                            if (val == true) {
                                              _selectedProductIds.add(product.id);
                                            } else {
                                              _selectedProductIds.remove(product.id);
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(flex: 3, child: Text(product.name, style: AppTypography.colorBlack.bodyLarge)),
                                    Expanded(flex: 1, child: Text(currencyFormat.format(product.price), style: AppTypography.colorBlack.bodyLarge)),
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
                              child: const Padding(padding: EdgeInsets.all(8.0), child: Text('Anterior')),
                            ),
                            const SizedBox(width: 16),
                            Text('$_currentPage / $totalPages', style: AppTypography.colorBlack.titleLarge),
                            const SizedBox(width: 16),
                            AnimatedHoverButton(
                              onTap: _currentPage < totalPages ? () => setState(() => _currentPage++) : null,
                              baseColor: AppColors.neutralColorLight,
                              borderRadius: 4,
                              child: const Padding(padding: EdgeInsets.all(8.0), child: Text('Siguiente')),
                            ),
                          ],
                        )
                      ],
                    )
                  ] else ...[
                    // TODO: Pestaña Pedidos
                    const Center(child: Text('Panel de Pedidos en construcción')),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortableHeader(String title) {
    IconData? icon;
    if (_sortColumn == title) {
      if (_sortState == 1) {
        icon = Icons.arrow_drop_up;
      } else if (_sortState == 2) icon = Icons.arrow_drop_down;
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
}

// ==========================================
// HEADER DEL ADMIN
// ==========================================
class _AdminHeader extends StatelessWidget {
  const _AdminHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      color: AppColors.secondaryColorLight,
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 40, errorBuilder: (_,_,_) => const Text('LOGO', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(width: 40),
          
          AnimatedHoverButton(
            onTap: () {},
            baseColor: AppColors.primaryColorDark,
            borderRadius: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.menu, color: AppColors.whiteColor),
                  const SizedBox(width: 8),
                  Text('Categorías', style: AppTypography.colorWhite.titleLarge),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: Center(
              child: Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(color: AppColors.neutralColorLight, borderRadius: BorderRadius.circular(32)),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Que estás buscando?',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    suffixIcon: Icon(Icons.search, color: AppColors.neutralColorDark),
                  ),
                ),
              ),
            ),
          ),
          
          Switch(value: false, onChanged: (v) {}, activeThumbColor: AppColors.primaryColorLight),
          const SizedBox(width: 24),
          AnimatedHoverButton(
            onTap: () => Navigator.pushReplacementNamed(context, '/login'), // Salir
            baseColor: Colors.transparent,
            child: const Icon(Icons.logout, color: AppColors.whiteColor, size: 28),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// COMPONENTE UNIVERSAL DE ANIMACIÓN (Hover & Click)
// ==========================================
class AnimatedHoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color baseColor;
  final double borderRadius;

  const AnimatedHoverButton({
    super.key,
    required this.child,
    this.onTap,
    required this.baseColor,
    this.borderRadius = 0,
  });

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // Oscurecer color al hacer click
    Color finalColor = widget.baseColor;
    if (widget.baseColor != Colors.transparent) {
      if (_isPressed) {
        finalColor = Color.alphaBlend(Colors.black.withValues(alpha: 0.2), widget.baseColor);
      } else if (_isHovered) {
        finalColor = Color.alphaBlend(Colors.white.withValues(alpha: 0.1), widget.baseColor);
      }
    }

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() { _isHovered = false; _isPressed = false; }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          if (widget.onTap != null) widget.onTap!();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isHovered && !_isPressed ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: finalColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}