package org.ddongq.DI_9_collection;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class CollectionBeanClient {
	public static void main(String[] args) {
		
		// 1. String 컨테이너 구동
		AbstractApplicationContext ctx = 
				new GenericXmlApplicationContext("applicationContext9.xml");
		
		CollectionBean bean1 = ctx.getBean("cBean1", CollectionBean.class);
		List<String> list = bean1.getAddressList();
		for(String address : list) {
			System.out.println(address);
		}

		System.out.println("----------------------------------");
		
		CollectionBean bean2 = ctx.getBean("cBean2", CollectionBean.class);
		Set<String> set = bean2.getAddressSet();
		Iterator<String> itr = set.iterator();
		while(itr.hasNext()) {
			System.out.println(itr.next());
		}
		
		System.out.println("----------------------------------");
		
		CollectionBean bean3 = ctx.getBean("cBean3", CollectionBean.class);
		Map<String, String> map = bean3.getAddressMap();
		Set<String> keySet = map.keySet();
		Iterator<String> itr_ = keySet.iterator();
		while(itr_.hasNext()) {
			String key = itr_.next();
			String value = map.get(key);
			System.out.println("이름 : " + key + ", 주소 : " + value);
		}
		
	}
}
