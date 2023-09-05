package org.zerock.mapper;

import java.util.List;

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
public class BoardMapperTests {
		
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		
		mapper.getList().forEach(list -> log.info(list));
	}
	
	@Test
	public void testinsertSelectKey() {
		
		BoardVO vo = new BoardVO();
		vo.setTitle("입력한 제목");
		vo.setContent("입력한 내용");
		vo.setWriter("입력한 사람");
		
		mapper.insertSelectKey(vo);
		
		log.info(vo);
	}
	
	@Test
	public void testRead() {
		
		BoardVO vo = mapper.read(3L);
		
		log.info("Read.." + vo);
	}
	
	@Test
	public void testDelete() {
		
		int de = mapper.delete(3L);
		
		log.info("delete.." + de);
	}
	
	@Test
	public void testUpdate() {
		
		BoardVO vo = new BoardVO();
		vo.setBno(5L);
		vo.setTitle("수정된 제목");
		vo.setContent("수정된 내용");
		vo.setWriter("작성자");
		
		mapper.update(vo);
		
		log.info(vo);
	}
	
	@Test
	public void testPaging() {
		
		Criteria cr = new Criteria();
		cr.setPageNum(3);
		cr.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cr);
		
		list.forEach(board -> log.info(board));
	}
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("conefnt");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(vo -> log.info(vo));
	}
	
}
