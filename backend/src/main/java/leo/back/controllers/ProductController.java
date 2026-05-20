package leo.back.controllers;

import leo.back.models.Product;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;


import java.math.BigDecimal;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/products")
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }

    // Endpoint para el buscador avanzado y filtros
    // Ejemplo de URL: /products/search?brand=Intel&minPrice=100&page=0&size=10
    @GetMapping("/products/search")
    public Page<Product> searchProducts(
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) String attributeName,
            @RequestParam(required = false) String attributeValue,
            Pageable pageable) {

        return productService.getFilteredProducts(brand, categoryId, minPrice, maxPrice, attributeName, attributeValue, pageable);
    }
}
