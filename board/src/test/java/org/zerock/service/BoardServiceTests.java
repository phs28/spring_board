package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Test
	public void testExist() {
		
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testRegister() {
		
		BoardVO vo = new BoardVO();
		vo.setTitle("새로 작성하는 글");
		vo.setContent("새로 작성하는 내용");
		vo.setWriter("작성자");
		
		service.register(vo);
		
		log.info("서비스 테스트.." + vo);
	}
	
	@Test
	public void testGetList() {
		
		service.getList(new Criteria(2, 10)).forEach(list -> log.info(list));
	}
	
	@Test
	public void testGet() {
		
		log.info("get.." + service.get(3L));
	}
	
	@Test
	public void testRemove() {
		
		log.info("remove.." + service.remove(2L));
	}
	
	@Test
	public void testModify() {
		
		BoardVO vo = new BoardVO();
		vo.setBno(1L);
		vo.setTitle("제목수정");
		vo.setContent("내용수정");
		vo.setWriter("사용자수정");
		
		service.modify(vo);
		
		log.info("update.." + vo);
	}
}
