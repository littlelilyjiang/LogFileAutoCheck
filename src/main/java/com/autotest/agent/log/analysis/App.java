package com.autotest.agent.log.analysis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


/**
 * Hello world!
 *
 */
@EnableAutoConfiguration
@ComponentScan("com.autotest.agent.log.analysis.controller")
@ComponentScan("com.autotest.agent.log.analysis.service")
public class App extends SpringBootServletInitializer{
	 public static void main(String[] args) {
         SpringApplication.run(App.class, args);
   }
	 
	 @Override
	    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	        return application.sources(App.class);
	    }

	 
	 @Bean
	 public ViewResolver getViewResolver(){
	     InternalResourceViewResolver resolver = new InternalResourceViewResolver();
	     resolver.setPrefix("/");
	     resolver.setSuffix(".jsp");
	     resolver.setViewClass(JstlView.class);
	     return resolver;
	 }
}
