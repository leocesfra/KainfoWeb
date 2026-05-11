package leo.back.repositories;

import leo.back.models.Categories;
import leo.back.models.Products;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ProductRepository extends JpaRepository<Products, Long>, JpaSpecificationExecutor<Products> {
    Page<Products> findByCategory(Categories category, Pageable pageable);
}
