package org.ddongq.DI_12_component;

import org.springframework.stereotype.Component;

	/*
	 * java -> @Component
	 * xml -> <bean class="org.ddongq.DI_12_component.LgTV">
	 * 
	 * java -> @Component("tv")
	 * xml -> <bean id="tv" class="org.ddongq.DI_12_component.LgTV">
	 * 
	 * @Component와 @Configuration/@Bean은 기능이 비슷
	 * @Component는 클래스 단위
	 * @Bean은 메소드 단위
	 */

@Component("tv")
public class LgTV implements TV {

	public LgTV() {
		System.out.println("LgTV 객체 생성");
	}
	
	@Override
	public void powerOn() {
		System.out.println("LgTV -- 전원 킨다");
	}

	@Override
	public void powerOff() {
		System.out.println("LgTV -- 전원 끈다");
	}

	@Override
	public void volumeUp() {
		System.out.println("LgTV -- 소리 올린다");
	}

	@Override
	public void volumeDown() {
		System.out.println("LgTV -- 소리  내린다");
	}
	
}
