package com.smhrd.bigdata.mapper;

import java.util.List;

import com.smhrd.bigdata.entity.Vcon;

public interface VconMapper {
   

   public List<Vcon> search_vcon(String id);

   public void input(Vcon vcon);
   
   public List<Vcon> search_vcon2(String st);

}