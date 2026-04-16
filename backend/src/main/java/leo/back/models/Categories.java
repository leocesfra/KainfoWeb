package leo.back.models;

import jakarta.persistence.*;

@Entity
public class Categories {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    String name;

    @JoinColumn(name = "parent_id")
    @ManyToOne
    Categories parentCategories;
}
