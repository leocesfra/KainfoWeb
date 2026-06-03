package leo.back.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // Desactiva CSRF (Obligatorio para que funcionen POST, PUT, DELETE desde Flutter)
                .csrf(csrf -> csrf.disable())
                // Desactiva CORS a nivel de seguridad (tu @CrossOrigin en el controller ya lo maneja)
                .cors(cors -> cors.disable())
                // Permite todas las peticiones sin exigir Token o Login de Spring Security
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().permitAll()
                );

        return http.build();
    }
}
