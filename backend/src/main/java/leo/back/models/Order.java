package leo.back.models;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Getter @Setter @NoArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date")
    private LocalDateTime orderDate;

    @Column(name = "client_name")
    private String clientName;

    @Column(name = "email_client")
    private String emailClient;

    private String address;

    private BigDecimal amount;

    private String state;
}