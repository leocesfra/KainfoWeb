package leo.back.services;

import leo.back.models.Product;

import java.math.BigDecimal;
import java.util.*;


public interface ProductService {

    // GET All
    List<Product> getAllProducts();

    // GET Filtered
    List<Product> filterProducts(
            Long categoryId,
            Long brandId,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Map<String, String> dynamicFilters
    );

    // POST
    Product addProduct(Product product);

    // PUT
    Product updateProduct(Long id, Product productDetails);

    // DELETE
    void deleteProduct(Long id);
}
