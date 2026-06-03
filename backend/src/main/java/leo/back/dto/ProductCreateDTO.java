package leo.back.dto;
import leo.back.models.Brand;
import leo.back.models.Category;
import lombok.*;
import java.math.BigDecimal;
import java.util.*;

@Getter @Setter
public class ProductCreateDTO {
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private String sku; // <-- Añade también el SKU que metimos nuevo
    private Category category;

    private Brand brand; // <--- ¡ESTE ES EL CAMBIO CLAVE!

    private Map<String, Object> specifications;
    private List<String> galleryImages;
}
