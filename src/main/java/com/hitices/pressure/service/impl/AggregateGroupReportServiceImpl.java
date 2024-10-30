package com.hitices.pressure.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hitices.pressure.domain.entity.AggregateGroupReport;
import com.hitices.pressure.domain.vo.AggregateReportEnhanceVO;
import com.hitices.pressure.domain.vo.ThreadGroupVO;
import com.hitices.pressure.repository.PressureMeasurementMapper;
import com.hitices.pressure.service.AggregateGroupReportService;
import com.hitices.pressure.repository.AggregateGroupReportMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
* @author 24957
* @description 针对表【aggregate_group_report】的数据库操作Service实现
* @createDate 2024-10-28 16:26:49
*/
@Service
public class AggregateGroupReportServiceImpl extends ServiceImpl<AggregateGroupReportMapper, AggregateGroupReport>
    implements AggregateGroupReportService{

    @Autowired
    private AggregateGroupReportMapper aggregateGroupReportMapper;

    @Autowired
    private PressureMeasurementMapper pressureMeasurementMapper;

    @Override
    public List<AggregateReportEnhanceVO> getAggregateGroupReportByPlanId(int planId) {
        LambdaQueryWrapper<AggregateGroupReport> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AggregateGroupReport::getPlanId,planId);
        List<AggregateGroupReport> reports = aggregateGroupReportMapper.selectList(wrapper);
        List<AggregateReportEnhanceVO> result = new ArrayList<>();
        for (AggregateGroupReport report : reports) {
            AggregateReportEnhanceVO reportEnhance = new AggregateReportEnhanceVO();
            reportEnhance.setGroupId(report.getGroupId());
            reportEnhance.setGroupName(report.getThreadGroupName());
            reportEnhance.setSamplesNum(report.getSamplesNum());
            BeanUtils.copyProperties(report,reportEnhance);
            result.add(reportEnhance);
        }
        return result;
    }
}




