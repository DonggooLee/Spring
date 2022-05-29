package org.ddongq.DI_6_multiFields;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class TVUser {
	public static void main(String[] args) {
		
		// 1. String 컨테이너 구동
		AbstractApplicationContext ctx = 
				new GenericXmlApplicationContext("applicationContext6.xml");
		
		// 2. Spring 컨테이너로부터 필요한 객체 요청
		TV stv = (SamsungTV)ctx.getBean("stv");
		stv.powerOn();
		stv.volumeUp();
		stv.volumeDown();
		stv.powerOff();
		
	}
}
