package leo.back.services;

import leo.back.dto.CategoryDTO;

import java.util.List;

public interface CategoryService {
    List<CategoryDTO> getRootCategories();
}
