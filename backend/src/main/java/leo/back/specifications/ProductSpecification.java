package leo.back.specifications;

import jakarta.persistence.criteria.Join;
import leo.back.models.Product;
import org.springframework.data.jpa.domain.Specification;

import java.math.BigDecimal;

public class ProductSpecification {

    // ==========================================
    // FILTROS GLOBALES
    // ==========================================

    // Filtro por Marca (
    public static Specification<Product> hasBrand(String brand) {
        return (root, query, criteriaBuilder) -> {
            if (brand == null || brand.isEmpty()) return null;
            return criteriaBuilder.equal(criteriaBuilder.lower(root.get("brand")), brand.toLowerCase());
        };
    }

    // Filtro por Categoría
    public static Specification<Product> hasCategoryId(Long categoryId) {
        return (root, query, criteriaBuilder) -> {
            if (categoryId == null) return null;
            return criteriaBuilder.equal(root.get("category").get("id"), categoryId);
        };
    }

    // Filtro por Precio Mínimo
    public static Specification<Product> priceGreaterThanOrEqual(BigDecimal minPrice) {
        return (root, query, criteriaBuilder) -> {
            if (minPrice == null) return null;
            return criteriaBuilder.greaterThanOrEqualTo(root.get("price"), minPrice);
        };
    }

    // Filtro por Precio Máximo
    public static Specification<Product> priceLessThanOrEqual(BigDecimal maxPrice) {
        return (root, query, criteriaBuilder) -> {
            if (maxPrice == null) return null;
            return criteriaBuilder.lessThanOrEqualTo(root.get("price"), maxPrice);
        };
    }

    // ==========================================
    // FILTRO CARACTERÍSTICAS
    // ==========================================

    // 5. Filtro dinámico de Características
    public static Specification<Product> hasAttribute(String attributeName, String attributeValue) {
        return (root, query, criteriaBuilder) -> {
            if (attributeName == null || attributeValue == null) return null;
            Join<Product, ProductsAttributes> attributesJoin = root.join("attributes");
            return criteriaBuilder.and(
                    criteriaBuilder.equal(attributesJoin.get("name"), attributeName),
                    criteriaBuilder.equal(attributesJoin.get("value"), attributeValue)
            );
        };
    }
}
