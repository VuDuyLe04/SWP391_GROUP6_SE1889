package com.se1889_jv.swp391.swpstart.domain;

import com.se1889_jv.swp391.swpstart.util.validator.annotation.WareHouseExist;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "ware_houses")
@Setter
@Getter
public class WareHouse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @WareHouseExist
    private String name;
    
    @ManyToOne
    @JoinColumn(name = "store_id")
    private Store store;

    @OneToMany(mappedBy = "warehouse", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Product> products;

}
