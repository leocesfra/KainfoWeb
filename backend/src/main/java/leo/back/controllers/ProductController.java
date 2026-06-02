package leo.back.controllers;

import leo.back.dto.ProductCreateDTO;
import leo.back.models.Product;
import leo.back.services.ProductService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;
import java.util.*;


@CrossOrigin(origins = "*")
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

    // Ruta: POST http://localhost:8080/api/products
    @PostMapping
    public ResponseEntity<Product> addProduct(@RequestBody ProductCreateDTO dto) {
        // El @RequestBody es OBLIGATORIO para leer el JSON que envía Flutter
        Product newProduct = productService.addProduct(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(newProduct);
    }

    // Ruta: PUT http://localhost:8080/api/products/{id}
    @PutMapping("/{id}")
    public ResponseEntity<Product> updateProduct(@PathVariable Long id, @RequestBody Product product) {
        try {
            Product updatedProduct = productService.updateProduct(id, product);
            return ResponseEntity.ok(updatedProduct);
        } catch (RuntimeException e) {
            // Si no encuentra el producto, devuelve un 404 Not Found
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    // Ruta: DELETE http://localhost:8080/api/products/{id}
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteProduct(@PathVariable Long id) {
        try {
            productService.deleteProduct(id);
            // Devuelve un JSON simple {"deleted": true} al frontend
            return ResponseEntity.ok(Map.of("deleted", true));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

}