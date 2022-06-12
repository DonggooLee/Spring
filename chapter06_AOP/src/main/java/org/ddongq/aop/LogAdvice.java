package org.ddongq.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component	// 빈으로 사용하기 위해서 붙임. 이것을 인식하기 위해서 root-context.xml 파일에서 컴포넌트 스캔 태그를 추가해주어야 한다.
@Aspect		// 해당 클래스 객체로 Aspect를 구현함을 나타냄
public class LogAdvice {

	/* 
	 * Aspect 실행 시점을 지정할 수 있는 어노테이션
	 * @Before : 어드바이스 타겟 메소드가 호출되기 전에 기능 수행 
	 * @After : 타겟 메소드의 결과에 관계없이(성공, 예외 관계없이)
	 *			타겟 메소드가 완료 되면 어드바이스 기능 수행
	 * @AfterReturning : 타겟 메소드가 성공적으로 결과값을 반환한 후 어드바이스 기능 수행
	 * @AfterThrowing : 타겟 메소드가 수행 중 예외를 던지면 어드바이스 기능 수행
	 * @Around : 어드바이스가 타겟 메소드 호출 전과 후에 어드바이스 기능을 수행
	 */
	
	@Before("execution(* org.ddongq.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("--------------------------");
	}
	
	/*
	 * Advice와 관련된 어노테이션들은 내부적으로 pointcut을 지정한다.
	 * pointcut은 @PointCut으로 지정해서 사용할 수 있다.
	 * @Before 내부의 excution은 Aspectj의 표현식이다.
	 * 맨 앞 *은 접근제한자, 맨 뒤 *는 클래스의 이름과 메소드의 이름과 메소드의 이름을 의미
	 */
	
	
	// doAdd 호출 할 때 받는 매개변수를 이 메소드도 받아서 화면에 출력
	@Before("execution(* org.ddongq.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1 : " + str1);
		log.info("str2 : " + str2);
	}
	
	
	@AfterThrowing(pointcut = "execution(* org.ddongq.service.SampleService*.*(..))", throwing = "exception")
	public void logException(Exception exception) {
		log.info("Exception.....!!!");
		log.info("Exception : " + exception);
	}
	
	
	@Around("execution(* org.ddongq.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pip) {
		log.info("Target" + pip.getTarget());
		log.info("Param:" + Arrays.toString(pip.getArgs()));
		
		long start = System.currentTimeMillis();
		Object result = null;
		try {
			result = pip.proceed();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		log.info("Time : " + (end - start));
		
		return result;
	}
	
}
