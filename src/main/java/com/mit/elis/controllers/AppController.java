package com.mit.elis.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Enumeration;
import java.util.regex.Pattern;
import org.springframework.ui.Model;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

// import com.sun.org.apache.xerces.internal.impl.dv.util.HexBin;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.mit.elis.class_common.Ws_url_config;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import ch.qos.logback.core.boolex.Matcher;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ws.casemgt.Ws_client_application;
import ws.casemgt.cls_casemgt;
import ws.casemgt.cls_general_query;
import ws.casemgt.ws_professional_portal;
import ws.csaumgt.ws_baby_steps;
import ws.rentmgt.Ws_rent_mgt;
import ws.users.Ws_users;

@Controller
public class AppController {
	@Autowired
	private Ws_url_config cls_url_config;
	// Ws_users cls_users = new Ws_users();

	cls_general_query general_q_cl = new cls_general_query();
	Ws_client_application user_web_service = new Ws_client_application();
	Ws_users cls_users = new Ws_users();
	cls_casemgt casemagt_cl = new cls_casemgt();
	cls_casemgt casemgt_cl = new cls_casemgt();
	ws_baby_steps baby_step_cl = new ws_baby_steps();
	Ws_rent_mgt rent_mgt_service = new Ws_rent_mgt();

	Pattern macpt = null;

	private String getMac(String ip) {

		// Find OS and set command according to OS
		String OS = System.getProperty("os.name").toLowerCase();
		System.out.println(OS);
		//System.out.println(ip);

		String[] cmd;
		if (OS.contains("win")) {
			// Windows
			macpt = Pattern
					.compile("[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+");
			String[] a = { "arp", "-a", ip };
			cmd = a;
		} else {
			// Mac OS X, Linux
			macpt = Pattern
					.compile("[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+");
			String[] a = { "arp", ip };
			cmd = a;
		}

		try {
			// Run command
			Process p = Runtime.getRuntime().exec(cmd);
			p.waitFor();
			// read output with BufferedReader
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					p.getInputStream()));
			String line = reader.readLine();
			// Loop trough lines
			while (line != null) {
				java.util.regex.Matcher m = macpt.matcher(line);
				// when Matcher finds a Line then return it as result
				if (m.find()) {
					System.out.println("Found");
					System.out.println("MAC: " + m.group(0));
					return m.group(0);
				}

				line = reader.readLine();
			}

		} catch (IOException e1) {
			e1.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		// Return empty string if no MAC is found
		return "";
	}

	public String getMacAddress() throws Exception {
		String macAddress = null;
		String command = "ifconfig";
	
		String osName = System.getProperty("os.name");
		System.out.println("Operating System is " + osName);
	
		if (osName.startsWith("Windows")) {
			command = "ipconfig /all";
		} else if (osName.startsWith("Linux") || osName.startsWith("Mac") || osName.startsWith("HP-UX")
				|| osName.startsWith("NeXTStep") || osName.startsWith("Solaris") || osName.startsWith("SunOS")
				|| osName.startsWith("FreeBSD") || osName.startsWith("NetBSD")) {
			command = "ifconfig -a";
		} else if (osName.startsWith("OpenBSD")) {
			command = "netstat -in";
		} else if (osName.startsWith("IRIX") || osName.startsWith("AIX") || osName.startsWith("Tru64")) {
			command = "netstat -ia";
		} else if (osName.startsWith("Caldera") || osName.startsWith("UnixWare") || osName.startsWith("OpenUNIX")) {
			command = "ndstat";
		} else {// Note: Unsupported system.
			throw new Exception("The current operating system '" + osName + "' is not supported.");
		}
	
		@SuppressWarnings("deprecation")
		Process pid = Runtime.getRuntime().exec(command);
		BufferedReader in = new BufferedReader(new InputStreamReader(pid.getInputStream()));
		Pattern p = Pattern.compile("([\\w]{1,2}(-|:)){5}[\\w]{1,2}");
		while (true) {
			String line = in.readLine();
			System.out.println("line " + line);
			if (line == null)
				break;
	
			java.util.regex.Matcher m = p.matcher(line);
			if (m.find()) {
				macAddress = m.group();
				break;
			}
		}
		in.close();
		return macAddress;
	}

	public String ipAddr()
	{

		try {
			Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
			while (networkInterfaces.hasMoreElements()) {
			   NetworkInterface networkInterface = networkInterfaces.nextElement();
			   if (!networkInterface.isUp()) {
				  continue;
			   }
			   if (networkInterface.isLoopback()) {
				  continue;
			   }
			   Enumeration<InetAddress> addresses = networkInterface.getInetAddresses();
			   while (addresses.hasMoreElements()) {
				  InetAddress address = addresses.nextElement();
				  if (address.isLinkLocalAddress()) {
					 continue;
				  }
				  if (address.isSiteLocalAddress()) {
						System.out.println("IP address: " + address.getHostAddress());
						return address.getHostAddress();
				  }
			   }
			}
		 } catch (SocketException ex) {
			ex.printStackTrace();
		 }
		return null;
	}

	// @RequestMapping
	// @PostMapping("/")
	// public String home(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
	// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
	// }
