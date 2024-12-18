package com.hitices.pressure.controller;


import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.hitices.pressure.common.MResponse;
import com.hitices.pressure.domain.entity.JointPlanMap;
import com.hitices.pressure.domain.vo.AggregateReportEnhanceVO;
import com.hitices.pressure.domain.vo.AggregateReportVO;
import com.hitices.pressure.domain.vo.JointPlanVO;
import com.hitices.pressure.domain.vo.TestPlanVO;
import com.hitices.pressure.service.AggregateGroupReportService;
import com.hitices.pressure.service.JointPlanService;
import com.hitices.pressure.service.PressureMeasurementService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 多个测试计划联合执行接口
 */
@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/jointMeasure")
public class JointMeasureController {

    @Autowired
    private PressureMeasurementService pressureMeasurementService;

    @Autowired
    private JointPlanService jointPlanService;

    @Autowired
    private AggregateGroupReportService aggregateGroupReportService;


    /**
     * 根据测试计划Id创建联合测试计划
     * @param jointPlanVO
     * @return
     */
    @PostMapping("/createJointPlans")
    public MResponse<Boolean> createJointPlan(@RequestBody JointPlanVO jointPlanVO){
        //参数校验
        List<Integer> ids = jointPlanVO.getTestPlanIds();
        if(ids.size() < 2) return new MResponse<Boolean>().failedMResponse().setStatus("至少选择两个测试计划进行联合测试!").data(false);
        if(StringUtils.isBlank(jointPlanVO.getName()) || StringUtils.isEmpty(jointPlanVO.getName())) {
            return new MResponse<Boolean>().failedMResponse().setStatus("测试计划名称不可以为空!").data(false);
        }
        //添加到数据库
        jointPlanService.addJointPlan(jointPlanVO);
        return new MResponse<Boolean>().successMResponse().data(true);
    }


    /**
     * 串行执行多个测试计划
     * @param
     * @return
     */
    @GetMapping("/measurePlans")
    public MResponse<Boolean> measurePlans(@RequestParam("jointPlanId") Integer jointPlanId) {
        List<JointPlanMap> maps = jointPlanService.getPlanByJointPlanId(jointPlanId);
        AtomicBoolean isFailed = new AtomicBoolean(false);
        AtomicInteger count = new AtomicInteger();
        //串行执行多个测试计划
        CompletableFuture<Void> future = CompletableFuture.completedFuture(null);
        jointPlanService.updateJointPlanStatus(jointPlanId,"Running");
        for (JointPlanMap map : maps) {
            int testPlanId = map.getPlanId();
            future = future.thenCompose(v -> pressureMeasurementService.measureFuture(testPlanId))
                    .thenAccept(result -> {
                        if (!result) {
                            log.info("测试计划执行失败: " + testPlanId);
                            isFailed.set(true);
                        }else{
                            log.info("测试计划执行成功: " + testPlanId);
                        }
                        //如果全部执行完毕，更新联合测试计划状态
                        count.getAndIncrement();
                        if(count.intValue() == maps.size()) {
                            jointPlanService.updateJointPlanStatus(jointPlanId,"Completed");
                        }
                    });
        }
        return new MResponse<Boolean>().successMResponse().data(true).setStatus("联合测试计划开始执行!");
    }

    /**
     * 创建联合测试计划的聚合报告
     * @param jointPlanId
     * @return
     */
    @GetMapping("/createJointReportByPlanId")
    public MResponse<Boolean> createJointReportById(@RequestParam int jointPlanId){
        //参数校验
        List<JointPlanMap> planByJointPlanId = jointPlanService.getPlanByJointPlanId(jointPlanId);
        if(ObjectUtils.isNull(planByJointPlanId) || planByJointPlanId.size() <=1){
            return new MResponse<Boolean>().failedMResponse().setStatus("此Id不存在!").data(false);
        }
        for (JointPlanMap map : planByJointPlanId) {
            //先检查是否已经创建了报告
            AggregateReportVO report = pressureMeasurementService.getAggregateReportByPlanId(map.getPlanId());
            List<AggregateReportEnhanceVO> groupReport = aggregateGroupReportService.getAggregateGroupReportByPlanId(map.getPlanId());
            if(ObjectUtils.isNull(report) || ObjectUtils.isEmpty(report)){
                //如果没有创建再创建
                boolean b = pressureMeasurementService.addAggregateReport(map.getPlanId());
                if(!b) throw new RuntimeException("Id:"+map.getPlanId()+"  创建聚合报告失败");
            }
            //检查子线程报告是否缺少
            if(ObjectUtils.isNull(groupReport) || ObjectUtils.isEmpty(groupReport) || groupReport.size() < planByJointPlanId.size()){
                boolean b = pressureMeasurementService.addAggregateGroupReport(map.getPlanId());
                if(!b) throw new RuntimeException("Id:"+map.getPlanId()+"  创建子线程聚合报告失败");
            }
        }
        return new MResponse<Boolean>().successMResponse().data(true);
    }

