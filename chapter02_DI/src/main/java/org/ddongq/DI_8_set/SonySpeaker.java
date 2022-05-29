package org.ddongq.DI_8_set;

public class SonySpeaker implements Speaker{
	public SonySpeaker() {
		System.out.println("--> SonySpeaker 객체 생성");
	}
	@Override
	public void volumUp() {
		System.out.println("--> SonySpeaker 소리 올린다");
	}
	@Override
	public void volumDown() {
		System.out.println("--> SonySpeaker 소리 내린다");
	}
}
