package leo.back.dto; // o leo.back.dto si creaste la carpeta

import leo.back.models.Category;
import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.util.stream.Collectors;

@Getter @Setter
public class CategoryDTO {
    private Long id;
    private String name;
    private List<CategoryDTO> subCategories;

    // Constructor que convierte de Entity a DTO limitando la profundidad a 1 nivel
    public CategoryDTO(Category category) {
        this.id = category.getId();
        this.name = category.getName();
        if (category.getSubCategories() != null) {
            this.subCategories = category.getSubCategories().stream()
                    .map(sub -> {
                        CategoryDTO dto = new CategoryDTO();
                        dto.setId(sub.getId());
                        dto.setName(sub.getName());
                        // No mapeamos los hijos de los hijos para evitar bucles
                        return dto;
                    })
                    .collect(Collectors.toList());
        }
    }

    // Constructor vacío
    public CategoryDTO() {}
}