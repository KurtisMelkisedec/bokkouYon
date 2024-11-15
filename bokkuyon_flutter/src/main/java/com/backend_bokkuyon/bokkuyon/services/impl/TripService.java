package com.backend_bokkuyon.bokkuyon.services.impl;

import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import com.backend_bokkuyon.bokkuyon.data.entities.Trip;
import com.backend_bokkuyon.bokkuyon.data.repositories.TripRepository;
import com.backend_bokkuyon.bokkuyon.services.ITripService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TripService  implements ITripService {
    private final TripRepository tripRepository;
    @Override
    public Trip addTrip(Trip trip) {
        return tripRepository.save(trip);
    }

    @Override
    public Trip findTripByDriverandDate(AppUser user, LocalDate date) {
        return tripRepository.findByDriverAndDate(user,date);
    }

    @Override
    public List<Trip> findTripsByDriver(AppUser user) {
        return tripRepository.findByDriver(user);
    }

    @Override
    public List<Trip> findTripsByPassengerContain(AppUser user) {
        return tripRepository.findByPassengersContaining(user);
    }

    @Override
    public List<Trip> findTripsByDepartureAndArrivalAndDriverNotAndDate(String departure, String arrival, AppUser user,LocalDate date) {
        return tripRepository.findByDepartureAndArrivalAndDriverNotAndDate(user,departure,arrival,date);
    }
}
