/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.olsofware_test.establecimiento.entities;

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
public class Establecimiento {
    
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Id
    private long   id_establecimiento;
    private String nombre_establecimiento ;
    private Double ingresos ;
    private String numero_empleados ;
    private long   id_comerciante;
    private String fecha_actualizacion;
    private String usuario_actualizacion ;
}
