package com.dfyy.b2b.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ViewUtils {
	/**
	 * 以友好的方式显示时间
	 * 
	 * @param sdate
	 * @return
	 */
	public static String getStandardDate(Date time) {
		String ftime = "";
		Calendar cal = Calendar.getInstance();

		SimpleDateFormat dateFormater2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 判断是否是同一天
		String curDate = dateFormater2.format(cal.getTime());
		String paramDate = dateFormater2.format(time);
		if (curDate.subSequence(0, curDate.indexOf(" ")).equals(paramDate.subSequence(0, paramDate.indexOf(" ")))) {
			if ((cal.getTimeInMillis() - time.getTime()) / 60000 < 1) {
				return "刚刚";
			}
			int hour = (int) ((cal.getTimeInMillis() - time.getTime()) / 3600000);
			if (hour == 0)
				ftime = Math.max((cal.getTimeInMillis() - time.getTime()) / 60000, 1) + "分钟前";
			else
				ftime = hour + "小时前";
			return ftime;
		}

		long lt = time.getTime() / 86400000;
		long ct = cal.getTimeInMillis() / 86400000;
		int days = (int) (ct - lt);
		if (days == 0) {
			int hour = (int) ((cal.getTimeInMillis() - time.getTime()) / 3600000);
			if (hour == 0) {
				if ((cal.getTimeInMillis() - time.getTime()) / 60000 < 1) {
					return "刚刚";
				}
				ftime = Math.max((cal.getTimeInMillis() - time.getTime()) / 60000, 1) + "分钟前";
			} else
				ftime = hour + "小时前";
		} else if (days == 1) {
			ftime = "昨天";
		} else if (days == 2) {
			ftime = "前天";
		} else if (days > 2 && days <= 10) {
			ftime = days + "天前";
		} else if (days > 10) {
			ftime = dateFormater2.format(time);
		}
		return ftime;
	}

	public static String getLevelName(int levelid) {
		switch (levelid) {
		case 1:
			return "农友";
		case 2:
			return "达人";
		case 3:
			return "农资店";
		case 4:
			return "专家";
		case 6:
			return "菜商";
		default:
			return "其他";
		}
	}
}
