package com.kh.springfinal.vo;

import java.util.List;

import com.kh.springfinal.dto.ChatOneDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatRoomResponseVO {

	private List<ChatListVO> roomList;
    private List<ChatOneDto> oneChatRoomList;
    private List<MeetingVO> meetingRoomList;
    
}
