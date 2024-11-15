package com.backend_bokkuyon.bokkuyon.data.repositories;

import com.backend_bokkuyon.bokkuyon.data.entities.AppUser;
import com.backend_bokkuyon.bokkuyon.data.entities.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface TripRepository extends JpaRepository<Trip, Long> {

    Trip findByDriverAndDate(AppUser user, LocalDate date);

    List<Trip>findByDriver(AppUser user);
    List<Trip>findByPassengersContaining(AppUser user);
    @Query("SELECT t FROM Trip t WHERE t.departure = :departure AND t.arrival = :arrival AND t.driver <> :user And t.date=:date")
    List<Trip> findByDepartureAndArrivalAndDriverNotAndDate(@Param("user") AppUser user, @Param("departure") String departure, @Param("arrival") String arrival,@Param("date")LocalDate date);
}
