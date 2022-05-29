package org.ddongq.DI_4;

public class SonySpeaker {
	public SonySpeaker() {
		System.out.println("---> SonySpeaker 객체 생성");
	}
	public void volumUp() {
		System.out.println("---> SonySpeaker 소리 올린다");
	}
	public void volumDown() {
		System.out.println("---> SonySpeaker 소리 내린다");
	}
}
