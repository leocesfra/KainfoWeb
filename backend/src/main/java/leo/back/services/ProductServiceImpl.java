package leo.back.services;

import leo.back.models.Product;
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
