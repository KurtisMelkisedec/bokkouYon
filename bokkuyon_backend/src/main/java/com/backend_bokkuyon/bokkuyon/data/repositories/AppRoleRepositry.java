package com.backend_bokkuyon.bokkuyon.data.repositories;

import com.backend_bokkuyon.bokkuyon.data.entities.AppRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppRoleRepositry extends JpaRepository<AppRole, Long> {
    AppRole findByName(String roleName);

}
