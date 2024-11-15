package com.backend_bokkuyon.bokkuyon.security.services;

import com.backend_bokkuyon.bokkuyon.data.entities.AppRole;
import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;

public interface ISecurityService {
    AppUser findUserByEmail(String email);
    AppRole findRoleByRolename(String rolename);
    AppUser saveUser(AppUser user);
    AppRole saveRole(String role);
    void addRoleToUser(String email,String rolename);
    AppUser findAdmin();
    AppUser findByEmailOrPhone(String email, String phone);
    AppUser findById(Long id);

}
