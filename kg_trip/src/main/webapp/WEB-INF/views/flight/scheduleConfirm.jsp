<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
	
	<section class="cont">
	
		<h1>여정 정보</h1><br>
		<div class="scheduleInfo" style="border: 1px solid black; width: 680px; height: 55px; padding: 10px;">
			<table>
				<tr>
					<th>비행일자</th>
					<th>항공편명</th>
					<th>출발공항</th>
					<th>도착공항</th>
					<th>좌석등급</th>
					<th>예매가격</th>
					<th>탑승시각</th>
					<th>출발시간</th>
	 				<th>도착시간</th>
				</tr>
				<tr>
					<td><fmt:formatDate value="${getSchedule.start_date }" pattern="yyyy-MM-dd"/></td>
					<td>${getSchedule.flight_name }</td>
					<td>${getSchedule.ap_name_d }</td>
					<td>${getSchedule.ap_name_a }</td>
					<td>${seat_grade }</td>
					<td id="ticketPrice"></td>
					<td>${getSchedule.boarding_time }</td>
					<td>${getSchedule.depart_time }</td>
					<td>${getSchedule.arrive_time }</td>
				</tr>
			</table>
		</div>
		
		<br><hr><br>
		
		<h1>승객 정보</h1><br>
		<div class="memberInfo" style="border: 1px solid black; padding: 10px; width: 270px;">
			<table>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="m_name" value="${loginPublicInfo.m_name}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<input type="text" name="m_gender" value="${loginPublicInfo.m_gender}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" name="m_email" value="${loginPublicInfo.m_email}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input type="text" name="m_phone" value="${loginPublicInfo.m_phone}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="m_birth" value="${loginPublicInfo.m_birth}" readonly="readonly">
					</td>
				</tr>			
			</table>
		</div>
		
		<br><hr><br>
		
		<h1>좌석 배정</h1><br>
		<div class="choiceSeat"></div>
		
		<br><hr><br>
		
		<h1>확인 및 동의</h1><br>
		<div style="border: 1px solid black; border-bottom: 0px; padding: 10px; width: 680px;">
			<input type="checkbox" id="ck1"><b>&nbsp;&nbsp;[필수] 운송약관, 운임 규정, 수하물 규정을 확인하였으며 이에 동의합니다.</b> <button style="border-radius: 15px; background-color: white; padding: 3px; border-width: thin;" id="view1">보기</button><br>
			<div style="padding: 20px">
				대한항공 항공권을 구매하시는 것은 본 항공사와 운송계약 체결에 동의하는 것으로 운임규정은 항공권 변경, 취소 등에 따른 수수료와 사전좌석배정, 좌석승급 등 구매하는 항공권 운임에 적용되는 세부 조건을 기재하고 있으며, 운송 약관은 운송 계약 체결에 따른 계약조건을 명시합니다.
				대한항공은 '항공교통이용자 보호기준'에 따라 항공교통이용자 서비스 계획 새 창 열림을 게시합니다.
			</div>
		</div>
		<div style="border: 1px solid black; padding: 10px; width: 680px;">
			<input type="checkbox" id="ck2"><b>&nbsp;&nbsp;[필수] 위험품 안내를 확인하였습니다.</b> <button style="border-radius: 15px; background-color: white; padding: 3px; border-width: thin;" id="view2">보기</button><br>
			<div style="padding: 20px">
				고객 안전을 위하여 항공기 내부로 반입이 금지된 폭발성, 인화성, 유독성 물질 및 무기로 사용될 수 있는 품목에 대한 안내 사항 입니다.
			</div>
		</div>
		
		<!-- modal_1 -->
		<div class="modal_1">
			<div class="modal_content">
				<h1>운임 규정 상세 보기</h1>
				<br><br>
				<div style="overflow:auto; width: 850px; height: 850px; text-align: left;">
					제 1 장 총칙<br>
				               제1조 (목적)<br>
				               이 약관은 ㈜대한항공(이하 "대한항공"이라 합니다)이 운영하는 대한항공 온라인 플랫폼에서 제공하는 온라인 서비스(이하 "서비스"라 합니다)를 이용함에 있어 대한항공과 이용자의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.<br>
				               <br>
				               제2조 (용어의 정의)<br>
				               "대한항공 온라인 플랫폼"이란 대한항공이 정보 또는 서비스를 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비와 정보통신망을 이용하여 정보 및 서비스를 이용자에게 제공하고 재화 또는 용역을 거래할 수 있도록 설정한 가상의 영업장(PC/모바일웹, 모바일 어플리케이션)을 말합니다.<br>
				               "이용자"란 대한항공 온라인 플랫폼에 접속하여 이 약관에 따라 대한항공이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>
				               "SKYPASS(스카이패스) 회원"이란 대한항공의 탑승 및 제휴사를 이용할 때마다 보너스 마일리지를 적립하고 적립된 마일리지를 사용하고자 스카이패스 회원 약관에 동의하고 회원이 된 자를 말합니다.<br>
				               "회원"이라 함은 스카이패스 회원 중 대한항공 온라인 플랫폼에 개인정보를 제공하여 회원등록을 한 자로서, 대한항공의 정보를 지속적으로 제공받으며, 대한항공이 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.<br>
				               "비회원"이라 함은 회원으로 가입하지 않고 대한항공이 제공하는 정보 및 서비스를 이용하는 자를 말합니다.<br>
				               "입점 제휴사"라 함은 대한항공과 제휴되어 온라인플랫폼에 입점 및 연결된 사이트의 제휴사를 말합니다.<br>
				               "개인정보"라 함은 당해 정보에 포함되어 있는 성명, 전자우편 등의 사항에 의하여 특정 개인을 식별할 수 있는 정보 (당해 정보만으로는 특정 개인을 인식할 수 없더라도 다른 정보 용이하게 결합하여 식별할 수 있는 것을 포함한다)을 말합니다.<br>
				               제3조 (약관의 명시와 개정)<br>
				               대한항공은 이 약관의 내용과 상호, 연락처(전자우편주소, 전화번호, 팩스번호 등), 통신판매업신고번호 등을 이용자가 알 수 있도록 초기 서비스화면(전면)에 게시합니다.<br>
				               대한항공은 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진및정보보호등에관한법률, 소비자기본법, 전자상거래등에서의소비자보호에관한법률 등 관련법령을 위반하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>
				               약관을 개정할 경우에는 개정사유 및 적용일자를 명시하여 현행약관과 함께 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다.<br>
				               개정약관은 개정된 내용이 관계 법령에 위배되지 않는 한 개정 이전에 회원으로 가입한 이용자에게도 적용됩니다. 다만 개정약관의 적용을 거절하는 뜻을 약관의 공시기간 내에 대한항공에 명시적으로 통지한 이용자에 대해서는 개정전의 약관조항이 적용됩니다.<br>
				               이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래등에서의소비자보호에관한법률, 약관의규제에관한법률, 공정거래위원회가 정하는 전자상거래등에서의소비자보호지침, 관계법령 또는 상관례에 따릅니다.<br>
				               <br>
				               제 2 장 서비스 이용<br>
				               제4조 (서비스의 제공)<br>
				               대한항공이 온라인 플랫폼을 통하여 제공하는 서비스는 아래와 같습니다.<br>
				               <br>
				               항공권 예약 및 구매에 관련된 정보, 서비스 제공<br>
				               스카이패스 관련 서비스<br>
				               에어텔, 호텔, 렌터카 등 여행 관련 정보, 서비스 제공<br>
				               기타 대한항공이 정하는 업무<br>
				               제5조 (서비스의 중단)<br>
				               대한항공은 컴퓨터 등 정보통신설비의 점검·보수·교체·고장·통신두절 등의 경우에는 온라인 플랫폼 상의 서비스 제공을 일시적으로 중단할 수 있습니다.<br>
				               제1항에 의한 서비스 중단의 경우 대한항공은 제8조에 정한 방법으로 이용자에게 통지합니다.<br>
				               대한항공은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 이용자 또는 제 3자가 입은 손해를 배상하지 아니합니다. 단, 대한항공에 고의 또는 중대한 과실이 있는 경우에는 그러하지 아니합니다.<br>
				               대한항공은 이용자가 다음 각 호의 1에 해당하는 행위 또는 행위를 할 우려가 있는 경우 사전통지 없이 서비스 이용을 중단할 수 있습니다.<br>
				               공공질서 또는 미풍양속에 반하는 행위<br>
				               범죄와 관련되었다고 추정되는 일체의 행위<br>
				               공공의 이익을 저해할 목적으로 서비스 이용을 계획 또는 실행하는 행위<br>
				               서비스의 제공을 방해하는 등 서비스의 건전한 이용을 저해하는 행위<br>
				               제4항에 의한 서비스 중단의 경우 대한항공은 이용자 또는 제3자가 입은 손해를 배상하지 아니합니다.<br>
				               제6조 (회원가입)<br>
				               이용자는 정해진 가입양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 하는 방법으로 회원가입을 신청합니다. 단, 14세 미만의 미성년자의 경우에는 법정 대리인의 동의를 받아 본 약관에 동의하고 가입신청을 할 수 있습니다.<br>
				               회원이 되고자 하는 자는 반드시 실명으로 회원가입을 하여야 하며, 대한항공이 요청하는 개인정보를 제공해야 합니다.<br>
				               대한항공은 이용자가 다음 각호에 해당하지 않는 한 회원으로 등록합니다.<br>
				               가입신청자가 이 약관 제7조제4항에 의하여 회원자격을 상실한 경우. 다만 회원자격 상실 후 3년이 경과한 자로서 대한항공의 회원 재가입 승낙을 얻은 경우는 예외로 합니다.<br>
				               등록 내용에 허위, 기재누락, 오기가 있는 경우<br>
				               기타 회원으로 등록하는 것이 기술적으로 현저히 지장이 있다고 판단되는 경우<br>
				               회원가입계약의 성립시기는 대한항공의 승낙이 회원에게 도달한 시점으로 합니다.<br>
				               회원은 등록사항에 변경이 있는 경우, 즉시 전자우편 기타 이에 준하는 방법으로 그 변경사항을 수정, 등록함으로써 최신의 정보를 유지해야 합니다.<br>
				               제7조 (회원탈퇴 및 자격상실 등)<br>
				               회원은 언제든지 탈퇴신청을 할 수 있으며, 이 경우 대한항공은 즉시 회원탈퇴를 처리합니다.<br>
				               회원이 다음 각 호의 사유에 해당하는 경우 대한항공은 서비스 이용을 제한 또는 해지시킬 수 있습니다.<br>
				               회원 사망 시<br>
				               가입 신청 시 허위 내용을 기재하거나 2개 이상의 I.D.로 이중 등록한 경우<br>
				               대한항공 온라인 플랫폼에서 구매한 항공권 등의 대금지급채무 및 기타 사이트 이용과 관련하여 회원이 부담하는 채무를 불이행하는 경우<br>
				               타인의 대한항공 온라인 플랫폼 이용을 방해하거나 타인의 개인정보를 도용하는 등 전자거래질서를 침해·위협하는 경우<br>
				               대한항공 온라인 플랫폼을 이용하여 이 약관이 금지하는 행위 또는 법령, 공서양속 등에 반하는 행위를 하는 경우<br>
				               회원가입 후, 연속하여 1년 동안 대한항공 온라인 플랫폼을 이용하기 위해 로그인한 기록이 없는 경우<br>
				               대한항공이 서비스 이용을 제한·정지하고자 할 때에는 미리 그 사유, 일시, 기간을 전자우편, 전화, 서면 등으로 이용자에게 통지합니다. 다만 긴급을 요할 경우에는 조치 후에 통지할 수 있습니다.<br>
				               대한항공이 서비스이용을 제한·정지시킨 후 그 제재사유가 된 행위가 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 대한항공은 회원자격을 상실시킬 수 있습니다.<br>
				               대한항공이 회원자격을 상실시키는 경우에는 회원등록을 말소하며, 이 경우 말소 전에 회원에게 이를 통지합니다. 단, 상기 2항의 6에 의하여 이용자의 회원자격을 상실시킬 경우에는 자격 상실 30일 전까지 동 내용에 대한 안내문을 제 8조에 의거 통지하며, 자격이 상실된 회원의 개인정보는 인터넷 개인정보처리방침 사항에 따라 파기합니다.<br>
				               서비스이용의 제한, 정지, 회원자격의 상실로 인한 손해에 대해서 대한항공은 책임을 지지 않습니다.<br>
				               제8조 (회원에 대한 통지)<br>
				               대한항공이 회원에 대한 통지를 하는 경우 회원이 제출한 전자우편주소로 할 수 있습니다.<br>
				               대한항공은 불특정다수의 회원에게 통지하는 경우, 홈페이지에 7일이상 공시함으로써 개별통지에 갈음 할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.<br>
				               제2항의 사유로 통지하는 경우, 부득이한 사정에 의해 사전 공시기간이 감축되거나 생략될 수 있습니다.<br>
				               제9조 (구매신청)<br>
				               이용자는 대한항공이 정한 아래 방법에 의하여 항공권 등의 구매신청을 할 수 있습니다.<br>
				               <br>
				               성명, 성별, 연락처 등 입력<br>
				               개인 정보 수집 및 규정, 법적 고지문, 약관 등에 동의한다는 표시(예: 마우스 클릭)<br>
				               결제수단 선택<br>
				               제10조 (구매계약의 성립)<br>
				               대한항공은 제9조에 정한 방법에 의한 구매신청에 대하여 다음 각 호에 해당하는 경우 승낙하지 않을 수 있습니다.<br>
				               신청 내용에 허위, 기재누락, 오기가 있는 경우<br>
				               구매신청에 대한 승낙이 영업상 또는 기술상 현저히 지장이 있다고 판단되는 경우<br>
				               대한항공의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.<br>
				               제11조 (결제방법)<br>
				               대한항공 온라인 플랫폼에서 구매한 재화·용역에 대한 대금지급방법은 다음 각 호의 하나로 할 수 있습니다.<br>
				               <br>
				               온라인 계좌이체<br>
				               신용카드 결제<br>
				               SKYPASS 마일리지에 의한 항공권 구입<br>
				               기타 대한항공이 정한 결제방식<br>
				               제12조 (수신확인통지·구매신청 변경 및 취소)<br>
				               대한항공은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.<br>
				               수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고, 대한항공은 그 요청에 따라 처리하여야 합니다.<br>
				               <br>
				               제 3 장 책임과 의무<br>
				               제13조 (개인정보보호)<br>
				               이용자의 개인정보 보호에 대한 상세한 내용은 대한항공 온라인 플랫폼(www.koreanair.com)상의 개인정보처리방침에서 규정한 바에 따릅니다.<br>
				               제14조 (대한항공의 의무)<br>
				               대한항공은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고 안정적인 서비스 제공 및 재화·용역의 공급에 노력합니다.<br>
				               대한항공은 이용자가 안전하게 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추겠습니다.<br>
				               대한항공이 상품이나 용역에 관하여 「표시·광고의공정화에관한법률」 제3조 소정의 부당한 표시·광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.<br>
				               대한항공은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.<br>
				               제15조 (회원의 I.D. 및 비밀번호에 대한 의무)<br>
				               개인정보처리방침에 명시된 이용을 제외한 I.D.와 비밀번호에 대한 관리책임은 회원에게 있습니다.<br>
				               대한항공 온라인 플랫폼 서비스를 이용하고자 하는 회원은 대한항공이 정하는 바에 따라 회원 ID 및 비밀번호를 대한항공 온라인 플랫폼에 등록해야 합니다.<br>
				               회원은 제3자에게 자신의 I.D. 및 비밀번호를 이용하게 해서는 안됩니다.<br>
				               회원이 자신의 I.D. 및 비밀번호를 도용 당하거나 제3자가 사용하고 있음을 인지한 경우에는 즉시 대한항공에 통보하여 그 안내에 따라야 합니다.<br>
				               제16조 (이용자의 의무)<br>
				               이용자는 이 약관 및 관계법령을 준수하여야 하며, 다음의 행위를 해서는 안됩니다.<br>
				               <br>
				               신청 또는 변경 시 허위내용의 기재<br>
				               대한항공 온라인 플랫폼에 게시된 정보의 임의변경<br>
				               대한항공이 허용하고 있지 않은 정보나 컴퓨터 프로그램 등을 무단으로 송신 또는 게시하는 행위<br>
				               대한항공 기타 제3자의 저작권 등 지적재산권 침해<br>
				               대한항공 기타 제3자의 명예, 프라이버시를 침해하거나 업무를 방해하는 행위<br>
				               외설적 또는 폭력적 메시지·화상·음성 기타 공서양속에 반하는 정보를 송신, 공개 또는 게시하는 행위<br>
				               제17조 (대한항공 온라인 플랫폼과 연결 사이트 간의 관계)<br>
				               대한항공 온라인 플랫폼과 연결 사이트가 하이퍼링크 (하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함) 방식으로 연결 된 경우, 대한항공은 연결 사이트가 독자적으로 제공하는 재화·용역에 의하여 이용자와 행하는 거래에 대해서 보증책임을 지지 않습니다.<br>
				               <br>
				               제18조 (저작권의 귀속 및 이용제한)<br>
				               대한항공이 작성한 저작물에 대한 저작권 기타 지적재산권은 대한항공에 귀속합니다.<br>
				               이용자는 대한항공 온라인 플랫폼을 이용함으로써 얻은 정보를 대한항공의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자로 하여금 이용하게 해서는 안됩니다.<br>
				               제19조 (분쟁해결)<br>
				               대한항공은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치·운영합니다.<br>
				               대한항공은 이용자가 제기하는 불만사항 및 의견을 신속·적정하게 처리합니다. 다만 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 지체 없이 통보해 드립니다.<br>
				               대한항공과 이용자간에 전자거래에 관한 분쟁 발생시 전자거래기본법 및 동법 시행령에 근거 하여 설치된 전자거래분쟁조정위원회의 조정에 따를 수 있습니다.<br>
				               제20조 (관할법원 및 준거법)<br>
				               대한항공과 이용자간에 발생한 전자거래 분쟁에 관한 소는 서울중앙지방법원에 제기합니다.<br>
				               대한항공과 이용자간에 제기된 전자거래 소송에는 대한민국 법을 적용합니다.<br>
				               <br>
				               부칙<br>
				               제1조 (약관의 효력)<br>
				               이 약관은 2001년 3월 13일부터 시행하며, 이 약관이 개정되기 전에 가입한 회원에게도 적용됩니다.<br>
				               <br>
				               제2조 (약관의 개정)<br>
				               대한항공은 대한민국의 약관의규제에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진및정보보호등에관한법률, 소비자기본법, 전자상거래등에서의소비자보호에관한법률, 개인정보보호법 등 관련법규를 준수합니다. 따라서 대한항공의 회원 약관은 대한민국 관련법규개정 및 정부지침의 변경으로 인하여 그 내용이 변경될 수 있습니다. 회원 약관 개정 시에는 개정일자, 개정이유, 개정내용 등을 온라인 플랫폼에 공시하겠습니다.<br>
				               <br>
				               이용약관 버전 번호 : v1.5<br>
				               이용약관 시행 일자 : 2001-3-13<br>
				               이용약관 개정 일자<br>
				               2001-03-13 버전 번호 v1.0 시행<br>
				               2008-10-08 (v1.1)<br>
				               변경사항 : 소비자보호법 개정에 따른 ‘소비자기본법’으로의 명칭 변경, 회원탈퇴 및 자격상실의 조건에 회원 사망 시 추가<br>
				               추가사항 : 인터넷 회원 약관의 개정에 관한 사항 추가<br>
				               2011-09-27 추가사항 : 서비스 중단 사유 추가 (v1.2)<br>
				               2011-11-01 추가사항 : 회원탈퇴 및 자격상실 조건 추가 (v1.3)<br>
				               2012-08-20 변경사항 : '정보통신망 이용촉진 및 정보보호 등에 관한 법률' 개정에 따라 회원탈퇴 및 자격 상실의 조건, 통지 방법 변경 (v1.4)<br>
				               2020-08-31 (v1.5)<br>
				               변경사항 : 약관 명칭을 ‘인터넷 회원 약관’에서 ‘이용약관’으로 변경, 기존 ‘웹사이트’의 ‘온라인 플랫폼’으로의 용어 변경<br>
				               추가사항 : '용어의 정의'에 일부 용어 추가, 회원가입의 조건에 만 14세 미만의 경우 및 실명 가입 추가<br>
				</div>
				<br>
				<button style="padding: 15px; width: 100px;" id="confirm_1">확인 </button>	
			</div>
		</div>
		
		<!-- modal_2 -->
		<div class="modal_2">
			<div class="modal_content">
				<h1>위험품 안내</h1>
				<br>
				<h1>항공기 반입금지 물품</h1>
				<br>
				<div>
					<img alt="약관" src="/img/terms.jpg" style="width: 800px; height: 800px;">
					<br><br><br>
					<button style="padding: 15px; width: 100px;" id="confirm_2">확인 </button>	
				</div>
			</div>
		</div>
		
		<br><hr><br>
		
		<div class="reservation">
			<button id="goBackBtn">뒤로가기</button>
			&nbsp;
			<button id="payBtn">결제하기</button>
		</div>
		
		<!-- 화면에 보이지 않는 부분 : 데이터 가공 -->
		<div class="hidden">
			<!-- 좌석을 보여주기 위함 -->
			<input type="hidden" name="seat_grade" value="${seat_grade}">
			<input type="hidden" name="date_idx" value="${getSchedule.date_idx}">
			<input type="hidden" name="flight_name" value="${getSchedule.flight_name}">
			<!-- 항공권 예약 시 회원정보 입력 위함 -->
			<input type="hidden" name="m_idx" value="${loginPublicInfo.m_idx}">
		</div>
		
		<!-- 항공권 예약-->				
		<form action="kakaoPay" method="post" id="reservationForm"></form>
	
	</section>
	
