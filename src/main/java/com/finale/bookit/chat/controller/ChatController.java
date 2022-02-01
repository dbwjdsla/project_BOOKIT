package com.finale.bookit.chat.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finale.bookit.chat.model.service.ChatService;
import com.finale.bookit.chat.model.vo.Chat;
import com.finale.bookit.chatRoom.model.service.ChatRoomService;
import com.finale.bookit.chatRoom.model.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;





@Controller
@Slf4j
public class ChatController {

	@Autowired
	private SimpMessagingTemplate template;

	@Autowired
	private ChatService chatService;

	@Autowired
	private ChatRoomService chatRoomService;

	@GetMapping("chat/chatMain")
	public String chatMain(@RequestParam String loginMember,Model model) {
		
		List<ChatRoom> result = chatRoomService.findAllRooms(loginMember);
        
        for(ChatRoom room : result) {
        	String memberId = room.getMemberId();
        	
        	memberId = memberId.replace(loginMember, "");
        	memberId = memberId.replace(",","");
        	
        	room.setMemberId(memberId);
        	
        	log.debug("newId = {}",room.getMemberId());
        	
        	
        }
        log.debug("list = {}", result);
        
        model.addAttribute("list", result);
		model.addAttribute("listSize", result.size());
		return "forward:/WEB-INF/views/chat/chatMain.jsp";
	}
	

    @MessageMapping("/chat")
    public void broadcasting(Chat msg) {
    	
    	int result = chatService.insertChatHistory(msg);
    	
    	template.convertAndSend("/sub/room/"+ msg.getRoomId(), msg);

    }
	
}