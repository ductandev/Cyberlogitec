package com.cybersoft.uniclub06.service.imp;

import com.cybersoft.uniclub06.dto.ColorDTO;
import com.cybersoft.uniclub06.dto.ProductDTO;
import com.cybersoft.uniclub06.dto.SizeDTO;
import com.cybersoft.uniclub06.entity.*;
import com.cybersoft.uniclub06.repository.ColorRepository;
import com.cybersoft.uniclub06.repository.ProductRepository;
import com.cybersoft.uniclub06.repository.SizeRepository;
import com.cybersoft.uniclub06.repository.VariantRepository;
import com.cybersoft.uniclub06.request.AddProductRequest;
import com.cybersoft.uniclub06.service.FileService;
import com.cybersoft.uniclub06.service.ProductService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductServiceImp implements ProductService {

    private final ProductRepository productRepository;
    private final VariantRepository variantRepository;
    private final SizeRepository sizeRepository;
    private final ColorRepository colorRepository;
    private final FileService fileService;
    private final RedisTemplate redisTemplate;        // RedisTemplate: dùng để lưu tự dữ liệu và lấy dữ liệu từ trên redis

    @Transactional
    @Override
    public void addProduct(AddProductRequest request) {
        ProductEntity productEntity = new ProductEntity();
        productEntity.setName(request.name());
        productEntity.setDesc(request.desc());
        productEntity.setInfo(request.information());
        productEntity.setPrice(request.price());

        BrandEntity brandEntity = new BrandEntity();
        brandEntity.setId(request.idBrand());

        productEntity.setBrand(brandEntity);

        ProductEntity productInserted = productRepository.save(productEntity);

        VariantEntity variantEntity = new VariantEntity();
        variantEntity.setProduct(productInserted);

        ColorEntity colorEntity = new ColorEntity();
        colorEntity.setId(request.idColor());
        variantEntity.setColor(colorEntity);

        SizeEntity sizeEntity = new SizeEntity();
        sizeEntity.setId(request.idSize());
        variantEntity.setSize(sizeEntity);
        variantEntity.setPrice(request.priceSize());
        variantEntity.setQuanity(request.quantity());
        variantEntity.setImages(request.files().getOriginalFilename());

        variantRepository.save(variantEntity);
        fileService.saveFile(request.files());

    }



    @Override
    public List<ProductDTO> getProduct(int numPage) {
//        List<ProductEntity> listProductEntity = productRepository.findAll();
        Pageable page = PageRequest.of(numPage,4);

        return productRepository.findAll(page).stream().map(item -> {
            ProductDTO productDTO = new ProductDTO();
            productDTO.setId(item.getId());
            productDTO.setName(item.getName());
            productDTO.setPrice(item.getPrice());
            if(item.getVariants().size() > 0){
                productDTO.setLink("http://localhost:8080/file/" + item.getVariants().get(0).getImages());
            }else{
                productDTO.setLink("");
            }

            return productDTO;
        }).toList();
    }





    
    // @Cacheable("userdetail")             // Cách này là dùng main cache lưu trên RAM
    @Override
    public ProductDTO getDetailProduct(int id) {
        ObjectMapper mapper = new ObjectMapper();
        ProductDTO productDTO1 = new ProductDTO();
        if (redisTemplate.hasKey(String.valueOf(id))){
            System.out.println("kiemtra co key");
            String data = redisTemplate.opsForValue().get(String.valueOf(id)).toString();       // opsForValue: tham số thứ 3 là thời gian hết hạn các bạn tự tìm hiểu
            try {
                productDTO1 = mapper.readValue(data, ProductDTO.class);
            } catch (Exception e){
                throw new RuntimeException("Loi " + e.getMessage());
            }

        } else {
            System.out.println("kiemtra không key");
            Optional<ProductEntity> optionProductEntity = productRepository.findById(id);

            productDTO1 = optionProductEntity.stream().map(productEntity -> {
                ProductDTO productDTO = new ProductDTO();
                productDTO.setId(productEntity.getId());
                productDTO.setName(productEntity.getName());
                productDTO.setPrice(productEntity.getPrice());
                productDTO.setOverview(productEntity.getDesc());
                productDTO.setCategories(productEntity.getProductCategories().stream().map(productCategory ->
                        productCategory.getCategory().getName()
                ).toList());

                productDTO.setSizes(sizeRepository.findAll().stream().map(sizeEntity -> {
                    SizeDTO sizeDTO = new SizeDTO();
                    sizeDTO.setId(sizeEntity.getId());
                    sizeDTO.setName(sizeEntity.getName());

                    return sizeDTO;
                }).toList());

                productDTO.setColors(colorRepository.findAll().stream().map(colorEntity -> {
                    ColorDTO colorDTO = new ColorDTO();
                    colorDTO.setId(colorEntity.getId());
                    colorDTO.setName(colorEntity.getName());

                    return colorDTO;
                }).toList());

//            productDTO.setSizes(productEntity.getVariants().stream().map(variantEntity -> {
//                SizeDTO sizeDTO = new SizeDTO();
//                sizeDTO.setId(variantEntity.getSize().getId());
//                sizeDTO.setName(variantEntity.getSize().getName());
//
//                return sizeDTO;
//            }).toList());

                productDTO.setPriceColorSize(productEntity.getVariants().stream().map(variantEntity -> {
                    ColorDTO colorDTO = new ColorDTO();
                    colorDTO.setId(variantEntity.getColor().getId());
                    colorDTO.setImages(variantEntity.getImages());
                    colorDTO.setName(variantEntity.getColor().getName());

                    colorDTO.setSizes(productEntity.getVariants().stream().map(variantEntity1 -> {
                        SizeDTO sizeDTO = new SizeDTO();
                        sizeDTO.setId(variantEntity1.getSize().getId());
                        sizeDTO.setName(variantEntity1.getSize().getName());
                        sizeDTO.setQuantity(variantEntity1.getQuanity());
                        sizeDTO.setPrice(variantEntity1.getPrice());

                        return sizeDTO;
                    }).toList());

                    return colorDTO;
                }).toList());

                return productDTO;
            }).findFirst().orElseThrow(()-> new RuntimeException("Không tìm thấy dữ liệu"));


            try {
                String json = mapper.writeValueAsString(productDTO1);
                redisTemplate.opsForValue().set(String.valueOf(id), json);      // .set(key, value)
            } catch (JsonProcessingException e){
                throw  new RuntimeException("Lỗi parser json " + e.getMessage());
            }
        }



        return productDTO1;

    }
}
