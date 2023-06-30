package com.hr.laraworld.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class HelloSpringUtils {

	/**
	 * yyyyMMdd_HHmmssSSS_123.jpg
	 * 
	 * @param upFile
	 * @return
	 */
	public static String renameMultipartFile(MultipartFile upFile) {
		String originalFilename = upFile.getOriginalFilename();
		String ext = "";
		int beginIndex = originalFilename.lastIndexOf(".");
		if(beginIndex > -1)
			ext = originalFilename.substring(beginIndex); // .jpg
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000"); // 022
		
		return sdf.format(new Date()) + df.format(Math.random() * 1000) + ext;
	}
	
	/**
	 * totalPage 전체 몇 페이지
	 * pagebarSize 페이지바의 링크 몇개?
	 * pageNo 증감변수
	 * pageStart ~ pageEnd 증감변수 범위
	 * 
	 * @param page
	 * @param limit
	 * @param totalCount
	 * @param url
	 * @param hompyId 
	 * @return
	 */
	public static String getPagebar(int page, int limit, int totalCount, String url, String hompyId) {
		StringBuilder pagebar = new StringBuilder();
		url += "?hompyId=" + hompyId + "&page="; 
		
		// 전체페이지수
		int totalPage = (int) Math.ceil((double) totalCount / limit); // 11.4  -> 12.0 -> 12
		
		int pagebarSize = 5;
		// 페이지바의 시작넘버
		// 1 2 3 4 5 		-> 1
		// 6 7 8 9 10 		-> 6
		// 11 12 13 14 15 	-> 11
		int pageStart = ((page - 1) / pagebarSize) * pagebarSize + 1; // page, pagebarSize
		int pageEnd = pageStart + pagebarSize - 1; // 1 - 5, 6 - 10
		
		int pageNo = pageStart;
		
		// 1. 이전 영역
		if(pageNo == 1) {
			pagebar.append("<li class='page-item disabled'>\n<a class='page-link' href='"+ url + (pageNo - 1) +"' >&laquo;</a>\n</li>\n");  // 현재페이지가 6인 경우 ?page=5
			// 1 2 3 4 5 이므로 이동할 이전페이지 없음.
		}
		else {
			pagebar.append("<li class='page-item'>\n<a class='page-link' href='"+ url + (pageNo - 1) +"' >&laquo;</a>\n</li>\n");  // 현재페이지가 6인 경우 ?page=5
		}
		
		// 2. pageNo 영역
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			if(pageNo == page) {
				// 현재페이지 링크인 경우
				pagebar.append("<li class='page-item active' aria-current='page'>\n<a class='page-link' href='#'>" + pageNo + "</a>\n</li>\n");
			}
			else {
				// 현재페이지 링크가 아닌 경우
				pagebar.append("<li class='page-item'>\n<a class='page-link' href='" + url + pageNo + "'>" + pageNo + "</a>\n</li>\n");
			}
			pageNo++;
		}
		
		// 3. 다음 영역
		if(pageNo > totalPage) {
			pagebar.append("<li class='page-item disabled'>\n<a class='page-link' href='" + url + pageNo + "'>&raquo;</a>\n</li>\n");
			// 마지막페이지이후는 다음 버튼이 필요 없음.
		}
		else {
			pagebar.append("<li class='page-item'>\n<a class='page-link' href='" + url + pageNo + "'>&raquo;</a>\n</li>\n");
		}
		
		
		return pagebar.toString();
	}

}