    /**
     * 根据Id更新联合测试计划的聚合报告
     * @param jointPlanId
     * @return
     */
    @GetMapping("/updateJointReportById")
    public MResponse<Object> updateJointReportById(@RequestParam int jointPlanId){
        //参数校验
        List<JointPlanMap> planByJointPlanId = jointPlanService.getPlanByJointPlanId(jointPlanId);
        if(ObjectUtils.isNull(planByJointPlanId) || planByJointPlanId.size() <=1){
            return new MResponse<>().failedMResponse().setStatus("此Id不存在!").data(null);
        }
        for (JointPlanMap map : planByJointPlanId) {
            boolean b = pressureMeasurementService.updateAggregateReport(map.getPlanId());
            if(!b) return new MResponse<>().failedMResponse().data(null).setStatus("子测试计划Id:"+map.getPlanId()+"更新聚合报告失败!");
        }
        return new MResponse<>().successMResponse();
    }

    /**
     * 创建联合测试计划的聚合报告
     * @param jointPlanId
     * @return
     */
    @GetMapping("/getJointReportByPlanId")
    public MResponse<List<AggregateReportEnhanceVO>> getJointReportById(@RequestParam int jointPlanId){
        //参数校验
        List<JointPlanMap> planByJointPlanId = jointPlanService.getPlanByJointPlanId(jointPlanId);
        if(ObjectUtils.isNull(planByJointPlanId) || planByJointPlanId.size() <=1){
            return new MResponse<List<AggregateReportEnhanceVO>>().failedMResponse().setStatus("此Id不存在!").data(null);
        }
        List<AggregateReportEnhanceVO> reports = new ArrayList<>();
        for (JointPlanMap map : planByJointPlanId) {
            AggregateReportEnhanceVO report = pressureMeasurementService.getAggregateReportEnhanceByPlanId(map.getPlanId());
            if(ObjectUtils.isNotNull(report) && ObjectUtils.isNotEmpty(report)) reports.add(report);
        }
        if(reports.size() <= 0) return new MResponse<List<AggregateReportEnhanceVO>>().failedMResponse().data(null).set("msg","未查询到聚合报告，请先创建!");
        return new MResponse<List<AggregateReportEnhanceVO>>().successMResponse().data(reports);
    }

    /**
     * 根据Id删除联合报告
     * @param jointPlanId
     * @return
     */
    @GetMapping("/deleteJointPlanByPlanId")
    public MResponse<Object> deleteJointReportById(@RequestParam int jointPlanId){
        //参数校验
        List<JointPlanMap> planByJointPlanId = jointPlanService.getPlanByJointPlanId(jointPlanId);
        if(ObjectUtils.isNull(planByJointPlanId) || planByJointPlanId.size() <=1){
            return new MResponse<Object>().failedMResponse().setStatus("此Id不存在!").data(null);
        }
        boolean b = jointPlanService.removeJointPlanById(jointPlanId);
        if(!b) return new MResponse<>().failedMResponse().data(null);
        return new MResponse<>().successMResponse();
    }

    /**
     * 根据Id删除联合报告
     * @param jointPlanVO
     * @return
     */
    @PostMapping("/updateJointPlan")
    public MResponse<Boolean> updateJointPlan(@RequestBody JointPlanVO jointPlanVO){
        //参数校验
        List<Integer> ids = jointPlanVO.getTestPlanIds();
        if(ids.size() < 2) return new MResponse<Boolean>().failedMResponse().setStatus("至少选择两个测试计划进行联合测试!").data(false);
        if(StringUtils.isBlank(jointPlanVO.getName()) || StringUtils.isEmpty(jointPlanVO.getName())) {
            return new MResponse<Boolean>().failedMResponse().setStatus("测试计划名称不可以为空!").data(false);
        }
        boolean b = jointPlanService.updateJointPlan(jointPlanVO);
        if(!b) return new MResponse<Boolean>().failedMResponse().data(false);
        return new MResponse<Boolean>().successMResponse().data(true);
    }


    /**
     * 获取所有的联合计划
     * @return
     */
    @GetMapping("/getJointTestPlans")
    public MResponse<List<JointPlanVO>> getJointTestPlans(){
        List<JointPlanVO> result = jointPlanService.getJointTestPlans();
        if(ObjectUtils.isNull(result) || ObjectUtils.isEmpty(result)){
            return new MResponse<List<JointPlanVO>>().failedMResponse().setStatus("未查询到联合测试计划");
        }
        return new MResponse<List<JointPlanVO>>().successMResponse().data(result);
    }

    @GetMapping("/getJointTestPlanById")
    public MResponse<JointPlanVO> getJointTestPlanById(int jointPlanId){
        JointPlanVO result = jointPlanService.getJointTestPlanById(jointPlanId);
        if(ObjectUtils.isNull(result) || ObjectUtils.isEmpty(result)){
            return new MResponse<JointPlanVO>().failedMResponse().setStatus("查询失败");
        }
        return new MResponse<JointPlanVO>().successMResponse().data(result);
    }

    @GetMapping("/getJointTestPlanSonById")
    public MResponse<List<TestPlanVO>> getJointTestPlanSonById(int jointPlanId){
        List<TestPlanVO> result = jointPlanService.getJointTestPlanSonById(jointPlanId);
        if(ObjectUtils.isNull(result) || ObjectUtils.isEmpty(result)){
            return new MResponse<List<TestPlanVO>>().failedMResponse().setStatus("查询失败");
        }
        return new MResponse<List<TestPlanVO>>().successMResponse().data(result);
    }



}
