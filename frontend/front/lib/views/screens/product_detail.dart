// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:front/viewmodels/category_viewmodel.dart';
import 'package:front/views/screens/catalog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../data/models/product_model.dart';
import '../widgets/footer.dart';
import '../widgets/header.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  bool _menuOpen = false; // <-- 1. Estado para el menú

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = true; 
    final images = widget.product.galleryImages.isNotEmpty
        ? widget.product.galleryImages
        : [''];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        // <-- 2. Stack para superponer el menú
        children: [
          Column(
            children: [
              HeaderWidget(
                onCategoryTap: () => setState(() => _menuOpen = !_menuOpen),
              ), // <-- 3. Botón conectado
              Expanded(
                child: LayoutBuilder(
                  // <-- 4. LayoutBuilder para el Footer
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Botón Volver
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 40,
                                  top: 24,
                                  bottom: 16,
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: AppColors.blackColor,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Volver al catálogo',
                                        style:
                                            AppTypography.colorBlack.titleLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Contenido Principal
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: Flex(
                                  direction: isDesktop
                                      ? Axis.horizontal
                                      : Axis.vertical,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // COLUMNA IZQ: GALERÍA
                                    Expanded(
                                      flex: isDesktop ? 1 : 0,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 400,
                                            width: double.infinity,
                                            color: AppColors.neutralColorLight,
                                            child: images.first.isEmpty
                                                ? const Icon(
                                                    Icons.image_not_supported,
                                                    size: 100,
                                                    color: AppColors
                                                        .neutralColorDark,
                                                  )
                                                : AnimatedSwitcher(
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    child: Image.network(
                                                      images[_selectedImageIndex],
                                                      key: ValueKey<int>(
                                                        _selectedImageIndex,
                                                      ),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(height: 16),
                                          if (images.first.isNotEmpty &&
                                              images.length > 1)
                                            SizedBox(
                                              height: 80,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: images.length,
                                                itemBuilder: (context, index) {
                                                  final isSelected =
                                                      _selectedImageIndex ==
                                                      index;
                                                  return MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: GestureDetector(
                                                      onTap: () => setState(
                                                        () =>
                                                            _selectedImageIndex =
                                                                index,
                                                      ),
                                                      child: AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                              milliseconds: 200,
                                                            ),
                                                        margin:
                                                            const EdgeInsets.only(
                                                              right: 12,
                                                            ),
                                                        width: 80,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? AppColors
                                                                      .primaryColorLight
                                                                : Colors
                                                                      .transparent,
                                                            width: 2,
                                                          ),
                                                          color: AppColors
                                                              .neutralColorLight,
                                                        ),
                                                        child: Image.network(
                                                          images[index],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (isDesktop) const SizedBox(width: 64),
                                    if (!isDesktop) const SizedBox(height: 32),

                                    // COLUMNA DER: INFORMACIÓN
                                    Expanded(
                                      flex: isDesktop ? 1 : 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.product.name,
                                            style: AppTypography
                                                .colorBlack
                                                .headlineLarge,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            widget.product.description,
                                            style: AppTypography
                                                .colorBlack
                                                .bodyLarge,
                                          ),
                                          const SizedBox(height: 32),

                                          // <-- AJUSTE: Especificaciones a la izq, Precio/Botón a la der
                                          Flex(
                                            direction: isDesktop
                                                ? Axis.horizontal
                                                : Axis.vertical,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Especificaciones
                                              Expanded(
                                                flex: isDesktop ? 2 : 0,
                                                child: Wrap(
                                                  spacing: 24,
                                                  runSpacing: 24,
                                                  children: widget.product.specifications.entries.map((
                                                    entry,
                                                  ) {
                                                    String key = entry.key
                                                        .replaceAll('_', ' ')
                                                        .toUpperCase();
                                                    String rawVal = entry.value
                                                        .toString();
                                                    String val =
                                                        rawVal.toLowerCase() ==
                                                            'true'
                                                        ? 'SI'
                                                        : (rawVal.toLowerCase() ==
                                                                  'false'
                                                              ? 'NO'
                                                              : rawVal.toUpperCase());

                                                    return Container(
                                                      width: isDesktop
                                                          ? 220
                                                          : (size.width / 2) -
                                                                60,
                                                      decoration:
                                                          const BoxDecoration(
                                                            border: Border(
                                                              left: BorderSide(
                                                                color: AppColors
                                                                    .primaryColorLight,
                                                                width: 4,
                                                              ),
                                                            ),
                                                          ),
                                                      padding:
                                                          const EdgeInsets.only(
                                                            left: 12,
                                                          ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            key,
                                                            style: AppTypography
                                                                .colorBlack
                                                                .headlineSmall,
                                                          ),
                                                          Text(
                                                            val,
                                                            style: AppTypography
                                                                .colorBlack
                                                                .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              if (isDesktop)
                                                const SizedBox(width: 32),
                                              if (!isDesktop)
                                                const SizedBox(height: 32),

                                              // Precio y Botón a la derecha
                                              Expanded(
                                                flex: isDesktop ? 1 : 0,
                                                child: Column(
                                                  crossAxisAlignment: isDesktop
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                            .start,
                                                  children: [
                                                    Text(
                                                      '${widget.product.price} €',
                                                      style: AppTypography
                                                          .colorBlack
                                                          .headlineLarge,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    const _AddCartButtonDetail(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 48),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(), // <-- 5. Empuja el footer hacia abajo
                              const FooterWidget(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          _buildExactSideMenu(), // <-- 6. Menú Lateral Renderizado
        ],
      ),
    );
  }

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
                          child: Material(
                            color: AppColors.secondaryColorLight,
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
                              children: category.subCategories.map((
                                subCategory,
                              ) {
                                return Material(
                                  color: AppColors.secondaryColorLight,
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
                                      // Al hacer clic, navega de nuevo a CatalogScreen con el nuevo ID
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CatalogScreen(
                                            categoryId: subCategory.id
                                                .toString(),
                                            categoryName: subCategory.name,
                                          ),
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

class _AddCartButtonDetail extends StatelessWidget {
  const _AddCartButtonDetail();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColorDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        // <-- AJUSTE: Esquinas redondeadas a 2px
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto añadido al carrito')),
        );
      },
      icon: const Icon(Icons.shopping_cart, color: AppColors.whiteColor),
      label: Text(
        'Añadir a la cesta',
        style: AppTypography.colorWhite.titleLarge,
      ),
    );
  }
}
