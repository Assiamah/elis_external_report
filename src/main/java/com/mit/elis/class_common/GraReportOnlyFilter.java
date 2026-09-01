package com.mit.elis.class_common;

import java.io.IOException;
import java.util.Set;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/** Limits this deployment to the externally accessible GRA report feature. */
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class GraReportOnlyFilter extends OncePerRequestFilter {

	private static final String GRA_REPORT_REQUEST = "get_stampduty_gra_results";

	private static final Set<String> REPORT_ASSETS = Set.of(
			"/assets/images/NewLogo.jpg",
			"/assets/images/NewLogo.png",
			"/assets/libs/bootstrap/dist/css/bootstrap.min.css",
			"/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js",
			"/assets/libs/flatpickr/dist/flatpickr.min.css",
			"/assets/libs/flatpickr/dist/flatpickr.min.js");

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
			FilterChain filterChain) throws ServletException, IOException {
		String path = request.getRequestURI().substring(request.getContextPath().length());
		String method = request.getMethod();

		if (isReportPageRequest(path, method)
				|| isReportAssetRequest(path, method)
				|| isGraReportApiRequest(request, path, method)
				|| "/error".equals(path)) {
			filterChain.doFilter(request, response);
			return;
		}

		if ("GET".equals(method) || "HEAD".equals(method)) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			request.getRequestDispatcher("/WEB-INF/jsp/pages/client_application/gra_report_404.jsp")
					.forward(request, response);
			return;
		}

		response.setStatus(HttpServletResponse.SC_NOT_FOUND);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"error\":\"Not found\"}");
	}

	private boolean isReportPageRequest(String path, String method) {
		return ("GET".equals(method) || "HEAD".equals(method))
				&& ("/".equals(path) || "/gra_report".equals(path));
	}

	private boolean isReportAssetRequest(String path, String method) {
		return ("GET".equals(method) || "HEAD".equals(method)) && REPORT_ASSETS.contains(path);
	}

	private boolean isGraReportApiRequest(HttpServletRequest request, String path, String method) {
		return "POST".equals(method)
				&& "/reports_api".equals(path)
				&& GRA_REPORT_REQUEST.equals(request.getParameter("request_type"));
	}
}
