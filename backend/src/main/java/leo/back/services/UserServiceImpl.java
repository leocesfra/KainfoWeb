package leo.back.services;

import leo.back.models.User;
import leo.back.repositories.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public String login(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        // Si el usuario existe y la contraseña coincide
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            return userOpt.get().getRol(); // Devuelve el rol ("admin")
        }
        return null;
    }
}
