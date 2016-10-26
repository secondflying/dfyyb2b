package com.dfyy.b2b.service;

import java.net.URL;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.dfyy.b2b.util.MyConstants;
import com.easemob.server.example.comm.Constants;
import com.easemob.server.example.comm.HTTPMethod;
import com.easemob.server.example.httpclient.utils.HTTPClientUtils;
import com.easemob.server.example.httpclient.vo.EndPoints;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Service
public class EasemobService {

	private static Logger logger = LoggerFactory.getLogger(EasemobService.class);

	public String registUser(String phone, String password, String alias) {

		ObjectNode datanode = JsonNodeFactory.instance.objectNode();
		datanode.put("username", phone);
		datanode.put("password", password);
		datanode.put("nickname", alias);
		ObjectNode createNewIMUserSingleNode = createNewIMUserSingle(datanode);

		if (null != createNewIMUserSingleNode) {
			JsonNode statusNode = createNewIMUserSingleNode.findValue("statusCode");
			int statuscode = statusNode.asInt();
			if (statuscode == 200) {
				return "ok";
			} else {
				String errorString = createNewIMUserSingleNode.findValue("exception").asText();
				return errorString;
			}

		} else {
			return "注册环信用户失败！";
		}

	}

	/**
	 * 注册IM用户[批量]
	 * 
	 * 给指定Constants.APPKEY创建一批用户
	 * 
	 * @param dataArrayNode
	 * @return
	 */
	public ObjectNode createNewIMUserBatch(ArrayNode dataArrayNode) {

		ObjectNode objectNode = MyConstants.factory.objectNode();

		// check Constants.APPKEY format
		if (!HTTPClientUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", Constants.APPKEY)) {

			objectNode.put("message", "Bad format of Constants.APPKEY");

			return objectNode;
		}

		if (dataArrayNode.isArray()) {
			for (JsonNode jsonNode : dataArrayNode) {
				if (null != jsonNode && !jsonNode.has("username")) {

					objectNode.put("message", "Property that named username must be provided .");

					return objectNode;
				}
				if (null != jsonNode && !jsonNode.has("password")) {

					objectNode.put("message", "Property that named password must be provided .");

					return objectNode;
				}
			}
		}

		try {

			objectNode = HTTPClientUtils.sendHTTPRequest(EndPoints.USERS_URL, MyConstants.credential, dataArrayNode,
					HTTPMethod.METHOD_POST);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return objectNode;
	}

	/**
	 * 注册IM用户[批量生成用户然后注册]
	 * 
	 * 给指定Constants.APPKEY创建一批用户
	 * 
	 * @param usernamePrefix
	 *            生成用户名的前缀
	 * @param perNumber
	 *            批量注册时一次注册的数量
	 * @param totalNumber
	 *            生成用户注册的用户总数
	 * @return
	 */
	public ObjectNode createNewIMUserBatchGen(ArrayNode userArrayNode, Long perNumber, Long totalNumber) {
		ObjectNode objectNode = MyConstants.factory.objectNode();

		if (totalNumber == 0 || perNumber == 0) {
			return objectNode;
		}
		if (totalNumber <= perNumber) {
			objectNode = createNewIMUserBatch(userArrayNode);
		} else {

			ArrayNode tmpArrayNode = MyConstants.factory.arrayNode();

			for (int i = 0; i < userArrayNode.size(); i++) {
				tmpArrayNode.add(userArrayNode.get(i));
				// 300 records on one migration
				if ((i + 1) % perNumber == 0) {
					objectNode = createNewIMUserBatch(tmpArrayNode);

					tmpArrayNode.removeAll();
					continue;
				}

				// the rest records that less than the times of 300
				if (i > (userArrayNode.size() / perNumber * perNumber - 1)) {
					objectNode = createNewIMUserBatch(tmpArrayNode);

					tmpArrayNode.removeAll();
				}
			}
		}

		return objectNode;
	}

	public String login(String username, String password) {

		ObjectNode datanode = JsonNodeFactory.instance.objectNode();
		datanode.put("username", username);
		datanode.put("password", password);
		ObjectNode imUserLoginNode = imUserLogin(datanode.get("username").asText(), datanode.get("password").asText());

		if (null != imUserLoginNode) {

			JsonNode statusNode = imUserLoginNode.findValue("statusCode");
			int statuscode = statusNode.asInt();
			if (statuscode == 200) {
				return "ok";
			} else {
				String errorString = imUserLoginNode.findValue("error_description").asText();
				return errorString;
			}

		} else {
			return "登录环信服务失败！";
		}

	}

	/**
	 * 修改密码
	 * 
	 * @param user
	 * @param newpass
	 * @return
	 */
	public String modifyPassword(String phone, String newpass) {
		ObjectNode json2 = JsonNodeFactory.instance.objectNode();
		json2.put("newpassword", newpass);
		ObjectNode modifyIMUserPasswordWithAdminTokenNode = modifyIMUserPasswordWithAdminToken(phone, json2);
		ObjectNode imUserLoginNode2 = imUserLogin(phone, json2.get("newpassword").asText());
		return "ok";
	}

	public boolean deleteUser(String phone) {
		try {
			deleteIMUserSingle(phone);
			return true;
		} catch (Exception e) {
			logger.error("删除用户失败：", e);
			return false;
		}
	}

	/**
	 * 注册IM用户[单个]
	 * 
	 * 给指定Constants.APPKEY创建一个新的用户
	 * 
	 * @param dataNode
	 * @return
	 */
	private ObjectNode createNewIMUserSingle(ObjectNode dataNode) {
		ObjectNode objectNode = MyConstants.factory.objectNode();

		// check Constants.APPKEY format
		if (!HTTPClientUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", Constants.APPKEY)) {
			objectNode.put("message", "Bad format of Constants.APPKEY");
			return objectNode;
		}

		objectNode.removeAll();
		// check properties that must be provided
		if (null != dataNode && !dataNode.has("username")) {
			objectNode.put("message", "Property that named username must be provided .");
			return objectNode;
		}
		if (null != dataNode && !dataNode.has("password")) {
			objectNode.put("message", "Property that named password must be provided .");
			return objectNode;
		}

		try {
			objectNode = HTTPClientUtils.sendHTTPRequest(EndPoints.USERS_URL, MyConstants.credential, dataNode,
					HTTPMethod.METHOD_POST);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return objectNode;
	}

	/**
	 * IM用户登录
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public static ObjectNode imUserLogin(String username, String password) {
		ObjectNode objectNode = MyConstants.factory.objectNode();
		// check appKey format
		if (!HTTPClientUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", Constants.APPKEY)) {
			objectNode.put("message", "Bad format of Appkey");
			return objectNode;
		}
		if (org.apache.commons.lang.StringUtils.isBlank(username)) {
			objectNode.put("message", "Your username must be provided，the value is username or uuid of imuser.");
			return objectNode;
		}
		if (org.apache.commons.lang.StringUtils.isBlank(password)) {
			objectNode.put("message", "Your password must be provided，the value is username or uuid of imuser.");
			return objectNode;
		}

		try {
			ObjectNode dataNode = MyConstants.factory.objectNode();
			dataNode.put("grant_type", "password");
			dataNode.put("username", username);
			dataNode.put("password", password);

			objectNode = HTTPClientUtils.sendHTTPRequest(EndPoints.TOKEN_APP_URL, null, dataNode,
					HTTPMethod.METHOD_POST);

		} catch (Exception e) {
			throw new RuntimeException("Some errors ocuured while fetching a token by usename and passowrd .");
		}

		return objectNode;
	}

	/**
	 * 重置IM用户密码 提供管理员token
	 * 
	 * @param userPrimaryKey
	 * @param dataObjectNode
	 * @return
	 */
	public static ObjectNode modifyIMUserPasswordWithAdminToken(String userPrimaryKey, ObjectNode dataObjectNode) {
		ObjectNode objectNode = MyConstants.factory.objectNode();

		// check Constants.APPKEY format
		if (!HTTPClientUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", Constants.APPKEY)) {
			objectNode.put("message", "Bad format of Constants.APPKEY");
			return objectNode;
		}

		if (StringUtils.isEmpty(userPrimaryKey)) {
			objectNode.put("message",
					"Property that named userPrimaryKey must be provided，the value is username or uuid of imuser.");
			return objectNode;
		}

		if (null != dataObjectNode && !dataObjectNode.has("newpassword")) {
			objectNode.put("message", "Property that named newpassword must be provided .");
			return objectNode;
		}

		try {
			URL modifyIMUserPasswordWithAdminTokenUrl = HTTPClientUtils.getURL(Constants.APPKEY.replace("#", "/")
					+ "/users/" + userPrimaryKey + "/password");
			objectNode = HTTPClientUtils.sendHTTPRequest(modifyIMUserPasswordWithAdminTokenUrl, MyConstants.credential,
					dataObjectNode, HTTPMethod.METHOD_PUT);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return objectNode;
	}

	private ObjectNode deleteIMUserSingle(String phone) {
		ObjectNode objectNode = MyConstants.factory.objectNode();

		// check Constants.APPKEY format
		if (!HTTPClientUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", Constants.APPKEY)) {
			objectNode.put("message", "Bad format of Constants.APPKEY");
			return objectNode;
		}

		if (StringUtils.isEmpty(phone)) {
			objectNode.put("message", "Your password must be provided，the value is username or uuid of imuser.");
			return objectNode;
		}

		URL USERS_URL = HTTPClientUtils.getURL(EndPoints.APP_URL + "/users/" + phone);
		objectNode = HTTPClientUtils.sendHTTPRequest(USERS_URL, MyConstants.credential, null, HTTPMethod.METHOD_DELETE);

		return objectNode;
	}

	/**
	 * 发送消息
	 * 
	 * @param targetType
	 *            消息投递者类型：users 用户, chatgroups 群组
	 * @param target
	 *            接收者ID 必须是数组,数组元素为用户ID或者群组ID
	 * @param msg
	 *            消息内容
	 * @param from
	 *            发送者
	 * @param ext
	 *            扩展字段
	 * 
	 * @return 请求响应
	 */
	public static ObjectNode sendMessages(String targetType, ArrayNode target, ObjectNode msg, ObjectNode ext) {
		ObjectNode objectNode = MyConstants.factory.objectNode();
		ObjectNode dataNode = MyConstants.factory.objectNode();

		// check appKey format
		if (!HTTPClientUtils.match("^(?!-)[0-9a-zA-Z\\-]+#[0-9a-zA-Z]+", Constants.APPKEY)) {
			objectNode.put("message", "Bad format of Appkey");
			return objectNode;
		}

		if (!("users".equals(targetType) || "chatgroups".equals(targetType))) {
			objectNode.put("message", "TargetType must be users or chatgroups .");
			return objectNode;
		}

		try {
			// 构造消息体
			dataNode.put("target_type", targetType);
			dataNode.put("target", target);
			dataNode.put("msg", msg);
			dataNode.put("ext", ext);
			dataNode.put("from", "种好地");

			objectNode = HTTPClientUtils.sendHTTPRequest(EndPoints.MESSAGES_URL, MyConstants.credential, dataNode,
					HTTPMethod.METHOD_POST);

			objectNode = (ObjectNode) objectNode.get("data");
		} catch (Exception e) {
			logger.error("发送消息失败", e);
		}

		return objectNode;
	}

}
