package leo.back.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter @Setter @NoArgsConstructor
public class ProductsImages {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

}
