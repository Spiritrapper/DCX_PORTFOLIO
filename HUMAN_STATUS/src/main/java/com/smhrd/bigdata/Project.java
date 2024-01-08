package com.smhrd.bigdata;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@MapperScan
@SpringBootApplication
@EnableScheduling
public class Project {

	public static void main(String[] args) {
		SpringApplication.run(Project.class, args);
	}

}
