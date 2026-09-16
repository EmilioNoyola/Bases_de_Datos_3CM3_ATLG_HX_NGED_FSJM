// Paquete donde residen las implementaciones en memoria (útil para pruebas o entornos de desarrollo)
package com.hospital.auth.repository.memory;

// Entidades y contratos de dominio
import com.hospital.auth.model.Role;
import com.hospital.auth.model.User;
import com.hospital.auth.repository.UserRepository;

// Anotación de Spring para inyectar propiedades definidas en application.properties/yml
import org.springframework.beans.factory.annotation.Value;
// Marca la clase como componente de persistencia dentro del contenedor de Spring IoC
import org.springframework.stereotype.Repository;
// Bean de codificación de contraseñas configurado previamente en SecurityConfig
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.*;
// Estructura de datos thread-safe para entornos concurrentes
import java.util.concurrent.ConcurrentHashMap;

/**
 * Implementación en memoria del repositorio de usuarios.
 * Simula una base de datos almacenando las entidades en la memoria RAM de la JVM.
 */
@Repository
public class InMemoryUserRepository implements UserRepository {

    /**
     * Almacén de usuarios en memoria.
     * ConcurrentHashMap garantiza operaciones atómicas y acceso seguro entre múltiples hilos (threads)
     * sin necesidad de bloquear todo el mapa como lo haría Collections.synchronizedMap.
     * Estructura: Key = email normalizado, Value = Objeto User.
     */
    private final Map<String, User> users = new ConcurrentHashMap<>();

    /**
     * Constructor con inyección de dependencias de Spring.
     * Se ejecuta una sola vez al inicializarse el bean, cargando un usuario demo por defecto.
     *
     * @param passwordEncoder Bean inyectado para hashear la contraseña inicial con BCrypt.
     * @param demoEmail Correo cargado dinámicamente desde 'app.demo-user.email'.
     * @param demoPassword Contraseña en texto plano cargada desde 'app.demo-user.password'.
     */
    public InMemoryUserRepository(
            PasswordEncoder passwordEncoder,
            @Value("${app.demo-user.email}") String demoEmail,
            @Value("${app.demo-user.password}") String demoPassword
    ) {
        // Asegura que el email de configuración no contenga espacios ni inconsistencias de mayúsculas
        String normalizedEmail = normalizeEmail(demoEmail);

        // Construcción de la entidad de demostración
        User demoUser = new User(
                UUID.randomUUID(),                         // Identificador único universal
                normalizedEmail,                           // Correo electrónico indexable
                passwordEncoder.encode(demoPassword),      // Contraseña hasheada (nunca en texto plano)
                Set.of(Role.DOCTOR)                        // Rol predeterminado usando un conjunto inmutable
        );

        // Registro del usuario en la estructura de almacenamiento concurrente
        users.put(normalizedEmail, demoUser);
    }

    /**
     * Busca un usuario por su correo electrónico.
     *
     * @param email Dirección enviada por el cliente.
     * @return Optional con el usuario si existe, o Optional.empty() si no existe o si el parámetro es nulo.
     */
    @Override
    public Optional<User> findByEmail(String email) {
        // Evita errores de puntero nulo (NPE) si el parámetro recibido es null
        if (email == null) {
            return Optional.empty();
        }

        // Aplica el mismo criterio de normalización usado al almacenar para garantizar coincidencias exactas
        String normalizedEmail = normalizeEmail(email);

        // Optional.ofNullable maneja automáticamente si users.get() retorna null, devolviendo Optional.empty()
        return Optional.ofNullable(users.get(normalizedEmail));
    }

    /**
     * Método auxiliar privado de sanitización.
     *
     * - trim(): Elimina espacios en blanco al inicio y al final.
     * - toLowerCase(Locale.ROOT): Convierte a minúsculas usando una configuración regional invariable,
     *   evitando comportamientos anómalos con alfabetos locales (como la 'i' turca sin punto).
     */
    private String normalizeEmail(String email) {
        return email.trim().toLowerCase(Locale.ROOT);
    }
}