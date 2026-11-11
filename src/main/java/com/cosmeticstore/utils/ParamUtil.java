package com.cosmeticstore.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.http.HttpServletRequest;

public class ParamUtil {
	// Trả về giá trị kiểu String
	public static String getString(HttpServletRequest request, String name) {
		try {
			return request.getParameter(name);
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}

	// Trả về giá trị kiểu int
	public static int getInt(HttpServletRequest request, String name) {
		try {
			return Integer.parseInt(request.getParameter(name));
		} catch (Exception e) {
			// TODO: handle exception
			return 0;
		}

	}

	// Trả về giá trị kiểu Date
	public static Date getDate(HttpServletRequest request, String name, String pattern) {
		try {
			String value = request.getParameter(name);
			SimpleDateFormat sdf = new SimpleDateFormat(pattern);
			return sdf.parse(value);
		} catch (Exception e) {
			return null;
		}
	}

	// Lấy double
	public static double getDouble(HttpServletRequest request, String name) {
		try {
			return Double.parseDouble(request.getParameter(name));
		} catch (Exception e) {
			return 0.0;
		}
	}

	// Lấy boolean
	public static boolean getBoolean(HttpServletRequest request, String name) {
		try {
			return Boolean.parseBoolean(request.getParameter(name));
		} catch (Exception e) {
			return false;
		}
	}

}