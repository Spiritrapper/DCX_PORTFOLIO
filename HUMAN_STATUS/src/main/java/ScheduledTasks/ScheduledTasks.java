package ScheduledTasks;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.smhrd.bigdata.entity.UserEvent;
import com.smhrd.bigdata.mapper.UserEventMapper;

@Component
public class ScheduledTasks {
	
    @Autowired
    private UserEventMapper mapper;
    
    @Scheduled(fixedRate = 2000)
    public void fetchLatestEvents() {
        // 데이터베이스에서 최신 이벤트 데이터를 가져오는 로직
        List<UserEvent> latestEvents = mapper.getAllUserEvents();
        List<UserEvent> latestEvents1 = mapper.getAllUserEvents1();
        
        int latestEvent = mapper.getAllNumber(); 
        int latestEvent1 = mapper.getAllNumber(); 
        // 가져온 데이터를 처리하는 로직
    
    }

}
