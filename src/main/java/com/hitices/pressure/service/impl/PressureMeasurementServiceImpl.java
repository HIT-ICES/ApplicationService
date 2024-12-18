package com.hitices.pressure.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hitices.pressure.common.BoundaryTestThread;
import com.hitices.pressure.common.MeasureThread;
import com.hitices.pressure.domain.entity.AggregateGroupReport;
import com.hitices.pressure.domain.entity.JointPlanMap;
import com.hitices.pressure.domain.enum_.TimerType;
import com.hitices.pressure.domain.vo.*;
import com.hitices.pressure.repository.AggregateGroupReportMapper;
import com.hitices.pressure.repository.JointPlanMapMapper;
import com.hitices.pressure.repository.PressureMeasurementMapper;
import com.hitices.pressure.service.PressureMeasurementService;
import com.hitices.pressure.utils.JMeterUtil;
import lombok.extern.slf4j.Slf4j;
import opennlp.tools.ml.BeamSearch;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.apache.jmeter.samplers.SampleResult;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.concurrent.CompletableFuture;

@Slf4j
@Service
public class PressureMeasurementServiceImpl implements PressureMeasurementService {

  private final List<SampleResult> results = new ArrayList<>();

  @Autowired
  private PressureMeasurementMapper pressureMeasurementMapper;

  @Autowired
  private AggregateGroupReportMapper aggregateGroupReportMapper;

  @Autowired
  private JointPlanMapMapper jointPlanMapMapper;

  @Override
  public boolean commonMeasure(TestPlanVO testPlanVO) {
    try {
      testPlanVO.setStatus("Running");
      pressureMeasurementMapper.updateTestPlan(testPlanVO);
      MeasureThread measureThread = new MeasureThread(testPlanVO, this,pressureMeasurementMapper);
      Thread thread = new Thread(measureThread);
      thread.start();
      return true;
    } catch (Exception e) {
      return false;
    }
  }

  /**
   * 采用completableFuture改进，便于编排多个任务
   * @param testPlanVO
   * @return
   */
  @Override
  public CompletableFuture<Boolean> commonMeasureFuture(TestPlanVO testPlanVO) {
    return CompletableFuture.supplyAsync(() -> {
      try {
        testPlanVO.setStatus("Running");
        pressureMeasurementMapper.updateTestPlan(testPlanVO);
        MeasureThread measureThread = new MeasureThread(testPlanVO, this,pressureMeasurementMapper);
        measureThread.run();
        return true;
      } catch (Exception e) {
        //todo dubug
        log.error("出现了bug");;
        e.printStackTrace();
        return false;
      }
    });
  }

