package com.backend_bokkuyon.bokkuyon.security.services.impl;

import com.backend_bokkuyon.bokkuyon.data.entities.ExpiredToken;
import com.backend_bokkuyon.bokkuyon.data.repositories.ExpiredTokenRepository;
import com.backend_bokkuyon.bokkuyon.security.services.IExpiredTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor

public class ExpiredTokenService implements IExpiredTokenService {
    private final ExpiredTokenRepository expiredTokenRepository;
    @Override
    public ExpiredToken findTokenInBlacklist(String token) {
        return expiredTokenRepository.findByToken(token);
    }

    @Override
    public ExpiredToken save(ExpiredToken token) {
        return expiredTokenRepository.save(token);
    }
}
