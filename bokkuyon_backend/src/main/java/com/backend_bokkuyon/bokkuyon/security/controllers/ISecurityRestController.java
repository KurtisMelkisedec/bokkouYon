package com.backend_bokkuyon.bokkuyon.security.controllers;

import com.backend_bokkuyon.bokkuyon.security.dto.request.RegisterRequestDto;
import com.backend_bokkuyon.bokkuyon.security.dto.request.UserLoginRequestDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("api")
public interface ISecurityRestController {

    @PostMapping("/login")
    ResponseEntity<?> login(@RequestBody UserLoginRequestDto user);

    @PostMapping("/register")
    ResponseEntity<?> register(@RequestBody RegisterRequestDto user);


}
