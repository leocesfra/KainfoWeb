package leo.back.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Entity
@Getter @Setter
public class OrdersLine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int quantity;

    @Column(name = "unitary_price")
    private BigDecimal unitaryPrice;

    @JoinColumn(name = "order_id")
    @ManyToOne
    private Orders order;

    @JoinColumn(name = "product_id")
    @ManyToOne
    private Products product;
}