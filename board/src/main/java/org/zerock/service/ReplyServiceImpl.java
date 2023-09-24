package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper2;
	
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public int register(ReplyVO vo) {
		
		log.info("register.." + vo);
		
		mapper2.updateReplyCnt(vo.getBno(), 1);
		int insert = mapper.insert(vo);
		
		return insert;
	}

	@Override
	public ReplyVO get(long rno) {
		
		log.info("get.." + rno);
		
		ReplyVO read = mapper.read(rno);
		
		return read;
	}
	
	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify.." + vo);
		
		int update = mapper.update(vo);
		
		return update;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public int remove(long rno) {
		
		log.info("remove.." + rno);
		ReplyVO vo = mapper.read(rno);
		
		mapper2.updateReplyCnt(vo.getBno(), -1);
		int delete = mapper.delete(rno);
		
		return delete;
	}

//	@Override
//	public List<ReplyVO> getList(Criteria cri, long bno) {
//		
//		log.info("getList.." + bno);
//		
//		List<ReplyVO> getList = mapper.getListWithPaging(cri, bno);
//		
//		return getList;
//	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, long bno) {
		
		log.info("getListPage.." + bno);
		
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

	
}
