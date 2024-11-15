package com.backend_bokkuyon.bokkuyon.data.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class Location {
    private Long id;
    private String placeId;
    private String description;
}
