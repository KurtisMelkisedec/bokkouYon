package com.backend_bokkuyon.bokkuyon.security.controllers.impl;

import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import com.backend_bokkuyon.bokkuyon.data.entities.ExpiredToken;
import com.backend_bokkuyon.bokkuyon.security.controllers.ISecurityRestController;
import com.backend_bokkuyon.bokkuyon.security.dto.request.RegisterRequestDto;
import com.backend_bokkuyon.bokkuyon.security.dto.request.UserLoginRequestDto;
import com.backend_bokkuyon.bokkuyon.security.dto.response.TokenResponseDto;
import com.backend_bokkuyon.bokkuyon.security.services.IExpiredTokenService;
import com.backend_bokkuyon.bokkuyon.security.services.IJwtService;
import com.backend_bokkuyon.bokkuyon.security.services.impl.SecurityService;
import com.backend_bokkuyon.bokkuyon.web.dto.response.RestResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
public class SecurityRestController implements ISecurityRestController {
    private final AuthenticationManager authenticationManager;
    private final IJwtService jwtService;
    private final IExpiredTokenService expiredTokenService;
    private final SecurityService securityService;

    @Override
    public ResponseEntity<?> login(UserLoginRequestDto user) {

        Authentication authenticate =null ;

        Map<Object, Object> response= RestResponseDto.response(null, HttpStatus.NOT_FOUND);
        try {
            authenticate = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
            if(authenticate.isAuthenticated()){

                //Generer le token
                String token= jwtService.createToken(user.getUsername());
                ExpiredToken expiredToken = expiredTokenService.findTokenInBlacklist(token);
                if(expiredToken != null){
                    response = RestResponseDto.response(null, HttpStatus.NO_CONTENT);
                }else{
                    AppUser appUser =securityService.findUserByEmail(user.getUsername());
                    TokenResponseDto tokenDto = TokenResponseDto.builder()
                            .id(appUser.getId())
                            .phone(appUser.getPhone())
                            .token(token)
                            .username(user.getUsername())
                            .roles(authenticate.getAuthorities().stream().map(GrantedAuthority::getAuthority).toList())
                            .build();
                    response = RestResponseDto.response(tokenDto, HttpStatus.OK);
                }
            }

        }
        catch (Exception e){
            response = RestResponseDto.response(null, HttpStatus.NOT_FOUND);

        }


        return new ResponseEntity<>(response,HttpStatus.OK);
    }

    @Override
    public ResponseEntity<?> register(RegisterRequestDto userRegister) {
        AppUser user = securityService.findByEmailOrPhone(userRegister.getEmail(),userRegister.getPhone());
        Map<Object,Object>response = RestResponseDto.response(null, HttpStatus.NOT_FOUND);

        if (user == null) {
            AppUser newUser = new AppUser(userRegister.getFullname(),userRegister.getEmail(),userRegister.getPassword(),userRegister.getPhone());
            securityService.saveUser(newUser);
            securityService.addRoleToUser(newUser.getEmail(), "user");
            response = RestResponseDto.response(null, HttpStatus.OK);

        }
        return new ResponseEntity<>(response,HttpStatus.OK);
    }
}

