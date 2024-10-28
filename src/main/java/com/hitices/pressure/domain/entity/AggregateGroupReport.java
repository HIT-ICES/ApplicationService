package com.hitices.pressure.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * @TableName aggregate_group_report
 */
@TableName(value ="aggregate_group_report")
@Data
public class AggregateGroupReport implements Serializable {
    @TableId(type = IdType.AUTO)
    private Integer id;

    @TableField("plan_id")
    private Integer planId;

    @TableField("group_id")
    private Integer groupId;

    @TableField("thread_group_name")
    private String threadGroupName;

    @TableField("samples_num")
    private Integer samplesNum;

    @TableField("average")
    private Double average;

    @TableField("median")
    private Double median;

    @TableField("min")
    private Double min;

    @TableField("max")
    private Double max;

    @TableField("p90")
    private Double p90;

    @TableField("p95")
    private Double p95;

    @TableField("p99")
    private Double p99;

    @TableField("tps")
    private Double tps;

    @TableField("error_rate")
    private Double errorRate;

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
