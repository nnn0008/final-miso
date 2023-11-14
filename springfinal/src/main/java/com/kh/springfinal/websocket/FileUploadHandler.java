package com.kh.springfinal.websocket;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.BinaryWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dto.AttachDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileUploadHandler extends BinaryWebSocketHandler {

	            private AttachDao attachDao;

	            // 초기 디렉터리 설정
	            @Autowired
	            private FileUploadProperties props;

	            private File dir;

	            @PostConstruct
	            public void init() {
	                dir = new File(props.getHome());
	                dir.mkdirs();
	            }

	            public FileUploadHandler(AttachDao attachDao) {
	                this.attachDao = attachDao;
	            }

	            protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) throws IOException {
	        
	                    byte[] payload = message.getPayload().array();
	                    String payloadString = new String(payload, StandardCharsets.UTF_8);

	                    Gson gson = new Gson();
	                    JsonObject json = gson.fromJson(payloadString, JsonObject.class);

	                    int roomNo = json.get("chatRoomNo").getAsInt();
	                    JsonObject fileInfo = json.getAsJsonObject("file");

	                    // [1] 시퀀스 번호를 생성한다
	                    int attachNo = attachDao.sequence();

	                    String fileName = String.valueOf(attachNo); // [2] 시퀀스 번호를 파일명으로 사용

	                    long fileSize = fileInfo.get("size").getAsLong();
	                    String fileType = fileInfo.get("type").getAsString();

	                    // 파일 저장
	                    saveFile(payload, fileName);

	                    // DB에 파일 정보 저장
	                    saveFileInfo(attachNo, fileName, fileSize, fileType);

	                    // 여기에서 필요한 작업 수행 (예: 채팅방에 파일 업로드 메시지 전송 등)

	                    // 로그 추가
	                    log.debug("File uploaded successfully. RoomNo: {}, FileName: {}, FileSize: {}, FileType: {}", roomNo, fileName, fileSize, fileType);

	                    // 파일 업로드 완료 메시지를 클라이언트에게 보낸다
	                    sendMessageToClient(session, "File uploaded successfully.");


	                }

	            private int saveFile(byte[] fileData, String fileName) throws IOException {
	                int attachNo = attachDao.sequence();
	                File target = new File(dir, String.valueOf(attachNo));
	                try (FileOutputStream fos = new FileOutputStream(target)) {
	                    fos.write(fileData);
	                }
	                return attachNo;
	            }

	            private void saveFileInfo(int attachNo, String fileName, long fileSize, String fileType) {
	                AttachDto attachDto = new AttachDto();
	                attachDto.setAttachNo(attachNo);
	                attachDto.setAttachName(fileName);
	                attachDto.setAttachSize(fileSize);
	                attachDto.setAttachType(fileType);
	                attachDao.insert(attachDto);
	            }

	            private void sendMessageToClient(WebSocketSession session, String message) throws IOException {
	                session.sendMessage(new TextMessage(message));
	            }
	        }

