package com.backend_bokkuyon.bokkuyon.web.dto.response;

import com.backend_bokkuyon.bokkuyon.data.entities.Trip;
import com.backend_bokkuyon.bokkuyon.data.enums.TripStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.format.DateTimeFormatter;
import java.util.Locale;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class TripListResponseDto {
    private Long id;
    private int seats;
    private String departureId;
    private String arrivalId;
    private boolean etat;
    private String date;

    public  static  TripListResponseDto toDto(Trip trip){
        return new TripListResponseDto(
                trip.getId(),
                trip.getSeats(),
                trip.getDeparture(),
                trip.getArrival(),
                trip.getTripStatus()== TripStatus.NotStarted?false:true,
                trip.getDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.ENGLISH))
        );
    }
}
