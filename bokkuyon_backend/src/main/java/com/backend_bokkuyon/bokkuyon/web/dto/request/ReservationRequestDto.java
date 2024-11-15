package com.backend_bokkuyon.bokkuyon.web.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class ReservationRequestDto {
    private String arrival;
    private String departure;
    private String date;
    private Long idClient;
}
