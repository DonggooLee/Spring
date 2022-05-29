package org.ddongq.DI_7_dependencyChange;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class TVUser {
	public static void main(String[] args) {
		
		// 1. String 컨테이너 구동
		AbstractApplicationContext ctx = 
				new GenericXmlApplicationContext("applicationContext7.xml");
		
		// 2. Spring 컨테이너로부터 필요한 객체 요청
		TV stv_sony = (SamsungTV)ctx.getBean("stv_sony");
		stv_sony.powerOn();
		stv_sony.volumeUp();
		stv_sony.volumeDown();
		stv_sony.powerOff();
		
		System.out.println("---------------------------------");
		
		TV stv_apple = (SamsungTV)ctx.getBean("stv_apple");
		stv_apple.powerOn();
		stv_apple.volumeUp();
		stv_apple.volumeDown();
		stv_apple.powerOff();
		
	}
}
