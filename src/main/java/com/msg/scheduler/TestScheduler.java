package com.msg.scheduler;

import org.springframework.scheduling.annotation.Scheduled;

public class TestScheduler {

	@Scheduled(fixedRate=10000)
	public void testScheduler(){
		System.out.println("스케줄러 잘 작동 하시는가?");
	}
}
