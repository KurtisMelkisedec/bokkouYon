package com.backend_bokkuyon.bokkuyon.security.controllers.impl;


import com.backend_bokkuyon.bokkuyon.data.entities.ExpiredToken;
import com.backend_bokkuyon.bokkuyon.security.controllers.IExpiredTokenRestcontroller;
import com.backend_bokkuyon.bokkuyon.security.dto.response.TokenResponseDto;
import com.backend_bokkuyon.bokkuyon.security.services.IExpiredTokenService;
import com.backend_bokkuyon.bokkuyon.web.dto.response.RestResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class ExpiredTokenRestController implements IExpiredTokenRestcontroller {
    private final IExpiredTokenService expiredTokenService;
    @Override
    public ResponseEntity<?> blackListToken(TokenResponseDto token) {
        ExpiredToken expiredToken = new ExpiredToken();

        expiredToken.setToken(token.getToken());
        expiredTokenService.save(expiredToken);

        return new ResponseEntity<>(RestResponseDto.response(expiredToken, HttpStatus.CREATED),HttpStatus.OK);
    }
}