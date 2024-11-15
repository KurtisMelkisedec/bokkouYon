package com.backend_bokkuyon.bokkuyon.security.services.impl;

import com.backend_bokkuyon.bokkuyon.data.entities.AppRole;
import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import com.backend_bokkuyon.bokkuyon.data.repositories.AppRoleRepositry;
import com.backend_bokkuyon.bokkuyon.data.repositories.AppUserReposity;
import com.backend_bokkuyon.bokkuyon.security.services.ISecurityService;
import jakarta.persistence.EntityExistsException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class SecurityService implements ISecurityService, UserDetailsService {
    private final AppRoleRepositry appRoleRepository;
    private final AppUserReposity appUserRepository;
    private final PasswordEncoder passwordEncoder;
    @Override
    public AppUser findUserByEmail(String email) {
        return appUserRepository.findByEmail(email);
    }

    @Override
    public AppRole findRoleByRolename(String rolename) {
        return null;
    }

    @Override
    public AppUser saveUser(AppUser user) {
        AppUser appUser = findUserByEmail(user.getEmail());
        if(appUser != null) throw new EntityExistsException("User already exists");
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return appUserRepository.save(user);
    }

    @Override
    public AppRole saveRole(String role) {
        AppRole appRole = appRoleRepository.findByName(role);
        if(appRole!=null)throw new EntityNotFoundException("Ce role n'existe pas");
        AppRole newRole = new AppRole();
        newRole.setName(role);

        return appRoleRepository.save(newRole);
    }

    @Override
    public void addRoleToUser(String email, String rolename) {
        AppRole role = appRoleRepository.findByName(rolename);
        if(role==null) throw new EntityNotFoundException("Ce role n'existe pas");
        AppUser user = appUserRepository.findByEmail(email);
        if(user==null) throw new EntityNotFoundException("Ce user n'existe pas");
        user.getRoles().add(role);
        appUserRepository.save(user);

    }

    @Override
    public AppUser findAdmin() {
        return appUserRepository.findById(1L).get();
    }

    @Override
    public AppUser findByEmailOrPhone(String email, String phone) {
        return appUserRepository.findByEmailOrPhone(email,phone);
    }

    @Override
    public AppUser findById(Long id) {
        return appUserRepository.findById(id).get();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AppUser user = appUserRepository.findByEmail(username);
        if(user==null) throw new EntityNotFoundException("Ce user n'existe pas");
        List<SimpleGrantedAuthority> authorities = user.getRoles().stream().map(r->new SimpleGrantedAuthority(r.getName())).toList();
        return new User(user.getEmail(), user.getPassword(), authorities);
    }
}
