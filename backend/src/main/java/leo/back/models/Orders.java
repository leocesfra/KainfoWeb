package leo.back.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.sql.Date;

@Entity
@Getter @Setter
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "date")
    private Date orderDate;

    @Column(name = "client_name")
    private String clientName;

    @Column(name = "email_client")
    private String emailClient;

    private String address;

    private BigDecimal amount;

    private String state;
}