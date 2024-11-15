package com.backend_bokkuyon.bokkuyon.data.entities;

import com.backend_bokkuyon.bokkuyon.data.enums.TripStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Table(name = "trips")
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private LocalDate date;
    @Column(nullable = false)
    private String departure;
    @Column(nullable = false)
    private String arrival;
    @Column(nullable = false)
    private Integer pricePerKm;
    @Column(nullable = false)
    private String registrationNumber;
    @Column(nullable = false)
    private Integer seats;
    @Column(nullable = false)
    private Integer reservedSeats=0;

    private TripStatus tripStatus=TripStatus.NotStarted;
    @ManyToOne
    private AppUser driver;
    @ManyToMany
    private List<AppUser> passengers=new ArrayList<>();

}
