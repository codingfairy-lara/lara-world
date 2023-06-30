package com.hr.laraworld;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger log = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "forward:/index.jsp"; // forwarding경로 오버라이드(InternalResourceViewResolver 사용안함)
	}

	@GetMapping("/error/accessDenied.do")
	public void accessDenied() {
		log.debug("403 Forbidden");
	}

}
