package org.ddongq.DI_2;

public class TVUser {
	public static void main(String[] args) {
		
		// 상속받았기 때문에 업캐스팅 가능하다
		TV lg = new LgTV();
		lg.powerOn();
		lg.volumeUp();
		lg.volumeDown();
		lg.powerOff();
		
		System.out.println("-------------------");
		
		TV sm = new SamsungTV();
		sm.powerOn();
		sm.volumeUp();
		sm.volumeDown();
		sm.powerOff();
		
	}
}
