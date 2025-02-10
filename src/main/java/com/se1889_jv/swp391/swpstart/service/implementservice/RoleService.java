package com.se1889_jv.swp391.swpstart.service.implementservice;

import com.se1889_jv.swp391.swpstart.domain.Role;
import com.se1889_jv.swp391.swpstart.repository.RoleRepository;
import com.se1889_jv.swp391.swpstart.service.IService.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleService implements IRoleService {
    @Autowired
    RoleRepository roleRepository;
    public Role getRole(Long id) {
        return roleRepository.getById(id);
    }


}
