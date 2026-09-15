package com.hospital.auth.dto.response;

//formato de json que nos devuelte el JWT, por el momento aqui
//despues lo vamos a meter HttpOnly
public record AuthResponse (
        String accessToken,
        String refreshToken,
        String tokenType
){
}
