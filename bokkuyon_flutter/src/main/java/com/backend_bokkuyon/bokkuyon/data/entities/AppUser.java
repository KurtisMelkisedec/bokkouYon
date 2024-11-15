package com.backend_bokkuyon.bokkuyon.data.entities;

import com.backend_bokkuyon.bokkuyon.data.enums.Status;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Table(name = "users")
public class AppUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String fullName;
    @Column(nullable = false,unique = true)
    private String email;
    @Column(nullable = false)
    private String phone;
    @Column(nullable = false)
    private String password;
    @Column(nullable = false)
    private Status statusAccount=Status.Visible;
    @Column(nullable = false)
    private Boolean isOnline=false;
    @ManyToMany(fetch = FetchType.EAGER)
    private List<AppRole> roles = new ArrayList<>();
    @OneToMany(mappedBy = "driver")
    private List<Trip>myTrips = new ArrayList<>();
    @ManyToMany(mappedBy = "passengers")
    private List<Trip>trips = new ArrayList<>();

    public AppUser(String fullName, String email,String password,String phone){
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
    }
}
