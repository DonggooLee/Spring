package org.ddongq.DI_6_multiFields;

public class SamsungTV implements TV {
	private SonySpeaker sonySpeaker;
	private int price;
	
	public SamsungTV() {
		System.out.println("--> SamsungTV 객체(1) 생성");
	}
	public SamsungTV(SonySpeaker speaker) {
		System.out.println("--> SamsungTV 객체(2) 생성");
		sonySpeaker = speaker;
	}
	public SamsungTV(SonySpeaker speaker, int price) {
		System.out.println("--> SamsungTV 객체(3) 생성");
		sonySpeaker = speaker;
		this.price = price;
	}
	@Override
	public void powerOn() {
		System.out.println("--> SamsungTV 전원 ON (가격 : " + price + " 원)");
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
