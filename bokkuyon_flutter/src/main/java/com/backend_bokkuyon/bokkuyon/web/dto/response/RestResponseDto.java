package com.backend_bokkuyon.bokkuyon.web.dto.response;

import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

public class RestResponseDto {
    public static Map<Object,Object> response(Object result, Object pages, Object currentPage, Object totalItems, Object totalPages, HttpStatus status){
        HashMap<Object,Object> model = new HashMap<Object,Object>();
        model.put("results", result);
        model.put("status", status.value());
        model.put("pages", pages);
        model.put("currentPage", currentPage);
        model.put("totalItems", totalItems);
        model.put("totalPages", totalPages);

        return  model;
    }
    public static Map<Object,Object> response(Object result, HttpStatus status){
        HashMap<Object,Object> model = new HashMap<Object,Object>();
        model.put("results", result);
        model.put("status", status.value());

        return  model;
    }

}
