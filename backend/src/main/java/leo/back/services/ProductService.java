package leo.back.services;

import leo.back.models.Products;
import leo.back.repositories.ProductRepository;
import leo.back.specifications.ProductSpecification;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;

    // Obtener todos los productos
    public List<Products> getAllProducts() {
        return productRepository.findAll();
    }

    // Obtener las novedades para el carrusel
    public List<Products> getLatestProducts(int limit) {

        Pageable pageInstructions = PageRequest.of(0, limit, Sort.by("createdAt").descending());

        Page<Products> pageResult = productRepository.findAll(pageInstructions);

        return pageResult.getContent();
    }

    // Obtener los productos filtrados
    public Page<Products> getFilteredProducts(String brand, Long categoryId, BigDecimal minPrice, BigDecimal maxPrice, String attributeName, String attributeValue, Pageable pageable) {
        Specification<Products> spec = (root, query, criteriaBuilder) -> criteriaBuilder.conjunction();

        if (brand != null && !brand.isEmpty()) {
            spec = spec.and(ProductSpecification.hasBrand(brand));
        }

        if (categoryId != null && categoryId > 0) {
            spec = spec.and(ProductSpecification.hasCategoryId(categoryId));
        }

        if (minPrice != null && minPrice.compareTo(BigDecimal.ZERO) > 0) {
            spec = spec.and(ProductSpecification.priceGreaterThanOrEqual(minPrice));
        }

        if (maxPrice != null && maxPrice.compareTo(BigDecimal.ZERO) > 0) {
            spec = spec.and(ProductSpecification.priceLessThanOrEqual(maxPrice));
        }

        if (attributeName != null && attributeValue != null) {
            spec = spec.and(ProductSpecification.hasAttribute(attributeName, attributeValue));
        }

        return productRepository.findAll(spec, pageable);
    }
}
