package com.hr.laraworld.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class ErroLogAspect {
	
	@Pointcut("execution(* com.hr.laraworld..*Controller.*(..))")
	public void pc() {}
	
	@AfterThrowing(pointcut = "pc()", throwing = "e")
	public void errorLog(JoinPoint joinPoint, Exception e) {
		log.error(e.getMessage(), e);
	}
}
