/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Service.java to edit this template
 */
package com.olsofware_test.reporte_comerciante.service;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Service
public class CsvService {

    public File generarCsv(List<Map<String, Object>> comerciantes) throws IOException {
        // Definir la ubicación y nombre del archivo
        File archivoCsv = new File("comerciantes_activos.csv");

        // Crear una cadena que representará el contenido del archivo CSV
        StringBuilder sb = new StringBuilder();

        // Agregar el encabezado (cabecera del CSV)
        sb.append("Nombre/Razón Social|Departamento|Municipio|Teléfono|Correo Electrónico|Fecha de Registro|Estado|Cantidad de Establecimientos|Total Activos|Cantidad de Empleados\n");

        // Recorrer los comerciantes y agregar cada uno al archivo CSV
        for (Map<String, Object> comerciante : comerciantes) {
            sb.append(comerciante.get("nombre_razon_social"))
              .append("|")
              .append(comerciante.get("departamento"))
              .append("|")
              .append(comerciante.get("municipio"))
              .append("|")
              .append(comerciante.get("telefono"))
              .append("|")
              .append(comerciante.get("correo_electronico"))
              .append("|")
              .append(comerciante.get("fecha_registro"))
              .append("|")
              .append(comerciante.get("estado"))
              .append("|")
              .append(comerciante.get("cantidad_establecimientos"))
              .append("|")
              .append(comerciante.get("total_activos"))
              .append("|")
              .append(comerciante.get("cantidad_empleados"))
              .append("\n");
        }

        // Escribir el contenido en el archivo
        FileUtils.writeStringToFile(archivoCsv, sb.toString(), "UTF-8");

        return archivoCsv;
    }
}

