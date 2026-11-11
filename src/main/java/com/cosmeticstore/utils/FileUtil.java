package com.cosmeticstore.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class FileUtil {

	// Thư mục lưu ảnh
	private static final String UPLOAD_FOLDER = "/uploads/";

	/**
	 * Upload file vào thư mục uploads
	 *
	 * @param request  HttpServletRequest
	 * @param partName tên của input file trong form
	 * @return tên file đã lưu hoặc null nếu upload thất bại
	 * @throws IOException
	 */
	public static String upload(HttpServletRequest request, String partName) throws IOException, ServletException {

		Part part = request.getPart(partName);

		if (part == null) {
			return null;
		}

		String fileName = part.getSubmittedFileName();

		if (fileName == null || fileName.isBlank()) {
			return null;
		}

		// Lấy phần mở rộng của file (.jpg, .png,...)
		String extension = fileName.substring(fileName.lastIndexOf("."));

		// Đặt tên file mới để tránh trùng
		String newFileName = System.currentTimeMillis() + extension;

		// Đường dẫn thư mục upload
		String uploadPath = request.getServletContext().getRealPath(UPLOAD_FOLDER);

		// Nếu thư mục chưa tồn tại thì tạo
		Files.createDirectories(Path.of(uploadPath));

		// Đường dẫn đầy đủ của file
		String filePath = uploadPath + File.separator + newFileName;

		// Lưu file
		part.write(filePath);

		return newFileName;
	}

	/**
	 * Xóa file trong thư mục uploads
	 *
	 * @param request  HttpServletRequest
	 * @param fileName tên file cần xóa
	 * @return true nếu xóa thành công
	 */
	public static boolean delete(HttpServletRequest request, String fileName) {

		if (fileName == null || fileName.isBlank()) {
			return false;
		}

		try {

			String uploadPath = request.getServletContext().getRealPath(UPLOAD_FOLDER);

			File file = new File(uploadPath, fileName);

			if (file.exists() && file.isFile()) {
				return file.delete();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}