  @Override
  public boolean boundaryMeasure(TestPlanVO testPlanVO) {
    Path path = Paths.get(JMeterUtil.JMX_PATH);
    Path jmxPath = path.resolve(testPlanVO.getId() + ".jmx");
    //这里会直接return false
    if (!Files.exists(path) || !Files.exists(jmxPath)) {
      return false;
    }
    try {
      testPlanVO.setStatus("Running");
      pressureMeasurementMapper.updateTestPlan(testPlanVO);
        BoundaryTestThread boundaryTestThread = new BoundaryTestThread(testPlanVO, jmxPath.toString(),pressureMeasurementMapper);
        Thread thread = new Thread(boundaryTestThread);
        thread.start();

        return true;
    } catch (Exception e) {
      testPlanVO.setStatus("Failed");
      pressureMeasurementMapper.updateTestPlan(testPlanVO);
        return false;
    }
    /*
    try {

      StandardJMeterEngine standardJMeterEngine;
      if (System.getProperty("os.name").equals("Windows 11")) {
        standardJMeterEngine =
            JMeterUtil.init(JMeterUtil.WINDOWS_HOME, JMeterUtil.WINDOWS_FILE_PATH);
      } else {
        standardJMeterEngine = JMeterUtil.init(JMeterUtil.LINUX_HOME, JMeterUtil.LINUX_FILE_PATH);
      }
      File jmxFile = new File(jmxPath.toString());
      HashTree testPlanTree = SaveService.loadTree(jmxFile);

      standardJMeterEngine.configure(testPlanTree);
      standardJMeterEngine.run();
      testPlanVO.setStatus("Completed");
      return true;
    } catch (IOException e) {
      return false;
    }*/
  }
  @Override
  public CompletableFuture<Boolean> boundaryMeasureFuture(TestPlanVO testPlanVO) {
    return CompletableFuture.supplyAsync(() -> {
      Path path = Paths.get(JMeterUtil.JMX_PATH);
      Path jmxPath = path.resolve(testPlanVO.getId() + ".jmx");
      if (!Files.exists(path) || !Files.exists(jmxPath)) {
        return false;
      }
      try {
        testPlanVO.setStatus("Running");
        pressureMeasurementMapper.updateTestPlan(testPlanVO);
        BoundaryTestThread boundaryTestThread = new BoundaryTestThread(testPlanVO, jmxPath.toString(),pressureMeasurementMapper);
        boundaryTestThread.run();
        return true;
      } catch (Exception e) {
        return false;
      }
    });
  }
  @Override
  public CompletableFuture<Boolean> measureFuture(int testPlanId) {
    TestPlanVO testPlanVO = null;
    try {
      testPlanVO = getTestPlanById(testPlanId);
    } catch (JsonProcessingException e) {
      throw new RuntimeException(e);
    }
    return testPlanVO.isBoundary()
            ? boundaryMeasureFuture(testPlanVO)
            : commonMeasureFuture(testPlanVO);
  }

  @Override
  public boolean measure(int testPlanId) throws JsonProcessingException {
    TestPlanVO testPlanVO = getTestPlanById(testPlanId);
    if (testPlanVO.isBoundary()) {
      return boundaryMeasure(testPlanVO);
    } else {
      return commonMeasure(testPlanVO);
    }
  }

  @Override
  public void addResults(SampleResult result) {
    // 需要将result和http sampler proxy对应起来，暂时查找的方法就是result中的label是对应的http sampler proxy名字，
    // 可进一步寻找更可行的方法，将二者id对应关系创建出来
    // 此外，这里只是将结果存起来了，还需要保存进数据库，还未完成
    results.add(result);
  }

  @Override
  public List<SampleResult> getResults() {
    // 浅拷贝，后续为保证变量不能随意篡改应改为深拷贝（但内部人员用谁会改呢），但是性能会下降
    return results;
  }

  @Override
  public List<TestPlanVO> getAllTestPlans() throws JsonProcessingException {
    List<TestPlanVO> testPlanVOList = pressureMeasurementMapper.getAllTestPlans();

    for (TestPlanVO testPlanVO : testPlanVOList) {
      refactorTestPlanVO(testPlanVO);
    }
    return testPlanVOList;
  }

  @Override
  public TestPlanVO getTestPlanById(int testPlanId) throws JsonProcessingException {
    TestPlanVO testPlanVO = pressureMeasurementMapper.getTestPlanById(testPlanId);
    //这里查询不到threadDelay
    if (testPlanVO != null) {
      refactorTestPlanVO(testPlanVO);
    }
    return testPlanVO;
  }

  @Override
  public AggregateReportVO getAggregateReportByPlanId(int planId) {
    AggregateReportVO aggregateReportVO = pressureMeasurementMapper.getAggregateReport(planId);
    if (aggregateReportVO != null) {
      return aggregateReportVO;
    }
    return null;
  }


