package leo.back.dto;
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
    private Category category;
    private Map<String, Object> specifications;
    private List<String> galleryImages;
}
