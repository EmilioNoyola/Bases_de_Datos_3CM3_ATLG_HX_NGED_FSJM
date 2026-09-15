package com.hospital.auth.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

//es un DTO que transporta informacion, y que el genera automaticamente los metodos cosntructor, getter, setter, equals,hashcode y tostring
public record LoginRequest(

        @NotBlank(message = "El coreo es obligatorio")
        @Email(message = "El formato del correo no es válido")

        String email,
        @NotBlank(message = "La contraseña es obligatoria")
        String password
) {

}
