package org.ddongq.DI_4;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class TVUser {
	public static void main(String[] args) {
		
		/* 
		 * 문제점
		 * 1. SonySpeaker 객체가 쓸데 없이 두 개 생성
		 * 2. SonySpeaker를  AppleSpeaker 같은 다른 Speaker로 변경하고자 할 때
		 * volumUp, volumDown 두 개의 메소드를 모두 수정해야 한다.
		 * 이러한 이유는 의존 관계에 있는 Speaker 객체에 대한 객체 생성 코드를 직접 SamsungTV 소스에 명시했기 때문
		 * 
		 * 이 문제를 의존성 주입(Dependency Injection)을 이용한다
		 */
		
		// 1. String 컨테이너 구동
		AbstractApplicationContext ctx = 
				new GenericXmlApplicationContext("applicationContext4.xml");
		
		// 2. Spring 컨테이너로부터 필요한 객체 요청
		TV stv = (SamsungTV)ctx.getBean("stv");
		stv.powerOn();
		stv.volumeUp();
		stv.volumeDown();
		stv.powerOff();
		
	}
}
