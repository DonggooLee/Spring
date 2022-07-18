package org.kg.service;

import java.util.List;

import org.kg.domain.B_CorpMemberVO;
import org.kg.domain.D_BoardInfo;
import org.kg.domain.D_BoardVO;
import org.kg.domain.D_ImageVO;
import org.kg.domain.D_likeDTO;
import org.kg.domain.D_likeNumDTO;
import org.kg.domain.D_likelistwhoDTO;
import org.kg.domain.D_likewhotfVO;
import org.kg.mapper.B_CorpMemberMapper;
import org.kg.mapper.D_mainmapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class D_boardServiceImpl implements D_boardService {
	
	@Setter(onMethod_ = @Autowired)
	private D_mainmapper mapper;
	
	@Override
	public int insertContent(D_BoardVO vo) {
		log.info("※※※※※※※※joining※※※※※※※※");
		return mapper.insertContent(vo);
	}

	@Override
	public List<D_BoardVO>contentlist(){
		log.info("add list");
		return mapper.contentlist();
	}
	
	@Override
	public int insertImg(D_ImageVO vo) {
		log.info("image insert......");
		return mapper.insertImg(vo);
	}

	@Override
	public List<D_ImageVO> imageData() {
		log.info("image load");
		return mapper.imageData();
	}

	@Override
	public D_BoardVO selectCard(int bno) {
		log.info("select");
		return mapper.selectCard(bno);
	}

	@Override
	public int likeInsert(D_likeDTO dto) {
		log.info("insert like");
		return mapper.likeInsert(dto);
	}

	@Override
	public D_likeDTO selectlike(int bno) {
		log.info("likereading");
		return mapper.selectlike(bno);
	}

	@Override
	public int selectlikeNum(int bno) {
		log.info("갯수검색완료");
		return mapper.selectlikeNum(bno);
	}

	@Override
	public List<D_likeNumDTO> likeNum() {
		// TODO Auto-generated method stub
		return mapper.likeNum();
	}

	@Override
	public List<D_likewhotfVO> likewhotf() {
		// TODO Auto-generated method stub
		return mapper.likewhotf();
	}

	@Override
	public int likedelete(D_likewhotfVO vo) {
		mapper.likedelete(vo);
		return 0;
	}

	@Override
	public List<D_likelistwhoDTO> alllikewho(int bno) {
		// TODO Auto-generated method stub
		return mapper.alllikewho(bno);
	} 
	
	
	
}
