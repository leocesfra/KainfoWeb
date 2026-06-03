package leo.back.dto;
import lombok.*;

@Getter @Setter
public class LoginRequestDTO {
    private String email;

    private String password;
}
