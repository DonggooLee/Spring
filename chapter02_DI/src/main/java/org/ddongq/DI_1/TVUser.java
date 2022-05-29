package org.ddongq.DI_1;

public class TVUser {
	public static void main(String[] args) {
		
		LgTV test1 = new LgTV();
		test1.powerOn();
		test1.volumeUp();
		test1.volumeDown();
		test1.powerOff();
		
		System.out.println("-------------------");
		
		SamsungTV test2 = new SamsungTV();
		test2.powerOn();
		test2.volumeUp();
		test2.volumeDown();
		test2.powerOff();
		
	}
}
