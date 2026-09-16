// Paquete donde reside la capa de lógica de negocio (Service Layer)
package com.hospital.auth.service;

// DTO de entrada con las credenciales enviadas por el cliente
import com.hospital.auth.dto.request.LoginRequest;
// Excepción personalizada para manejar fallos de autenticación de forma controlada
import com.hospital.auth.exception.AuthenticationException;
// Modelo de dominio que representa al usuario
import com.hospital.auth.model.User;
// Interfaz del repositorio para acceder a los datos
import com.hospital.auth.repository.UserRepository;
// Codificador de contraseñas para comparar el hash seguro
import org.springframework.security.crypto.password.PasswordEncoder;
// Marca la clase como componente de servicio dentro del contenedor de Spring IoC
import org.springframework.stereotype.Service;

/**
 * Servicio encargado de la lógica central de autenticación del sistema.
 */
@Service
public class AuthService {

    // Dependencias inmutables requeridas por el servicio
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    /**
     * Constructor para inyección de dependencias (Constructor Injection).
     * Spring detecta automáticamente este constructor e inyecta los beans correspondientes.
     * Es la forma recomendada en Spring: facilita pruebas unitarias y garantiza inmutabilidad (final).
     */
    public AuthService(
            UserRepository userRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * Valida las credenciales de acceso de un usuario.
     *
     * @param request DTO con el correo y contraseña en texto plano recibidos del cliente.
     * @return El objeto User autenticado si las credenciales son correctas.
     * @throws AuthenticationException Si el usuario no existe o la contraseña no coincide.
     */
    public User authenticate(LoginRequest request) {
        // 1. Busca al usuario por su email.
        // Si el Optional está vacío, lanza la excepción de autenticación de inmediato.
        User user = userRepository.findByEmail(request.email())
                .orElseThrow(() ->
                        new AuthenticationException("Credenciales inválidas")
                );

        // 2. Compara la contraseña en texto plano con el hash almacenado usando BCrypt.
        // matches(rawPassword, encodedPassword) extrae el salt del hash y verifica si coinciden.
        boolean passwordMatches = passwordEncoder.matches(
                request.password(),
                user.getPasswordHash()
        );

        // 3. Si el hash no coincide con la contraseña provista, interrumpe el flujo con la excepción.
        if (!passwordMatches) {
            // Nota de seguridad: Se usa el mismo mensaje genérico ("Credenciales inválidas")
            // tanto para "usuario no encontrado" como para "contraseña incorrecta",
            // evitando ataques de enumeración de usuarios (User Enumeration Attack).
            throw new AuthenticationException("Credenciales inválidas");
        }

        // 4. Si pasa ambas validaciones, retorna la entidad del usuario autenticado.
        return user;
    }
}