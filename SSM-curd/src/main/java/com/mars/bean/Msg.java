package com.mars.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * ClassName:Msg
 * Package:com.mars.bean
 * Description:通用的返回的类
 *
 * @Date:2021/11/29 17:39
 * @Author:Mars
 */
public class Msg {

    // 状态码 100：成功；200：失败
    private Integer code;
    // 提示信息
    private String msg;

    // 用户要返回给浏览器的数据
    private Map<String, Object> extendMap = new HashMap<>();

    // 设置成功信息
    public static Msg success() {
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理成功！");
        return msg;
    }

    // 设置成功信息
    public static Msg fail() {
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理失败！");
        return msg;
    }

    public Msg add(String key, Object value) {
        this.getExtendMap().put(key, value);
        return this;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtendMap() {
        return extendMap;
    }

    public void setExtendMap(Map<String, Object> extendMap) {
        this.extendMap = extendMap;
    }
}
