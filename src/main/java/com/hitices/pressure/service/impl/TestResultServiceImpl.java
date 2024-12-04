package com.hitices.pressure.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hitices.pressure.domain.entity.TestResult;
import com.hitices.pressure.repository.TestResultMapper;
import com.hitices.pressure.service.TestResultService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @author 24957
* @description 针对表【test_result】的数据库操作Service实现
* @createDate 2024-12-04 10:00:34
*/
@Service
public class TestResultServiceImpl extends ServiceImpl<TestResultMapper, TestResult>
    implements TestResultService{

    @Autowired
    private TestResultMapper testResultMapper;

    @Override
    public IPage<TestResult> getTestResultsByPlanId(int testPlanId, long current, long size) {
        Page<TestResult> page = new Page<>(current, size);
        IPage<TestResult> resultPage = testResultMapper.selectPage(page,
                new QueryWrapper<TestResult>().eq("plan_id", testPlanId));
        return resultPage;
    }

}




