package org.ddongq.DI_4;

public class SamsungTV implements TV {
	// SamsungTV 의 볼륨 조절 기능은 SonySpeaker를 이용한다.
	private SonySpeaker sonySpeaker;
	
	public SamsungTV() {
		System.out.println("--> SamsungTV 객체 생성");
	}
	@Override
	public void powerOn() {
		System.out.println("--> SamsungTV 전원 ON");
	}
	@Override
	public void powerOff() {
		System.out.println("--> SamsungTV 전원 OFF");
	}
	@Override
	public void volumeUp() {
		sonySpeaker = new SonySpeaker();
		sonySpeaker.volumUp();
	}
	@Override
	public void volumeDown() {
		sonySpeaker = new SonySpeaker();
		sonySpeaker.volumDown();
	}
}
