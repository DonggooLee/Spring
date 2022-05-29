package org.ddongq.DI_8_set;

public class SamsungTV implements TV {
	private Speaker speaker;
	private int price;
	
	public SamsungTV() {
		System.out.println("--> SamsungTV 객체(1) 생성");
	}
	public void setSpeaker(Speaker speaker) {
		System.out.println("--> setSpeaker() 호출");
		this.speaker = speaker;
	}
	public void setPrice(int price) {
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
		speaker.volumUp();
	}
	@Override
	public void volumeDown() {
		speaker.volumDown();
	}
}
