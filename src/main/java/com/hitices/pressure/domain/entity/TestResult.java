package com.hitices.pressure.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * @TableName test_result
 */
@TableName(value ="test_result")
@Data
public class TestResult implements Serializable {
    private Integer id;

    @TableField("plan_id")
    private Integer planId;

    private Date timestamp;

    @TableField("start_time")
    private Date startTime;

    @TableField("end_time")
    private Date endTime;

    @TableField("pause_time")
    private Long pauseTime;

    @TableField("idle_time")
    private Long idleTime;

    private Long latency;

    private Integer success;

    @TableField("connect_time")
    private Long connectTime;

    @TableField("response_code")
    private Integer responseCode;

    @TableField("response_data")
    private String responseData;

    @TableField("response_message")
    private String responseMessage;

    @TableField("response_headers")
    private String responseHeaders;

    private Long bytes;
    @TableField("headers_size")
    private Integer headersSize;

    @TableField("body_size")
    private Integer bodySize;

    @TableField("sent_bytes")
    private Integer sentBytes;

    @TableField("group_id")
    private Integer groupId;

    private static final long serialVersionUID = 1L;
}
