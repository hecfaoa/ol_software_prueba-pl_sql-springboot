package com.olsofware_test.establecimiento.controller;

import com.olsofware_test.establecimiento.entities.Establecimiento;
import com.olsofware_test.establecimiento.repository.EstablecimientoRepository;
import java.util.Date;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

/**
 *
 * @author HEKTOR
 */
@RestController
@RequestMapping("/establecimiento")
public class EstablecimientoRestController {
    
    @Autowired
    EstablecimientoRepository establecimientoRepository; 
    
    @GetMapping()
    public List<Establecimiento> list() {
        return establecimientoRepository.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<?> get(@PathVariable long id) {
         Optional<Establecimiento> establecimiento = establecimientoRepository.findById(id);
        if (establecimiento.isPresent()) {
            return new ResponseEntity<>(establecimiento.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<?> put(@PathVariable Long id, @RequestBody Establecimiento input) {
         Optional<Establecimiento> optionalestablecimiento = establecimientoRepository.findById(id);
        if (optionalestablecimiento.isPresent()) {
            Establecimiento newestablecimiento = optionalestablecimiento.get();
            newestablecimiento.setNombre_establecimiento(input.getNombre_establecimiento());
            newestablecimiento.setIngresos(input.getIngresos());
            newestablecimiento.setNumero_empleados(input.getNumero_empleados());
            newestablecimiento.setId_comerciante(input.getId_comerciante());
            newestablecimiento.setFecha_actualizacion(input.getFecha_actualizacion());
            newestablecimiento.setUsuario_actualizacion(input.getUsuario_actualizacion());
            newestablecimiento.setFecha_actualizacion(new Date().toString());
             Establecimiento save = establecimientoRepository.save(newestablecimiento);
          return new ResponseEntity<>(save, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PostMapping
    public ResponseEntity<?> post(@RequestBody List<Establecimiento> input) {
        List<Establecimiento> save = establecimientoRepository.saveAll(input);
        return ResponseEntity.ok(save);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
                 establecimientoRepository.deleteById(id);
         return new ResponseEntity<>(HttpStatus.OK);
    }
    
}
