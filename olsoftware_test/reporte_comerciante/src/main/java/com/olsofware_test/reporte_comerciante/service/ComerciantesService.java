/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package com.olsofware_test.reporte_comerciante.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
/**
 *
 * @author HEKTOR
 */
@Service
public class ComerciantesService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Map<String, Object>> obtenerComerciantesActivos() {
        // Llamada a la función en Oracle
        String sql = "SELECT * FROM TABLE(obtener_comerciantes_activos())"; // Suponiendo que la función retorna una tabla
        return jdbcTemplate.queryForList(sql);
    }
}
