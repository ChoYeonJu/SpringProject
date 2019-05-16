<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(function(){
    // 검색버튼 눌렸을 때 함수 실행
    $("#searchBtn").click(function(e){
        e.preventDefault();
        // ajax
        $.ajax({
            url : "${root}/member/zipsearch.cafe",
            // zip_codeForm을 serialize 해줍니다.
            data : $("#zip_codeForm").serialize(),
            type : "POST",
            // dataType 은 json형태로 보냅니다.
            dataType : "json",
            success : function(result){
                $("#zip_codeList").empty();
                var html = "";
                if(result.errorCode != null && result.errorCode != ""){
                    html += "<tr>";
                    html += "    <td colspan='2'>";
                    html +=            result.errorMessage;
                    html += "    </td>";
                    html += "</tr>";
                }
                else{
                    // 검색결과를 list에 담는다.
                    var list = result.list;
                    
                    for(var i = 0; i < list.length; i++){
                        html += "<tr>";
                        html += "    <td>";
                        // 우편번호
                        var zipcode = list[i].zipcode;
                        // 주소
                        var address = list[i].address;
 
                        html +=         list[i].zipcode;
                        html += "    </td>";
                        html += "    <td>";
                        html +=     '<a href="#" onclick="put(\'' + list[i].address + '\',\'' + zipcode + '\')">' + address + '</a>';
                        html += "    </td>";
                        html += "</tr>";
                    }
                }
                // 완성된 html(우편번호 list)를 zip_codeList밑에 append
                $("#zip_codeList").append(html);
            }
        });
    });
});
 
// 원하는 우편번호 선택시 함수 실행
function put(address,zipcode){
    var address = address;
    var zipcode = zipcode;
    // 모달창 닫기
    $("#zipModal").modal("hide");
    $(".zipcode").val(zipcode);
    $(".address").val(address);
}

</script>
<div id="zipModal" class="modal fade" role="dialog">
<h5 class="modal-title" id="myModalLabel">우편번호검색</h5>
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header text-center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>    
            <div class="modal-body text-center">
            	<form id = "zip_codeForm">
            		<div align="center">
            			<label>도로명 주소검색</label>
            		</div>
					<div class="input-group" align="left">
						<input type="text" class="form-control" id="dong" name="dong" placeholder="검색 할 도로명 입력(예: 구로디지털로, 여수울로)">
						<span class="input-group-btn">
						<input type="submit" class="btn btn-warning" value="검색" id="searchBtn">
						</span>
					</div>
                </form>
                <div style="width:100%; height:200px; overflow:auto">
                	<table class = "table text-center">
                		<thead>
                		<tr>
                			<th style="width:150px;">우편번호</th>
                			<th style="width:600px;">주소</th>
                		</tr>
                		</thead>
                		<tbody id="zip_codeList"></tbody>
                	</table>
                </div>
            </div>
        </div>
    </div>
</div>