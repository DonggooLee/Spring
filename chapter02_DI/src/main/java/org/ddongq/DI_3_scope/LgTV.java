package org.ddongq.DI_3_scope;

public class LgTV implements TV{
	@Override
	public void powerOn() {
		System.out.println("--> LgTV 전원 ON");
	}

	@Override
	public void powerOff() {
		System.out.println("--> LgTV 전원 OFF");
	}

	@Override
	public void volumeUp() {
		System.out.println("--> LgTV 소리 올린다");
	}

	@Override
	public void volumeDown() {
		System.out.println("--> LgTV 소리 내린다");
	}
}
