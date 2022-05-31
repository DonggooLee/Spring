package org.ddongq.mapper;

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
//DB 연결정보를 root-context.xml 에서 가져온다. mapper 연결해주는  package 경로도 설정되어 있다.
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired) // 전체 가져오기
	private BoardMapper mapper;		// 인터페이스 이기 때문에 어차피 new 할 수 없다
	
	
	@Test
	public void testGetList() {
		List<BoardVO> list = mapper.getList();
		for(BoardVO vo : list) {
			log.info(vo);
		}
	}
	
	// 데이터 삽입
	/*
	@Test
	public void testInsert() {
		
		BoardVO vo = new BoardVO();
		
		vo.setTitle("새로 작성하는 제목");
		vo.setContent("새로 작성하는 내용");
		vo.setWriter("새 작성자");
		mapper.insert(vo);
		log.info(vo);
		
	}
	*/
	
	
	// 한 개 데이터 조회
	/*
	@Test
	public void getRead() {
		BoardVO vo = mapper.read(3);
		//System.out.println(vo);
		log.info(vo);
	}
	*/
	
	
	// 데이터 삭제
	/*
	@Test
	public void getDelete() {
		int result = mapper.delete(5);
		log.info(result);
	}
	*/
	
	
	// 데이터 수정
	/*
	@Test
	public void getUpdate() {
		
		BoardVO vo = new BoardVO();
		vo.setBno(2);
		vo.setTitle("제목바꿈");
		vo.setContent("내용바꿈");
		
		int result = mapper.update(vo);
		
		log.info(result);
		
	}
	*/
	
}
