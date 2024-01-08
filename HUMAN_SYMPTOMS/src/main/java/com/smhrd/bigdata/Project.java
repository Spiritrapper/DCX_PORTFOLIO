package com.smhrd.bigdata;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan
@SpringBootApplication
public class Project {

	public static void main(String[] args) {
		SpringApplication.run(Project.class, args);
	}

}
