package org.ddongq.DI_1;

public class SamsungTV {
	public SamsungTV() {
		System.out.println("--> SamsungTV 객체 생성");	}
	public void powerOn() {
		System.out.println("--> SamsungTV 전원 ON");
	}
	public void powerOff() {
		System.out.println("--> SamsungTV 전원 OFF");
	}
	public void volumeUp() {
		System.out.println("--> SamsungTV 소리 올린다");
	}	
	public void volumeDown() {
		System.out.println("--> SamsungTV 소리 내린다");
	}
}
