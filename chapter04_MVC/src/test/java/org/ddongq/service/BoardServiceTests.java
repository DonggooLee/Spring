package org.ddongq.service;

import java.util.List;

import org.ddongq.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//DB 연결정보를 root-context.xml 에서 가져온다. service 연결해주는  package 경로도 설정되어 있다.
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)	// 전체 가져오기
	private BoardService service;	// 인터페이스 이기 때문에 어차피  new 할 수 없다
	
	
	// 전체 데이터 조회
	/*
	@Test
	public void testGetList() {
		// 아래 코드가 정석이지만 굳이 반복문 돌면서 실행하지 않아도 출력이 가능!
		// log4jdbc 파일이 있기 때문...
		List<BoardVO> list = service.getList();
		for(BoardVO vo : list) {
			log.info("내가 출력한 결과물 : " + vo);
		}
	}
	*/
	
	
	// 데이터 한 개 조회
	/*
	@Test
	public void getRead() {
		BoardVO vo = service.get(3);
		log.info("내가 출력한 결과물 : " + vo);
	}
	*/
	
	
	// 데이터 삽입
	/*
	@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("06-01 서비스 테스트 제목");
		vo.setContent("06-01 서비스 테스트 내용");
		vo.setWriter("06-01 서비스 테스트 작가");
		service.register(vo);
		log.info("내가 출력한 결과물 : " + vo);
	}
	*/

	
	// 데이터 삭제
	/*
	@Test
	public void getRemove() {
		boolean test = service.remove(30);
		log.info("내가 출력한 결과물 : " + test);
	}
	*/
	
	
	// 데이터 수정
	/*
	@Test
	public void getModify() {
		BoardVO vo = new BoardVO();
		vo.setBno(28);
		vo.setTitle("**제목바꿈**");
		vo.setContent("**내용바꿈**");
		vo.setWriter("**작성자바꿈**");
		boolean test = service.modify(vo);
		log.info("내가 출력한 결과물 : " + test);
	}
	*/
	
	
}
