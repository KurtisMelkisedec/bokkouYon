package com.backend_bokkuyon.bokkuyon.web.dto.response;

import com.backend_bokkuyon.bokkuyon.data.entities.Trip;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
public class TripReservationResponseDto {
    private Long id;
    private String departure;
    private String arrival;
    private int seats;
    private int price;

    public static TripReservationResponseDto toDto(Trip trip){
        return new TripReservationResponseDto(
                trip.getId(),
                trip.getDeparture(),
                trip.getArrival(),
                trip.getSeats(),
                trip.getPricePerKm()
        );

    }
}
