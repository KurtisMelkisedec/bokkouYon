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
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "roles")
public class AppRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false,unique = true)
    private String name;
    @Column(nullable = false)
    private Status status=Status.Visible;

    @ManyToMany(mappedBy = "roles")
    private List<AppUser> users=new ArrayList<>();

}
