package org.zerock.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mvc;
	
	@Before
	public void setup() {
		this.mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception {
		
		log.info(
				mvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView()
				.getViewName()
		);
	}
	
	@Test
	public void testRegister() throws Exception {
		
		String resultPage = mvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer", "user00")
				).andReturn().getModelAndView().getViewName();
		
		log.info("register.." + resultPage);
	}
	
	@Test
	public void testGet() throws Exception {
		
		log.info(mvc.perform(MockMvcRequestBuilders
				.get("/board/get")
				.param("bno","5"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
	}
	
	@Test
	public void testModify() throws Exception {
		
		String resultPage = mvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", "4")
				.param("title", "테스트 수정 제목")
				.param("content", "테스트 수정 내용")
				.param("writer", "user01")
				).andReturn().getModelAndView().getViewName();
		
		log.info("modify.." + resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		
		String resultPage = mvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "4")
				).andReturn().getModelAndView().getViewName();
		
		log.info("remove.." + resultPage);
	}
	
	@Test
	public void testListPaging() throws Exception {
		
		log.info(mvc.perform(
					MockMvcRequestBuilders.get("/board/list")
					.param("pageNum", "2")
					.param("amount", "50"))
					.andReturn().getModelAndView().getModelMap());
		
	}
		
}
