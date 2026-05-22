package leo.back.controllers;

import leo.back.models.Product;
import leo.back.services.ProductService;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;
import java.util.*;


@RestController
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    // Ruta: GET http://localhost:8080/api/products
    @GetMapping
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }

    // Ruta: GET http://localhost:8080/api/products/search?
    @GetMapping("/search")
    public List<Product> filterProducts(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) Long brandId,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam Map<String, String> allParams
    ) {

        // Limpiamos el mapa de los filtros estáticos para dejar solo los dinámicos (el JSON)
        allParams.remove("categoryId");
        allParams.remove("brandId");
        allParams.remove("minPrice");
        allParams.remove("maxPrice");

        return productService.filterProducts(categoryId, brandId, minPrice, maxPrice, allParams);
    }
}