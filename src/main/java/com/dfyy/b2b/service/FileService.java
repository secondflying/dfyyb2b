package com.dfyy.b2b.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.util.PublicHelper;

@Service
@Transactional
public class FileService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	public String saveImage(String format, String folder, InputStream upImg) {

		String image = null;
		try {
			image = PublicHelper.saveImage1(upImg, format, folder);
		} catch (IOException e) {
			logger.error("上传文件失败，文件名：{},目录:{}", format, folder);
		}
		return image;
	}

	public void deleteImage(String name, String folder) {
		PublicHelper.deleteImage(name, folder);
	}

	public void cutImage(String name, String folder, String targetFolder) {
		File originFile = new File(PublicConfig.getImagePath() + folder + File.separator + "big" + File.separator, name);
		File smallFile = new File(PublicConfig.getImagePath() + folder + File.separator + "small" + File.separator,
				name);

		File originFile2 = new File(PublicConfig.getImagePath() + targetFolder + File.separator + "big"
				+ File.separator, name);
		File smallFile2 = new File(PublicConfig.getImagePath() + targetFolder + File.separator + "small"
				+ File.separator, name);

		if (originFile.exists()) {
			originFile.renameTo(originFile2);
		}
		if (smallFile.exists()) {
			smallFile.renameTo(smallFile2);
		}
	}

}
