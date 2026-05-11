package leo.back.services;

import leo.back.models.Products;
import leo.back.repositories.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

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
}
