// Paquete donde residen los DTOs (Data Transfer Objects) orientados a solicitudes entrantes
package com.hospital.auth.dto.request;

// Anotaciones de Bean Validation (Jakarta Validation) para validar los datos antes de procesarlos
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

/**
 * DTO que representa la carga útil (payload) enviada por el cliente al iniciar sesión.
 *
 * Nota sobre Java Record:
 * - Es una clase inmutable introducida en Java 14/16.
 * - Genera automáticamente: constructor canónico, getters con el nombre del campo (ej. email(), password()),
 *   equals(), hashCode() y toString().
 * - NO genera setters, ya que todos sus campos son inherentemente 'final' (inmutables).
 */
public record LoginRequest(

        // Valida que el texto no sea nulo ni esté compuesto únicamente de espacios en blanco
        @NotBlank(message = "El correo es obligatorio")
        // Valida que la cadena cumpla con un patrón formal de dirección de correo electrónico
        @Email(message = "El formato del correo no es válido")
        String email,

        // Valida que el campo de la contraseña no venga vacío ni nulo
        @NotBlank(message = "La contraseña es obligatoria")
        String password
) {
        // Los records no requieren cuerpo si no se agrega lógica de validación compacta adicional
}