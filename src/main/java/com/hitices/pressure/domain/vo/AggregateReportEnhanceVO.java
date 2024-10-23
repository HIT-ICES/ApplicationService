package com.hitices.pressure.domain.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class AggregateReportEnhanceVO extends AggregateReportVO{

    String namespace;

    String podName;

    String name;
}
