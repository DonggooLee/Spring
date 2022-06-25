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
	public void rregister(P_Review_VO rboard);		// 후기 등록
	public List<P_Review_VO> getReview(String p_num);			// 후기 리스트 목록
	public P_Review_VO star(String p_num);			// 평균 별점
	
	public List<P_Pakage_info_VO> getmList(int m_idx);	// 개인 구매 페이지 리스트 목록
	
	public void cinserta(P_Pakage_info_VO board);		// 기업 패키지 정보 등록
	public void cinsertb(P_Pakage_list_VO liboard);		// 기업 패키지 리스트 등록
	public List<P_Pakage_info_VO> getcList(int c_idx);	// 기업 페이지 리스트 목록
	public boolean cupdatea(P_Pakage_info_VO board);	// 기업 패키지 정보 수정
	public boolean cupdateb(P_Pakage_list_VO liboard);	// 기업 패키지 리스트 수정
	public boolean cdeletea(String p_num);				// 기업 패키지 정보 삭제
	public boolean cdeleteb(String p_num);				// 기업 패키지 리스트 삭제
	
}
