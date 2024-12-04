package com.hitices.pressure.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.hitices.pressure.domain.entity.TestResult;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hitices.pressure.domain.vo.TestResultVO;

/**
* @author 24957
* @description 针对表【test_result】的数据库操作Service
* @createDate 2024-12-04 10:00:34
*/
public interface TestResultService extends IService<TestResult> {

    IPage<TestResult> getTestResultsByPlanId(int testPlanId, long current, long size);
}
