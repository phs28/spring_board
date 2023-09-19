package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper mapper;
	@Autowired
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardVO board) {

		log.info("register......" + board);

		mapper.insertSelectKey(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {

			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(long bno) {
		log.info(log);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO vo) {
		
		int up = mapper.update(vo);
		if(up == 1) {
			return true;
		}
		
		log.info("modify.." + up);
		
		return false;
	}

	@Override
	public boolean remove(long bno) {
		
		int re = mapper.delete(bno);
		if(re == 1) {
			return true;
		}
		
		return false;
	}

//	@Override
//	public List<BoardVO> getList() {
//		
//		return mapper.getList();
//	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		
		log.info("Pageing.." + cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		log.info("Total.." + cri);
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno" + bno);
		
		return attachMapper.findByBno(bno);
	}
	
	
}
