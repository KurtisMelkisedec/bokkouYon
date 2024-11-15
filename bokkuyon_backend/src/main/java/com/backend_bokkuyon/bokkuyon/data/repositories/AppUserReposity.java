package com.backend_bokkuyon.bokkuyon.data.repositories;

import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppUserReposity extends JpaRepository<AppUser, Long> {
    AppUser findByEmail(String email);

    AppUser findByEmailOrPhone(String email, String phone);
}