  @Override
  public int[] getStartAndEndOfTest(int planId) {
    class StartTimeComparator implements Comparator<TestResultVO> {
      @Override
      public int compare(TestResultVO r1, TestResultVO r2) {
        return r2.getTimestamp().compareTo(r1.getTimestamp());
      }
    }
    List<TestResultVO> resultList = pressureMeasurementMapper.getTestResultsByPlanId(planId);
    int samplesNum = resultList.size();
    if (samplesNum > 0) {
      Collections.sort(resultList, new StartTimeComparator());
      int maxStart = (int) (resultList.get(0).getTimestamp().getTime() / 1000);
      int minStart = (int) (resultList.get(samplesNum - 1).getTimestamp().getTime() / 1000);
      return new int[] {minStart, maxStart};
    }
    return new int[] {-1, -1};
  }

  private static double calculateMedian(List<TestResultVO> sortedData) {
    int middle = sortedData.size() / 2;
    if (sortedData.size() % 2 == 0) {
      return (sortedData.get(middle - 1).getLatency() + sortedData.get(middle).getLatency()) / 2.0;
    } else {
      return sortedData.get(middle).getLatency();
    }
  }

  // 计算百分位数的方法
  private static double calculatePercentile(List<TestResultVO> sortedData, int percentile) {
    if (percentile < 0 || percentile > 100) {
      throw new IllegalArgumentException("百分位数必须在0到100之间");
    }
    double index = percentile / 100.0 * (sortedData.size() - 1);
    if (index == Math.floor(index)) {
      return sortedData.get((int) index).getLatency();
    } else {
      int lowerIndex = (int) Math.floor(index);
      int upperIndex = (int) Math.ceil(index);
      return (sortedData.get(lowerIndex).getLatency() + sortedData.get(upperIndex).getLatency())
          / 2.0;
    }
  }

  public AggregateReportVO calculateReport(int planId) {
    class LatencyComparator implements Comparator<TestResultVO> {
      @Override
      public int compare(TestResultVO r1, TestResultVO r2) {
        return (int) (r1.getLatency() - r2.getLatency());
      }
    }
    class StartTimeComparator implements Comparator<TestResultVO> {
      @Override
      public int compare(TestResultVO r1, TestResultVO r2) {
        return r2.getTimestamp().compareTo(r1.getTimestamp());
      }
    }
    AggregateReportVO aggregateReportVO = new AggregateReportVO();
    List<TestResultVO> resultList = pressureMeasurementMapper.getTestResultsByPlanId(planId);
    int samplesNum = resultList.size();
    if (samplesNum > 0) {
      Collections.sort(resultList, new LatencyComparator());
      double min = resultList.get(0).getLatency();
      double max = resultList.get(samplesNum - 1).getLatency();
      double sum =
          resultList.stream()
              .reduce(0f, (result, item) -> result + item.getLatency(), (i1, i2) -> i1 + i2);
      double errorNum =
          resultList.stream()
              .reduce(
                  0, (result, item) -> result + (item.isSuccess() ? 0 : 1), (i1, i2) -> i1 + i2);
      double median = calculateMedian(resultList);
      double p90 = calculatePercentile(resultList, 50);
      double p95 = calculatePercentile(resultList, 95);
      double p99 = calculatePercentile(resultList, 99);
      aggregateReportVO.setSamplesNum(samplesNum);
      aggregateReportVO.setAverage(sum / samplesNum);
      aggregateReportVO.setErrorRate(errorNum / samplesNum);
      aggregateReportVO.setMax(max);
      aggregateReportVO.setMin(min);
      aggregateReportVO.setMedian(median);
      aggregateReportVO.setP90(p90);
      aggregateReportVO.setP95(p95);
      aggregateReportVO.setP99(p99);
      aggregateReportVO.setPlanId(planId);
      Collections.sort(resultList, new StartTimeComparator());
      double sec =
          (resultList.get(0).getTimestamp().getTime()
                  - resultList.get(samplesNum - 1).getTimestamp().getTime())
              / 1000;
      if (Double.compare(sec, 1.0) < 0) {
        sec = 1;
      }
      aggregateReportVO.setTps(samplesNum / sec);
      return aggregateReportVO;
    }
    return null;
  }

