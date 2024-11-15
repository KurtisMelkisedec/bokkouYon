package com.backend_bokkuyon.bokkuyon.security.services;

import io.jsonwebtoken.Claims;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.security.Key;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

public interface IJwtService {
    String generateToken(String username, Collection<? extends GrantedAuthority> authorities);

    String createToken(String username, Map<String,Object> claims);
    String createToken(String username);
    Key getSignKey();

    Claims exctractAllClaim(String token);

    String extractUsername(String token);

    Date extractExpiration(String token);

    Boolean isTokenExpired(String token);

    Boolean validateToken(String token, UserDetails userDetails);
}
