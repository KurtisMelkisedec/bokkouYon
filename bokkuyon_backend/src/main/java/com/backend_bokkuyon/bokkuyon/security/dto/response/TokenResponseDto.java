package com.backend_bokkuyon.bokkuyon.security.dto.response;



import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;
@Builder
@Getter
@Setter
public class TokenResponseDto {
    private Long id;
    private String token;
    private String username;
    private String phone;

    private List<String>roles = new ArrayList<>();



}
