package com.hospital.auth.repository;

import com.hospital.auth.model.User;

import java.util.Optional;
/**
 * Interfaz que define el contrato de operaciones de persistencia para la entidad User.
 *
 * Nota: Si estás usando Spring Data JPA, normalmente extenderías de JpaRepository<User, Long>
 * o CrudRepository<User, Long> para heredar métodos CRUD estándar (save, findById, delete, etc.).
 */
public interface UserRepository {

    /**
     * Busca un usuario a partir de su dirección de correo electrónico.
     *
     * En Spring Data JPA, este método funciona por convención de nombres (Derived Query Method):
     * Spring analiza 'findByEmail' y genera automáticamente la consulta SQL/HQL equivalente:
     * "SELECT u FROM User u WHERE u.email = :email"
     *
     * @param email La dirección de correo a consultar en la base de datos.
     * @return un Optional que contiene la entidad User si existe,
     *         o un Optional.empty() si no se encontró coincidencia,
     *         evitando excepciones por valor nulo (NullPointerException).
     */
    Optional<User> findByEmail(String email);
}

