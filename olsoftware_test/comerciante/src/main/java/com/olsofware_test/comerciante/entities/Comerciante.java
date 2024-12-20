/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.olsofware_test.comerciante.entities;

import jakarta.persistence.Entity;
import lombok.Data;
import jakarta.persistence.GenerationType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

/**
 *
 * @author HEKTOR
 */
@Data
@Entity
public class Comerciante {

    @GeneratedValue(strategy = GenerationType.AUTO)
    @Id
    private long id_comerciante;
    private String nombre;
    private String departamento;
    private String municipio;
    private String telefono;
    private String correo_electronico;
    private String fecha_registro;
    private String estado;
    private String fecha_actualizacion;
    private String usuario_actualizacion;

}
