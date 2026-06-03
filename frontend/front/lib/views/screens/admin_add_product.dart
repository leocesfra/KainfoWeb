import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/data/models/brand_model.dart';
import 'package:front/viewmodels/brand_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/constants/colors.dart';
import '../../core/constants/typography.dart';
import '../../data/models/product_model.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../widgets/admin_header.dart';
import '../widgets/footer.dart';

class AdminProductAddScreen extends StatefulWidget {
  final ProductModel? productToEdit;

  const AdminProductAddScreen({super.key, this.productToEdit});

  @override
  State<AdminProductAddScreen> createState() => _AdminProductFormScreenState();
}

class _AdminProductFormScreenState extends State<AdminProductAddScreen> {
  bool _menuOpen = false;
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _skuController = TextEditingController();

  int? _selectedParentCategoryId;
  int? _selectedSubCategoryId;
  int? _selectedBrandId;
  bool _isLoading = false;

  List<TextEditingController> _imageUrlControllers = [TextEditingController()];

  // Especificaciones Dinámicas
  Map<String, TextEditingController> _specControllers = {};

  // Diccionario simulado de atributos por categoría
  final Map<String, List<String>> _categorySpecsTemplate = {
    'PROCESADORES': ['socket', 'gen', 'modelo', 'núcleos', 'gpu_integrada'],
    'PLACAS BASE': ['socket', 'chipset', 'factor_forma', 'wifi', 'lan'],
    'TARJETAS GRÁFICAS': [
      'ensamblador',
      'serie',
      'modelo',
      'memoria',
      'num_ventiladores',
    ],
    'MEMORIAS RAM': [
      'familia',
      'formato',
      'cantidad',
      'kits',
      'velocidad',
      'latencia',
    ],
    'DISCOS DUROS': [
      'formato',
      'tamaño',
      'capacidad',
    ], // Ajusta el nombre de la categoría si es distinto
    'FUENTES DE ALIMENTACIÓN': [
      'potencia',
      'eficiencia',
      'modularidad',
      'formato',
    ], // Ajusta el nombre de la categoría si es distinto
    'CAJAS Y TORRES': [
      'formato',
      'color',
      'num_ventiladores_incluidos',
      'fuente_incluida',
    ], // Ajusta el nombre de la categoría si es distinto
    'VENTILADORES': ['tamaño', 'conexion'],
    'MONITORES': [
      'tamaño',
      'resolucion',
      'panel',
      'max_hercios',
      'respuesta',
      'sincronizacion_vertical',
      'curvo',
      'ajustable_altura',
      'táctil',
    ],
    'TECLADOS': ['formato', 'tipo', 'switches', 'conexión'],
    'RATONES': ['conexión'],
    'AURICULARES': ['conexion', 'microfono'],
    'TODOS LOS PORTATILES': [
      'fabricante_cpu',
      'generación_cpu',
      'familia_cpu',
      'gpu',
      'familia_gpu',
      'ram',
      'disco',
      'puertos',
      'tamaño',
      'panel',
      'resolucion',
    ],
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryViewModel>().fetchCategories();
      context.read<BrandViewModel>().fetchBrands(); // <-- AÑADIR ESTA LÍNEA
    });

    if (widget.productToEdit != null) {
      final p = widget.productToEdit!;
      _nameController.text = p.name;
      _descController.text = p.description;
      _priceController.text = p.price.toString();

      if (p.galleryImages.isNotEmpty) {
        _imageUrlControllers = p.galleryImages
            .map((url) => TextEditingController(text: url))
            .toList();
      }

      p.specifications.forEach((key, value) {
        String formattedKey = key.replaceAll('_', ' ').toUpperCase();
        if (_specControllers.containsKey(formattedKey)) {
          _specControllers[formattedKey]!.text = value.toString();
        } else {
          _specControllers[formattedKey] = TextEditingController(
            text: value.toString(),
          );
        }
      });
    }
  }

  // Método para actualizar los campos según la categoría
  void _updateSpecsForCategory(String categoryName) {
    // Normalizamos el string a mayúsculas para evitar fallos de coincidencia
    final normalizedCategory = categoryName.trim().toUpperCase();

    // Buscamos las especificaciones. Si no existe, usamos el fallback.
    final specs =
        _categorySpecsTemplate[normalizedCategory] ??
        ['MARCA', 'MODELO', 'COLOR', 'PESO'];

    // Guardamos los valores antiguos por si cambiamos de categoría y coinciden claves (ej. MARCA)
    final oldValues = _specControllers.map(
      (key, controller) => MapEntry(key, controller.text),
    );

    // Limpiamos los controladores viejos
    for (var c in _specControllers.values) {
      c.dispose();
    }
    _specControllers.clear();

    // Creamos los nuevos dinámicamente
    for (var spec in specs) {
      _specControllers[spec] = TextEditingController(
        text: oldValues[spec] ?? '',
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _skuController.dispose();
    for (var c in _imageUrlControllers) {
      c.dispose();
    }
    for (var c in _specControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _addUrlField() {
    // LÍMITE DE 5 FOTOS
    if (_imageUrlControllers.length < 5) {
      setState(() {
        _imageUrlControllers.add(TextEditingController());
      });
    }
  }

  void _removeUrlField(int index) {
    setState(() {
      if (_imageUrlControllers.length > 1) {
        _imageUrlControllers[index].dispose();
        _imageUrlControllers.removeAt(index);
      }
    });
  }

  void _onReorderImages(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = _imageUrlControllers.removeAt(oldIndex);
      _imageUrlControllers.insert(newIndex, item);
    });
  }

  InputDecoration _customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.colorBlack.bodyLarge?.copyWith(
        color: Colors.grey,
      ),
      filled: true,
      fillColor: AppColors.neutralColorLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(
          color: AppColors.primaryColorLight,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(
          color: AppColors.primaryColorDark,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  Widget _buildLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.blackColor,
          ),
          children: [
            if (isRequired)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecLabel(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.primaryColorLight, width: 4),
        ),
      ),
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        text,
        style: AppTypography.colorBlack.headlineSmall?.copyWith(fontSize: 16),
      ),
    );
  }

  Future<void> _handleSave() async {
    // 1. Validar campos obligatorios
    if (_formKey.currentState!.validate() && _selectedSubCategoryId != null) {
      setState(() => _isLoading = true);

      try {
        // 2. Extraer Especificaciones a un Mapa
        final Map<String, String> specs = {};
        _specControllers.forEach((key, controller) {
          if (controller.text.trim().isNotEmpty) {
            specs[key] = controller.text.trim();
          }
        });

        // 3. Extraer Imágenes a una Lista (Solo las que tengan texto)
        final List<String> images = _imageUrlControllers
            .map((c) => c.text.trim())
            .where((text) => text.isNotEmpty)
            .toList();

        // 4. Montar el Objeto JSON
        // IMPORTANTE: Los nombres de las claves deben coincidir con tu Entidad/DTO en Spring Boot
        final Map<String, dynamic> productPayload = {
          'name': _nameController.text.trim(),
          'description': _descController.text.trim(),
          'price': double.tryParse(_priceController.text.replaceAll(',', '.')) ?? 0.0,
          'stock': 10, 
          'sku': _skuController.text.trim(), 
          'category': { 'id': _selectedSubCategoryId }, 
          'brand': { 'id': _selectedBrandId }, 
          'specifications': specs, 
          'galleryImages': images, 
        };

        // 5. Petición POST al Servidor
        final response = await http.post(
          Uri.parse(
            'http://localhost:8080/api/products',
          ), // Cambia si usas otro puerto/ruta
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(productPayload),
        );

        if (!mounted) return;
        setState(() => _isLoading = false);

        // 6. Gestionar la Respuesta
        if (response.statusCode == 200 || response.statusCode == 201) {
          // 201 = Created
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Producto guardado en base de datos correctamente'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Vuelve al admin_home
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error del servidor: ${response.statusCode}'),
              backgroundColor: AppColors.secondaryColorDark,
            ),
          );
          print('Error body: ${response.body}'); // Para debug en consola
        }
      } catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error de conexión con el servidor'),
            backgroundColor: AppColors.secondaryColorDark,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Por favor, cubre todos los campos obligatorios (*) y selecciona categoría',
            style: AppTypography.colorWhite.bodyLarge,
          ),
          backgroundColor: AppColors.secondaryColorDark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String mainImageUrl = '';
    if (_imageUrlControllers.isNotEmpty &&
        _imageUrlControllers.first.text.isNotEmpty) {
      mainImageUrl = _imageUrlControllers.first.text;
    }

    final categoryViewModel = context.watch<CategoryViewModel>();
    final parentCategories = categoryViewModel.categories;
    final selectedParent = parentCategories
        .where((c) => c.id == _selectedParentCategoryId)
        .firstOrNull;
    final subCategories = selectedParent?.subCategories ?? [];

    // --- NUEVO: CONSUMIR MARCAS REALES DEL VIEWMODEL ---
    final brandViewModel = context.watch<BrandViewModel>();
    final allBrands = brandViewModel.brands;
    
    List<BrandModel> filteredBrands = List.from(allBrands);

    // FILTRO DINÁMICO
    if (_selectedSubCategoryId != null) {
      final selectedCategoryName = subCategories.firstWhere((c) => c.id == _selectedSubCategoryId).name.toUpperCase();
      
      if (selectedCategoryName == 'PROCESADORES') {
        filteredBrands = allBrands.where((b) => ['AMD', 'INTEL'].contains(b.name.toUpperCase())).toList();
      } else if (selectedCategoryName == 'PLACAS BASES' || selectedCategoryName == 'GRÁFICAS') {
        filteredBrands = allBrands.where((b) => ['MSI', 'ASUS', 'GIGABYTE', 'ZOTAC', 'SAPPHIRE', 'PNY', 'AMD'].contains(b.name.toUpperCase())).toList();
      } else if (selectedCategoryName == 'MEMORIAS RAM') { // Ajustado a tu nombre exacto
        filteredBrands = allBrands.where((b) => ['CORSAIR', 'G.SKILL', 'PATRIOT'].contains(b.name.toUpperCase())).toList();
      }
    }

    Widget leftZone = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PREVIEW CUADRADO PERFECTO
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: double.infinity,
            color: AppColors.neutralColorLight,
            child: mainImageUrl.isEmpty
                ? Center(
                    child: Text(
                      'Preview',
                      style: AppTypography.colorBlack.headlineLarge?.copyWith(
                        color: AppColors.neutralColorDark,
                      ),
                    ),
                  )
                : Image.network(
                    mainImageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Center(
                      child: Text(
                        'Error de carga',
                        style: AppTypography.colorBlack.headlineLarge,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  scrollDirection: Axis.horizontal,
                  buildDefaultDragHandles: false,
                  itemCount: _imageUrlControllers.length,
                  onReorder: _onReorderImages,
                  itemBuilder: (context, index) {
                    final url = _imageUrlControllers[index].text;
                    return ReorderableDragStartListener(
                      key: ValueKey('thumb_$index'),
                      index: index,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.neutralColorLight,
                          border: Border.all(
                            color: index == 0
                                ? AppColors.primaryColorDark
                                : AppColors.primaryColorLight,
                            width: index == 0 ? 3 : 1,
                          ),
                        ),
                        child: url.isEmpty
                            ? const Icon(Icons.image, color: Colors.grey)
                            : Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image),
                              ),
                      ),
                    );
                  },
                ),
              ),
              // Botón Más Ocultable (Máximo 5)
              if (_imageUrlControllers.length < 5)
                InkWell(
                  onTap: _addUrlField,
                  child: Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(left: 8),
                    color: Colors.transparent,
                    child: const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 36,
                      color: AppColors.primaryColorDark,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildLabel('URL Imágenes'),
        ..._imageUrlControllers.asMap().entries.map((entry) {
          int idx = entry.key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Text(
                  '${idx + 1}. ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TextFormField(
                    controller: entry.value,
                    decoration: _customInputDecoration(
                      'Introduzca la URL de la imagen',
                    ),
                    onChanged: (val) => setState(() {}),
                  ),
                ),
                if (_imageUrlControllers.length > 1)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeUrlField(idx),
                  ),
              ],
            ),
          );
        }).toList(),
      ],
    );

    Widget rightZone = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // NOMBRE REDUCIDO (Flex 1)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Nombre producto', isRequired: true),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'El nombre es obligatorio'
                        : null,
                    decoration: _customInputDecoration(
                      'Ej. AMD Ryzen 7 7800X3D',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // CATEGORÍAS AMPLIADAS (Flex 2)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Categoría', isRequired: true),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          isExpanded: true, // <-- EVITA EL OVERFLOW
                          decoration: _customInputDecoration('Familia')
                              .copyWith(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                          value: _selectedParentCategoryId,
                          items: parentCategories
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c.id,
                                  child: Text(
                                    c.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) => setState(() {
                            _selectedParentCategoryId = val;
                            _selectedSubCategoryId = null;
                          }),
                          validator: (value) =>
                              value == null ? 'Obligatorio' : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          isExpanded: true, // <-- EVITA EL OVERFLOW
                          decoration: _customInputDecoration('Subcategoría')
                              .copyWith(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                              ),
                          value: _selectedSubCategoryId,
                          items: subCategories
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c.id,
                                  child: Text(
                                    c.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: _selectedParentCategoryId == null
                              ? null
                              : (val) {
                                  setState(() {
                                    _selectedSubCategoryId = val;
                                    // CAMBIAR ESPECIFICACIONES DINÁMICAMENTE
                                    final subCat = subCategories.firstWhere(
                                      (c) => c.id == val,
                                    );
                                    _updateSpecsForCategory(subCat.name);
                                  });
                                },
                          validator: (value) =>
                              value == null ? 'Obligatorio' : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildLabel('Descripción'),
        TextFormField(
          controller: _descController,
          maxLines: 5,
          decoration: _customInputDecoration(
            'Añada información detallada del producto...',
          ).copyWith(contentPadding: const EdgeInsets.all(16)),
        ),
        const SizedBox(height: 24),
        // --- NUEVA FILA: MARCA Y SKU ---
        // --- FILA: MARCA Y SKU ---
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Marca', isRequired: true),
                  DropdownButtonFormField<int>(
                    isExpanded: true,
                    decoration: _customInputDecoration('Seleccione marca'),
                    value: _selectedBrandId,
                    // AQUÍ ESTÁ EL CAMBIO: Usamos b.id y b.name directamente del modelo
                    items: filteredBrands.map((b) => DropdownMenuItem<int>(
                      value: b.id, 
                      child: Text(b.name)
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedBrandId = val),
                    validator: (value) => value == null ? 'Obligatorio' : null,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('SKU', isRequired: true),
                  TextFormField(
                    controller: _skuController,
                    validator: (value) => value == null || value.trim().isEmpty ? 'Obligatorio' : null,
                    decoration: _customInputDecoration('Ej. CPUAMD-001'),
                  ),
                ],
              ),
            ),
          ],
        ),
        // --- FIN NUEVA FILA ---
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Introduce el precio', isRequired: true),
                TextFormField(
                  controller: _priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+[\.,]?\d{0,2}'),
                    ),
                  ],
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Requerido'
                      : null,
                  textAlign: TextAlign.right,
                  decoration: _customInputDecoration('0.00 €'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Divider(),
        const SizedBox(height: 32),
        Text(
          'Especificaciones Técnicas',
          style: AppTypography.colorBlack.headlineMedium,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: _specControllers.entries.map((entry) {
            return SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSpecLabel(entry.key),
                  TextFormField(
                    controller: entry.value,
                    decoration: _customInputDecoration('Introduce información'),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          AdminHeaderWidget(
            onCategoryTap: () => setState(() => _menuOpen = !_menuOpen),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
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
                                  'Volver a Almacén',
                                  style: AppTypography.colorBlack.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColorDark,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: _isLoading ? null : _handleSave,
                            icon: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.whiteColor,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.save,
                                    color: AppColors.whiteColor,
                                  ),
                            label: Text(
                              _isLoading ? 'Guardando...' : 'Guardar Producto',
                              style: AppTypography.colorWhite.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 4, child: leftZone),
                          const SizedBox(width: 64),
                          Expanded(flex: 6, child: rightZone),
                        ],
                      ),
                    ),
                    const SizedBox(height: 64),
                    const FooterWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
