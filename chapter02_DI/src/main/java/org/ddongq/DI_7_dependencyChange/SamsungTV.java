package org.ddongq.DI_7_dependencyChange;

public class SamsungTV implements TV {
	// 다형성 때문에 업캐스팅 돼서 한번에 사용할 수 있다.
	private Speaker speaker;
	
	public SamsungTV() {
		System.out.println("--> SamsungTV 객체(1) 생성");
	}
	public SamsungTV(Speaker speaker) {
		System.out.println("--> SamsungTV 객체(2) 생성");
		this.speaker = speaker;
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
		speaker.volumUp();
	}
	@Override
	public void volumeDown() {
		speaker.volumDown();
	}
}
