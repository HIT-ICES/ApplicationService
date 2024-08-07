package com.hitices.pressure.entity;

import com.fasterxml.jackson.annotation.JsonTypeName;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@JsonTypeName("UniformRandomTimer")
public class UniformRandomTimerVO extends TimerVO{

    private double randomDelayMaximum;

    private String constantDelayOffset;

}
