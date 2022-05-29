package org.ddongq.DI_5_constructor;

public class SamsungTV implements TV {
	// SamsungTV 의 볼륨 조절 기능은 SonySpeaker를 이용한다.
	private SonySpeaker sonySpeaker;
	
	public SamsungTV() {
		System.out.println("--> SamsungTV 객체(1) 생성");
	}
	public SamsungTV(SonySpeaker speaker) {
		System.out.println("--> SamsungTV 객체(2) 생성");
		// 이렇게 할 경우 볼륨 업다운시 객체 생성이 필요 없어 진다.
		sonySpeaker = speaker;
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
		sonySpeaker.volumUp();
	}
	@Override
	public void volumeDown() {
		sonySpeaker.volumDown();
	}
}
