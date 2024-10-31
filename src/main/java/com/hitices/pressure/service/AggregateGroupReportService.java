package com.hitices.pressure.service;

import com.hitices.pressure.domain.entity.AggregateGroupReport;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hitices.pressure.domain.vo.AggregateReportEnhanceVO;

import java.util.List;

/**
* @author 24957
* @description 针对表【aggregate_group_report】的数据库操作Service
* @createDate 2024-10-28 16:26:49
*/
public interface AggregateGroupReportService extends IService<AggregateGroupReport> {

    List<AggregateReportEnhanceVO> getAggregateGroupReportByPlanId(int planId);
}
