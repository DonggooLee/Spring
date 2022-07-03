package org.kg.mapper;

import java.util.List;

import org.kg.domain.P_Pakage_info_VO;
import org.kg.domain.P_Pakage_list_VO;
import org.kg.domain.P_Pakage_reser_VO;
import org.kg.domain.P_Review_VO;

public interface P_PakageMapper {
	public List<P_Pakage_info_VO> getList();		// 전체 리스트 목록
	public List<P_Pakage_info_VO> getListWeu();		// 서유럽 리스트 목록
	public List<P_Pakage_info_VO> getListSai();		// 사이판 리스트 목록
	public List<P_Pakage_info_VO> getListKos();		// 사이판 리스트 목록
	public P_Pakage_info_VO read(String p_num);		// Read
	public void insert(P_Pakage_reser_VO board);	// 예약 등록
	public P_Pakage_list_VO readp(String p_num);	// 예약용 read
	public int update(P_Pakage_list_VO liboard);	// 예약용 update
	public List<P_Pakage_info_VO> search(String region);	// 검색하기
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
	public List<P_Review_VO> getReview(String p_num);	// 후기 리스트 목록	
	public P_Review_VO star(String p_num);			// 평균 별점
	public int wishinsert(String p_num, int m_idx);		// 위시리스트 추가		
	
	
	
	
	public List<P_Pakage_info_VO> getmList(int m_idx);	// 개인 구매 패키지 정보 목록
	public P_Pakage_reser_VO mread(String p_rnum);	// 개인 예약 read
	public int mdeletea(String p_rnum);					// 개인 예약취소 delete
	public int mupdatea(P_Pakage_list_VO liboard);		// 개인 예약취소 update
	public void rinsert(P_Review_VO rboard);		// 후기 등록
	public List<P_Review_VO> allreview();			// 전체 후기 리스트 목록
	
	
	public void cinserta(P_Pakage_info_VO board);		// 기업 패키지 정보 등록
	public void cinsertb(P_Pakage_list_VO liboard);		// 기업 패키지 리스트 등록
	public List<P_Pakage_info_VO> getcList(int c_idx);	// 기업 패키지 리스트 목록
	public int cupdatea(P_Pakage_info_VO board);		// 기업 패키지 정보 수정
	public int cupdateb(P_Pakage_list_VO liboard);		// 기업 패키지 리스트 수정
	public int cdeletea(String p_num);					// 기업 패키지 정보 삭제
	public int cdeleteb(String p_num);					// 기업 패키지 리스 삭제
}

