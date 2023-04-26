package sitemesh;
/*
 * sitemesh 기능 : 화면에 layout을 코딩한 jsp를 페이지에 적용
 * addDecoratorPath("/model1/member/*","/layout/layout.jsp")
 *      url :/model1/member/로 시작하는 모든 요청 url 
 *      layout : 응답 시 layout용으로 사용되는 jsp 페이지 설정 
 *       
 *      addExcludedPath("/model1/member/id*") 
 *         url : /model1/member/id로 시작하는 모든 요청 시 layout제외
 * 
 * 
 */

import javax.servlet.annotation.WebFilter;	

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;


@WebFilter("/*") //  /* : 모든 요청이 들어오면 레이아웃을 붙여줘


	public class SiteMeshFilter extends ConfigurableSiteMeshFilter {
		 @Override
		 protected void applyCustomConfiguration
		                    (SiteMeshFilterBuilder  builder) {
			   builder.addDecoratorPath("/model1/*","/layout/layout.jsp")
			   .addExcludedPath("/model1/member/id*")
			   .addExcludedPath("/model1/member/pw*")
			   .addExcludedPath("/model1/member/password*")
			   .addExcludedPath("/model1/member/picture*");
		 }
		 
	}


