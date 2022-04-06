package com.seoulauction.common.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class StartupApplicationListener implements ApplicationListener<ContextRefreshedEvent> {

    @Value("${server.config}")
    String config;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
      log.info("server config : {}" , config );
    }
}
