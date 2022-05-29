package org.ddongq.DI_10_annoConfig;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

public class PersonInfoMain {
	public static void main(String[] args) {
		
		AnnotationConfigApplicationContext ctx = 
				new AnnotationConfigApplicationContext(AnnoConfig.class);
		
		//Person person1 = (Person)ctx.getBean("human1");
		Person person1 = ctx.getBean("human2", Person.class);	// 다운캐스팅이랑 같은 역할 괄호 뒤! (위와 동일한 내용의 코드)
		System.out.println(person1.getName());
		System.out.println(person1.getAge());
		System.out.println(person1.getHobbies());
		
	}
}
