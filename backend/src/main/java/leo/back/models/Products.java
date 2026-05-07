package leo.back.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Getter @Setter
public class Products {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String description;

    private BigDecimal price;

    private int stock;

    @Column(name = "image_url")
    private String imageUrl;

    @JoinColumn(name = "category_id")
    @ManyToOne
    private Categories category;

    private String brand;

    private String SKU;
}