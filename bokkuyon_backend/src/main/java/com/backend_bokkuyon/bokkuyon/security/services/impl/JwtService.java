package com.backend_bokkuyon.bokkuyon.security.services.impl;

import com.backend_bokkuyon.bokkuyon.security.services.IJwtService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;

import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class JwtService implements IJwtService {
    private static final String SECRET = "5367566B59703373367639792F423F4528482B4D6251655468576D5A71347437";


    @Override
    public String generateToken(String username, Collection<? extends GrantedAuthority> authorities) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("roles",authorities);

        return createToken(username,claims) ;
    }


    @Override
    public String createToken(String username, Map<String, Object> claims) {
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis()+(3*3600*1000)))
                .signWith(getSignKey(),SignatureAlgorithm.HS256)
                .compact();
    }


    @Override
    public String createToken(String username) {
        return Jwts.builder()
                .setClaims(new HashMap<String, Object>())
                .setSubject(username)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis()+(3*3600*1000)))
                .signWith(getSignKey(), SignatureAlgorithm.HS256)
                .compact();
    }


    @Override
    public Key getSignKey() {
        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(SECRET));
    }


    public Claims exctractAllClaim(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSignKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }



    @Override
    public String extractUsername(String token) {
        return exctractAllClaim(token).getSubject();
    }


    @Override
    public Date extractExpiration(String token) {
        return exctractAllClaim(token).getExpiration();
    }


    @Override
    public Boolean isTokenExpired(String token) {
        try {
            return extractExpiration(token).before(new Date());
        }
        catch  (ExpiredJwtException e) {
            return true;
        }

    }


    @Override
    public Boolean validateToken(String token, UserDetails userDetails) {
        final String username = extractUsername(token);

        return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
    }
}
