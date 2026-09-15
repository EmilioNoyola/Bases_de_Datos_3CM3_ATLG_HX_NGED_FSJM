package com.hospital.auth.model;

import lombok.Getter;

import java.util.Set;
import java.util.UUID;
//simulacion de componentes de lo que tiene un usuario, es solo una simulacion
@Getter
public class User {
    private final UUID id;
    private final String email;
    private final String passwordHash;
    private final Set<Role> roles;

    public User(UUID id, String email, String passwordHash, Set<Role> roles) {
        this.id = id;
        this.email = email;
        this.passwordHash = passwordHash;
        this.roles = Set.copyOf(roles);
    }
}
