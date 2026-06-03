package leo.back.controllers;

import leo.back.dto.LoginRequestDTO;
import leo.back.services.UserService;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequestDTO request) {
        String role = userService.login(request.getEmail(), request.getPassword());

        if (role != null) {
            return ResponseEntity.ok(Map.of("message", "Éxito", "rol", role));
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("error", "Credenciales incorrectas"));
        }
    }
}
