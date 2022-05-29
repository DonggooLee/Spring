package org.ddongq.DI_10_annoConfig;

import java.util.HashSet;
import java.util.Set;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration // applicationContext와 같은 역할을 하는 자바 클래스
public class AnnoConfig {
	
	@Bean					 // @Bean을 만드는 메소드
	public Person human1() { // <bean id="human1" class="org.ddongq.DI_10_annoConfig.">
		Set<String> hobbies = new HashSet<String>();
		hobbies.add("여행");
		hobbies.add("축구");
		hobbies.add("수면");
		
		Person person = new Person();
		person.setName("김씨");
		person.setAge(18);
		person.setHobbies(hobbies);
		
		return person;
	}
	
	@Bean(name = "human2")	// @Bean을 만드는 메소드 => name 값을 주면 id 값이  name 값을 잡는다
	public Person abc() {	// <bean id="human2" class="org.ddongq.DI_10_annoConfig.">
		Set<String> hobbies = new HashSet<String>();
		hobbies.add("여행");
		hobbies.add("축구");
		hobbies.add("수면");
		
		Person person = new Person();
		person.setName("박씨");
		person.setAge(25);
		person.setHobbies(hobbies);
		
		return person;
	}
	
}
