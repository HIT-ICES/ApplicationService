package com.hitices.pressure.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hitices.pressure.domain.entity.JointPlan;
import com.hitices.pressure.domain.entity.JointPlanMap;
import com.hitices.pressure.domain.vo.JointPlanVO;
import com.hitices.pressure.domain.vo.TestPlanVO;
import com.hitices.pressure.repository.JointPlanMapMapper;
import com.hitices.pressure.repository.JointPlanMapper;
import com.hitices.pressure.repository.PressureMeasurementMapper;
import com.hitices.pressure.service.JointPlanService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
* @author 24957
* @description 针对表【joint_plan】的数据库操作Service实现
* @createDate 2024-10-20 15:24:39
*/
@Service
public class JointPlanServiceImpl extends ServiceImpl<JointPlanMapper, JointPlan>
    implements JointPlanService{

    @Autowired
    private PressureMeasurementMapper pressureMeasurementMapper;

    @Autowired
    private JointPlanMapMapper jointPlanMapMapper;


    @Override
    @Transactional
    public boolean addJointPlan(JointPlanVO jointPlanVO) {
        String name = jointPlanVO.getName();
        String comment = jointPlanVO.getComment();
        List<Integer> testPlanIds = jointPlanVO.getTestPlanIds();

        //首先添加JointPlan
        JointPlan jointPlan = new JointPlan();
        jointPlan.setJointPlanName(name);
        jointPlan.setComment(comment);
        jointPlan.setStatus("Created");
        int insert = this.baseMapper.insert(jointPlan);
        if(insert <= 0) throw new RuntimeException("添加联合测试计划失败!");

        //依次检查每个testPlanId是否存在,并添加到数据库
        boolean isExist = testPlanIds.stream().allMatch(id -> {
            TestPlanVO testPlanById = pressureMeasurementMapper.getTestPlanById(id);
            if (ObjectUtils.isNotNull(testPlanById) && ObjectUtils.isNotEmpty(testPlanById)) {
                JointPlanMap jointPlanMap = new JointPlanMap();
                jointPlanMap.setJointPlanId(jointPlan.getId());
                jointPlanMap.setPlanId(id);
                int insert1 = jointPlanMapMapper.insert(jointPlanMap);
                if(insert1 <= 0) return false;
                return true;
            }
            return false;
        });

        //如果添加出现了问题，直接抛出异常，回滚事务
        if(!isExist) {
            throw new RuntimeException("添加联合测试计划与测试计划映射关系失败,测试计划可能不存在!");
        }
        return true;
    }

    @Override
    public List<JointPlanMap> getPlanByJointPlanId(Integer jointPlanId) {
        LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JointPlanMap::getJointPlanId,jointPlanId);
        List<JointPlanMap> planMapList = jointPlanMapMapper.selectList(wrapper);
        return planMapList;
    }

    @Override
    @Transactional
    public boolean updateJointPlanStatus(Integer jointPlanId, String status) {
        LambdaQueryWrapper<JointPlan> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(JointPlan::getId,jointPlanId);
        JointPlan jointPlan = this.baseMapper.selectOne(queryWrapper);
        jointPlan.setStatus(status);
        int i = this.baseMapper.updateById(jointPlan);
        if(i <= 0){
            throw new RuntimeException("更新联合任务状态失败!");
        }
        return true;
    }

    @Override
    public List<JointPlanVO> getJointTestPlans() {
        List<JointPlan> jointTestPlans = this.baseMapper.selectList(null);
        List<JointPlanVO> result = jointTestPlans.stream().map(jointPlan -> {
            JointPlanVO jointPlanVO = new JointPlanVO();
            BeanUtils.copyProperties(jointPlan, jointPlanVO);
            jointPlanVO.setName(jointPlan.getJointPlanName());
            LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(JointPlanMap::getJointPlanId, jointPlan.getId());
            List<JointPlanMap> jointPlanMaps = jointPlanMapMapper.selectList(wrapper);
            //获取该jointPlan的所有子查询计划的Id
            List<String> collect = jointPlanMaps.stream().map(jointPlanMap -> {
                Integer planId = jointPlanMap.getPlanId();
                TestPlanVO testPlanById = pressureMeasurementMapper.getTestPlanById(planId);
                if(testPlanById != null) return testPlanById.getTestPlanName();
                return null;
            }).collect(Collectors.toList());

            List<Integer> collect1 = jointPlanMaps.stream().map(jointPlanMap -> {
                return jointPlanMap.getPlanId();
            }).collect(Collectors.toList());

            jointPlanVO.setTestPlansName(collect);
            jointPlanVO.setTestPlanIds(collect1);
            return jointPlanVO;
        }).collect(Collectors.toList());
        return result;
    }

    @Override
    public JointPlanVO getJointTestPlanById(int jointPlanId) {
        JointPlan jointPlan = this.baseMapper.selectById(jointPlanId);
        JointPlanVO result = new JointPlanVO();
        BeanUtils.copyProperties(jointPlan,result);
        result.setName(jointPlan.getJointPlanName());
        //设置子计划
        LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JointPlanMap::getJointPlanId, jointPlan.getId());
        List<JointPlanMap> jointPlanMaps = jointPlanMapMapper.selectList(wrapper);

        List<String> collect = jointPlanMaps.stream().map(jointPlanMap -> {
            Integer planId = jointPlanMap.getPlanId();
            TestPlanVO testPlanById = pressureMeasurementMapper.getTestPlanById(planId);
            return testPlanById.getTestPlanName();
        }).collect(Collectors.toList());

        List<Integer> collect1 = jointPlanMaps.stream().map(jointPlanMap -> {
            return jointPlanMap.getPlanId();
        }).collect(Collectors.toList());

        result.setTestPlansName(collect);
        result.setTestPlanIds(collect1);
        return result;

    }

    @Override
    public List<TestPlanVO> getJointTestPlanSonById(int jointPlanId) {
        //先找到jointPlan所有映射到的子plan id
        LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JointPlanMap::getJointPlanId, jointPlanId);
        List<JointPlanMap> jointPlanMaps = jointPlanMapMapper.selectList(wrapper);
        List<TestPlanVO> collect = jointPlanMaps.stream().map(jointPlanMap -> {
            Integer planId = jointPlanMap.getPlanId();
            return pressureMeasurementMapper.getTestPlanById(planId);
        }).collect(Collectors.toList());
        return collect;
    }

    @Override
    @Transactional
    public boolean updateJointPlan(JointPlanVO jointPlanVO) {
        String name = jointPlanVO.getName();
        String comment = jointPlanVO.getComment();
        List<Integer> testPlanIds = jointPlanVO.getTestPlanIds();

        //首先更新JointPlan
        JointPlan jointPlan = new JointPlan();
        jointPlan.setId(jointPlanVO.getId());
        jointPlan.setJointPlanName(name);
        jointPlan.setComment(comment);
        jointPlan.setStatus("Created");
        int i = this.baseMapper.updateById(jointPlan);
        if(i <= 0) throw new RuntimeException("更新联合测试计划失败!");

        //删除原来的映射关系
        LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JointPlanMap::getJointPlanId,jointPlanVO.getId());
        int delete = jointPlanMapMapper.delete(wrapper);
        if(delete < 2) throw new RuntimeException("删除原有映射关系失败!");

        //依次检查每个testPlanId是否存在,并添加新的映射关系到数据库
        boolean isExist = testPlanIds.stream().allMatch(id -> {
            TestPlanVO testPlanById = pressureMeasurementMapper.getTestPlanById(id);
            if (ObjectUtils.isNotNull(testPlanById) && ObjectUtils.isNotEmpty(testPlanById)) {
                JointPlanMap jointPlanMap = new JointPlanMap();
                jointPlanMap.setJointPlanId(jointPlan.getId());
                jointPlanMap.setPlanId(id);
                int insert1 = jointPlanMapMapper.insert(jointPlanMap);
                if(insert1 <= 0) return false;
                return true;
            }
            return false;
        });
        //如果添加出现了问题，直接抛出异常，回滚事务
        if(!isExist) {
            throw new RuntimeException("更新联合测试计划与测试计划映射关系失败!");
        }
        return true;
    }

    @Override
    public boolean removeJointPlanById(int jointPlanId) {
        //删除joint Plan
        int i = this.baseMapper.deleteById(jointPlanId);
        if(i <= 0) return false;
        //删除joint Plan 和 test Plan的映射关系
        LambdaQueryWrapper<JointPlanMap> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JointPlanMap::getJointPlanId,jointPlanId);
        int delete = jointPlanMapMapper.delete(wrapper);
        if(delete < 2) return false;
        return true;
    }
}