  //针对每个线程组都创建一份聚合报告
  public AggregateGroupReport calculateGroupReport(int planId,int groupId,String groupName) {
    class LatencyComparator implements Comparator<TestResultVO> {
      @Override
      public int compare(TestResultVO r1, TestResultVO r2) {
        return (int) (r1.getLatency() - r2.getLatency());
      }
    }
    class StartTimeComparator implements Comparator<TestResultVO> {
      @Override
      public int compare(TestResultVO r1, TestResultVO r2) {
        return r2.getTimestamp().compareTo(r1.getTimestamp());
      }
    }
    AggregateGroupReport aggregateReportVO = new AggregateGroupReport();
    //拿到单个thread group的测试结果
    List<TestResultVO> resultList = pressureMeasurementMapper.getTestResultByGroupId(groupId);
    int samplesNum = resultList.size();
    if (samplesNum > 0) {
      Collections.sort(resultList, new LatencyComparator());
      double min = resultList.get(0).getLatency();
      double max = resultList.get(samplesNum - 1).getLatency();
      double sum =
              resultList.stream()
                      .reduce(0f, (result, item) -> result + item.getLatency(), (i1, i2) -> i1 + i2);
      int errorNum =
              resultList.stream()
                      .reduce(
                              0, (result, item) -> result + (item.isSuccess() ? 0 : 1), (i1, i2) -> i1 + i2);
      double median = calculateMedian(resultList);
      double p90 = calculatePercentile(resultList, 50);
      double p95 = calculatePercentile(resultList, 95);
      double p99 = calculatePercentile(resultList, 99);
      aggregateReportVO.setSamplesNum(samplesNum);
      aggregateReportVO.setAverage(sum / samplesNum);
      aggregateReportVO.setErrorRate( errorNum / (double)samplesNum);
      aggregateReportVO.setMax(max);
      aggregateReportVO.setMin(min);
      aggregateReportVO.setMedian(median);
      aggregateReportVO.setP90(p90);
      aggregateReportVO.setP95(p95);
      aggregateReportVO.setP99(p99);
      aggregateReportVO.setPlanId(planId);
      aggregateReportVO.setGroupId(groupId);
      aggregateReportVO.setThreadGroupName(groupName);
      Collections.sort(resultList, new StartTimeComparator());
      double sec =
              (resultList.get(0).getTimestamp().getTime()
                      - resultList.get(samplesNum - 1).getTimestamp().getTime())
                      / 1000;
      if (Double.compare(sec, 1.0) < 0) {
        sec = 1;
      }
      aggregateReportVO.setTps(samplesNum / sec);
      return aggregateReportVO;
    }
    return null;
  }

