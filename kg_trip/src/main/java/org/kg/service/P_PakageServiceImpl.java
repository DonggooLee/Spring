package org.kg.service;

import java.util.List;

import org.kg.domain.P_Pakage_info_VO;
import org.kg.domain.P_Pakage_list_VO;
import org.kg.domain.P_Pakage_reser_VO;
import org.kg.domain.P_Review_VO;
import org.kg.mapper.P_PakageMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class P_PakageServiceImpl implements P_PakageService {

	@Setter(onMethod_= @Autowired)
	private P_PakageMapper mapper;
	
	public P_PakageServiceImpl() {}

	// 전체 리스트 목록
	@Override
	public List<P_Pakage_info_VO> getList() {
		return mapper.getList();
	}

	// 서유럽 리스트 목록
	@Override
	public List<P_Pakage_info_VO> getListWeu() {
		return mapper.getListWeu();
	}
	
	// 사이판 리스트 목록
	@Override
	public List<P_Pakage_info_VO> getListSai() {
		return mapper.getListSai();
	}
	
	// 국내섬 리스트 목록
	@Override
	public List<P_Pakage_info_VO> getListKos() {
		return mapper.getListKos();
	}
	

	// read
	@Override
	public P_Pakage_info_VO get(String p_num) {
		return mapper.read(p_num);
	}

	// 예약
	@Override
	public void register(P_Pakage_reser_VO board) {
		mapper.insert(board);
	}

	// 예약용 read
	@Override
	public P_Pakage_list_VO getp(String p_num) {
		return mapper.readp(p_num);
	}

	// 예약용 update
	@Override
	public void update(P_Pakage_list_VO liboard) {
		mapper.update(liboard);
	}

	// 검색
	@Override
	public List<P_Pakage_info_VO> search(String region) {
		return mapper.search(region);
	}
	
	// 가격낮은순
	@Override
	public List<P_Pakage_info_VO> linka() {
		return mapper.linka();
	}
	
	// 가격높은순
	@Override
	public List<P_Pakage_info_VO> linkb() {
		return mapper.linkb();
	}

	// 날짜빠른순
	@Override
	public List<P_Pakage_info_VO> linkc() {
		return mapper.linkc();
	}

	// 날짜느린순
	@Override
	public List<P_Pakage_info_VO> linkd() {
		return mapper.linkd();
	}

	// 후기많은순
	@Override
	public List<P_Pakage_info_VO> linke() {
		return mapper.linke();
	}
	
	// 별점높은순
	@Override
	public List<P_Pakage_info_VO> linkf() {
		return mapper.linkf();
	}
	
	// 유럽검색
	@Override
	public List<P_Pakage_info_VO> slinka() {
		return mapper.slinka();
	}

	// 동남아일본검색
	@Override
	public List<P_Pakage_info_VO> slinkb() {
		return mapper.slinkb();
	}

	// 하와이검색
	@Override
	public List<P_Pakage_info_VO> slinkc() {
		return mapper.slinkc();
	}

	// 괌사이판검색
	@Override
	public List<P_Pakage_info_VO> slinkd() {
		return mapper.slinkd();
	}

	// 국내여행검색
	@Override
	public List<P_Pakage_info_VO> slinke() {
		return mapper.slinke();
	}


	// 후기 리스트 목록
	@Override
	public List<P_Review_VO> getReview(String p_num) {
		return mapper.getReview(p_num);
	}

	// 별점
	@Override
	public P_Review_VO star(String p_num) {
		return mapper.star(p_num);
	}
	
	// 위시리스트 추가
	@Override
	public int wishinsert(P_Pakage_info_VO board) {
		return mapper.wishinsert(board);
	}
	
	// 위시리스트 삭제
	@Override
	public int wishdelete(P_Pakage_info_VO board) {
		return mapper.wishdelete(board);
	}

	
	// 위시리스트 조회
	@Override
	public P_Pakage_info_VO getheart(P_Pakage_info_VO vo) {
		return mapper.getheart(vo);
	}
	
	// 위시리스트 메인 조회
	@Override
	public List<P_Pakage_info_VO> getheartMain(int m_idx) {
		return mapper.getheartMain(m_idx);
	}
	
	////////////////////////////////////////////////////////
	
	
	// 개인 구매 패키지 리스트 목록
	@Override
	public List<P_Pakage_info_VO> getmList(int m_idx) {
		return mapper.getmList(m_idx);
	}
	
	// 개인 예약 read
	@Override
	public P_Pakage_reser_VO mread(String p_rnum) {
		return mapper.mread(p_rnum);
	}
	
	// 개인 예약 취소
	@Override
	public boolean mdeletea(String p_rnum) {
		int result = mapper.mdeletea(p_rnum);
		
		if(result == 1){
			return true;
		}else {
			return false;
		}
	}
	
	// 개인 예약 취소 update
	@Override
	public int mupdatea(P_Pakage_list_VO liboard) {
		return mapper.mupdatea(liboard);
	}
	
	// 후기 등록
	@Override
	public void rregister(P_Review_VO rboard) {
		mapper.rinsert(rboard);
	}
	
	// 전체 후기 리스트 목록
	@Override
	public List<P_Review_VO> allreview() {
		return mapper.allreview();
	}
	
	// 위시리스트 개인 조회
	@Override
	public List<P_Pakage_info_VO> getwishlist(int m_idx) {
		return mapper.getwishlist(m_idx);
	}

	
	////////////////////////////////////////////////////////
	
	
	// 기업 패키지 정보 등록 
	@Override
	public void cinserta(P_Pakage_info_VO board) {
		mapper.cinserta(board);
	}

	// 기업 패키지 리스트 등록
	@Override
	public void cinsertb(P_Pakage_list_VO liboard) {
		mapper.cinsertb(liboard);
	}

	// 기업 패키지 리스트 목록
	@Override
	public List<P_Pakage_info_VO> getcList(int c_idx) {
		return mapper.getcList(c_idx);
	}

	// 기업 패키지 정보 수정
	@Override
	public boolean cupdatea(P_Pakage_info_VO board) {

		int result = mapper.cupdatea(board);
		
		if(result == 1){
			return true;
		}else {
			return false;
		}
	}
	
	// 기업 패키지 리스트 수정
	@Override
	public boolean cupdateb(P_Pakage_list_VO liboard) {
		
		int result = mapper.cupdateb(liboard);
		
		if(result == 1){
			return true;
		}else {
			return false;
		}
	}

	// 기업 패키지 리스트 삭제
	@Override
	public boolean cdeletea(String p_num) {
		
		int result = mapper.cdeletea(p_num);
		
		if(result == 1){
			return true;
		}else {
			return false;
		}
	}
	
	// 기업 패키지 리스트 삭제
	@Override
	public boolean cdeleteb(String p_num) {
		int result = mapper.cdeleteb(p_num);
		
		if(result == 1){
			return true;
		}else {
			return false;
		}
	}









	
}
