package com.backend_bokkuyon.bokkuyon.web.controllers.impl;

import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import com.backend_bokkuyon.bokkuyon.data.entities.Trip;
import com.backend_bokkuyon.bokkuyon.security.services.ISecurityService;
import com.backend_bokkuyon.bokkuyon.services.ITripService;
import com.backend_bokkuyon.bokkuyon.web.controllers.ITripRestController;
import com.backend_bokkuyon.bokkuyon.web.dto.request.ReservationRequestDto;
import com.backend_bokkuyon.bokkuyon.web.dto.request.TripRequestDto;
import com.backend_bokkuyon.bokkuyon.web.dto.response.RestResponseDto;
import com.backend_bokkuyon.bokkuyon.web.dto.response.TripListResponseDto;
import com.backend_bokkuyon.bokkuyon.web.dto.response.TripReservationResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.logging.SimpleFormatter;

@RestController
@RequiredArgsConstructor
public class TripRestController implements ITripRestController {
    final ITripService tripService;
    final ISecurityService securityService;
    @Override
    public ResponseEntity<?> addRide(TripRequestDto ride) {
     AppUser driver= securityService.findById(ride.getIdUser());
     Map<Object, Object> response= RestResponseDto.response(null, HttpStatus.NOT_FOUND);

        if (driver!=null) {
         DateTimeFormatter formatter=DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.ENGLISH);
         LocalDate date=LocalDate.parse(ride.getDate(), formatter);
         if (tripService.findTripByDriverandDate(driver,date)==null) {

         Trip newTrip=new Trip();
         newTrip.setDriver(driver);
         newTrip.setArrival(ride.getArrival());
         newTrip.setDeparture(ride.getDeparture());
         newTrip.setRegistrationNumber(ride.getRegistrationNumber());

         newTrip.setDate(date);
         newTrip.setPricePerKm(ride.getPrice());
         newTrip.setSeats(ride.getSeats());
         tripService.addTrip(newTrip);
         response= RestResponseDto.response(null, HttpStatus.OK);
         }


        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @Override
    public ResponseEntity<?> findMyRides(String role,Long idUser) {
        AppUser user = securityService.findById(idUser);
        Map<Object, Object> response= RestResponseDto.response(null, HttpStatus.NOT_FOUND);
        if (user!=null){
            if (role.compareTo("driver")==0){
                response= RestResponseDto.response(tripService.findTripsByDriver(user).stream().map(t-> TripListResponseDto.toDto(t)).toList(), HttpStatus.OK);
            }
            else {
                response= RestResponseDto.response(tripService.findTripsByPassengerContain(user).stream().map(t-> TripListResponseDto.toDto(t)).toList(), HttpStatus.OK);
            }

        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @Override
    public ResponseEntity<?> findRidesByDepartureAndArrival(@RequestBody ReservationRequestDto trip) {
        AppUser client=securityService.findById(trip.getIdClient());
        Map<Object,Object>response=RestResponseDto.response(null,HttpStatus.NOT_FOUND);
        if (client!=null){
            response=RestResponseDto.response(

                    tripService.findTripsByDepartureAndArrivalAndDriverNotAndDate(trip.getDeparture(),trip.getArrival(),client,LocalDate.parse(trip.getDate())).stream().map(t -> TripReservationResponseDto.toDto(t)).toList(),
                    HttpStatus.OK
            );
        }
        return new ResponseEntity<>(response,HttpStatus.OK);
    }
}
