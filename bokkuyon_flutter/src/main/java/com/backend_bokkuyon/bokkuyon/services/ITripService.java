package com.backend_bokkuyon.bokkuyon.services;

import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import com.backend_bokkuyon.bokkuyon.data.entities.Trip;

import java.time.LocalDate;
import java.util.List;

public interface ITripService {

    Trip addTrip(Trip trip);

    Trip findTripByDriverandDate(AppUser user, LocalDate date);

    List<Trip> findTripsByDriver(AppUser user);
    List<Trip> findTripsByPassengerContain(AppUser user);

    List<Trip>findTripsByDepartureAndArrivalAndDriverNotAndDate(String departure,String arrival,AppUser user,LocalDate date);
}
