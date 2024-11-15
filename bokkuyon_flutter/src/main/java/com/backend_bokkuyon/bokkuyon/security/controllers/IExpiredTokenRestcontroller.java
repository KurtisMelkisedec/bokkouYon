package com.backend_bokkuyon.bokkuyon.security.controllers;

import com.backend_bokkuyon.bokkuyon.security.dto.response.TokenResponseDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("api")
public interface IExpiredTokenRestcontroller {
    @PostMapping("/admin/expiredToken")
    ResponseEntity<?> blackListToken(@RequestBody TokenResponseDto token);

}
