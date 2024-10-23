package com.hitices.pressure.domain.vo;

import lombok.Data;
import org.springframework.data.relational.core.sql.In;

import java.util.List;

@Data
public class JointPlanVO {

    int id;

    /**
     * 联合测试计划的名称
     */
    String name;


    String status;

    /**
     * 联合测试计划的备注
     */
    String comment;

    /**
     * 要执行的多个测试计划的id集合
     */
    List<String> testPlansName;

    List<Integer> testPlanIds;
}
