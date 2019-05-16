package com.cafe.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.member.model.MemberDetailDto;
import com.cafe.member.model.MemberDto;
import com.cafe.member.model.ZipDto;
import com.cafe.member.service.MemberService;

@Controller
@RequestMapping(value="/member")
public class MemberController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MemberService memberService;

	@RequestMapping(value="/idcheck.cafe", method=RequestMethod.GET)
	@ResponseBody
	public String idCheck(@RequestParam("userid") String userid) {
		int count = memberService.idCount(userid);
		JSONObject json = new JSONObject();
		json.put("idcount", count);
		return json.toString();
	}
	
	@RequestMapping(value="/zipsearch.cafe", method=RequestMethod.GET)
	public String zipSearch() {
		return "user/zipsearch";
	}
	
//	http://pjsprogram.tistory.com/6
	@RequestMapping(value="/zipsearch.cafe", method=RequestMethod.POST)
	@ResponseBody
	public String zipSearch(@RequestParam("dong") String dong) throws IOException {
//		인증키
//	    public static final String ZIPCODE_API_KEY = "";
		String ZIPCODE_API_KEY = "6e1635d1f8d757fa41528100473160";
//	    api를 쓰기 위한 주소
//	    public static final String ZIPCODE_API_URL = "http://biz.epost.go.kr/KpostPortal/openapi";
		String ZIPCODE_API_URL = "http://biz.epost.go.kr/KpostPortal/openapi";
//		http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdSearchAllService/retrieveNewAdressAreaCdSearchAllService/getNewAddressListAreaCdSearchAll?serviceKey=9Xo0vlglWcOBGUDxH8PPbuKnlBwbWU6aO7%2Bk3FV4baF9GXok1yxIEF%2BIwr2%2B%2F%2F4oVLT8bekKU%2Bk9ztkJO0wsBw%3D%3D&srchwrd=%EA%B3%B5%ED%8F%89%EB%8F%99&countPerPage=10&currentPage=1
//		http://biz.epost.go.kr/KpostPortal/openapi?regkey=test&target=postNew&query=정보화길&countPerPage=20&currentPage=1
//		http://biz.epost.go.kr/KpostPortal/openapi?regkey=test&target=postNew&query=삼평동
		JSONObject json = new JSONObject();
        StringBuilder queryUrl = new StringBuilder();
        queryUrl.append(ZIPCODE_API_URL);
        queryUrl.append("?regkey=");
        queryUrl.append(ZIPCODE_API_KEY);
        queryUrl.append("&target=");
        queryUrl.append("postNew");
        queryUrl.append("&query=");
//        queryUrl.append(dong.replaceAll(" ", ""));
//        queryUrl.append(URLEncoder.encode(dong.replaceAll(" ", ""), "UTF-8"));
        queryUrl.append(URLEncoder.encode(dong.replaceAll(" ", ""), "EUC-KR"));
        
        // document 선언
        Document document = Jsoup.connect(queryUrl.toString()).get();
        // errorCode 선언
        String errorCode = document.select("error_code").text();
        
        if(null == errorCode || "".equals(errorCode))
        {
            Elements elements = document.select("item");
            List<ZipDto> list = new ArrayList<ZipDto>();
            ZipDto zipDto = null;
            
            for(Element element : elements){
            	zipDto = new ZipDto();
            	zipDto.setZipcode(element.select("postcd").text());
                // 지번 검색
            	zipDto.setAddress(element.select("address").text());
                list.add(zipDto);
            }
            // list 결과 put
            json.put("list", list);
        }else{
            String errorMessage = document.select("message").text();
            json.put("errorCode", errorCode);
            json.put("errorMessage", errorMessage);
        }
		return json.toString();
	}
	
	//회원가입
	@RequestMapping(value="/users", method=RequestMethod.POST, headers = { "Content-type=application/json" })
	@ResponseBody
	public Map<String, String> registerMember(@RequestBody MemberDetailDto memberDetailDto) {
		memberService.registerMember(memberDetailDto);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "ok");
		return map;
	}
	
	//회원정보보기
	@RequestMapping(value="/users/{userid}", method=RequestMethod.GET)
	@ResponseBody
	public String viewMember(@PathVariable String userid) {
		MemberDetailDto memberDetailDto = memberService.getMember(userid);
		JSONObject json = new JSONObject();
		json.put("userid", memberDetailDto.getUserid());
		json.put("username", memberDetailDto.getUsername());
		json.put("telephone", memberDetailDto.getTel1() + "-" + memberDetailDto.getTel2() + "-" + memberDetailDto.getTel3());
		json.put("address", memberDetailDto.getZipcode() + "<br>" + memberDetailDto.getAddress() + "<br>" + memberDetailDto.getAddressdetail());
		json.put("email", memberDetailDto.getEmailid() + "@" + memberDetailDto.getEmaildomain());
		json.put("joindate", memberDetailDto.getJoindate());
//		System.out.println(json.toString());
		return json.toString();
	}
	
	//회원정보수정
	@RequestMapping(value="/users", method=RequestMethod.PUT, headers = { "Content-type=application/json" })
	@ResponseBody
	public Map<String, String> modifyMember(@RequestBody MemberDetailDto memberDetailDto) {
		memberService.modifyMember(memberDetailDto);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "ok");
		return map;
	}
	
	//회원탈퇴
	@RequestMapping(value="/users/{userid}", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String, String> deleteMember(@PathVariable String userid) {
		memberService.deleteMember(userid);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "ok");
		return map;
	}
	
	@RequestMapping(value="/view.cafe", method=RequestMethod.GET)
	public String viewMember(HttpSession session, Model model) {
		MemberDetailDto memberDetailDto = null;
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			memberDetailDto = memberService.getMember(memberDto.getUserid());
			model.addAttribute("user", memberDetailDto);
		}
		return "user/view";
	}
	
	@RequestMapping(value="/reregister.cafe", method=RequestMethod.GET)
	public String reregisterMember(@RequestParam("userid") String userid, Model model) {
//		System.out.println("재가입 ::: " + userid);
		memberService.reregisterMember(userid);
		return "redirect:/commons/index.cafe";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@RequestParam Map<String, String> logininfo, Model model, HttpServletRequest request, HttpSession session) {
		MemberDto memberDto = memberService.login(logininfo);
		String prePage = request.getHeader("Referer");
		if(memberDto != null) {
			if(memberDto.getRole() != 100) {
				session.setAttribute("userInfo", memberDto);
				return "redirect:" + prePage;
			} else {
				model.addAttribute("userid", logininfo.get("userid"));
				model.addAttribute("loginMsg", "100");
				return "index";
			}
		} else {
			model.addAttribute("loginMsg", "아이디 또는 비밀번호를 확인해 주세요.");
			return "index";
		}
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("userInfo");
		return "redirect:/commons/index.cafe";
	}
	
}
