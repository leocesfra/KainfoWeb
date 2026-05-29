package leo.back.models;
import lombok.*;

@Getter @Setter
public class LoginRequestDTO {
    private String email;

    private String password;
}
