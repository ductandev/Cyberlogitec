package com.cybersoft.uniclub06.controller;

import com.cybersoft.uniclub06.request.AddProductRequest;
import com.cybersoft.uniclub06.response.BaseResponse;
import com.cybersoft.uniclub06.service.FileService;
import com.cybersoft.uniclub06.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @PostMapping
    public ResponseEntity<?> addProduct(AddProductRequest request){
        productService.addProduct(request);

        BaseResponse baseResponse = new BaseResponse();
        baseResponse.setStatusCode(200);
        baseResponse.setMessage("Success !");

        return new ResponseEntity<>(baseResponse, HttpStatus.OK);
    }

    @GetMapping("/{page}")
    public ResponseEntity<?> getProduct(@PathVariable int page){
        BaseResponse baseResponse = new BaseResponse();
        baseResponse.setStatusCode(200);
        baseResponse.setMessage("Success !");
        baseResponse.setData(productService.getProduct(page));

        return new ResponseEntity<>(baseResponse,HttpStatus.OK);
    }

    @GetMapping("/detail/{id}")
    public ResponseEntity<?> getDetailProduct(@PathVariable int id){

        BaseResponse baseResponse = new BaseResponse();
        baseResponse.setStatusCode(200);
        baseResponse.setMessage("Success !");
        baseResponse.setData(productService.getDetailProduct(id));

        return new ResponseEntity<>(baseResponse,HttpStatus.OK);
    }
}
