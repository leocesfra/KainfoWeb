import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../widgets/header.dart';
import '../widgets/footer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          HeaderWidget(onCategoryTap: () {}), 
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TÍTULO
                    Text('Mi Cesta', style: AppTypography.colorBlack.headlineLarge?.copyWith(fontSize: 40, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 48),

                    if (cart.items.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(64.0),
                          child: Text('Tu cesta está vacía', style: TextStyle(fontSize: 24, color: Colors.grey)),
                        ),
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // COLUMNA IZQUIERDA (PRODUCTOS) - 65%
                          Expanded(
                            flex: 65,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...cart.items.values.map((cartItem) {
                                  return _buildCartItemRow(cartItem, cart);
                                }),
                                const SizedBox(height: 24),
                                // BOTÓN LIMPIAR
                                ElevatedButton.icon(
                                  onPressed: () => cart.clearCart(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColorDark, // <-- Color K
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                  icon: const Icon(Icons.delete_outline, color: AppColors.whiteColor),
                                  label: Text('Limpiar', style: AppTypography.colorWhite.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48), // Espaciador central
                          
                          // COLUMNA DERECHA (RESUMEN) - 35%
                          Expanded(
                            flex: 35,
                            child: Container(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total: ${cart.totalAmount.toStringAsFixed(2)}€',
                                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.blackColor),
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 64, // Altura generosa
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // TODO: POST al Backend (/api/orders)
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Procesando pedido...')));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColorDark, // <-- Color K
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                      child: const Text('Tramitar pedido', style: TextStyle(color: AppColors.whiteColor, fontSize: 28, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
          const FooterWidget(),
        ],
      ),
    );
  }

  Widget _buildCartItemRow(CartItem item, CartViewModel cart) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.primaryColorDark, width: 1.5)), // <-- Color K
      ),
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen 80x80
          Container(
            width: 80,
            height: 80,
            color: AppColors.neutralColorLight,
            child: item.product.primaryImageUrl != null && item.product.primaryImageUrl!.isNotEmpty
                ? Image.network(item.product.primaryImageUrl!, fit: BoxFit.cover)
                : const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(width: 24),
          
          // Info (Nombre y Precio Unitario)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                const SizedBox(height: 8),
                Text('Precio unitario: ${item.product.price.toStringAsFixed(2)}€', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          
          // Controles de cantidad
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQtyButton(Icons.chevron_left, () => cart.removeSingleItem(item.product.id.toInt())),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.neutralColorLight, borderRadius: BorderRadius.circular(4)),
                  child: Text('${item.quantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                _buildQtyButton(Icons.chevron_right, () => cart.addItem(item.product)),
              ],
            ),
          ),
          
          // Precio Total Item y Papelera
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.totalPrice.toStringAsFixed(2)}€',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.blackColor),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.blackColor, size: 28),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => cart.removeItem(item.product.id.toInt()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.grey[600], size: 24),
        ),
      ),
    );
  }
}