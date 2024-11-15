package com.backend_bokkuyon.bokkuyon.web.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class TripRequestDto {
    private Long idUser;
    private String departure;
    private String arrival;
    private String date;
    private Integer seats;
    private Integer price;
    private String registrationNumber;
}
