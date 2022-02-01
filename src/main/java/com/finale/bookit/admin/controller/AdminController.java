package com.finale.bookit.admin.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finale.bookit.admin.model.service.AdminService;
import com.finale.bookit.admin.model.vo.AdminInquire;
import com.finale.bookit.admin.model.vo.Chart;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	
	
	
	@GetMapping("/selectChartDay")
	@ResponseBody
	public List<Chart> selectChartDay(@RequestParam String month,Model model) {
		

		List<Chart> chartDay = adminService.selectChartDay(month);
		
		log.debug("chartDay = {}",chartDay);
		
		return chartDay;
		
	}
	@GetMapping("/selectChartMonth")
	@ResponseBody
	public String selectChartMonth(@RequestParam String category,Model model) {
		String month = "month";
		log.debug("category = {}",category);
		if(category.equals(month)) {
			model.addAttribute("category", month);
		};
		
		return category;
		
	}
	
	@GetMapping("/admin.do")
	public void adminPage() {}
	
	@GetMapping("/chart.do")
	public void chart(Model model) {
		
		List<Chart> chart = adminService.selectChart();
		int[] arr = new int[chart.size()];
		for(int i = 0 ; i < chart.size(); i++) {
			arr[i] = chart.get(i).getCount();
		}
		
		model.addAttribute("arr", arr);
		model.addAttribute("size", chart.size());
		
		
	}

	// 관리자 답변 등록
	@PostMapping("/inquireAdminReply.do")
	public String inquireAdminReply(RedirectAttributes redirectAttr, AdminInquire adminInquire) {
		int result = adminService.insertAdminReply(adminInquire);
		log.debug("result = {}", result);
		redirectAttr.addFlashAttribute("msg", result > 0 ? "답변이 등록되었습니다." : "다시 시도하세요.");

		return "redirect:/inquire/inquireDetail.do?no=" + adminInquire.getInquireNo();
	}
	
	// 신고 상태 변경(승인 = 1, 반려 = 2)
	@PostMapping("/reportUpdateCondition.do")
	public String reportUpdateCondition(@RequestParam int condition, @RequestParam int no, RedirectAttributes redirectAttr) {
		Map<String, Object> param = new HashMap<>();
		param.put("condition", condition);
		param.put("no", no);
		
		int result = adminService.updateCondition(param);
		log.debug("result = {}", result);
		if(condition > 1)
			redirectAttr.addFlashAttribute("msg", result > 0 ? "신고가 반려되었습니다." : "다시 시도하세요.");
		else
			redirectAttr.addFlashAttribute("msg", result > 0 ? "신고가 접수되었습니다." : "다시 시도하세요.");
		
		return "redirect:/report/reportList.do";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}