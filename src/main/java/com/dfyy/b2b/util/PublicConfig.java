package com.dfyy.b2b.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PublicConfig {

	private static Properties prop;
	static {
		try {
			InputStream in = PublicConfig.class.getResourceAsStream("/config.properties");
			prop = new Properties();
			prop.load(in);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getImagePath() {
		return prop.getProperty("imagePath");
	}

	public static String getImageUrl() {
		return prop.getProperty("imageUrl");
	}

	public static String getEmail() {
		return prop.getProperty("email");
	}

	public static String getMailuser() {
		return prop.getProperty("mailuser");
	}

	public static String getMailpass() {
		return prop.getProperty("mailpass");
	}

	public static String getMailhost() {
		return prop.getProperty("mailhost");
	}

	public static String getSmsaddress() {
		return prop.getProperty("smsaddress");
	}

	public static String getSmsaddress2() {
		return prop.getProperty("smsaddress2");
	}

	public static boolean isCheckToken() {
		return prop.getProperty("checkToken") != null && Boolean.parseBoolean(prop.getProperty("checkToken"));
	}
}