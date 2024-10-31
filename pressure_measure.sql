/*
 Navicat Premium Data Transfer

 Source Server         : 本机MySql
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : localhost:3306
 Source Schema         : pressure_measure

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 31/10/2024 15:11:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aggregate_group_report
-- ----------------------------
DROP TABLE IF EXISTS `aggregate_group_report`;
CREATE TABLE `aggregate_group_report`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) NULL DEFAULT NULL,
  `group_id` int(11) NULL DEFAULT NULL,
  `thread_group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `samples_num` int(11) NULL DEFAULT NULL,
  `average` double NULL DEFAULT NULL,
  `median` double NULL DEFAULT NULL,
  `min` double NULL DEFAULT NULL,
  `max` double NULL DEFAULT NULL,
  `p90` double NULL DEFAULT NULL,
  `p95` double NULL DEFAULT NULL,
  `p99` double NULL DEFAULT NULL,
  `tps` double NULL DEFAULT NULL,
  `error_rate` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of aggregate_group_report
-- ----------------------------
INSERT INTO `aggregate_group_report` VALUES (18, 69, 112, 'thread group1', 4, 21, 18.5, 0, 47, 18.5, 41.5, 41.5, 0.00001720163759589913, 0);
INSERT INTO `aggregate_group_report` VALUES (19, 69, 113, 'thread group3', 40, 2.7, 1, 0, 47, 1, 19, 41.5, 0.00017201489649003603, 0);
INSERT INTO `aggregate_group_report` VALUES (20, 69, 114, 'thread group1', 4, 21, 18.5, 0, 47, 18.5, 41.5, 41.5, 0.00001720163759589913, 0);
INSERT INTO `aggregate_group_report` VALUES (21, 70, 115, 'thread group1', 4, 0.75, 1, 0, 1, 1, 1, 1, 0.00001720163759589913, 0);
INSERT INTO `aggregate_group_report` VALUES (22, 70, 116, 'thread group3', 40, 0.575, 1, 0, 1, 1, 1, 1, 0.00017201489649003603, 0);
INSERT INTO `aggregate_group_report` VALUES (23, 70, 117, 'thread group1', 4, 0.75, 1, 0, 1, 1, 1, 1, 0.00001720163759589913, 0);
INSERT INTO `aggregate_group_report` VALUES (24, 68, 109, 'thread group1', 2, 48, 48, 46, 50, 48, 48, 48, 0.000008493037832237024, 0);
INSERT INTO `aggregate_group_report` VALUES (25, 68, 110, 'thread group3', 20, 5.45, 1, 0, 50, 1, 48, 48, 0.00008493001766544368, 0);
INSERT INTO `aggregate_group_report` VALUES (26, 68, 111, 'thread group1', 2, 48, 48, 46, 50, 48, 48, 48, 0.000008493037832237024, 0);

-- ----------------------------
-- Table structure for aggregate_report
-- ----------------------------
DROP TABLE IF EXISTS `aggregate_report`;
CREATE TABLE `aggregate_report`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) NULL DEFAULT NULL,
  `samples_num` int(11) NULL DEFAULT NULL,
  `average` double NULL DEFAULT NULL,
  `median` double NULL DEFAULT NULL,
  `min` double NULL DEFAULT NULL,
  `max` double NULL DEFAULT NULL,
  `p90` double NULL DEFAULT NULL,
  `p95` double NULL DEFAULT NULL,
  `p99` double NULL DEFAULT NULL,
  `tps` double NULL DEFAULT NULL,
  `error_rate` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of aggregate_report
-- ----------------------------
INSERT INTO `aggregate_report` VALUES (40, 69, 48, 5.75, 1, 0, 47, 1, 41.5, 47, 0.00020641787578804324, 0);
INSERT INTO `aggregate_report` VALUES (41, 70, 48, 0.6041666666666666, 1, 0, 1, 1, 1, 1, 0.00020641787578804324, 0);
INSERT INTO `aggregate_report` VALUES (42, 68, 24, 12.541666666666666, 1, 0, 50, 1, 50, 50, 0.00010191602119853241, 0);

-- ----------------------------
-- Table structure for constant_timer
-- ----------------------------
DROP TABLE IF EXISTS `constant_timer`;
CREATE TABLE `constant_timer`  (
  `id` int(11) NOT NULL COMMENT '定时器id',
  `timer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '定时器名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `thread_delay` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '线程延迟时间(ms)',
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_constant_timer_timer` FOREIGN KEY (`id`) REFERENCES `timer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of constant_timer
-- ----------------------------
INSERT INTO `constant_timer` VALUES (100, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (101, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (102, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (103, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (104, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (105, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (106, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (107, NULL, '2', '300');
INSERT INTO `constant_timer` VALUES (108, NULL, '2', '300');

-- ----------------------------
-- Table structure for cookie_manager
-- ----------------------------
DROP TABLE IF EXISTS `cookie_manager`;
CREATE TABLE `cookie_manager`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'cookie管理器id',
  `cookie_manager_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cookie管理器名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `cookies` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cookies',
  `clear_each_iteration` bit(1) NOT NULL COMMENT '每次迭代是否清除cookie',
  `thread_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cookie_manager_thread_group`(`thread_group_id`) USING BTREE,
  CONSTRAINT `fk_cookie_manager_thread_group` FOREIGN KEY (`thread_group_id`) REFERENCES `thread_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cookie_manager
-- ----------------------------

-- ----------------------------
-- Table structure for gaussian_random_timer
-- ----------------------------
DROP TABLE IF EXISTS `gaussian_random_timer`;
CREATE TABLE `gaussian_random_timer`  (
  `id` int(11) NOT NULL COMMENT '定时器id',
  `timer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '定时器名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `deviation` bigint(20) NOT NULL COMMENT '偏差(ms)',
  `constant_delay_offset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '固定延迟(ms)',
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_gaussian_random_timer_timer` FOREIGN KEY (`id`) REFERENCES `timer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gaussian_random_timer
-- ----------------------------

-- ----------------------------
-- Table structure for header_manager
-- ----------------------------
DROP TABLE IF EXISTS `header_manager`;
CREATE TABLE `header_manager`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'http请求信息头管理器id',
  `header_manager_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'http请求信息头管理器名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `headers` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求信息头键值对',
  `thread_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_header_manager_thread_group`(`thread_group_id`) USING BTREE,
  CONSTRAINT `fk_header_manager_thread_group` FOREIGN KEY (`thread_group_id`) REFERENCES `thread_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of header_manager
-- ----------------------------
INSERT INTO `header_manager` VALUES (102, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 109);
INSERT INTO `header_manager` VALUES (103, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 110);
INSERT INTO `header_manager` VALUES (104, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 111);
INSERT INTO `header_manager` VALUES (105, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 112);
INSERT INTO `header_manager` VALUES (106, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 113);
INSERT INTO `header_manager` VALUES (107, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 114);
INSERT INTO `header_manager` VALUES (108, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 115);
INSERT INTO `header_manager` VALUES (109, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 116);
INSERT INTO `header_manager` VALUES (110, 'header manager', NULL, '{\"Content-Type\":\"application/text\"}', 117);
INSERT INTO `header_manager` VALUES (111, 'header manager', NULL, '{}', 118);

-- ----------------------------
-- Table structure for http_sampler_proxy
-- ----------------------------
DROP TABLE IF EXISTS `http_sampler_proxy`;
CREATE TABLE `http_sampler_proxy`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'http请求取样器id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'http请求取样器名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `protocol` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'http请求协议，如https、http',
  `server` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '服务器名称或IP地址',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求路径',
  `port` int(11) NOT NULL COMMENT '端口',
  `method` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方法',
  `content_encoding` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容编码',
  `use_keep_alive` bit(1) NULL DEFAULT b'1' COMMENT '是否使用保持连接',
  `follow_redirects` bit(1) NULL DEFAULT b'1' COMMENT '是否开启跟随重定向',
  `auto_redirects` bit(1) NULL DEFAULT b'0' COMMENT '是否开启自动重定向',
  `arguments` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数键值对',
  `thread_group_id` int(11) NOT NULL COMMENT '所属线程组id',
  `body` varchar(1023) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求体',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_http_sampler_proxy_thread_group`(`thread_group_id`) USING BTREE,
  CONSTRAINT `fk_http_sampler_proxy_thread_group` FOREIGN KEY (`thread_group_id`) REFERENCES `thread_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of http_sampler_proxy
-- ----------------------------
INSERT INTO `http_sampler_proxy` VALUES (102, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 109, '');
INSERT INTO `http_sampler_proxy` VALUES (103, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 110, '');
INSERT INTO `http_sampler_proxy` VALUES (104, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 111, '');
INSERT INTO `http_sampler_proxy` VALUES (105, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 112, '');
INSERT INTO `http_sampler_proxy` VALUES (106, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 113, '');
INSERT INTO `http_sampler_proxy` VALUES (107, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 114, '');
INSERT INTO `http_sampler_proxy` VALUES (108, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 115, '');
INSERT INTO `http_sampler_proxy` VALUES (109, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 116, '');
INSERT INTO `http_sampler_proxy` VALUES (110, 'http sampler proxy', NULL, 'http', 'localhost', '/testMeasure/getSystem', 8848, 'GET', NULL, b'1', b'1', b'0', 'null', 117, '');
INSERT INTO `http_sampler_proxy` VALUES (111, 'HTTP请求默认值', NULL, '', '', '123', 0, 'POST', NULL, b'1', b'1', b'0', '{}', 118, '');

-- ----------------------------
-- Table structure for joint_plan
-- ----------------------------
DROP TABLE IF EXISTS `joint_plan`;
CREATE TABLE `joint_plan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `joint_plan_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '测试计划状态，已创建，运行中，执行完毕',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of joint_plan
-- ----------------------------

-- ----------------------------
-- Table structure for joint_plan_map
-- ----------------------------
DROP TABLE IF EXISTS `joint_plan_map`;
CREATE TABLE `joint_plan_map`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `joint_plan_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 226 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of joint_plan_map
-- ----------------------------

-- ----------------------------
-- Table structure for loop_controller
-- ----------------------------
DROP TABLE IF EXISTS `loop_controller`;
CREATE TABLE `loop_controller`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `loop_num` int(11) NOT NULL,
  `continue_forever` bit(1) NOT NULL,
  `thread_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `loop_controller___fk_thread_group`(`thread_group_id`) USING BTREE,
  CONSTRAINT `loop_controller___fk_thread_group` FOREIGN KEY (`thread_group_id`) REFERENCES `thread_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '循环控制器' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of loop_controller
-- ----------------------------
INSERT INTO `loop_controller` VALUES (94, 'loop controller', NULL, 1, b'0', 109);
INSERT INTO `loop_controller` VALUES (95, 'loop controller', NULL, 1, b'0', 110);
INSERT INTO `loop_controller` VALUES (96, 'loop controller', NULL, 1, b'0', 111);
INSERT INTO `loop_controller` VALUES (97, 'loop controller', NULL, 1, b'0', 112);
INSERT INTO `loop_controller` VALUES (98, 'loop controller', NULL, 1, b'0', 113);
INSERT INTO `loop_controller` VALUES (99, 'loop controller', NULL, 1, b'0', 114);
INSERT INTO `loop_controller` VALUES (100, 'loop controller', NULL, 1, b'0', 115);
INSERT INTO `loop_controller` VALUES (101, 'loop controller', NULL, 1, b'0', 116);
INSERT INTO `loop_controller` VALUES (102, 'loop controller', NULL, 1, b'0', 117);
INSERT INTO `loop_controller` VALUES (103, 'Loop Controller', NULL, 1, b'0', 118);

-- ----------------------------
-- Table structure for poisson_random_timer
-- ----------------------------
DROP TABLE IF EXISTS `poisson_random_timer`;
CREATE TABLE `poisson_random_timer`  (
  `id` int(11) NOT NULL COMMENT '定时器id',
  `timer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '定时器名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `lambda` bigint(20) NOT NULL COMMENT 'lambda(ms)',
  `constant_delay_offset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '固定延迟(ms)',
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_poissonrandomtimer_timer` FOREIGN KEY (`id`) REFERENCES `timer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of poisson_random_timer
-- ----------------------------

-- ----------------------------
-- Table structure for test_plan
-- ----------------------------
DROP TABLE IF EXISTS `test_plan`;
CREATE TABLE `test_plan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '测试计划id',
  `test_plan_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '测试计划名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `serialized` bit(1) NOT NULL COMMENT '是否独立运行每个线程组，如在一个组运行结束后启动下一个',
  `functional_mode` bit(1) NOT NULL COMMENT '是否开启函数测试模式',
  `tear_down` bit(1) NOT NULL COMMENT '主线程结束后是否允许tear down线程组',
  `status` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '测试计划状态，已创建，运行中，执行完毕',
  `namespace` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pod_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `boundary` bit(1) NOT NULL COMMENT '是否是边界测试',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_plan
-- ----------------------------
INSERT INTO `test_plan` VALUES (68, 't1', NULL, b'0', b'0', b'0', 'Completed', 'userService', 'java', b'0');
INSERT INTO `test_plan` VALUES (69, 't2', NULL, b'0', b'0', b'0', 'Completed', 'userService', 'java', b'0');
INSERT INTO `test_plan` VALUES (70, 't3', NULL, b'0', b'0', b'0', 'Completed', 'userService', 'java', b'0');
INSERT INTO `test_plan` VALUES (71, 'Test Plan', '123', b'0', b'0', b'0', 'Created', 'zr', 'network-service-57c547ccf4-blvxg', b'0');

-- ----------------------------
-- Table structure for test_result
-- ----------------------------
DROP TABLE IF EXISTS `test_result`;
CREATE TABLE `test_result`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) NULL DEFAULT NULL,
  `group_id` int(11) NULL DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `pause_time` bigint(20) NULL DEFAULT NULL,
  `idle_time` bigint(20) NULL DEFAULT NULL,
  `latency` bigint(20) NULL DEFAULT NULL,
  `success` int(11) NULL DEFAULT NULL,
  `connect_time` bigint(20) NULL DEFAULT NULL,
  `response_code` int(11) NULL DEFAULT NULL,
  `response_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `response_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `response_headers` varchar(1023) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bytes` bigint(20) NULL DEFAULT NULL,
  `headers_size` int(11) NULL DEFAULT NULL,
  `body_size` int(11) NULL DEFAULT NULL,
  `sent_bytes` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of test_result
-- ----------------------------
INSERT INTO `test_result` VALUES (1022, 68, 109, '2024-10-28 18:59:35', '2024-10-28 18:59:35', '2024-10-28 18:59:36', 0, 0, 50, 249, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1023, 68, 110, '2024-10-28 18:59:35', '2024-10-28 18:59:35', '2024-10-28 18:59:36', 0, 0, 50, 356, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1024, 68, 110, '2024-10-28 18:59:35', '2024-10-28 18:59:35', '2024-10-28 18:59:36', 0, 0, 1, 230, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1025, 68, 111, '2024-10-28 18:59:35', '2024-10-28 18:59:35', '2024-10-28 18:59:36', 0, 0, 50, 443, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1026, 68, 110, '2024-10-28 18:59:36', '2024-10-28 18:59:36', '2024-10-28 18:59:36', 0, 0, 1, 335, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1027, 68, 110, '2024-10-28 18:59:36', '2024-10-28 18:59:36', '2024-10-28 18:59:36', 0, 0, 1, 234, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1028, 68, 110, '2024-10-28 18:59:36', '2024-10-28 18:59:36', '2024-10-28 18:59:36', 0, 0, 0, 501, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1029, 68, 110, '2024-10-28 18:59:36', '2024-10-28 18:59:36', '2024-10-28 18:59:36', 0, 0, 1, 154, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:35 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1030, 68, 110, '2024-10-28 18:59:36', '2024-10-28 18:59:36', '2024-10-28 18:59:37', 0, 0, 1, 361, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:36 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1031, 68, 110, '2024-10-28 18:59:37', '2024-10-28 18:59:37', '2024-10-28 18:59:37', 0, 0, 0, 204, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:36 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1032, 68, 110, '2024-10-28 18:59:37', '2024-10-28 18:59:37', '2024-10-28 18:59:37', 0, 0, 0, 253, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:36 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1033, 68, 110, '2024-10-28 18:59:37', '2024-10-28 18:59:37', '2024-10-28 18:59:37', 0, 0, 1, 289, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 10:59:36 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1034, 69, 113, '2024-10-28 19:48:48', '2024-10-28 19:48:48', '2024-10-28 19:48:48', 0, 0, 36, 186, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1035, 69, 114, '2024-10-28 19:48:48', '2024-10-28 19:48:48', '2024-10-28 19:48:48', 0, 0, 36, 208, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1036, 69, 113, '2024-10-28 19:48:48', '2024-10-28 19:48:48', '2024-10-28 19:48:48', 0, 0, 1, 171, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1037, 69, 112, '2024-10-28 19:48:48', '2024-10-28 19:48:48', '2024-10-28 19:48:48', 0, 0, 36, 555, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1038, 69, 113, '2024-10-28 19:48:48', '2024-10-28 19:48:48', '2024-10-28 19:48:49', 0, 0, 0, 412, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1039, 69, 113, '2024-10-28 19:48:49', '2024-10-28 19:48:49', '2024-10-28 19:48:49', 0, 0, 1, 124, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1040, 69, 113, '2024-10-28 19:48:48', '2024-10-28 19:48:48', '2024-10-28 19:48:49', 0, 0, 1, 463, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:47 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1041, 69, 113, '2024-10-28 19:48:49', '2024-10-28 19:48:49', '2024-10-28 19:48:49', 0, 0, 1, 196, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:49 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1042, 69, 113, '2024-10-28 19:48:49', '2024-10-28 19:48:49', '2024-10-28 19:48:49', 0, 0, 1, 471, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:49 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1043, 69, 113, '2024-10-28 19:48:49', '2024-10-28 19:48:49', '2024-10-28 19:48:49', 0, 0, 1, 248, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:49 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1044, 69, 113, '2024-10-28 19:48:49', '2024-10-28 19:48:49', '2024-10-28 19:48:50', 0, 0, 1, 285, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:49 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1045, 69, 113, '2024-10-28 19:48:49', '2024-10-28 19:48:49', '2024-10-28 19:48:50', 0, 0, 0, 122, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:49 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1046, 70, 115, '2024-10-28 19:48:50', '2024-10-28 19:48:50', '2024-10-28 19:48:50', 0, 0, 1, 152, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:49 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1047, 70, 117, '2024-10-28 19:48:50', '2024-10-28 19:48:50', '2024-10-28 19:48:50', 0, 0, 1, 388, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:50 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1048, 70, 116, '2024-10-28 19:48:50', '2024-10-28 19:48:50', '2024-10-28 19:48:50', 0, 0, 1, 459, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:50 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1049, 70, 116, '2024-10-28 19:48:50', '2024-10-28 19:48:50', '2024-10-28 19:48:50', 0, 0, 1, 338, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:50 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1050, 70, 116, '2024-10-28 19:48:50', '2024-10-28 19:48:50', '2024-10-28 19:48:50', 0, 0, 1, 130, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:50 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1051, 70, 116, '2024-10-28 19:48:50', '2024-10-28 19:48:50', '2024-10-28 19:48:51', 0, 0, 0, 388, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:50 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1052, 70, 116, '2024-10-28 19:48:51', '2024-10-28 19:48:51', '2024-10-28 19:48:51', 0, 0, 1, 458, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:50 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1053, 70, 116, '2024-10-28 19:48:51', '2024-10-28 19:48:51', '2024-10-28 19:48:51', 0, 0, 1, 450, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:51 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1054, 70, 116, '2024-10-28 19:48:51', '2024-10-28 19:48:51', '2024-10-28 19:48:51', 0, 0, 0, 394, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:51 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1055, 70, 116, '2024-10-28 19:48:51', '2024-10-28 19:48:51', '2024-10-28 19:48:52', 0, 0, 1, 442, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:51 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1056, 70, 116, '2024-10-28 19:48:52', '2024-10-28 19:48:52', '2024-10-28 19:48:52', 0, 0, 1, 181, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:51 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1057, 70, 116, '2024-10-28 19:48:51', '2024-10-28 19:48:51', '2024-10-28 19:48:52', 0, 0, 0, 475, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Mon, 28 Oct 2024 11:48:51 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1058, 69, 114, '2024-10-30 13:26:15', '2024-10-30 13:26:15', '2024-10-30 13:26:15', 0, 0, 47, 218, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1059, 69, 113, '2024-10-30 13:26:15', '2024-10-30 13:26:15', '2024-10-30 13:26:15', 0, 0, 47, 255, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1060, 69, 112, '2024-10-30 13:26:15', '2024-10-30 13:26:15', '2024-10-30 13:26:15', 0, 0, 47, 465, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1061, 69, 113, '2024-10-30 13:26:15', '2024-10-30 13:26:15', '2024-10-30 13:26:15', 0, 0, 1, 140, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1062, 69, 113, '2024-10-30 13:26:15', '2024-10-30 13:26:15', '2024-10-30 13:26:15', 0, 0, 1, 348, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1063, 69, 113, '2024-10-30 13:26:15', '2024-10-30 13:26:15', '2024-10-30 13:26:16', 0, 0, 1, 132, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1064, 69, 113, '2024-10-30 13:26:16', '2024-10-30 13:26:16', '2024-10-30 13:26:16', 0, 0, 1, 308, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:15 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1065, 69, 113, '2024-10-30 13:26:16', '2024-10-30 13:26:16', '2024-10-30 13:26:16', 0, 0, 1, 462, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:16 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1066, 69, 113, '2024-10-30 13:26:16', '2024-10-30 13:26:16', '2024-10-30 13:26:16', 0, 0, 0, 456, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:16 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1067, 69, 113, '2024-10-30 13:26:16', '2024-10-30 13:26:16', '2024-10-30 13:26:17', 0, 0, 0, 409, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:16 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1068, 69, 113, '2024-10-30 13:26:17', '2024-10-30 13:26:17', '2024-10-30 13:26:17', 0, 0, 0, 111, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:16 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1069, 69, 113, '2024-10-30 13:26:16', '2024-10-30 13:26:16', '2024-10-30 13:26:17', 0, 0, 1, 457, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:16 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1070, 70, 115, '2024-10-30 13:26:17', '2024-10-30 13:26:17', '2024-10-30 13:26:17', 0, 0, 1, 461, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1071, 70, 117, '2024-10-30 13:26:17', '2024-10-30 13:26:17', '2024-10-30 13:26:18', 0, 0, 1, 480, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1072, 70, 116, '2024-10-30 13:26:17', '2024-10-30 13:26:17', '2024-10-30 13:26:18', 0, 0, 0, 505, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1073, 70, 116, '2024-10-30 13:26:17', '2024-10-30 13:26:17', '2024-10-30 13:26:18', 0, 0, 1, 214, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1074, 70, 116, '2024-10-30 13:26:17', '2024-10-30 13:26:17', '2024-10-30 13:26:18', 0, 0, 0, 422, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1075, 70, 116, '2024-10-30 13:26:18', '2024-10-30 13:26:18', '2024-10-30 13:26:18', 0, 0, 1, 108, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1076, 70, 116, '2024-10-30 13:26:18', '2024-10-30 13:26:18', '2024-10-30 13:26:18', 0, 0, 1, 355, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1077, 70, 116, '2024-10-30 13:26:18', '2024-10-30 13:26:18', '2024-10-30 13:26:18', 0, 0, 1, 244, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:17 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1078, 70, 116, '2024-10-30 13:26:18', '2024-10-30 13:26:18', '2024-10-30 13:26:19', 0, 0, 0, 492, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:18 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1079, 70, 116, '2024-10-30 13:26:18', '2024-10-30 13:26:18', '2024-10-30 13:26:19', 0, 0, 1, 161, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:18 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1080, 70, 116, '2024-10-30 13:26:19', '2024-10-30 13:26:19', '2024-10-30 13:26:19', 0, 0, 1, 251, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:18 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1081, 70, 116, '2024-10-30 13:26:19', '2024-10-30 13:26:19', '2024-10-30 13:26:19', 0, 0, 0, 189, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:18 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1082, 69, 112, '2024-10-30 13:26:38', '2024-10-30 13:26:38', '2024-10-30 13:26:38', 0, 0, 1, 170, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1083, 69, 114, '2024-10-30 13:26:38', '2024-10-30 13:26:38', '2024-10-30 13:26:39', 0, 0, 1, 272, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1084, 69, 113, '2024-10-30 13:26:38', '2024-10-30 13:26:38', '2024-10-30 13:26:39', 0, 0, 1, 311, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1085, 69, 113, '2024-10-30 13:26:38', '2024-10-30 13:26:38', '2024-10-30 13:26:39', 0, 0, 1, 391, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1086, 69, 113, '2024-10-30 13:26:39', '2024-10-30 13:26:39', '2024-10-30 13:26:39', 0, 0, 1, 383, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1087, 69, 113, '2024-10-30 13:26:39', '2024-10-30 13:26:39', '2024-10-30 13:26:39', 0, 0, 1, 219, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1088, 69, 113, '2024-10-30 13:26:39', '2024-10-30 13:26:39', '2024-10-30 13:26:39', 0, 0, 1, 229, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:38 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1089, 69, 113, '2024-10-30 13:26:39', '2024-10-30 13:26:39', '2024-10-30 13:26:39', 0, 0, 0, 196, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:39 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1090, 69, 113, '2024-10-30 13:26:39', '2024-10-30 13:26:39', '2024-10-30 13:26:40', 0, 0, 1, 138, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:39 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1091, 69, 113, '2024-10-30 13:26:40', '2024-10-30 13:26:40', '2024-10-30 13:26:40', 0, 0, 0, 264, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:39 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1092, 69, 113, '2024-10-30 13:26:40', '2024-10-30 13:26:40', '2024-10-30 13:26:40', 0, 0, 2, 346, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:39 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1093, 69, 113, '2024-10-30 13:26:40', '2024-10-30 13:26:40', '2024-10-30 13:26:41', 0, 0, 0, 483, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:40 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1094, 70, 115, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:41', 0, 0, 0, 359, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:40 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1095, 70, 117, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:41', 0, 0, 0, 366, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:40 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1096, 70, 116, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:41', 0, 0, 0, 414, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:40 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1097, 70, 116, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:41', 0, 0, 1, 297, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:40 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1098, 70, 116, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:41', 0, 0, 0, 199, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:40 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1099, 70, 116, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:42', 0, 0, 0, 348, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:41 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1100, 70, 116, '2024-10-30 13:26:41', '2024-10-30 13:26:41', '2024-10-30 13:26:42', 0, 0, 0, 463, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:41 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1101, 70, 116, '2024-10-30 13:26:42', '2024-10-30 13:26:42', '2024-10-30 13:26:42', 0, 0, 1, 167, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:41 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1102, 70, 116, '2024-10-30 13:26:42', '2024-10-30 13:26:42', '2024-10-30 13:26:42', 0, 0, 1, 393, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:41 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1103, 70, 116, '2024-10-30 13:26:42', '2024-10-30 13:26:42', '2024-10-30 13:26:42', 0, 0, 0, 208, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:41 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1104, 70, 116, '2024-10-30 13:26:42', '2024-10-30 13:26:42', '2024-10-30 13:26:43', 0, 0, 1, 501, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:42 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1105, 70, 116, '2024-10-30 13:26:42', '2024-10-30 13:26:42', '2024-10-30 13:26:43', 0, 0, 0, 424, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Wed, 30 Oct 2024 05:26:42 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1106, 68, 110, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:22', 0, 0, 46, 232, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1107, 68, 111, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:22', 0, 0, 46, 464, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1108, 68, 109, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:22', 0, 0, 46, 524, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1109, 68, 110, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:22', 0, 0, 1, 474, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1110, 68, 110, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:22', 0, 0, 1, 427, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1111, 68, 110, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:22', 0, 0, 1, 231, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1112, 68, 110, '2024-10-31 12:24:23', '2024-10-31 12:24:23', '2024-10-31 12:24:23', 0, 0, 1, 159, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1113, 68, 110, '2024-10-31 12:24:22', '2024-10-31 12:24:22', '2024-10-31 12:24:23', 0, 0, 0, 448, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:21 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1114, 68, 110, '2024-10-31 12:24:23', '2024-10-31 12:24:23', '2024-10-31 12:24:23', 0, 0, 1, 368, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1115, 68, 110, '2024-10-31 12:24:23', '2024-10-31 12:24:23', '2024-10-31 12:24:23', 0, 0, 0, 291, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1116, 68, 110, '2024-10-31 12:24:23', '2024-10-31 12:24:23', '2024-10-31 12:24:23', 0, 0, 1, 198, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1117, 68, 110, '2024-10-31 12:24:23', '2024-10-31 12:24:23', '2024-10-31 12:24:24', 0, 0, 1, 221, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1118, 69, 113, '2024-10-31 12:24:24', '2024-10-31 12:24:24', '2024-10-31 12:24:24', 0, 0, 0, 181, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1119, 69, 114, '2024-10-31 12:24:24', '2024-10-31 12:24:24', '2024-10-31 12:24:24', 0, 0, 0, 298, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1120, 69, 112, '2024-10-31 12:24:24', '2024-10-31 12:24:24', '2024-10-31 12:24:24', 0, 0, 0, 360, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:23 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1121, 69, 113, '2024-10-31 12:24:24', '2024-10-31 12:24:24', '2024-10-31 12:24:24', 0, 0, 1, 396, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:24 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1122, 69, 113, '2024-10-31 12:24:24', '2024-10-31 12:24:24', '2024-10-31 12:24:24', 0, 0, 1, 150, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:24 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1123, 69, 113, '2024-10-31 12:24:24', '2024-10-31 12:24:24', '2024-10-31 12:24:25', 0, 0, 1, 407, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:24 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1124, 69, 113, '2024-10-31 12:24:25', '2024-10-31 12:24:25', '2024-10-31 12:24:25', 0, 0, 0, 182, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:24 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1125, 69, 113, '2024-10-31 12:24:25', '2024-10-31 12:24:25', '2024-10-31 12:24:25', 0, 0, 1, 247, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:24 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1126, 69, 113, '2024-10-31 12:24:25', '2024-10-31 12:24:25', '2024-10-31 12:24:25', 0, 0, 0, 439, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1127, 69, 113, '2024-10-31 12:24:25', '2024-10-31 12:24:25', '2024-10-31 12:24:26', 0, 0, 0, 204, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1128, 69, 113, '2024-10-31 12:24:25', '2024-10-31 12:24:25', '2024-10-31 12:24:26', 0, 0, 0, 429, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1129, 69, 113, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:26', 0, 0, 0, 125, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1130, 70, 116, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:26', 0, 0, 1, 234, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1131, 70, 115, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:26', 0, 0, 1, 388, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1132, 70, 117, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:26', 0, 0, 1, 399, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1133, 70, 116, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:26', 0, 0, 0, 375, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:25 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1134, 70, 116, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:26', 0, 0, 1, 347, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:26 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1135, 70, 116, '2024-10-31 12:24:26', '2024-10-31 12:24:26', '2024-10-31 12:24:27', 0, 0, 1, 284, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:26 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1136, 70, 116, '2024-10-31 12:24:27', '2024-10-31 12:24:27', '2024-10-31 12:24:27', 0, 0, 1, 160, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:26 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1137, 70, 116, '2024-10-31 12:24:27', '2024-10-31 12:24:27', '2024-10-31 12:24:27', 0, 0, 0, 462, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:26 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1138, 70, 116, '2024-10-31 12:24:27', '2024-10-31 12:24:27', '2024-10-31 12:24:27', 0, 0, 0, 469, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:26 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1139, 70, 116, '2024-10-31 12:24:27', '2024-10-31 12:24:27', '2024-10-31 12:24:27', 0, 0, 1, 326, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:26 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1140, 70, 116, '2024-10-31 12:24:28', '2024-10-31 12:24:28', '2024-10-31 12:24:28', 0, 0, 1, 283, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:27 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);
INSERT INTO `test_result` VALUES (1141, 70, 116, '2024-10-31 12:24:27', '2024-10-31 12:24:27', '2024-10-31 12:24:28', 0, 0, 0, 498, 1, 200, '{\"message\":\"success\",\"code\":0,\"data\":\"Windows 10\",\"valueMap\":{}}', '', 'HTTP/1.1 200 \nVary: Origin\nVary: Access-Control-Request-Method\nVary: Access-Control-Request-Headers\nContent-Type: application/json\nTransfer-Encoding: chunked\nDate: Thu, 31 Oct 2024 04:24:27 GMT\nKeep-Alive: timeout=60\nConnection: keep-alive\n', 326, 251, 75, 171);

-- ----------------------------
-- Table structure for thread_group
-- ----------------------------
DROP TABLE IF EXISTS `thread_group`;
CREATE TABLE `thread_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '线程组id',
  `test_plan_id` int(11) NOT NULL COMMENT '所属的测试计划id',
  `thread_group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '线程组名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注释',
  `thread_num` int(11) NOT NULL COMMENT '线程数量',
  `ramp_up` bigint(20) NOT NULL COMMENT 'ramp up时间(s)',
  `delay` bigint(20) NULL DEFAULT NULL COMMENT '延迟时间(s)',
  `scheduler` bit(1) NOT NULL COMMENT '是否开启调度器',
  `duration` int(11) NULL DEFAULT NULL COMMENT '持续时间',
  `stepping` bit(1) NULL DEFAULT NULL,
  `initial_delay` int(11) NULL DEFAULT NULL,
  `start_users_count` int(11) NULL DEFAULT NULL,
  `start_users_count_burst` int(11) NULL DEFAULT NULL,
  `start_users_period` int(11) NULL DEFAULT NULL,
  `stop_users_count` int(11) NULL DEFAULT NULL,
  `stop_users_period` int(11) NULL DEFAULT NULL,
  `flighttime` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_thread_group_test_plan`(`test_plan_id`) USING BTREE,
  CONSTRAINT `fk_thread_group_test_plan` FOREIGN KEY (`test_plan_id`) REFERENCES `test_plan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of thread_group
-- ----------------------------
INSERT INTO `thread_group` VALUES (109, 68, 'thread group1', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (110, 68, 'thread group3', NULL, 10, 2, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (111, 68, 'thread group1', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (112, 69, 'thread group1', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (113, 69, 'thread group3', NULL, 10, 2, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (114, 69, 'thread group1', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (115, 70, 'thread group1', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (116, 70, 'thread group3', NULL, 10, 2, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (117, 70, 'thread group1', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `thread_group` VALUES (118, 71, 'Thread Group', NULL, 1, 1, 0, b'0', 0, b'0', 0, 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for timer
-- ----------------------------
DROP TABLE IF EXISTS `timer`;
CREATE TABLE `timer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NULL DEFAULT NULL COMMENT '1-ConstantTimer, 2-UniformRandomTimer, 3-GaussianRandomTimer, 4-PoissonRandomTimer',
  `thread_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_timer_thread_group`(`thread_group_id`) USING BTREE,
  CONSTRAINT `fk_timer_thread_group` FOREIGN KEY (`thread_group_id`) REFERENCES `thread_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of timer
-- ----------------------------
INSERT INTO `timer` VALUES (100, 1, 109);
INSERT INTO `timer` VALUES (101, 1, 110);
INSERT INTO `timer` VALUES (102, 1, 111);
INSERT INTO `timer` VALUES (103, 1, 112);
INSERT INTO `timer` VALUES (104, 1, 113);
INSERT INTO `timer` VALUES (105, 1, 114);
INSERT INTO `timer` VALUES (106, 1, 115);
INSERT INTO `timer` VALUES (107, 1, 116);
INSERT INTO `timer` VALUES (108, 1, 117);

-- ----------------------------
-- Table structure for uniform_random_timer
-- ----------------------------
DROP TABLE IF EXISTS `uniform_random_timer`;
CREATE TABLE `uniform_random_timer`  (
  `id` int(11) NOT NULL,
  `timer_name` timestamp NULL DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `random_delay_maximum` bigint(20) NULL DEFAULT NULL,
  `constant_delay_offset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `fk_uniform_random_timer_timer` FOREIGN KEY (`id`) REFERENCES `timer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of uniform_random_timer
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
