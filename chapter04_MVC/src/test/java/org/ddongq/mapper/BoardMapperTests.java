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
	
	// 전체 데이터 조회
	/*
	@Test
	public void testGetList() {
		List<BoardVO> list = mapper.getList();
		for(BoardVO vo : list) {
			log.info("내가 출력한 결과물 : " + vo);
		}
	}
	*/


	// 한 개 데이터 조회
	/*
	@Test
	public void getRead() {
		BoardVO vo = mapper.read(3);
		log.info("내가 출력한 결과물 : " + vo);
	}
	*/
	
	
	// 데이터 삽입
	/*
	@Test
	public void testInsert() {
		BoardVO vo = new BoardVO();
		vo.setTitle("06-01 테스트 제목");
		vo.setContent("06-01 테스트 내용");
		vo.setWriter("06-01 테스트 작가");
		mapper.insert(vo);
		log.info("내가 출력한 결과물 : " + vo);
	}
	*/
	
	
	// 데이터 삭제
	/*
	@Test
	public void getDelete() {
		int result = mapper.delete(32);
		log.info("내가 출력한 결과물 : " + result);
	}
	*/

	
	// 데이터 수정
	@Test
	public void getUpdate() {
		BoardVO vo = new BoardVO();
		vo.setBno(27);
		vo.setTitle("06-01 제목 수정");
		vo.setContent("06-01 내용 수정");
		vo.setWriter("06-01 작성자 수정");
		int result = mapper.update(vo);
		log.info("내가 출력한 결과물 : " + result);
	}
	
}
