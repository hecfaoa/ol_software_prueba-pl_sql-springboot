package com.olsofware_test.comerciante.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.olsofware_test.comerciante.entities.Comerciante;
import com.olsofware_test.comerciante.repository.ComercianteRepository;
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
@RequestMapping("/comerciante")
public class ComercianteRestController {
    
    @Autowired
    ComercianteRepository comercianteRepository;
    
    @GetMapping()
    public List<Comerciante> list() {
        return comercianteRepository.findAll();
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<?> get(@PathVariable long id) {
         Optional<Comerciante> comerciante = comercianteRepository.findById(id);
        if (comerciante.isPresent()) {
            return new ResponseEntity<>(comerciante.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<?> put(@PathVariable long id, @RequestBody Comerciante input) {
         Optional<Comerciante> optionalcomerciante = comercianteRepository.findById(id);
        if (optionalcomerciante.isPresent()) {
            Comerciante newcomerciante = optionalcomerciante.get();
            newcomerciante.setNombre(input.getNombre());
            newcomerciante.setDepartamento(input.getDepartamento());
            newcomerciante.setDepartamento(input.getDepartamento());
            newcomerciante.setMunicipio(input.getMunicipio());
            newcomerciante.setTelefono(input.getTelefono());
            newcomerciante.setCorreo_electronico(input.getCorreo_electronico());
            newcomerciante.setFecha_registro(input.getFecha_registro());
            newcomerciante.setEstado(input.getEstado());
            newcomerciante.setFecha_actualizacion(new Date().toString());
             Comerciante save = comercianteRepository.save(newcomerciante);
          return new ResponseEntity<>(save, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @PostMapping
    public ResponseEntity<?> post(@RequestBody List<Comerciante> input) {
        List<Comerciante> save = comercianteRepository.saveAll(input);
        return ResponseEntity.ok(save);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable long id) {
         comercianteRepository.deleteById(id);
         return new ResponseEntity<>(HttpStatus.OK);
    }
    
}