@GetMapping("/")
	public String gethome(Model model, HttpServletRequest request,
			HttpServletResponse response) throws JSONException {
		return renderGraReports(model, request);
	}






		   @RequestMapping("/gra_report")
	@GetMapping
	public String GraReports(Model model, HttpServletRequest request, HttpServletResponse response) throws JSONException {

        // String servletName = request.getServletPath();
		// servletName = servletName.replace("/", "");
		// String assigenedmenus = (String) session.getAttribute("menus_com");
		// boolean isFound = false;
		// try {
		// 	isFound = assigenedmenus.contains(servletName); // true
		// } catch (Exception e) {
		// }

        // if (!isFound) {
		// 	request.setAttribute("login", "Please this is not alllowed");
		// 	//
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";
		// }

		// if (request.getRequestedSessionId() != null && !request.isRequestedSessionIdValid()) {
		// 	// Session is expired
		// 	request.setAttribute("login", "sessionout");
		// 	System.out.println("If Not success");
		// 	 model.addAttribute("content", "../auth/login.jsp");return "layouts/guest";

		// }

		return renderGraReports(model, request);
	}

	private String renderGraReports(Model model, HttpServletRequest request)
			throws JSONException {
		String jsonArrayContent_office_region = user_web_service
							.select_lc_office_regions_districts_all(cls_url_config.getWeb_service_url_ser(),
									cls_url_config.getWeb_service_url_ser_api_key());

        JSONObject office_region_obj = new JSONObject(jsonArrayContent_office_region);
        String office_region_list = office_region_obj.get("data").toString();

        Gson googleJson_officeregions = new Gson();
        ArrayList javaArrayListFromGSON_officeregions = googleJson_officeregions.fromJson(office_region_list,
                ArrayList.class);
        request.setAttribute("officeregionlist", javaArrayListFromGSON_officeregions);

		String jsonArrayContent_region_list = casemagt_cl.get_region_list(
				cls_url_config.getWeb_service_url_ser(), cls_url_config.getWeb_service_url_ser_api_key());
		JSONObject region_list_obj = new JSONObject(jsonArrayContent_region_list);
		String region_list = region_list_obj.get("data").toString();
		Gson googleJson_regions = new Gson();
        ArrayList javaArrayListFromGSON_regions = googleJson_regions.fromJson(region_list, ArrayList.class);
        request.setAttribute("regionlist", javaArrayListFromGSON_regions);


		request.setAttribute("page_name", "gra_report");
		model.addAttribute("content", "../pages/client_application/gra_reports.jsp");
		return "layouts/app";
    }
	
	
}
