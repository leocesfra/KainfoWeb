package leo.back.controllers;

import leo.back.models.Products;
import leo.back.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;


import java.util.List;

@RestController
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/products")
    public List<Products> getAllProducts() {
        return productService.getAllProducts();
    }
}
