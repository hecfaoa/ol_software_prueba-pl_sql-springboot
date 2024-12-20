/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Repository.java to edit this template
 */
package com.olsofware_test.establecimiento.repository;

import com.olsofware_test.establecimiento.entities.Establecimiento;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author HEKTOR
 */
public interface EstablecimientoRepository extends JpaRepository<Establecimiento, Long> {
    
}
