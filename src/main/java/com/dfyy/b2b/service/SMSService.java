package com.dfyy.b2b.service;

import java.net.URL;
import java.net.URLEncoder;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.dfyy.b2b.util.PublicConfig;
import com.easemob.server.example.httpclient.utils.HTTPClientUtils;

@Service
public class SMSService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public void sendsms(String phone, String code) {
		try {
			String content = URLEncoder.encode("尊敬的用户，您的验证码是：" + code + "。请不要把验证码泄露给其他人。如非本人操作，可不用理会！", "UTF-8");
			URL url = new URL(PublicConfig.getSmsaddress() + "&mobile=" + phone + "&content=" + content);
			HttpGet httpGet = new HttpGet(url.toURI());
			HttpClient httpClient = HTTPClientUtils.getClient(true);
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			if (null != entity) {
				String responsecontent = EntityUtils.toString(entity, "UTF-8");
				logger.info("互亿短信接口返回结果：{}", responsecontent);
			}

		} catch (Exception e) {
			logger.error("互亿短信接口报错", e);
		}
	}

	public void sendpass(String phone, String code) {
		try {
			String content = URLEncoder.encode("尊敬的用户，您的密码已经改为：" + code + "。请不要把密码泄露给其他人。登录后请及时修改密码。", "UTF-8");
			URL url = new URL(PublicConfig.getSmsaddress() + "&mobile=" + phone + "&content=" + content);
			HttpGet httpGet = new HttpGet(url.toURI());
			HttpClient httpClient = HTTPClientUtils.getClient(true);
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			if (null != entity) {
				String responsecontent = EntityUtils.toString(entity, "UTF-8");
				logger.info("互亿短信接口返回结果：{}", responsecontent);
			}

		} catch (Exception e) {
			logger.error("互亿短信接口报错", e);
		}
	}

	public void sendsms2(String phone, String code) {
		try {
			String content = URLEncoder.encode("【种好地】尊敬的用户，您的验证码是：" + code + "。请不要把验证码泄露给其他人。如非本人操作，可不用理会！", "UTF-8");
			URL url = new URL(PublicConfig.getSmsaddress2() + "&phone=" + phone + "&message=" + content);
			HttpGet httpGet = new HttpGet(url.toURI());
			HttpClient httpClient = HTTPClientUtils.getClient(true);
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			if (null != entity) {
				String responsecontent = EntityUtils.toString(entity, "UTF-8");
				logger.info("亿美短信接口返回结果：{}", responsecontent);
			}

		} catch (Exception e) {
			logger.error("亿美短信接口报错", e);
		}
	}

	public void sendpass2(String phone, String code) {
		try {
			String content = URLEncoder.encode("【种好地】尊敬的用户，您的密码已经改为：" + code + "。请不要把密码泄露给其他人。登录后请及时修改密码。", "UTF-8");
			URL url = new URL(PublicConfig.getSmsaddress2() + "&phone=" + phone + "&message=" + content);
			HttpGet httpGet = new HttpGet(url.toURI());
			HttpClient httpClient = HTTPClientUtils.getClient(true);
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			if (null != entity) {
				String responsecontent = EntityUtils.toString(entity, "UTF-8");
				logger.info("亿美短信接口返回结果：{}", responsecontent);
			}

		} catch (Exception e) {
			logger.error("亿美短信接口报错", e);
		}
	}

	public static void main(String[] args) {
		try {
			SMSService sms = new SMSService();
			sms.sendsms2("18611360504", "8888");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
