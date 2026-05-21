package leo.back.services;

import leo.back.models.Product;

import java.math.BigDecimal;
import java.util.*;


public interface ProductService {

    List<Product> getAllProducts();

    List<Product> filterProducts(
            Long categoryId,
            Long brandId,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Map<String, String> dynamicFilters
    );
}
