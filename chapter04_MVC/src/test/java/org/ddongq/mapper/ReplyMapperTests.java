package org.ddongq.mapper;

import java.util.List;

import org.ddongq.domain.Criteria;
import org.ddongq.domain.ReplyVO;
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
public class ReplyMapperTests {
		
		@Setter(onMethod_ = @Autowired)
		private ReplyMapper mapper;
		
		// 댓글 삽입
		/*
		@Test
		public void testInsert() {
			ReplyVO vo = new ReplyVO();
			vo.setBno(94);
			vo.setReply("하이 테스트임3");
			vo.setReplyer("테스트 작성자3");
			mapper.insert(vo);
			log.info("내가 출력한 결과물 : " + vo);
		}
		*/
		
		
		// 댓글 전체 출력
		/*
		@Test
		public void testGetList() {
			Criteria cri = new Criteria();
			List<ReplyVO> list = mapper.getListWithPaging(cri, 94);
			log.info("내가 출력한 결과물 : " + list);
		}
		*/
		
		
		// 댓글 조회
		/*
		@Test
		public void read() {
			ReplyVO vo = mapper.read(94);
			log.info("내가 출력한 결과물 : " + vo);
		}
		*/
		
		
		// 댓글 삭제
		/*
		@Test
		public void delete() {
			int result = mapper.delete(2);
			log.info("내가 출력한 결과물 : " + result);
		}
		*/
		
		
		// 댓글 수정
		/*
		@Test
		public void getUpdate() {
			ReplyVO vo = new ReplyVO();
			vo.setRno(3);
			vo.setReply("**수정한 댓글 내용**");
			vo.setReplyer("**수정한 댓글 작성자**");
			int result = mapper.update(vo);
			log.info("내가 출력한 결과물 : " + result);
		}
		*/
		
}
