package leo.back.services.impl;

import leo.back.models.Brand;
import leo.back.repositories.BrandRepository;
import leo.back.services.BrandService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandServiceImpl implements BrandService {

    private final BrandRepository brandRepository;

    // Inyección de dependencias por constructor (Buena práctica)
    public BrandServiceImpl(BrandRepository brandRepository) {
        this.brandRepository = brandRepository;
    }

    @Override
    public List<Brand> getAllBrands() {
        // Llama a MariaDB y devuelve absolutamente todas las marcas
        return brandRepository.findAll();
    }
}