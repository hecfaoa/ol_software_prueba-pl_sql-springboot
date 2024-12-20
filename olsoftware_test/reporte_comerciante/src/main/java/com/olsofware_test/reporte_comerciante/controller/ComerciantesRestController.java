/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/RestController.java to edit this template
 */
package com.olsofware_test.reporte_comerciante.controller;

import com.olsofware_test.reporte_comerciante.service.ComerciantesService;
import com.olsofware_test.reporte_comerciante.service.CsvService;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;




/**
 *
 * @author HEKTOR
 */


@RestController
public class ComerciantesRestController {

    @Autowired
    private ComerciantesService comerciantesService;

    @Autowired
    private CsvService csvService;

    @GetMapping("/comerciantes/csv")
    public ResponseEntity<byte[]> obtenerCsv() throws IOException {
        // Obtener los comerciantes activos desde la base de datos
        var comerciantes = comerciantesService.obtenerComerciantesActivos();

        // Generar el archivo CSV
        File archivoCsv = csvService.generarCsv(comerciantes);

        // Leer el archivo CSV y convertirlo en un array de bytes
        FileInputStream fileInputStream = new FileInputStream(archivoCsv);
        byte[] archivoBytes = fileInputStream.readAllBytes();
        fileInputStream.close();

        // Configurar los headers de la respuesta para indicar que es un archivo CSV
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=comerciantes_activos.csv");

        return new ResponseEntity<>(archivoBytes, headers, HttpStatus.OK);
    }
}

