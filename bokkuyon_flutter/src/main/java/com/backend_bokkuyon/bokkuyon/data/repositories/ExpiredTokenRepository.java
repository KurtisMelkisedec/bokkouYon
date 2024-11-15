package com.backend_bokkuyon.bokkuyon.data.repositories;

import com.backend_bokkuyon.bokkuyon.data.entities.ExpiredToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExpiredTokenRepository extends JpaRepository<ExpiredToken, Long> {
    ExpiredToken findByToken(String token);
}
