package com.hitices.pressure.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.hitices.pressure.common.MResponse;
import com.hitices.pressure.domain.entity.HardwareRecord;
import com.hitices.pressure.domain.entity.MonitorParam;
import com.hitices.pressure.domain.entity.NetworkRecord;
import com.hitices.pressure.domain.entity.TestResult;
import com.hitices.pressure.domain.vo.AggregateReportEnhanceVO;
import com.hitices.pressure.domain.vo.AggregateReportVO;
import com.hitices.pressure.domain.vo.TestPlanVO;
import com.hitices.pressure.domain.vo.TestResultVO;
import com.hitices.pressure.service.AggregateGroupReportService;
import com.hitices.pressure.service.PressureMeasurementService;
import com.hitices.pressure.service.TestResultService;
import com.hitices.pressure.utils.ExcelGenerator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/pressureMeasurement")
public class PressureMeasurementController {

  @Autowired private PressureMeasurementService pressureMeasurementService;

  @Autowired private AggregateGroupReportService aggregateGroupReportService;

  @Autowired private TestResultService testResultService;

  /**
   * 获取所有的测试计划
   * @return
   */
  @GetMapping("/testPlans")
  public MResponse<List<TestPlanVO>> getAllTestPlans() {
    try {
      return new MResponse<List<TestPlanVO>>()
          .successMResponse()
          .data(pressureMeasurementService.getAllTestPlans());
    } catch (JsonProcessingException e) {
      return new MResponse<List<TestPlanVO>>().failedMResponse();
    }
  }

  @GetMapping("/getTestPlanById")
  public MResponse<TestPlanVO> getTestPlanById(@RequestParam("testPlanId") int testPlanId) {
    try {
      return new MResponse<TestPlanVO>()
          .successMResponse()
          .data(pressureMeasurementService.getTestPlanById(testPlanId));
    } catch (JsonProcessingException e) {
      return new MResponse<TestPlanVO>().failedMResponse();
    }
  }

  /**
   * 执行测试计划
   * @param testPlanId
   * @return
   */
  @GetMapping("/measure")
  public MResponse<Boolean> measure(@RequestParam("testPlanId") int testPlanId) {
    try {
      pressureMeasurementService.measure(testPlanId);
    } catch (JsonProcessingException e) {
      return new MResponse<Boolean>().failedMResponse().data(false);
    }

    return new MResponse<Boolean>().successMResponse().data(true);
  }

  @PostMapping("/createTestPlan")
  public MResponse<Object> createTestPlan(@RequestBody TestPlanVO testPlanVO) {
    if (pressureMeasurementService.addTestPlan(testPlanVO) <= 0) {
      return new MResponse<>().failedMResponse();
    }
    return new MResponse<>().successMResponse();
  }

  @PostMapping("/createBoundaryTest")
  public MResponse<Object> createBoundaryTest(@RequestBody TestPlanVO testPlanVO)
      throws IOException {
    if (pressureMeasurementService.addBoundaryTestPlan(testPlanVO) <= 0) {
      return new MResponse<>().failedMResponse();
    }
    return new MResponse<>().successMResponse();
  }

  @GetMapping("/deleteTestPlan")
  public MResponse<Object> deleteTestPlan(@RequestParam("testPlanId") int testPlanId) {
    int res = pressureMeasurementService.deleteTestPlan(testPlanId);
    if(res != -1){
      return new MResponse<>().successMResponse().set("rows", res);
    }else{
      return new MResponse<>().failedMResponse().setStatus("请先删除其所属的联合测试计划!");
    }

  }

  @PostMapping("/updateTestPlan")
  public MResponse<Object> updateTestPlan(@RequestBody TestPlanVO testPlanVO) {
    pressureMeasurementService.updateTestPlan(testPlanVO);
    return new MResponse<>().successMResponse();
  }

  /**
   * 更新总体的聚合报告，以及各个线程组的聚合报告
   * @param planId
   * @return
   */
  @GetMapping("/updateAggregateReport")
  public MResponse<Object> updateAggregateReport(int planId) {
    if (!pressureMeasurementService.updateAggregateReport(planId)) {
      return new MResponse<>().failedMResponse();
    }
    return new MResponse<>().successMResponse();
  }

  /**
   * 创建测试计划的整体聚合报告以及各个线程组的报告
   * @param planId
   * @return
   */
  @GetMapping("/createAggregateReport")
  public MResponse<Object> createAggregateReport(int planId) {
    if (pressureMeasurementService.addAggregateReport(planId) && pressureMeasurementService.addAggregateGroupReport(planId)) {
      return new MResponse<>().successMResponse();
    }
    return new MResponse<>().failedMResponse();
  }


