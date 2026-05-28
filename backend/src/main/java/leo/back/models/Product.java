package leo.back.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name = "products")
@Getter @Setter @NoArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private BigDecimal price;

    private int stock;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    private String sku;

    @JoinColumn(name = "category_id")
    @ManyToOne
    @JsonIgnoreProperties({"subCategories", "parentCategory"}) // Solo trae el id y el name de la categoría
    private Category category;

    @JoinColumn(name = "brand_id")
    @ManyToOne
    private Brand brand;

    @JdbcTypeCode(SqlTypes.JSON)
    private Map<String, Object> specifications;
}