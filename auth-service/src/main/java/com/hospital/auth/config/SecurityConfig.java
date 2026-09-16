// Paquete donde se ubica la clase dentro de la arquitectura del proyecto (módulo de autenticación/configuración)
package com.hospital.auth.config;

// Importación de anotaciones de Spring Framework para la gestión del contexto e inyección de dependencias
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

// Importaciones de Spring Security para el manejo y codificación de contraseñas
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Clase de configuración de seguridad para el sistema.
 *
 * @Configuration indica a Spring que esta clase contiene definiciones de beans
 * (métodos anotados con @Bean) que formarán parte del contenedor de dependencias (Spring IoC).
 */
@Configuration
public class SecurityConfig {

    /**
     * Define y registra el bean de PasswordEncoder en el contexto de Spring.
     * Al exponerlo como bean, puede ser inyectado automáticamente (por ejemplo, con @Autowired)
     * en servicios de autenticación, registro de usuarios o gestión de credenciales.
     *
     * @return una implementación segura de PasswordEncoder basada en BCrypt.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        // BCryptPasswordEncoder utiliza un algoritmo de hashing adaptativo unidireccional con salt automático.
        // El parámetro '12' representa el factor de costo de trabajo (strength / log rounds):
        // Realiza 2^12 (4,096) iteraciones de hashing.
        // Un costo de 10 a 12 es el estándar actual recomendado: ofrece alta resistencia 
        // ante ataques de fuerza bruta y diccionarios sin sobrecargar de forma crítica la CPU del servidor.
        return new BCryptPasswordEncoder(12);
    }
}