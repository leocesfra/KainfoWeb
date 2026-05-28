package leo.back.services;

import leo.back.models.Category;
import leo.back.models.CategoryDTO;

import java.util.List;

public interface CategoryService {
    List<CategoryDTO> getRootCategories();
}