<style>

	#BookSeat{
		background-color: lightgray;
		/* 포인터 클릭 이벤트 막기 */
		pointer-events: none;
	}

	#noneBookSeat{
		background-color: white;
	}
	
	#noneBookSeat:hover {
		background-color: #ffc0cb;
		font-weight: bold;
		color: black;
		transform: scale(1.2);
	}
	
	/* 모달창 스타일 */
	.modal_1, .modal_2{ 
		position: absolute; 
		width:100%; height:100%; 
		background: rgba(0,0,0,0.3); 
		top:0; left:0; 
		display:none;
	}
	
	.modal_content{
		width:850px; height:1100px;
		background:#fff;
		position:relative; top:10%; left:10%;
		margin-top:-50px; margin-left:-100px;
		text-align:center;
		box-sizing:border-box; padding:74px 0;
		line-height:23px; cursor:pointer;
	}
	
</style>
<script type="text/javascript" src="/resources/js/flight.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 약관 1 버튼 클릭 이벤트
		$("#view1").on("click", function() {
			$(".modal_1").fadeIn();
		}); // end : 약관 1 버튼 클릭 이벤트
		
		// 모달창 1 확인 버튼 클릭 이벤트
		$("#confirm_1").click(function(){
			var checked = $("#ck1").is(':checked');
		    if(!checked){
		    	$('#ck1').prop('checked',true);
			}
			$(".modal_1").fadeOut();
		}); // end : 모달창 1 확인 버튼 클릭 이벤트
		
		// 약관 2 버튼 클릭 이벤트
		$("#view2").on("click", function() {
			$(".modal_2").fadeIn();
		}); // end : 약관 2 버튼 클릭 이벤트
		
		// 모달창 2 확인 버튼 클릭 이벤트 
		$("#confirm_2").click(function(){
		    var checked = $("#ck2").is(':checked');
		    if(!checked){
		    	$('#ck2').prop('checked',true);
		    }
		    $(".modal_2").fadeOut();
		}); // end : 모달창 2 확인 버튼 클릭 이벤트
		
		// 가격을 하나의 변수에 담기 위한 전역 변수 선언
		var price = "";

		// 좌석정보 얻기 위한 객체
		var div = $(".choiceSeat");
		var date_idx = $(".hidden").find("input[name='date_idx']");
		var seat_grade = $(".hidden").find("input[name='seat_grade']");
		
		// 항공권 예매를 위한 객체
		var seat = '';
		var bookInfo_ = '';
		var m_idx = $(".hidden").find("input[name='m_idx']");
		var flight_name = $(".hidden").find("input[name='flight_name']");
		
		// 티켓 가격에 천단위 구분을 위한 함수
		function AmountCommas(val){
		    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
		}

		// 해당 항공편의 좌석정보 출력
		getSeatList({seat_grade:seat_grade.val(), date_idx:date_idx.val()},
				function(seat) {
			
			// 이미 선택된 좌석정보 출력
			getReservationSeatList({flight_name:flight_name.val(), date_idx:date_idx.val()}, 
					function(seatList) {
				
				// 이코노미석 선택
				if(seat.economyseat != null) {
					var pEs = seat.economyseatprice;
					price = pEs;
           			pEs = AmountCommas(pEs)+'원';
					$("#ticketPrice").html(pEs);
					var es = seat.economyseat;
					var split_es = es.split(',');
					var str = '';
					str += "<div style='border: 1px solid black; padding: 10px; text-align: center; width: 680px;'>"
					for(var i=0; i<split_es.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_es[i] == seatList[j].seat_name) {
								if(seatList[j].completion != "환불완료"){
									str += "<button style='padding: 15px; margin: 5px;' id='BookSeat'>" + split_es[i] + "</button>"
									i++;
								}
							}
						}
						if(split_es[i] != undefined){
							str += "<button style='padding: 15px; margin: 5px;' id='noneBookSeat' data-idx=" + split_es[i] + ">" + split_es[i] + "</button>"
						}
					}
					str += "</div>"
					div.html(str);
					// 좌석 버튼 클릭 이벤트
					$(".choiceSeat button").on("click", function() {
						$(".choiceSeat #noneBookSeat").css("background-color","white");
						$(this).css("background-color","#ffc0cb");
						var seat_es = $(this).data("idx");
						// 로그인 유무 따른 예외처리
						if(m_idx.val() != ""){
							var rstr = '';
							alert("선택한 좌석 번호 : " + seat_es);
							// 예약을 위한 정보 생성
							rstr += "<input type='hidden' name='m_idx' value=" + m_idx.val() + ">";
							rstr += "<input type='hidden' name='date_idx' value=" + date_idx.val() + ">";
							rstr += "<input type='hidden' name='flight_name' value=" + flight_name.val() + ">";
							rstr += "<input type='hidden' name='seat_name' value=" + seat_es + ">";
							rstr += "<input type='hidden' name='ticket_price' value=" + price + ">";
							$("#reservationForm").html(rstr);
							// 결제하기 버튼 클릭 이벤트
							$("#payBtn").on("click", function() {
								// 확인 및 동의 약관
								var checked_1 = $("#ck1").is(':checked');
								var checked_2 = $("#ck2").is(':checked');
								// 이용약관 동의 여부 체크
								if(!checked_1 || !checked_2){
									alert("필수 약관에 동의해 주세요.")
							    }else {
									$("#reservationForm").submit();
								} // end : 이용약관 동의 여부 체크
							}) // end : 결제하기 버튼 클릭 이벤트
						}else {
							alert("로그인이 필요한 서비스 입니다.")
							if(!confirm("로그인 하시겠습니까?")){
								return;
							}else{
								location.href = "${pageContext.request.contextPath}/Member/login";
							}
						} // end : 로그인 유무 따른 예외처리
					}) // end : 좌석 버튼 클릭 이벤트
				} // end : 이코노미석 선택
				// 비즈니스석 선택
				if(seat.businessseat != null){
					var pBs = seat.businessseatprice;
					price = pBs;
           			pBs = AmountCommas(pBs)+'원';
					$("#ticketPrice").html(pBs);
					var bs = seat.businessseat;
					var split_bs = bs.split(',');
					var str = '';
					str += "<div style='border: 1px solid black; padding: 10px; text-align: center; width: 680px;'>"
           			for(var i=0; i<split_bs.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_bs[i] == seatList[j].seat_name) {
								if(seatList[j].completion != "환불완료"){
									str += "<button style='padding: 15px; margin: 5px;' id='BookSeat'>" + split_bs[i] + "</button>"
									i++;
								}
							}
						}
						if(split_bs[i] != undefined){
							str += "<button style='padding: 15px; margin: 5px;' id='noneBookSeat' data-idx=" + split_bs[i] + ">" + split_bs[i] + "</button>"
						}
					}
					str += "</div>"
					div.html(str);
					// 좌석 버튼 클릭 이벤트
					$(".choiceSeat button").on("click", function() {
						$(".choiceSeat #noneBookSeat").css("background-color","white");
						$(this).css("background-color","#ffc0cb");
						var seat_bs = $(this).data("idx");
						// 로그인 유무 따른 예외처리
						if(m_idx.val() != ""){
							var rstr = '';
							alert("선택한 좌석 번호 : " + seat_bs);
							// 예약을 위한 정보 생성
							rstr += "<input type='hidden' name='m_idx' value=" + m_idx.val() + ">";
							rstr += "<input type='hidden' name='date_idx' value=" + date_idx.val() + ">";
							rstr += "<input type='hidden' name='flight_name' value=" + flight_name.val() + ">";
							rstr += "<input type='hidden' name='seat_name' value=" + seat_bs + ">";
							rstr += "<input type='hidden' name='ticket_price' value=" + price + ">";
							$("#reservationForm").html(rstr);
							// 결제하기 버튼 클릭 이벤트
							$("#payBtn").on("click", function() {
								// 확인 및 동의 약관
								var checked_1 = $("#ck1").is(':checked');
								var checked_2 = $("#ck2").is(':checked');
								// 이용약관 동의 여부 체크
								if(!checked_1 || !checked_2){
									alert("필수 약관에 동의해 주세요.")
							    }else {
									$("#reservationForm").submit();
								} // end : 이용약관 동의 여부 체크
							}) // end : 결제하기 버튼 클릭 이벤트
						}else {
							alert("로그인이 필요한 서비스 입니다.")
							if(!confirm("로그인 하시겠습니까?")){
								return;
							}else{
								location.href = "${pageContext.request.contextPath}/Member/login";
							}
						} // end : 로그인 유무 따른 예외처리
					}) // end : 좌석 버튼 클릭 이벤트
				} // end : 비즈니스석 선택
				// 퍼스트석 선택
				if(seat.firstseat != null){
					var pFs = seat.firstseatprice;
					price = pFs;
           			pFs = AmountCommas(pFs)+'원';
					$("#ticketPrice").html(pFs);
					var fs = seat.firstseat;
					var split_fs = fs.split(',');
					var str = '';
					str += "<div style='border: 1px solid black; padding: 10px; text-align: center; width: 680px;'>"
           			for(var i=0; i<split_fs.length; i++){
						for(var j=0; j<seatList.length; j++) {
							if(split_fs[i] == seatList[j].seat_name) {
								if(seatList[j].completion != "환불완료"){
									str += "<button style='padding: 15px; margin: 5px;' id='BookSeat'>" + split_fs[i] + "</button>"
									i++;
								}
							}
						}
						if(split_fs[i] != undefined){
							str += "<button style='padding: 15px; margin: 5px;' id='noneBookSeat' data-idx=" + split_fs[i] + ">" + split_fs[i] + "</button>"
						}
					}
					str += "</div>"
					div.html(str);
					// 좌석 버튼 클릭 이벤트
					$(".choiceSeat button").on("click", function() {
						// 현우가 해결해준 코드!!!
						$(".choiceSeat #noneBookSeat").css("background-color","white");
						$(this).css("background-color","#ffc0cb");
						var seat_fs = $(this).data("idx");
						// 로그인 유무 따른 예외처리
						if(m_idx.val() != ""){
							var rstr = '';
							alert("선택한 좌석 번호 : " + seat_fs);
							// 예약을 위한 정보 생성
							rstr += "<input type='hidden' name='m_idx' value=" + m_idx.val() + ">";
							rstr += "<input type='hidden' name='date_idx' value=" + date_idx.val() + ">";
							rstr += "<input type='hidden' name='flight_name' value=" + flight_name.val() + ">";
							rstr += "<input type='hidden' name='seat_name' value=" + seat_fs + ">";
							rstr += "<input type='hidden' name='ticket_price' value=" + price + ">";
							$("#reservationForm").html(rstr);
							// 결제하기 버튼 클릭 이벤트
							$("#payBtn").on("click", function() {
								// 확인 및 동의 약관
								var checked_1 = $("#ck1").is(':checked');
								var checked_2 = $("#ck2").is(':checked');
								// 이용약관 동의 여부 체크
								if(!checked_1 || !checked_2){
									alert("필수 약관에 동의해 주세요.");
							    }else {
									$("#reservationForm").submit();
								} // end : 이용약관 동의 여부 체크
							}) // end : 결제하기 버튼 클릭 이벤트
						}else {
							alert("로그인이 필요한 서비스 입니다.")
							if(!confirm("로그인 하시겠습니까?")){
								return;
							}else{
								location.href = "${pageContext.request.contextPath}/Member/login";
							}
						} // end : 로그인 유무 따른 예외처리
					}) // end : 좌석 버튼 클릭 이벤트
				} // end : 퍼스트석 선택
				
			}) // end : 이미 선택된 좌석정보 출력
			
		}) // end : 해당 항공편의 좌석정보 출력
		
		// 뒤로가기 버튼 클릭 이벤트
		$("#goBackBtn").on("click", function() {
			history.back();
		}) // end : 뒤로가기 버튼 클릭 이벤트
		
	}) // end : onload
	
</script>

<!-- 이 부분 내용만 수정 (바디 작성 부분)-->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>