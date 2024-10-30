package com.hitices.pressure.utils;
import com.hitices.pressure.domain.entity.AggregateGroupReport;
import com.hitices.pressure.domain.vo.AggregateReportEnhanceVO;
import com.hitices.pressure.domain.vo.AggregateReportVO;
import com.hitices.pressure.domain.entity.HardwareRecord;
import com.hitices.pressure.domain.entity.NetworkRecord;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ExcelGenerator {

    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    private static String formatTimestamp(Long timestamp) {

        return sdf.format(new Date(timestamp * 1000));
    }

    public static InputStream generateBoundaryExcel(List<AggregateReportVO> aggregateReportVOList) throws IOException {
        // 创建工作簿
        Workbook workbook = new HSSFWorkbook();
        // 创建工作表
        Sheet brSheet = workbook.createSheet("Boundary Report");
        // 创建行
        Row labelRow = brSheet.createRow(0);


        Cell cell10 = labelRow.createCell(0);
        cell10.setCellValue("Concurrency");
        Cell cell11 = labelRow.createCell(1);
        cell11.setCellValue("# Samples");
        Cell cell12 = labelRow.createCell(2);
        cell12.setCellValue("Average");
        Cell cell13 = labelRow.createCell(3);
        cell13.setCellValue("Median");
        Cell cell14 = labelRow.createCell(4);
        cell14.setCellValue("MIN");
        Cell cell15 = labelRow.createCell(5);
        cell15.setCellValue("MAX");
        Cell cell16 = labelRow.createCell(6);
        cell16.setCellValue("p90");
        Cell cell17 = labelRow.createCell(7);
        cell17.setCellValue("P95");
        Cell cell18 = labelRow.createCell(8);
        cell18.setCellValue("P99");
        Cell cell19 = labelRow.createCell(9);
        cell19.setCellValue("TPS");
        Cell cell110 = labelRow.createCell(10);
        cell110.setCellValue("Error %");

        int rowIndex = 1;

        for(AggregateReportVO aggregateReportVO: aggregateReportVOList)  {
            Row valueRow = brSheet.createRow(rowIndex);
            valueRow.createCell(0).setCellValue(aggregateReportVO.getId());
            valueRow.createCell(1).setCellValue(aggregateReportVO.getSamplesNum());
            valueRow.createCell(2).setCellValue(aggregateReportVO.getAverage());
            valueRow.createCell(3).setCellValue(aggregateReportVO.getMedian());
            valueRow.createCell(4).setCellValue(aggregateReportVO.getMin());
            valueRow.createCell(5).setCellValue(aggregateReportVO.getMax());
            valueRow.createCell(6).setCellValue(aggregateReportVO.getP90());
            valueRow.createCell(7).setCellValue(aggregateReportVO.getP95());
            valueRow.createCell(8).setCellValue(aggregateReportVO.getP99());
            valueRow.createCell(9).setCellValue(aggregateReportVO.getTps());
            valueRow.createCell(10).setCellValue(aggregateReportVO.getErrorRate());
            rowIndex++;
        }
        try (ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
            workbook.write(byteArrayOutputStream);
            return new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        } finally {
            // 关闭工作簿
            workbook.close();
        }

    }

    public static InputStream generateAggregateReportExcel(AggregateReportVO aggregateReportVO, List<AggregateReportEnhanceVO> aggregateGroupReport , ArrayList<HardwareRecord> cpuUsage, ArrayList<HardwareRecord> memoryUsage, ArrayList<NetworkRecord> byteTransmitted, ArrayList<NetworkRecord> byteReceived) throws IOException {
        // 创建工作簿
        Workbook workbook = new HSSFWorkbook();
        // 创建工作表
        Sheet arSheet = workbook.createSheet("Aggregate Report");
        // 创建行
        Row title1Row = arSheet.createRow(0);
        Row labelRow = arSheet.createRow(1);
        Row valueRow = arSheet.createRow(2);
        Row title2Row = arSheet.createRow(4);

        Cell cell0 = title1Row.createCell(0);
        cell0.setCellValue("聚合报告");
        Cell cell4 = title2Row.createCell(0);
        cell4.setCellValue("线程组聚合报告");

        // 创建单元格
        Cell cell10 = labelRow.createCell(0);
        cell10.setCellValue("Label");
        Cell cell20 = valueRow.createCell(0);
        cell20.setCellValue("Total");

        Cell cell11 = labelRow.createCell(1);
        cell11.setCellValue("# Samples");
        Cell cell21 = valueRow.createCell(1);
        cell21.setCellValue(aggregateReportVO.getSamplesNum());

        Cell cell12 = labelRow.createCell(2);
        cell12.setCellValue("Average");
        Cell cell22 = valueRow.createCell(2);
        cell22.setCellValue(aggregateReportVO.getAverage());

        Cell cell13 = labelRow.createCell(3);
        cell13.setCellValue("Median");
        Cell cell23 = valueRow.createCell(3);
        cell23.setCellValue(aggregateReportVO.getMedian());

        Cell cell14 = labelRow.createCell(4);
        cell14.setCellValue("MIN");
        Cell cell24 = valueRow.createCell(4);
        cell24.setCellValue(aggregateReportVO.getMin());

        Cell cell15 = labelRow.createCell(5);
        cell15.setCellValue("MAX");
        Cell cell25 = valueRow.createCell(5);
        cell25.setCellValue(aggregateReportVO.getMax());

        Cell cell16 = labelRow.createCell(6);
        cell16.setCellValue("p90");
        Cell cell26 = valueRow.createCell(6);
        cell26.setCellValue(aggregateReportVO.getP90());

        Cell cell17 = labelRow.createCell(7);
        cell17.setCellValue("P95");
        Cell cell27 = valueRow.createCell(7);
        cell27.setCellValue(aggregateReportVO.getP95());

        Cell cell18 = labelRow.createCell(8);
        cell18.setCellValue("TPS");
        Cell cell28 = valueRow.createCell(8);
        cell28.setCellValue(aggregateReportVO.getP99());

        Cell cell19 = labelRow.createCell(9);
        cell19.setCellValue("Error %");
        Cell cell29 = valueRow.createCell(9);
        cell29.setCellValue(aggregateReportVO.getErrorRate());

        //设置title
        Row labelRow2 =  arSheet.createRow(5);
        // 创建单元格
        Cell cell50 = labelRow2.createCell(0);
        cell50.setCellValue("Label");

        Cell cell51 = labelRow2.createCell(1);
        cell51.setCellValue("# Samples");

        Cell cell52 = labelRow2.createCell(2);
        cell52.setCellValue("Average");


        Cell cell53 = labelRow2.createCell(3);
        cell53.setCellValue("Median");


        Cell cell54 = labelRow2.createCell(4);
        cell54.setCellValue("MIN");


        Cell cell55 = labelRow2.createCell(5);
        cell55.setCellValue("MAX");


        Cell cell56 = labelRow2.createCell(6);
        cell56.setCellValue("p90");


        Cell cell57 = labelRow2.createCell(7);
        cell57.setCellValue("P95");


        Cell cell58 = labelRow2.createCell(8);
        cell58.setCellValue("TPS");


        Cell cell59 = labelRow2.createCell(9);
        cell59.setCellValue("Error %");

        for(int i = 0 ; i < aggregateGroupReport.size() ; i++){
            AggregateReportEnhanceVO groupReport = aggregateGroupReport.get(i);
            int curRow = 6 + i;
            Row valueRow2 = arSheet.createRow(curRow);
            Cell celli0 = valueRow2.createCell(0);
            celli0.setCellValue(groupReport.getGroupName());

            Cell celli1 = valueRow2.createCell(1);
            celli1.setCellValue(groupReport.getSamplesNum());

            Cell celli2 = valueRow2.createCell(2);
            celli2.setCellValue(groupReport.getAverage());

            Cell celli3 = valueRow2.createCell(3);
            celli3.setCellValue(groupReport.getMedian());

            Cell celli4 = valueRow2.createCell(4);
            celli4.setCellValue(groupReport.getMin());

            Cell celli5 = valueRow2.createCell(5);
            celli5.setCellValue(groupReport.getMax());

            Cell celli6 = valueRow2.createCell(6);
            celli6.setCellValue(groupReport.getP90());

            Cell celli7 = valueRow2.createCell(7);
            celli7.setCellValue(groupReport.getP95());

            Cell celli8 = valueRow2.createCell(8);
            celli8.setCellValue(groupReport.getP99());

            Cell celli9 = valueRow2.createCell(9);
            celli9.setCellValue(groupReport.getErrorRate());
        }

        Sheet cpuSheet = workbook.createSheet("CPU Report");
        Row cpuLabelRow = cpuSheet.createRow(0);
        cpuLabelRow.createCell(0).setCellValue("时间");
        cpuLabelRow.createCell(1).setCellValue("CPU用量 (m)");
        int rowIdx = 1;
        for(HardwareRecord hardwareRecord : cpuUsage) {
            Row tmpRow = cpuSheet.createRow(rowIdx);
            rowIdx++;
            tmpRow.createCell(0).setCellValue(formatTimestamp(hardwareRecord.getName()));
            tmpRow.createCell(1).setCellValue(hardwareRecord.getUsage());
        }

        Sheet memorySheet = workbook.createSheet("Memory Report");
        Row memoryLabelRow = memorySheet.createRow(0);
        memoryLabelRow.createCell(0).setCellValue("时间");
        memoryLabelRow.createCell(1).setCellValue("内存用量 (Mi)");
        rowIdx = 1;
        for(HardwareRecord hardwareRecord : memoryUsage) {
            Row tmpRow = memorySheet.createRow(rowIdx);
            rowIdx++;
            tmpRow.createCell(0).setCellValue(formatTimestamp(hardwareRecord.getName()));
            tmpRow.createCell(1).setCellValue(hardwareRecord.getUsage());
        }

        Sheet byteTransmittedSheet = workbook.createSheet("Transmitted Bytes Report");
        Row byteTransmittedLabelRow = byteTransmittedSheet.createRow(0);
        byteTransmittedLabelRow.createCell(0).setCellValue("时间");
        byteTransmittedLabelRow.createCell(1).setCellValue("出站流量 (Kbps)");
        rowIdx = 1;
        for(NetworkRecord networkRecord : byteTransmitted) {
            Row tmpRow = byteTransmittedSheet.createRow(rowIdx);
            rowIdx++;
            tmpRow.createCell(0).setCellValue(formatTimestamp(networkRecord.getName()));
            tmpRow.createCell(1).setCellValue(networkRecord.getFlow());
        }

        Sheet byteReceivedSheet = workbook.createSheet("Received Bytes Report");
        Row byteReceivedLabelRow = byteReceivedSheet.createRow(0);
        byteReceivedLabelRow.createCell(0).setCellValue("时间");
        byteReceivedLabelRow.createCell(1).setCellValue("入站流量 (Kbps)");
        rowIdx = 1;
        for(NetworkRecord networkRecord : byteReceived) {
            Row tmpRow = byteReceivedSheet.createRow(rowIdx);
            rowIdx++;
            tmpRow.createCell(0).setCellValue(formatTimestamp(networkRecord.getName()));
            tmpRow.createCell(1).setCellValue(networkRecord.getFlow());
        }

        // 使用 ByteArrayOutputStream 将 Excel 数据写入内存
//        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
//        response.setHeader("Content-disposition", "attachment;filename=sss.xlsx");
//        response.flushBuffer();
//        workbook.write(response.getOutputStream());
//        workbook.close();
        try (ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
            workbook.write(byteArrayOutputStream);
            return new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        } finally {
            // 关闭工作簿
            workbook.close();
        }
    }


}

