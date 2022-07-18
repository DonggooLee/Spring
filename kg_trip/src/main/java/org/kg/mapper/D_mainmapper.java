package org.kg.mapper;

import java.util.List;


import org.kg.domain.D_BoardVO;
import org.kg.domain.D_ImageVO;
import org.kg.domain.D_likeDTO;
import org.kg.domain.D_likeNumDTO;
import org.kg.domain.D_likelistwhoDTO;
import org.kg.domain.D_likewhotfVO;

public interface D_mainmapper {
	
	
	public int insertContent(D_BoardVO vo);
	public List<D_BoardVO> contentlist();
	public int insertImg(D_ImageVO vo);
	public List<D_ImageVO> imageData();
	public D_BoardVO selectCard(int bno);
	public int likeInsert(D_likeDTO dto);
	public D_likeDTO selectlike(int bno);
	public int selectlikeNum(int bno);
	public List<D_likeNumDTO>likeNum();
	public List<D_likewhotfVO>likewhotf();
	public List<D_likelistwhoDTO>alllikewho(int bno);

	public void likedelete(D_likewhotfVO vo);
	
}
