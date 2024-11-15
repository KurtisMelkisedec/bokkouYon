package com.backend_bokkuyon.bokkuyon.data.fixtures;

import com.backend_bokkuyon.bokkuyon.data.entities.AppRole;
import com.backend_bokkuyon.bokkuyon.data.repositories.AppRoleRepositry;
import com.backend_bokkuyon.bokkuyon.security.services.impl.SecurityService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

//@Component
@RequiredArgsConstructor
public class RoleFixtures implements CommandLineRunner {
    private final AppRoleRepositry appRoleRepositry;
    private final SecurityService securityService;
    @Override
    public void run(String... args) throws Exception {
        securityService.saveRole("admin");
        securityService.saveRole("user");


    }
}
