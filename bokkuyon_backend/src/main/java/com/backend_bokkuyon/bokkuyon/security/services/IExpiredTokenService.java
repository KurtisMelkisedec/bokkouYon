package com.backend_bokkuyon.bokkuyon.security.services;

import com.backend_bokkuyon.bokkuyon.data.entities.ExpiredToken;

public interface IExpiredTokenService {
    ExpiredToken findTokenInBlacklist(String token);

    ExpiredToken save(ExpiredToken token);
}
