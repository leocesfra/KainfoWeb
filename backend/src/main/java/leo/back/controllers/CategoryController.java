package leo.back.controllers;

import leo.back.models.Category;
import leo.back.models.CategoryDTO;
import leo.back.services.CategoryService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/categories")
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/roots")
    public List<CategoryDTO> getRootCategories() {
        return categoryService.getRootCategories();
    }
}