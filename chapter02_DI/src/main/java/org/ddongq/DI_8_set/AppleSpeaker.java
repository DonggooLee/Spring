package org.ddongq.DI_8_set;

public class AppleSpeaker implements Speaker {
	public AppleSpeaker() {
		System.out.println("--> AppleSpeaker 객체 생성");
	}
	@Override
	public void volumUp() {
		System.out.println("--> AppleSpeaker 소리 올린다");
	}
	@Override
	public void volumDown() {
		System.out.println("--> AppleSpeaker 소리 내린다");
	}
}
