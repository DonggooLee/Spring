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
	public void rinsert(P_Review_VO rboard);		// 후기 등록
	public List<P_Review_VO> getReview(String p_num);	// 후기 리스트 목록	
	public P_Review_VO star(String p_num);			// 평균 별점

	
	public List<P_Pakage_info_VO> getmList(int m_idx);	// 개인 구매 패키지 정보 목록
	
	
	
	
	
	
	public void cinserta(P_Pakage_info_VO board);		// 기업 패키지 정보 등록
	public void cinsertb(P_Pakage_list_VO liboard);		// 기업 패키지 리스트 등록
	public List<P_Pakage_info_VO> getcList(int c_idx);	// 기업 패키지 리스트 목록
	public int cupdatea(P_Pakage_info_VO board);		// 기업 패키지 정보 수정
	public int cupdateb(P_Pakage_list_VO liboard);		// 기업 패키지 리스트 수정
	public int cdeletea(String p_num);					// 기업 패키지 정보 삭제
	public int cdeleteb(String p_num);					// 기업 패키지 리스 삭제
}

