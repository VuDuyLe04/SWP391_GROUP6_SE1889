package com.se1889_jv.swp391.swpstart.controller.admin;


import com.se1889_jv.swp391.swpstart.domain.User;
import com.se1889_jv.swp391.swpstart.service.implementservice.StoreService;
import com.se1889_jv.swp391.swpstart.service.implementservice.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    StoreService storeService;

    @GetMapping("/usermanagement")
    public String getAllUser(@RequestParam(value = "input", required = false) String input,
                             @RequestParam(value = "role", required = false, defaultValue = "-1") String roleId,
                             @RequestParam(value = "active", required = false, defaultValue = "-1") String active,
                             @RequestParam(value="page",required = false,defaultValue = "0") String page,
                             Model model) {
        Sort sort = Sort.by(Sort.Direction.ASC, "name");
        Pageable pageable = PageRequest.of(Integer.parseInt(page),5 ,sort);
        Page<User> users = userService.getAll(pageable);
        if (!(input == null)) {
            users = userService.getUsersBySearch(input, input,pageable);
            model.addAttribute("input", input);
        }
        else if (!roleId.equals("-1") && active.equals("-1"))
            users = userService.getUsersbyRoleID(Long.parseLong(roleId),pageable);
        else if (roleId.equals("-1") && !active.equals("-1"))
            users = userService.getUsersByActive(active.equals("1"),pageable);
        else if (!roleId.equals("-1") && !active.equals("-1"))
            users = userService.getUsersByRoleIDAndActive(Long.parseLong(roleId), active.equals("1"),pageable);
        model.addAttribute("active", active);
        model.addAttribute("roleId", roleId);
        model.addAttribute("userPage", users);

//        List<Store> stores = storeService.getAllStores();
//        model.addAttribute("stores", stores);

        return "admin/user/usermanagement";
    }
    @GetMapping("adduserin")
    public String addUserIn(){
        return "admin/user/adduserin";
    }
    @GetMapping("checkphone")
    public String checkPhone(@RequestParam(value="phone") String phone,
                                    Model model){
        String error = null;

        if(phone != null){
            if(userService.getUserByPhone(phone) != null){
                error = "Số điện thoại đã tồn tại! ";
                model.addAttribute("error", error);
            }

        }
        return "admin/user/adduserin";

    }

}
// su khac biet giua return redirect and return ko co direct
// redirect sang mot url moi, thanh 2 request, ngan ngua viec gui lai form vi no la 2 request
//nen khi refresh lai trang thi no chi noi dung cua request thu 2,thuong khong gui dc du lieu kem
//chi co the gui qua url

// return ko redirect ko chuyen sang 1 url moi, chi 1 request, bi gui lai form
// va thuong dunf khi can tra ve file jsp de render , thuong gui dc du lieu di kem
// thong qua Modal


// dung param de lay du lieu tu request, nhung chi trong mot request thoi, con neu 2 request thi ko lay duoc
//vi du nhu neu dung redirect sang urrl moi thi ko lay duoc
// nma neu jsp gui len server,sau do server return ve jsp do (ko redirect) thi van lay duoc
