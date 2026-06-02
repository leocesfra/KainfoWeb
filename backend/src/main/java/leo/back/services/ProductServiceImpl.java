package leo.back.services;

import leo.back.dto.ProductCreateDTO;
import leo.back.models.Product;
import leo.back.models.ProductImage;
import leo.back.repositories.ProductRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService{

    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public List<Product> filterProducts(Long categoryId, Long brandId, BigDecimal minPrice, BigDecimal maxPrice, Map<String, String> dynamicFilters) {
        // 1: Filtro por las tablas de SQL
        List<Product> filteredBySQL = productRepository.findBasicFilters(categoryId, brandId, minPrice, maxPrice);

        // Si no hay filtros devolver la lista tal cual
        if (dynamicFilters == null || dynamicFilters.isEmpty()) {
            return filteredBySQL;
        }

        // 2: Java Streams sobre el JSON
        return filteredBySQL.stream()
                .filter(product -> matchesAllDynamicFilters(product, dynamicFilters))
                .collect(Collectors.toList());
    }

    @Override
    public Product addProduct(ProductCreateDTO dto) {
        Product product = new Product();
        product.setName(dto.getName());
        product.setDescription(dto.getDescription());
        product.setPrice(dto.getPrice());
        product.setStock(dto.getStock());
        product.setCategory(dto.getCategory());
        product.setSpecifications(dto.getSpecifications());

        // Guardamos el producto primero para que tenga ID
        Product savedProduct = productRepository.save(product);

        // Ahora convertimos las URLs (String) a ProductImage (Objetos)
        if (dto.getGalleryImages() != null && !dto.getGalleryImages().isEmpty()) {
            List<ProductImage> images = new ArrayList<>();
            for (int i = 0; i < dto.getGalleryImages().size(); i++) {
                ProductImage img = new ProductImage();
                img.setImageUrl(dto.getGalleryImages().get(i));
                img.setPrimary(i == 0); // La primera foto es la principal
                img.setProduct(savedProduct); // Le asignamos el producto recién creado
                images.add(img);
            }
            // Guarda las imágenes en su repositorio correspondiente
            // productImageRepository.saveAll(images);
        }

        return savedProduct;
    }

    @Override
    public Product updateProduct(Long id, Product productDetails) {
        // Buscamos el producto, si existe lo modificamos, si no lanzamos error
        return productRepository.findById(id).map(existingProduct -> {
            existingProduct.setName(productDetails.getName());
            existingProduct.setDescription(productDetails.getDescription());
            existingProduct.setPrice(productDetails.getPrice());
            existingProduct.setStock(productDetails.getStock());
            existingProduct.setSku(productDetails.getSku());
            existingProduct.setBrand(productDetails.getBrand());
            existingProduct.setCategory(productDetails.getCategory());
            existingProduct.setSpecifications(productDetails.getSpecifications());

            // Guardamos los cambios
            return productRepository.save(existingProduct);
        }).orElseThrow(() -> new RuntimeException("Producto no encontrado con el ID: " + id));
    }

    @Override
    public void deleteProduct(Long id) {
        // Borra por ID
        productRepository.deleteById(id);
    }

    private boolean matchesAllDynamicFilters(Product product, Map<String, String> dynamicFilters) {
        Map<String, Object> specs = product.getSpecifications();

        // Si el producto no tiene especificaciones y me piden filtros, lo descarto
        if (specs == null) return false;

        // Checkbox marcado = valor JSON
        for (Map.Entry<String, String> filter : dynamicFilters.entrySet()) {
            String requiredKey = filter.getKey();
            String requiredValue = filter.getValue();

            // No clave, o No valor, descarte
            if (!specs.containsKey(requiredKey) ||
                    !specs.get(requiredKey).toString().equalsIgnoreCase(requiredValue)) {
                return false;
            }
        }
        return true;
    }


}
