package com.backend_bokkuyon.bokkuyon.security.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class RegisterRequestDto {
    private String email;
    private String phone;
    private String password;
    private String fullname;
}
