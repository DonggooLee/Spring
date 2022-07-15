console.log("obo Module...");

var oboService = (function() {
	
	function remove(o_num, callback, error) {
		$.ajax({
			type : 'DELETE',
			url : '/obo/' + o_num ,
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
					alert("성공적으로 삭제되었습니다.");
				}
			},
			
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function update(obbo, callback, error) {
		console.log("update~~" + obbo.o_num);
		$.ajax({
			type : 'PUT',
			url : '/obo/' + obbo.o_num, 
			data : JSON.stringify(obbo),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
					alert("성공적으로 수정되었습니다.");
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function removeImg(o_num, callback, error) {
		console.log("removeImg할 o_num? >> " + o_num);
		$.ajax({
			type : 'PUT',
			url : '/obo/removeImg/' + o_num ,
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
					alert("이미지가 성공적으로 삭제되었습니다.");
				}
			},
			
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	return {
		
		remove : remove,
		update : update,
		removeImg : removeImg
	}
	
})();