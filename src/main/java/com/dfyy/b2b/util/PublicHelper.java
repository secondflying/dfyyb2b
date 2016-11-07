package com.dfyy.b2b.util;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.WritableRaster;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

public class PublicHelper {
	static Logger logger = Logger.getLogger(PublicHelper.class.getName());

	// public static String encryptPassword(Integer uid, String password) {
	// return DigestUtils.sha1Hex(StringUtils.join(new String[] {
	// uid.toString(), password }));
	// }

	// public static String encryptUser(Integer uid, String password, Integer
	// utype) {
	// String token = encryptPassword(uid, password);
	// return StringUtils.join(new String[] { uid.toString(), token,
	// utype.toString() }, '|');
	// }


	/**
	 * 将原图进行压缩存储主要用于管理端上传的图片
	 * 
	 * @param upImg
	 * @param oldName
	 * @param folder
	 * @return
	 * @throws IOException
	 */
	public static String saveImage1(InputStream upImg, String format, String folder) throws IOException {

		ByteArrayOutputStream buffer = new ByteArrayOutputStream();
		int nRead;
		byte[] data = new byte[16384];
		while ((nRead = upImg.read(data, 0, data.length)) != -1) {
			buffer.write(data, 0, nRead);
		}
		buffer.flush();
		byte[] bs = buffer.toByteArray();

		if (bs.length > 0) {
			
			String ending = "jpg";
			if(format != null && format.equalsIgnoreCase("png")){
				ending = "png";
			}

			BufferedImage bi = ImageIO.read(new ByteArrayInputStream(bs));

			String id = UUID.randomUUID().toString();
			String image = id + "." + ending;

			String tmpPath;
			tmpPath = System.getProperty("java.io.tmpdir");

			File originFile = new File(tmpPath + image);
			if (originFile.isDirectory()) {
				ImageIO.write(bi, ending, originFile);
			} else {
				originFile.mkdirs();
				ImageIO.write(bi, ending, originFile);
			}

			// 生成缩小的图片
			File smallFile = saveSmallImage(bi, tmpPath + "small" + image);

			// 将图片保存
			originFile.renameTo(new File(
					PublicConfig.getImagePath() + folder + File.separator + "big" + File.separator, image));
			smallFile.renameTo(new File(PublicConfig.getImagePath() + folder + File.separator + "small"
					+ File.separator, image));

			return image;
		}
		return null;
	}

	public static void deleteImage(String oldName, String folder) {
		if (!StringUtils.isBlank(oldName)) {

			File oldbigFile = new File(PublicConfig.getImagePath() + folder + File.separator + "big" + File.separator,
					oldName);
			File oldsmallFile = new File(PublicConfig.getImagePath() + folder + File.separator + "small"
					+ File.separator, oldName);

			if (oldbigFile.isFile() && oldbigFile.exists()) {
				oldbigFile.delete();
			}

			if (oldsmallFile.isFile() && oldsmallFile.exists()) {
				oldsmallFile.delete();
			}
		}
	}

	public static boolean findcodefile(File codeFile) {

		if (codeFile.isFile() && codeFile.exists()) {
			return true;
		} else {
			return false;
		}

	}

	public static File getCodeFile(String filename) {

		File oldbigFile = new File(PublicConfig.getImagePath() + "apps" + File.separator + filename);
		//
		// File oldbigFile = new File(PublicConfig.getImagePath()
		// +"apps\\", filename);

		return oldbigFile;

	}

	private static File saveScaledImage(BufferedImage bi, int width, int height, String filePath) throws IOException {
		Image bigImage = bi.getScaledInstance(width, height, BufferedImage.SCALE_SMOOTH);
		BufferedImage big = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		big.createGraphics().drawImage(bigImage, 0, 0, null);
		File bigFile = new File(filePath);
		ImageIO.write(big, "jpg", bigFile);
		return bigFile;
	}

	private static File saveSmallImage(BufferedImage bi, String filePath) throws IOException {
		int width = bi.getWidth() / 2;
		int height = bi.getHeight() / 2;
		Image smallImage = bi.getScaledInstance(width, height, BufferedImage.SCALE_SMOOTH);
		BufferedImage smallBufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		smallBufferedImage.createGraphics().drawImage(smallImage, 0, 0, null);
		File smallFile = new File(filePath);
		ImageIO.write(smallBufferedImage, "jpg", smallFile);
		return smallFile;
	}