  @GetMapping("/getTestResultsByID")
  public MResponse<IPage<TestResult>> getTestResultsById(
          int testPlanId,
          @RequestParam(required = false, defaultValue = "1") long current,
          @RequestParam(required = false, defaultValue = "10") long size) {
    IPage<TestResult> resultPage = testResultService.getTestResultsByPlanId(testPlanId, current, size);
    return new MResponse<IPage<TestResult>>()
            .successMResponse()
            .data(resultPage);
  }


  @GetMapping("/getTestResultByResultId")
  public MResponse<TestResultVO> getTestResultByResultId(int testResultId) {
    return new MResponse<TestResultVO>()
        .successMResponse()
        .data(pressureMeasurementService.getTestResultByResultId(testResultId));
  }


  /**
   * 获取某个测试计划下面的所有线程组的聚合报告
   * @param planId
   * @return
   */
  @GetMapping("/getAggregateGroupReportByPlanId")
  public MResponse<List<AggregateReportEnhanceVO>> getAggregateGroupReportByPlanId(int planId) {
    return new MResponse<List<AggregateReportEnhanceVO>>()
        .successMResponse()
        .data(aggregateGroupReportService.getAggregateGroupReportByPlanId(planId));
  }


  @GetMapping("/getAggregateReportByPlanId")
  public MResponse<AggregateReportVO> getAggregateReportByPlanId(int planId) {
    return new MResponse<AggregateReportVO>()
            .successMResponse()
            .data(pressureMeasurementService.getAggregateReportByPlanId(planId));
  }



  @GetMapping("/getStartAndEndOfTest")
  public MResponse<int[]> getStartAndEndOfTest(int planId) {
    int[] startAndEnd = pressureMeasurementService.getStartAndEndOfTest(planId);
    if (startAndEnd[0] == -1) {
      return new MResponse<int[]>()
          .failedMResponse()
          .setStatus("No available test samples, please execute the test.")
          .data(null);
    }
    return new MResponse<int[]>().successMResponse().data(startAndEnd);
  }


  @PostMapping("/aggregateReportExcel")
  public ResponseEntity<InputStreamResource> generateExcel(
      @RequestParam int planId, @RequestBody MonitorParam monitorParam) throws IOException {
    //整个测试计划的聚合报告
    AggregateReportVO aggregateReportVO =
        pressureMeasurementService.getAggregateReportByPlanId(planId);
    //每个线程组的聚合报告
    List<AggregateReportEnhanceVO> aggregateGroupReport =
            aggregateGroupReportService.getAggregateGroupReportByPlanId((planId));
    ArrayList<HardwareRecord> cpuUsage = monitorParam.getCpuUsage();
    ArrayList<HardwareRecord> memoryUsage = monitorParam.getMemoryUsage();
    ArrayList<NetworkRecord> byteTransmitted = monitorParam.getByteTransmitted();
    ArrayList<NetworkRecord> byteReceived = monitorParam.getByteReceived();
    InputStream inputStream =
        ExcelGenerator.generateAggregateReportExcel(
            aggregateReportVO, aggregateGroupReport,cpuUsage, memoryUsage, byteTransmitted, byteReceived);

    if (inputStream != null) {
      InputStreamResource resource = new InputStreamResource(inputStream);

      return ResponseEntity.ok()
          .contentType(MediaType.APPLICATION_OCTET_STREAM)
          .contentLength(inputStream.available())
          .body(resource);
    } else {
      // 处理InputStream为null的情况，可以返回适当的错误响应
      return ResponseEntity.status(HttpStatus.ACCEPTED).body(null);
    }
  }

  @PostMapping("/boundaryExcel")
  public ResponseEntity<InputStreamResource> generateBoundaryExcel(@RequestParam int planId) throws IOException {
    List<AggregateReportVO> aggregateReportVOList = pressureMeasurementService.getBoundaryTestResult(planId);
    InputStream inputStream =
            ExcelGenerator.generateBoundaryExcel(aggregateReportVOList.subList(0, aggregateReportVOList.size() - 1));
    if (inputStream != null) {
      InputStreamResource resource = new InputStreamResource(inputStream);

      return ResponseEntity.ok()
              .contentType(MediaType.APPLICATION_OCTET_STREAM)
              .contentLength(inputStream.available())
              .body(resource);
    } else {
      // 处理InputStream为null的情况，可以返回适当的错误响应
      return ResponseEntity.status(HttpStatus.ACCEPTED).body(null);
    }
  }

  @GetMapping("/getBoundaryTestResult")
  public MResponse<List<AggregateReportVO>> getBoundaryTestResult(int planId) {
    List<AggregateReportVO> resultList = pressureMeasurementService.getBoundaryTestResult(planId);
    if (resultList == null) {
      return new MResponse<List<AggregateReportVO>>()
          .setStatus("No available test samples, please execute the test.")
          .failedMResponse()
          .data(null);
    }
    return new MResponse<List<AggregateReportVO>>().successMResponse().data(resultList);
  }
}
