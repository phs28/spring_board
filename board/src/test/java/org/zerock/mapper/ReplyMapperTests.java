package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private long[] bnoArr = {228l, 227l, 226l, 224l, 223l, 222l, 221l};
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		
		log.info(mapper);
	}
	
	@Test
	public void testCreate() {
		
		IntStream.range(1, 10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트" + i);
			vo.setReplyer("replyer" + i );
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testRead() {
		
		long targetRno = 5l;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		
		long targetRno = 2l;
		
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		
		long targetBno = 10l;
		
		ReplyVO vo = mapper.read(targetBno);
		
		vo.setReply("update Reply");
		
		int count = mapper.update(vo);
		
		log.info("update count: " + count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria(1, 10);
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 228L);
		
		replies.forEach(reply -> log.info(reply));
	}
	
	
}