	/**
	 * 将源图片的BufferedImage对象生成缩略图
	 * 
	 * @param source
	 *            源图片的BufferedImage对象
	 * @param targetW
	 *            缩略图的宽
	 * @param targetH
	 *            缩略图的高
	 * @return
	 */
	private static BufferedImage resize(BufferedImage source, int targetW, int targetH) {
		int type = source.getType();
		BufferedImage target = null;
		double sx = (double) targetW / source.getWidth();
		double sy = (double) targetH / source.getHeight();
		if (sx > sy) {
			sx = sy;
			targetW = (int) (sx * source.getWidth());
		} else {
			sy = sx;
			targetH = (int) (sy * source.getHeight());
		}

		if (type == BufferedImage.TYPE_CUSTOM) {
			ColorModel cm = source.getColorModel();
			WritableRaster raster = cm.createCompatibleWritableRaster(targetW, targetH);
			boolean alphaPremultiplied = cm.isAlphaPremultiplied();
			target = new BufferedImage(cm, raster, alphaPremultiplied, null);
		} else {
			target = new BufferedImage(targetW, targetH, type);
		}
		Graphics2D g = target.createGraphics();
		g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
		g.drawRenderedImage(source, AffineTransform.getScaleInstance(sx, sy));
		g.dispose();
		return target;
	}

	public static String convertDatestringFormat(String dateString) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat format2 = new SimpleDateFormat("MM/dd/yyyy");
		String dString = "";
		try {
			Date date = format.parse(dateString);
			dString = format2.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dString;
	}

	public static String convertYearstringFormat(String dateString) {
		DateFormat format = new SimpleDateFormat("yyyy-MM");
		DateFormat format2 = new SimpleDateFormat("yyyy");
		String dString = "";
		try {
			Date date = format.parse(dateString);
			dString = format2.format(date);
		} catch (ParseException e) {
		}
		return dString;
	}

	@SuppressWarnings("deprecation")
	public static int dateSpace(Date date) {
		Date now = new Date();
		return now.getDay() - date.getDay();
	}

	public static double distance(double x1, double y1, double x2, double y2) {

		double _x = Math.abs(x1 - x2);
		double _y = Math.abs(y1 - y2);
		return Math.sqrt(_x * _x + _y * _y);

	}

	public static String game(int count) {
		StringBuffer sb = new StringBuffer();
		String str = "0123456789";
		Random r = new Random();
		for (int i = 0; i < count; i++) {
			int num = r.nextInt(str.length());
			sb.append(str.charAt(num));
			str = str.replace((str.charAt(num) + ""), "");
		}
		return sb.toString();
	}

	public static String generateCode() {
		StringBuffer sb = new StringBuffer();
		String str = "ABCDEFGHJKLMNPQRSTUVWXYZ";
		Random r = new Random();
		for (int i = 0; i < 4; i++) {
			int num = r.nextInt(str.length());
			sb.append(str.charAt(num));
		}
		return sb.toString();
	}

	public static boolean isMobile(String phone) {
		Pattern p = Pattern.compile("^((13[0-9])|(15[0-9])|(18[0-9])|(17[0-9]))\\d{8}$");
		Matcher m = p.matcher(phone);
		return m.matches();
	}
	
	
	public static String filterEmoji(String source) {
		if (StringUtils.isNotBlank(source)) {
			return source.replaceAll("[\\ud800\\udc00-\\udbff\\udfff\\ud800-\\udfff]", "");
		} else {
			return source;
		}
	}

	public static void main(String[] args) {
		System.out.println(isMobile("15908034369"));
		System.out.println(isMobile("17865673382"));
		System.out.println(isMobile("17065673382"));
		System.out.println(isMobile("13385363102"));
		System.out.println(isMobile("15964585519"));
		System.out.println(isMobile("15664585519"));
		System.out.println(isMobile("18265652248"));
		System.out.println(isMobile("18165652248"));
		System.out.println(isMobile("18065652248"));
		System.out.println(isMobile("1806565224"));

		try {
			String text = "This is a smiley \uD83C\uDFA6 face\uD860\uDD5D \uD860\uDE07 \uD860\uDEE2 \uD863\uDCCA \uD863\uDCCD \uD863\uDCD2 \uD867\uDD98 ";
			System.out.println(text);
			System.out.println(text.length());
//			System.out.println(text.replaceAll(
//					"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]", "*"));
			System.out.println(filterEmoji(text));
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public static double correctTo(double d){
		BigDecimal b = new BigDecimal(d);  
		return b.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
	}
}