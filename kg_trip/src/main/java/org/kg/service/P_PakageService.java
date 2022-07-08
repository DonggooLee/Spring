package org.kg.service;

import java.util.List;

import org.kg.domain.P_Pakage_info_VO;
import org.kg.domain.P_Pakage_list_VO;
import org.kg.domain.P_Pakage_reser_VO;
import org.kg.domain.P_Review_VO;


public interface P_PakageService {
	public List<P_Pakage_info_VO> getList();		// 전체 리스트 목록
	public List<P_Pakage_info_VO> getListWeu();		// 서유럽 리스트 목록
	public List<P_Pakage_info_VO> getListSai();		// 사이판 리스트 목록
	public List<P_Pakage_info_VO> getListKos();		// 국내섬 리스트 목록
	public P_Pakage_info_VO get(String p_num);		// Read
	public void register(P_Pakage_reser_VO board);	// 예약
	public P_Pakage_list_VO getp(String p_num);		// 예약용 Read	
	public void update(P_Pakage_list_VO liboard); 	// 예약용 update
	public List<P_Pakage_info_VO> search(String region);	// 검색
	public List<P_Pakage_info_VO> linka();			// 가격낮은순
	public List<P_Pakage_info_VO> linkb();			// 가격높은순
	public List<P_Pakage_info_VO> linkc();			// 날짜빠른순
	public List<P_Pakage_info_VO> linkd();			// 날짜느린순
	public List<P_Pakage_info_VO> linke();			// 후기많은순
	public List<P_Pakage_info_VO> linkf();			// 별점높은순
	public List<P_Pakage_info_VO> slinka();			// 유럽검색
	public List<P_Pakage_info_VO> slinkb();			// 동남아일본검색
	public List<P_Pakage_info_VO> slinkc();			// 하와이검색
	public List<P_Pakage_info_VO> slinkd();			// 괌사이판검색
	public List<P_Pakage_info_VO> slinke();			// 국내여행검색
	public List<P_Review_VO> getReview(String p_num);			// 후기 리스트 목록
	public P_Review_VO star(String p_num);			// 평균 별점
	public int wishinsert(P_Pakage_info_VO board);		// 위시리스트 추가
	public int wishdelete(P_Pakage_info_VO board);		// 위시리스트 삭제
	public P_Pakage_info_VO getheart(P_Pakage_info_VO vo);	// 위시리스트  조회
	public List<P_Pakage_info_VO> getheartMain(int m_idx);		// 위시리스트 메인 조회
	
	
	
	public List<P_Pakage_info_VO> getmList(int m_idx);	// 개인 구매 페이지 리스트 목록
	public P_Pakage_reser_VO mread(String p_rnum);	// 개인 예약 read  
	public boolean mdeletea(String p_rnum);				// 개인 예약취소
	public int mupdatea(P_Pakage_list_VO liboard);		// 개인 예약취소 update
	public void rregister(P_Review_VO rboard);		// 후기 등록
	public List<P_Review_VO> allreview();			// 전체 후기 리스트 목록
	public List<P_Pakage_info_VO> getwishlist(int m_idx);		// 개인  위시리스트 조회
	
	
	
	public void cinserta(P_Pakage_info_VO board);		// 기업 패키지 정보 등록
	public void cinsertb(P_Pakage_list_VO liboard);		// 기업 패키지 리스트 등록
	public List<P_Pakage_info_VO> getcList(int c_idx);	// 기업 페이지 리스트 목록
	public boolean cupdatea(P_Pakage_info_VO board);	// 기업 패키지 정보 수정
	public boolean cupdateb(P_Pakage_list_VO liboard);	// 기업 패키지 리스트 수정
	public boolean cdeletea(String p_num);				// 기업 패키지 정보 삭제
	public boolean cdeleteb(String p_num);				// 기업 패키지 리스트 삭제
	
}
 