  @Override
  public boolean addAggregateReport(int planId) {
    AggregateReportVO aggregateReportVO = calculateReport(planId);
    try {
      AggregateReportVO aggregateReport = pressureMeasurementMapper.getAggregateReport(planId);
      //检查是否已经创建过聚合报告，只能创建一份聚合报告
      if(ObjectUtils.isNotNull(aggregateReport) || ObjectUtils.isNotEmpty(aggregateReport)){
        return false;
      }
      int res = pressureMeasurementMapper.insertAggregateReport(aggregateReportVO);
      if (res <= 0) {
        return false;
      }
      return true;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }

  @Override
  public boolean addAggregateReport(AggregateReportVO aggregateReportVO) {
    int res = pressureMeasurementMapper.insertAggregateReport(aggregateReportVO);
    if (res <= 0) {
      return false;
    }
    return true;
  }

  @Override
  public boolean addAggregateGroupReport(int planId) {
    //该测试计划下的所有线程组
    List<ThreadGroupVO> groups = pressureMeasurementMapper.getThreadGroupsByTestPlanId(planId);
    try {
      for (ThreadGroupVO group : groups) {
        AggregateGroupReport aggregateReportVO = calculateGroupReport(planId,group.getId(),group.getThreadGroupName());
        //检查是否已经创建过聚合报告，只能创建一份聚合报告
        LambdaQueryWrapper<AggregateGroupReport> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AggregateGroupReport::getGroupId,group.getId());
        AggregateGroupReport aggregateGroupReport = aggregateGroupReportMapper.selectOne(wrapper);
        if(ObjectUtils.isNotNull(aggregateGroupReport) || ObjectUtils.isNotEmpty(aggregateGroupReport)){
          return false;
        }
        int res = aggregateGroupReportMapper.insert(aggregateReportVO);
        if (res <= 0) {
          return false;
        }
      }
      return true;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }

  @Override
  public boolean updateAggregateReport(int planId) {
    //更新测试计划的整体聚合报告
    AggregateReportVO aggregateReportVO = calculateReport(planId);
    if(pressureMeasurementMapper.updateAggregateReport(aggregateReportVO) <= 0){
      return false;
    }
    //更新每个线程组的聚合报告
    List<ThreadGroupVO> threadGroupsByTestPlanId = pressureMeasurementMapper.getThreadGroupsByTestPlanId(planId);
    for (ThreadGroupVO groupVO : threadGroupsByTestPlanId) {
      AggregateGroupReport reportEnhanceVO = calculateGroupReport(planId, groupVO.getId(), groupVO.getThreadGroupName());
      LambdaQueryWrapper<AggregateGroupReport> wrapper = new LambdaQueryWrapper<>();
      wrapper.eq(AggregateGroupReport::getGroupId,groupVO.getId());
      if(aggregateGroupReportMapper.update(reportEnhanceVO,wrapper) <= 0) return false;
    }
    return true;
  }

  public List<TimerVO> getTimersByThreadGroupId(int threadGroupId) {

    List<TimerVO> timers = pressureMeasurementMapper.getTimersByThreadGroupId(threadGroupId);
    if (timers == null) return null;

    List<TimerVO> res = new ArrayList<>();
    for (TimerVO timer : timers) {

      if (timer.getTimerType() == TimerType.CONSTANT_TIMER) {
        ConstantTimerVO constantTimer =
            pressureMeasurementMapper.getConstantTimerById(timer.getId());
        fillTimer(constantTimer, timer);
        res.add(constantTimer);
      } else if (timer.getTimerType() == TimerType.UNIFORM_RANDOM_TIMER) {
        UniformRandomTimerVO uniformRandomTimer =
            pressureMeasurementMapper.getUniformRandomTimerById(timer.getId());
        fillTimer(uniformRandomTimer, timer);
        res.add(uniformRandomTimer);
      } else if (timer.getTimerType() == TimerType.GAUSSIAN_RANDOM_TIMER) {
        GaussianRandomTimerVO gaussianRandomTimer =
            pressureMeasurementMapper.getGaussianRandomTimerById(timer.getId());
        fillTimer(gaussianRandomTimer, timer);
        res.add(gaussianRandomTimer);
      } else {
        PoissonRandomTimerVO poissonRandomTimer =
            pressureMeasurementMapper.getPoissonRandomTimerById(timer.getId());
        fillTimer(poissonRandomTimer, timer);
        res.add(poissonRandomTimer);
      }
    }
    return res;
  }

  @Override
  public int deleteTestPlan(int testPlanId) {
    //首先查询有没有和某些联合测试计划关联
    LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
    wrapper.eq(JointPlanMap::getPlanId,testPlanId);
    List<JointPlanMap> jointPlanMaps = jointPlanMapMapper.selectList(wrapper);
    if (ObjectUtils.isNotNull(jointPlanMaps) && ObjectUtils.isNotEmpty(jointPlanMaps)){
      return -1;
    }else {
      return pressureMeasurementMapper.deleteTestPlan(testPlanId);
    }
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public int addTestPlan(TestPlanVO testPlan) {
    testPlan.setStatus("Created");
    pressureMeasurementMapper.insertTestPlan(testPlan);
    testPlan
        .getThreadGroupList()
        .forEach(threadGroupVO -> threadGroupVO.setTestPlanId(testPlan.getId()));
    saveThreadGroups(testPlan.getThreadGroupList());
    return testPlan.getId();
  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public int addBoundaryTestPlan(TestPlanVO testPlan) throws IOException {

    testPlan.setStatus("Created");
    String jmxPath = JMeterUtil.saveTestPlan(testPlan, this);
    if (JMeterUtil.transformJmx(testPlan, jmxPath)) {
      return 1;
    }
    return 0;
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void updateTestPlan(TestPlanVO testPlanVO) {

    pressureMeasurementMapper.updateTestPlan(testPlanVO);

    pressureMeasurementMapper.deleteThreadGroupByTestPlanId(testPlanVO.getId());
    testPlanVO
        .getThreadGroupList()
        .forEach(threadGroupVO -> threadGroupVO.setTestPlanId(testPlanVO.getId()));
    saveThreadGroups(testPlanVO.getThreadGroupList());
  }

  @Override
  public void addTimers(List<TimerVO> timers, int threadGroupId) {
    if (threadGroupId > 0) {
      timers.forEach(timer -> timer.setThreadGroupId(threadGroupId));
    }

    List<ConstantTimerVO> constantTimerVOList = new ArrayList<>();
    List<UniformRandomTimerVO> uniformRandomTimerVOList = new ArrayList<>();
    List<GaussianRandomTimerVO> gaussianRandomTimerVOList = new ArrayList<>();
    List<PoissonRandomTimerVO> poissonRandomTimerVOList = new ArrayList<>();

    for (TimerVO timer : timers) {
      if (timer instanceof ConstantTimerVO) {
        timer.setTimerType(TimerType.CONSTANT_TIMER);
        constantTimerVOList.add((ConstantTimerVO) timer);
      } else if (timer instanceof UniformRandomTimerVO) {
        timer.setTimerType(TimerType.UNIFORM_RANDOM_TIMER);
        uniformRandomTimerVOList.add((UniformRandomTimerVO) timer);
      } else if (timer instanceof GaussianRandomTimerVO) {
        timer.setTimerType(TimerType.GAUSSIAN_RANDOM_TIMER);
        gaussianRandomTimerVOList.add((GaussianRandomTimerVO) timer);
      } else {
        timer.setTimerType(TimerType.POISSON_RANDOM_TIMER);
        poissonRandomTimerVOList.add((PoissonRandomTimerVO) timer);
      }
    }

    pressureMeasurementMapper.insertTimers(timers);

    if (constantTimerVOList.size() > 0) {
      pressureMeasurementMapper.insertConstantTimerList(constantTimerVOList);
    }
    if (uniformRandomTimerVOList.size() > 0) {
      pressureMeasurementMapper.insertUniformRandomTimerList(uniformRandomTimerVOList);
    }
    if (gaussianRandomTimerVOList.size() > 0) {
      pressureMeasurementMapper.insertGaussianRandomTimerList(gaussianRandomTimerVOList);
    }
    if (poissonRandomTimerVOList.size() > 0) {
      pressureMeasurementMapper.insertPoissonRandomTimerList(poissonRandomTimerVOList);
    }
  }

  public int addTestResult(TestResultVO testResultVO) {
    return pressureMeasurementMapper.insertTestResult(testResultVO);
  }

  public List<TestResultVO> getTestResultsByPlanId(int planId) {
    return pressureMeasurementMapper.getTestResultsByPlanId(planId);
  }

  public TestResultVO getTestResultByResultId(int testResultId) {
    return pressureMeasurementMapper.getTestResultByResultId(testResultId);
  }

  private void saveThreadGroups(List<ThreadGroupVO> threadGroupVOList) {

    pressureMeasurementMapper.insertThreadGroups(threadGroupVOList);

    for (ThreadGroupVO threadGroup : threadGroupVOList) {
      List<HTTPSamplerProxyVO> httpSamplerProxyVOList = new ArrayList<>();
      List<HeaderManagerVO> headerManagerVOList = new ArrayList<>();
      List<CookieManagerVO> cookieManagerVOList = new ArrayList<>();

      if (threadGroup.getHttpSamplerProxyVO() != null) {
        HTTPSamplerProxyVO httpSamplerProxyVO = threadGroup.getHttpSamplerProxyVO();
        httpSamplerProxyVO.setArgumentsString(JSON.toJSONString(httpSamplerProxyVO.getArguments()));
        httpSamplerProxyVO.setThreadGroupId(threadGroup.getId());
        httpSamplerProxyVOList.add(httpSamplerProxyVO);
      }
      if (threadGroup.getHeaderManagerVO() != null) {
        HeaderManagerVO headerManagerVO = threadGroup.getHeaderManagerVO();
        headerManagerVO.setThreadGroupId(threadGroup.getId());
        headerManagerVO.setHeaderListString(JSON.toJSONString(headerManagerVO.getHeaderList()));
        headerManagerVOList.add(headerManagerVO);
      }
      if (threadGroup.getCookieManagerVO() != null) {
        CookieManagerVO cookieManagerVO = threadGroup.getCookieManagerVO();
        cookieManagerVO.setThreadGroupId(threadGroup.getId());
        cookieManagerVO.setCookiesString(JSON.toJSONString(cookieManagerVO.getCookies()));
        cookieManagerVOList.add(cookieManagerVO);
      }
      if (threadGroup.getLoopControllerVO() != null) {
        LoopControllerVO loopControllerVO = threadGroup.getLoopControllerVO();
        loopControllerVO.setThreadGroupId(threadGroup.getId());
        pressureMeasurementMapper.insertLoopController(loopControllerVO);
      }

      if (httpSamplerProxyVOList.size() > 0)
        pressureMeasurementMapper.insertHTTPSamplerProxyList(httpSamplerProxyVOList);
      if (headerManagerVOList.size() > 0)
        pressureMeasurementMapper.insertHeaderManagerList(headerManagerVOList);
      if (cookieManagerVOList.size() > 0)
        pressureMeasurementMapper.insertCookieManagerList(cookieManagerVOList);

      // 添加定时器
      List<TimerVO> timerVOList = threadGroup.getTimers();
      if (timerVOList.size() > 0) {
        addTimers(timerVOList, threadGroup.getId());
      }
    }
  }

  private void refactorTestPlanVO(TestPlanVO testPlanVO) throws JsonProcessingException {

    ObjectMapper mapper = new ObjectMapper();

    //为每一个线程组设置Timmer
    for (ThreadGroupVO threadGroupVO : testPlanVO.getThreadGroupList()) {

      threadGroupVO.setTimers(getTimersByThreadGroupId(threadGroupVO.getId()));

      HTTPSamplerProxyVO httpSamplerProxyVO = threadGroupVO.getHttpSamplerProxyVO();
      if (httpSamplerProxyVO.getArgumentsString() != null) {
        httpSamplerProxyVO.setArguments(
            mapper.readValue(
                httpSamplerProxyVO.getArgumentsString(),
                new TypeReference<Map<String, String>>() {}));
        httpSamplerProxyVO.setArgumentsString(null);
      }
      HeaderManagerVO headerManagerVO = threadGroupVO.getHeaderManagerVO();
      if (headerManagerVO != null) {
        headerManagerVO.setHeaderList(
            mapper.readValue(
                headerManagerVO.getHeaderListString(),
                new TypeReference<Map<String, String>>() {}));
        headerManagerVO.setHeaderListString(null);
      }
      CookieManagerVO cookieManagerVO = threadGroupVO.getCookieManagerVO();
      if (cookieManagerVO != null) {
        cookieManagerVO.setCookies(
            mapper.readValue(
                cookieManagerVO.getCookiesString(), new TypeReference<List<String>>() {}));
        cookieManagerVO.setCookiesString(null);
      }
    }
  }

  private <concreteTimer extends TimerVO> void fillTimer(
      concreteTimer concreteTimer, TimerVO timer) {
    concreteTimer.setThreadGroupId(timer.getThreadGroupId());
    concreteTimer.setTimerType(timer.getTimerType());
  }

  public List<AggregateReportVO> getBoundaryTestResult(int planId) {
    Path resultDir = Paths.get(JMeterUtil.RES_PATH);
    Path resultFile = resultDir.resolve(planId + ".csv");
    if (!Files.exists(resultDir) || !Files.exists(resultFile)) {
      return null;
    }
    List<AggregateReportVO> aggregateReportVOList = new ArrayList<>();
    try (Reader reader = new FileReader(resultFile.toString());
        CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT)) {
      for (CSVRecord csvRecord : csvParser) {
        // 获取每一行的数据
        String numThreads = csvRecord.get(0);
        String numSamples = csvRecord.get(1);
        String mean = csvRecord.get(2);
        String median = csvRecord.get(3);
        String percent90 = csvRecord.get(4);
        String percent95 = csvRecord.get(5);
        String percent99 = csvRecord.get(6);
        String min = csvRecord.get(7);
        String max = csvRecord.get(8);
        String tps = csvRecord.get(9);
        String errorRate = csvRecord.get(10);
        aggregateReportVOList.add(
            new AggregateReportVO(
                Integer.valueOf(numThreads),
                planId,
                Double.valueOf(numSamples),
                Double.valueOf(mean),
                Double.valueOf(median),
                Double.valueOf(min),
                Double.valueOf(max),
                Double.valueOf(percent90),
                Double.valueOf(percent95),
                Double.valueOf(percent99),
                Double.valueOf(tps),
                Double.valueOf(errorRate)));
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    return aggregateReportVOList;
  }

  @Override
  public AggregateReportEnhanceVO getAggregateReportEnhanceByPlanId(Integer planId) {
    AggregateReportVO aggregateReport = pressureMeasurementMapper.getAggregateReport(planId);
    TestPlanVO testPlan = pressureMeasurementMapper.getTestPlanById(planId);
    List<ThreadGroupVO> groups = pressureMeasurementMapper.getThreadGroupsByTestPlanId(planId);
    AggregateReportEnhanceVO result = new AggregateReportEnhanceVO();
    //将属性进行复制
    if(ObjectUtils.isNull(aggregateReport) || ObjectUtils.isEmpty(aggregateReport)){
      return null;
    }
    if(ObjectUtils.isNotNull(groups) && ObjectUtils.isNotEmpty(groups)){
      ThreadGroupVO threadGroupVO = groups.get(0);
      int threadNum = threadGroupVO.getThreadNum();
      result.setThreadNum(threadNum);
    }
    BeanUtils.copyProperties(aggregateReport,result);
    result.setNamespace(testPlan.getNamespace());
    result.setPodName(testPlan.getPodName());
    result.setName(testPlan.getTestPlanName());
    return result;
  }


  @Scheduled(fixedRate = 60000)
  public void batchUpdateStatusForBoundaryTest() {
    File[] files = new File(JMeterUtil.RES_PATH).listFiles();
    List<Integer> plans = new ArrayList<>();
    if (files != null) {
      for(File file : files) {
        String fileName = file.getName();
        String planId = fileName.substring(0, fileName.indexOf("."));;
        plans.add(Integer.valueOf(planId));
      }
    }
    if(plans.size() != 0) {
      pressureMeasurementMapper.updatePlanStatus(plans);
    }
  }
}
