package com.backend_bokkuyon.bokkuyon.security.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class UserLoginRequestDto {
    String username;
    String password;
}
