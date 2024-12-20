/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/springframework/Repository.java to edit this template
 */
package com.olsofware_test.comerciante.repository;

import com.olsofware_test.comerciante.entities.Comerciante;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author HEKTOR
 */
public interface ComercianteRepository extends JpaRepository<Comerciante, Long> {

    
}
