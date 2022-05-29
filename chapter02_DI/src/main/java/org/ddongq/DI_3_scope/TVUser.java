package org.ddongq.DI_3_scope;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class TVUser {
	public static void main(String[] args) {
		
		// 1. String 컨테이너 구동
		AbstractApplicationContext ctx = 
				new GenericXmlApplicationContext("applicationContext3.xml");
		
		// 2. Spring 컨테이너로부터 필요한 객체 요청
		TV ltv = (LgTV)ctx.getBean("ltv"); // 형변환을(TV)로 하지 않는 이유는 인터페이스 이기 때문에 객체 생성 X
		TV ltv2 = (LgTV)ctx.getBean("ltv"); // applicationContext3.xml의 bean을 id 값으로 가져옴
		ltv.powerOn();
		ltv.volumeUp();
		ltv.volumeDown();
		ltv.powerOff();
		
		System.out.println("-------------------");
		
		TV stv = (SamsungTV)ctx.getBean("stv");
		TV stv2 = (SamsungTV)ctx.getBean("stv");
		stv.powerOn();
		stv.volumeUp();
		stv.volumeDown();
		stv.powerOff();
		
		// prototype 은 다른 객체로 인식
		System.out.println(ltv==ltv2 ? "같은 객체" : "다른 객체");
		// singleton 은 같은 객체로 인식
		System.out.println(stv==stv2 ? "같은 객체" : "다른 객체");
		
	}
}
