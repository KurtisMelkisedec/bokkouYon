package com.backend_bokkuyon.bokkuyon.web.controllers;

import com.backend_bokkuyon.bokkuyon.web.dto.request.ReservationRequestDto;
import com.backend_bokkuyon.bokkuyon.web.dto.request.TripRequestDto;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("api/user/rides")
public interface ITripRestController {

    @PostMapping("")
    ResponseEntity<?>addRide(@RequestBody TripRequestDto ride);

    @GetMapping("")
    ResponseEntity<?>findMyRides(@RequestParam String role,
                                 @RequestParam Long idUser
    );
    @PostMapping("/reservation")
    ResponseEntity<?>findRidesByDepartureAndArrival(@RequestBody ReservationRequestDto trip

                                                    );
}
