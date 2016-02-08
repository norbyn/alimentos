/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : alimentos

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2016-01-10 11:53:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `actividad_producto`
-- ----------------------------
DROP TABLE IF EXISTS `actividad_producto`;
CREATE TABLE `actividad_producto` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `producto_id` int(4) NOT NULL,
  `actividad_id` int(4) NOT NULL,
  `plan` float(11,4) NOT NULL,
  `actual` float(11,4) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `actividad_id` (`actividad_id`),
  CONSTRAINT `actividad_producto_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `actividad_producto_ibfk_2` FOREIGN KEY (`actividad_id`) REFERENCES `nom_actividad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of actividad_producto
-- ----------------------------
INSERT INTO `actividad_producto` VALUES ('26', '21', '12', '15.0000', '5.0000', '2015-01-07');
INSERT INTO `actividad_producto` VALUES ('27', '21', '8', '28.0000', '12.0000', '2015-01-07');
INSERT INTO `actividad_producto` VALUES ('28', '21', '12', '10.0000', '9.0000', '2015-02-07');
INSERT INTO `actividad_producto` VALUES ('29', '21', '12', '8.0000', '2.0000', '2015-09-07');
INSERT INTO `actividad_producto` VALUES ('30', '21', '8', '24.0000', '12.0000', '2015-02-07');
INSERT INTO `actividad_producto` VALUES ('31', '21', '8', '17.0000', '6.0000', '2015-09-07');
INSERT INTO `actividad_producto` VALUES ('32', '21', '9', '17.0000', '17.4444', '2015-09-16');
INSERT INTO `actividad_producto` VALUES ('33', '36', '12', '4.0000', '4.0000', '2015-09-01');

-- ----------------------------
-- Table structure for `appa_path`
-- ----------------------------
DROP TABLE IF EXISTS `appa_path`;
CREATE TABLE `appa_path` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dir` varchar(256) NOT NULL,
  `filename` varchar(120) NOT NULL,
  `full_path` varchar(256) NOT NULL,
  `ci_controller` varchar(256) NOT NULL,
  `ci_method` varchar(256) NOT NULL,
  `found` tinyint(1) NOT NULL,
  `public_flag` tinyint(1) NOT NULL,
  `permission_id` int(11) DEFAULT NULL,
  `note` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permission_id` (`permission_id`),
  KEY `dir` (`dir`(255)),
  KEY `ci_controller` (`ci_controller`(255)),
  KEY `ci_method` (`ci_method`(255)),
  CONSTRAINT `appa_path_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `appa_permission` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=3276;

-- ----------------------------
-- Records of appa_path
-- ----------------------------
INSERT INTO `appa_path` VALUES ('1', '.', 'welcome.php', 'welcome.php', 'Welcome', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('2', 'appunto-auth', 'ui.php', 'appunto-auth/ui.php', 'Ui', '_remap', '1', '0', '1', null);
INSERT INTO `appa_path` VALUES ('3', 'appunto-auth', 'user.php', 'appunto-auth/user.php', 'User', 'login', '1', '1', null, null);
INSERT INTO `appa_path` VALUES ('4', 'appunto-auth', 'user.php', 'appunto-auth/user.php', 'User', 'error', '1', '1', null, null);
INSERT INTO `appa_path` VALUES ('5', 'appunto-auth', 'user.php', 'appunto-auth/user.php', 'User', 'logout', '1', '1', null, null);
INSERT INTO `appa_path` VALUES ('6', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('7', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('8', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('9', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('10', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'findByProveedor', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('11', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'findAllByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('12', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'consecutivo', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('13', '.', 'c_boleta.php', 'c_boleta.php', 'C_boleta', 'id', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('14', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('15', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('16', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('17', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('18', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'findByProveedor', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('19', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'findAllByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('20', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'consecutivo', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('21', '.', 'c_boletaproducto.php', 'c_boletaproducto.php', 'C_boletaproducto', 'getStore', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('22', '.', 'c_disponibilidad.php', 'c_disponibilidad.php', 'C_disponibilidad', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('23', '.', 'c_disponibilidad.php', 'c_disponibilidad.php', 'C_disponibilidad', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('24', '.', 'c_disponibilidad.php', 'c_disponibilidad.php', 'C_disponibilidad', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('25', '.', 'c_disponibilidad.php', 'c_disponibilidad.php', 'C_disponibilidad', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('26', '.', 'comedores.php', 'comedores.php', 'Comedores', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('27', '.', 'comedores.php', 'comedores.php', 'Comedores', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('28', '.', 'comedores.php', 'comedores.php', 'Comedores', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('29', '.', 'comedores.php', 'comedores.php', 'Comedores', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('30', '.', 'comedores.php', 'comedores.php', 'Comedores', 'findAllByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('31', '.', 'consumo.php', 'consumo.php', 'Consumo', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('32', '.', 'entidad.php', 'entidad.php', 'Entidad', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('33', '.', 'entidad.php', 'entidad.php', 'Entidad', 'findByOrganismo', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('34', '.', 'entidad.php', 'entidad.php', 'Entidad', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('35', '.', 'entidad.php', 'entidad.php', 'Entidad', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('36', '.', 'eventosc.php', 'eventosc.php', 'Eventosc', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('37', '.', 'eventosc.php', 'eventosc.php', 'Eventosc', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('38', '.', 'eventosc.php', 'eventosc.php', 'Eventosc', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('39', '.', 'fuente.php', 'fuente.php', 'Fuente', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('40', '.', 'fuente.php', 'fuente.php', 'Fuente', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('41', '.', 'fuente.php', 'fuente.php', 'Fuente', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('42', '.', 'inventarioc.php', 'inventarioc.php', 'Inventarioc', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('43', '.', 'inventarioc.php', 'inventarioc.php', 'Inventarioc', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('44', '.', 'inventarioc.php', 'inventarioc.php', 'Inventarioc', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('45', '.', 'inventarioc.php', 'inventarioc.php', 'Inventarioc', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('46', '.', 'months.php', 'months.php', 'Months', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('47', '.', 'nivelact.php', 'nivelact.php', 'Nivelact', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('48', '.', 'nivelact.php', 'nivelact.php', 'Nivelact', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('49', '.', 'nivelact.php', 'nivelact.php', 'Nivelact', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('50', '.', 'nivelact.php', 'nivelact.php', 'Nivelact', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('51', '.', 'organismo.php', 'organismo.php', 'Organismo', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('52', '.', 'organismo.php', 'organismo.php', 'Organismo', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('53', '.', 'organismo.php', 'organismo.php', 'Organismo', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('54', '.', 'organismonominalizado.php', 'organismonominalizado.php', 'Organismonominalizado', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('55', '.', 'organismonominalizado.php', 'organismonominalizado.php', 'Organismonominalizado', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('56', '.', 'organismonominalizado.php', 'organismonominalizado.php', 'Organismonominalizado', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('57', '.', 'organismonominalizado.php', 'organismonominalizado.php', 'Organismonominalizado', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('58', '.', 'producto.php', 'producto.php', 'Producto', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('59', '.', 'producto.php', 'producto.php', 'Producto', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('60', '.', 'producto.php', 'producto.php', 'Producto', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('61', '.', 'producto.php', 'producto.php', 'Producto', 'findByProveedor', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('62', '.', 'producto.php', 'producto.php', 'Producto', 'findByProveedor2', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('63', '.', 'producto.php', 'producto.php', 'Producto', 'findByProveedorBoleta', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('64', '.', 'producto.php', 'producto.php', 'Producto', 'findAllByProveedor', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('65', '.', 'producto.php', 'producto.php', 'Producto', 'findByProveedor_Nominalizado', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('66', '.', 'productofuente.php', 'productofuente.php', 'Productofuente', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('67', '.', 'productofuente.php', 'productofuente.php', 'Productofuente', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('68', '.', 'productofuente.php', 'productofuente.php', 'Productofuente', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('69', '.', 'proveedor.php', 'proveedor.php', 'Proveedor', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('70', '.', 'proveedor.php', 'proveedor.php', 'Proveedor', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('71', '.', 'proveedor.php', 'proveedor.php', 'Proveedor', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('73', '.', 'provincia.php', 'provincia.php', 'Provincia', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('74', '.', 'reportes.php', 'reportes.php', 'Reportes', 'inventario', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('75', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_inventario', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('76', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_inventario', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('77', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_reporte_inventario', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('79', '.', 'reportes.php', 'reportes.php', 'Reportes', 'nominalizados_y_otros', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('80', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_nominalizados', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('81', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_nominalizados', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('84', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_nivel_actividad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('85', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_nivel_actividad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('87', '.', 'reportes.php', 'reportes.php', 'Reportes', 'boleta', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('89', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_boleta', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('90', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_boleta', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('94', '.', 'reportes.php', 'reportes.php', 'Reportes', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('95', '.', 'subordinacion.php', 'subordinacion.php', 'Subordinacion', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('96', '.', 'subordinacion.php', 'subordinacion.php', 'Subordinacion', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('97', '.', 'subordinacion.php', 'subordinacion.php', 'Subordinacion', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('98', '.', 'tcomedor.php', 'tcomedor.php', 'Tcomedor', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('99', '.', 'tcomedor.php', 'tcomedor.php', 'Tcomedor', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('100', '.', 'tcomedor.php', 'tcomedor.php', 'Tcomedor', 'notIn', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('101', '.', 'tcomedor.php', 'tcomedor.php', 'Tcomedor', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('102', '.', 'um.php', 'um.php', 'Um', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('103', '.', 'um.php', 'um.php', 'Um', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('104', '.', 'um.php', 'um.php', 'Um', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('105', '.', 'welcome.php', 'welcome.php', 'Welcome', 'menu', '1', '0', null, null);
INSERT INTO `appa_path` VALUES ('106', '.', 'reportes.php', 'reportes.php', 'Reportes', 'eventos', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('107', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_evento', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('108', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_evento', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('110', '.', 'c_consumoInter.php', 'c_consumoInter.php', 'C_consumoInter', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('111', '.', 'c_consumoInter.php', 'c_consumoInter.php', 'C_consumoInter', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('112', '.', 'c_consumoInter.php', 'c_consumoInter.php', 'C_consumoInter', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('113', '.', 'c_consumoInter.php', 'c_consumoInter.php', 'C_consumoInter', 'findByEntidad', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('114', '.', 'producto.php', 'producto.php', 'Producto', 'findByProveedor_consumoInter', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('115', '.', 'reportes.php', 'reportes.php', 'Reportes', 'consumoInter', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('116', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_consumoInter', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('117', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_consumoInter', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('119', '.', 'splash.php', 'splash.php', 'Splash', 'index', '1', '0', '3', null);
INSERT INTO `appa_path` VALUES ('120', '.', 'c_database.php', 'c_database.php', 'C_database', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('121', '.', 'c_database.php', 'c_database.php', 'C_database', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('122', '.', 'c_database.php', 'c_database.php', 'C_database', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('123', '.', 'c_database.php', 'c_database.php', 'C_database', 'getStore', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('124', '.', 'producto.php', 'producto.php', 'Producto', 'findByProveedorBD', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('126', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_basedatos', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('127', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_basedatos', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('128', '.', 'municipio.php', 'municipio.php', 'Municipio', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('129', '.', 'municipio.php', 'municipio.php', 'Municipio', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('130', '.', 'municipio.php', 'municipio.php', 'Municipio', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('131', '.', 'provincia.php', 'provincia.php', 'Provincia', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('132', '.', 'provincia.php', 'provincia.php', 'Provincia', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('134', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_disp', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('136', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_disp', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('137', '.', 'auditor.php', 'auditor.php', 'Auditor', 'index', '1', '0', '4', null);
INSERT INTO `appa_path` VALUES ('138', '.', 'registros_del_sistema.php', 'registros_del_sistema.php', 'Registros_del_sistema', 'index', '1', '0', '3', null);
INSERT INTO `appa_path` VALUES ('139', '.', 'consumo.php', 'consumo.php', 'Consumo', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('140', '.', 'months.php', 'months.php', 'Months', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('141', '.', 'registros_del_sistema.php', 'registros_del_sistema.php', 'Registros_del_sistema', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('142', '.', 'reportes.php', 'reportes.php', 'Reportes', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('143', '.', 'c_actividad.php', 'c_actividad.php', 'C_actividad', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('144', '.', 'c_actividad.php', 'c_actividad.php', 'C_actividad', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('145', '.', 'c_actividad.php', 'c_actividad.php', 'C_actividad', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('150', '.', 'c_actividadproducto.php', 'c_actividadproducto.php', 'C_actividadproducto', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('151', '.', 'c_actividadproducto.php', 'c_actividadproducto.php', 'C_actividadproducto', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('152', '.', 'c_actividadproducto.php', 'c_actividadproducto.php', 'C_actividadproducto', 'findbyproduct', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('153', '.', 'c_actividadproducto.php', 'c_actividadproducto.php', 'C_actividadproducto', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('154', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_balance', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('155', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_balance', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('157', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_mensual', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('159', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_xls_portada', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('160', '.', 'reportes.php', 'reportes.php', 'Reportes', 'generar_pdf_portada', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('161', '.', 'mercado.php', 'mercado.php', 'Mercado', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('162', '.', 'mercado.php', 'mercado.php', 'Mercado', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('163', '.', 'mercado.php', 'mercado.php', 'Mercado', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('164', '.', 'producto_mercado.php', 'producto_mercado.php', 'Producto_mercado', 'index', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('165', '.', 'producto_mercado.php', 'producto_mercado.php', 'Producto_mercado', 'save', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('166', '.', 'producto_mercado.php', 'producto_mercado.php', 'Producto_mercado', 'remove', '1', '0', '2', null);
INSERT INTO `appa_path` VALUES ('167', '.', 'reportes.php', 'reportes.php', 'Reportes', 'test', '1', '0', null, null);

-- ----------------------------
-- Table structure for `appa_permission`
-- ----------------------------
DROP TABLE IF EXISTS `appa_permission`;
CREATE TABLE `appa_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_bin NOT NULL,
  `internal_name` varchar(60) COLLATE utf8_bin NOT NULL,
  `description` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `internal_name` (`internal_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of appa_permission
-- ----------------------------
INSERT INTO `appa_permission` VALUES ('1', 'Administración', 'ADMINISTRACION', 'Permiso de administración');
INSERT INTO `appa_permission` VALUES ('2', 'Básico', 'BASICO', 'Acceso básico');
INSERT INTO `appa_permission` VALUES ('3', 'Lectura', 'LECTURA', 'Permiso de lectura');
INSERT INTO `appa_permission` VALUES ('4', 'auditoría', 'AUDITORíA', 'Permiso de auditoría');

-- ----------------------------
-- Table structure for `appa_role`
-- ----------------------------
DROP TABLE IF EXISTS `appa_role`;
CREATE TABLE `appa_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appa_role
-- ----------------------------
INSERT INTO `appa_role` VALUES ('1', 'Admin', 'Administrador del sistema');
INSERT INTO `appa_role` VALUES ('2', 'Operador', 'Operador');
INSERT INTO `appa_role` VALUES ('3', 'Auditor', 'Auditor del sistema');

-- ----------------------------
-- Table structure for `appa_role_permission`
-- ----------------------------
DROP TABLE IF EXISTS `appa_role_permission`;
CREATE TABLE `appa_role_permission` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `appa_role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `appa_role` (`id`),
  CONSTRAINT `appa_role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `appa_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appa_role_permission
-- ----------------------------
INSERT INTO `appa_role_permission` VALUES ('1', '1');
INSERT INTO `appa_role_permission` VALUES ('2', '2');
INSERT INTO `appa_role_permission` VALUES ('1', '2');
INSERT INTO `appa_role_permission` VALUES ('2', '3');
INSERT INTO `appa_role_permission` VALUES ('1', '3');
INSERT INTO `appa_role_permission` VALUES ('3', '3');
INSERT INTO `appa_role_permission` VALUES ('3', '4');
INSERT INTO `appa_role_permission` VALUES ('1', '4');

-- ----------------------------
-- Table structure for `appa_user`
-- ----------------------------
DROP TABLE IF EXISTS `appa_user`;
CREATE TABLE `appa_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `surname` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `last_ip` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`),
  KEY `name` (`name`),
  KEY `surname` (`surname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appa_user
-- ----------------------------
INSERT INTO `appa_user` VALUES ('1', 'norbyn', '$2a$08$gK17UCHVDWXgxwu/S8epTOvfB0QS5m9BhGRuMwkcHIMff84bGHBSS', 'norbyn.leyva@gmail.com', '1', 'Norbyn', 'Leyva', '127.0.0.1', '2015-10-02 02:51:31', '2015-07-13 12:25:35', '0000-00-00 00:00:00');
INSERT INTO `appa_user` VALUES ('2', 'Invitado', '$2a$08$Aou98qHm5Of/7AbUSCR4o.quI5r7BH4cHmGXrsd/QLERh1w5Ifqfe', 'guess@gmail.com', '1', 'Invitado', '...', '127.0.0.1', '2016-01-10 16:11:33', '2015-08-27 17:21:11', '0000-00-00 00:00:00');
INSERT INTO `appa_user` VALUES ('3', 'auditor', '$2a$08$28hSZ7BzEoi0o8HLyLCpBuGooGkkDTXCjM1MQKMe/8HLHckUVxz5u', 'auditor@gmail.com', '1', '...', '...', '127.0.0.1', '2016-01-10 16:05:00', '2015-08-30 15:01:53', '0000-00-00 00:00:00');
INSERT INTO `appa_user` VALUES ('4', 'administrador', '$2a$08$PZ2toygcLLBiha2./Itvzu5ZYxLSLoCbfzkl1CV.JCBVy748SSPIi', 'administrador@ejemplo.com', '1', 'Norbyn', 'Leyva', '127.0.0.1', '2016-01-10 16:12:46', '2015-09-01 12:54:05', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `appa_user_login_attempt`
-- ----------------------------
DROP TABLE IF EXISTS `appa_user_login_attempt`;
CREATE TABLE `appa_user_login_attempt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attempt_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(120) DEFAULT NULL,
  `ip_address` varchar(120) NOT NULL,
  `success` tinyint(1) NOT NULL,
  `user_agent` varchar(180) DEFAULT NULL,
  `note` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attempt_time` (`attempt_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1400 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=156;

-- ----------------------------
-- Records of appa_user_login_attempt
-- ----------------------------
INSERT INTO `appa_user_login_attempt` VALUES ('366', '2015-08-31 15:53:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('367', '2015-08-31 15:53:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('368', '2015-08-31 15:53:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:18]');
INSERT INTO `appa_user_login_attempt` VALUES ('369', '2015-08-31 15:53:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:17]');
INSERT INTO `appa_user_login_attempt` VALUES ('370', '2015-08-31 15:53:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('371', '2015-08-31 15:53:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:12]');
INSERT INTO `appa_user_login_attempt` VALUES ('372', '2015-08-31 15:53:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('373', '2015-08-31 16:06:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProducto, Fila eliminada [id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('374', '2015-08-31 16:08:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProducto, Fila eliminada [id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('375', '2015-08-31 16:09:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:25]');
INSERT INTO `appa_user_login_attempt` VALUES ('376', '2015-08-31 16:12:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomUm, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('377', '2015-08-31 16:15:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('378', '2015-08-31 16:15:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('379', '2015-08-31 16:23:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('380', '2015-08-31 16:33:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:38]');
INSERT INTO `appa_user_login_attempt` VALUES ('381', '2015-08-31 16:39:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('382', '2015-08-31 16:39:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('383', '2015-08-31 16:39:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('384', '2015-08-31 16:39:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('385', '2015-08-31 16:40:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('386', '2015-08-31 16:42:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('387', '2015-08-31 16:42:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:127]');
INSERT INTO `appa_user_login_attempt` VALUES ('388', '2015-08-31 16:42:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:128]');
INSERT INTO `appa_user_login_attempt` VALUES ('389', '2015-08-31 16:43:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('335', '2015-08-31 00:50:03', 'auditor', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Usuario bloqueado.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('336', '2015-08-31 00:50:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('337', '2015-08-31 01:03:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('338', '2015-08-31 01:03:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla OrgNominalizado, Fila eliminada [id:73]');
INSERT INTO `appa_user_login_attempt` VALUES ('339', '2015-08-31 01:14:14', 'dfsdfg', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('340', '2015-08-31 01:14:18', 'ddd', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('341', '2015-08-31 01:14:23', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('342', '2015-08-31 01:15:15', 'tete', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('343', '2015-08-31 01:15:19', 'tete', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('344', '2015-08-31 01:15:22', '', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Usuario es requerido.]\n[El campo Clave es');
INSERT INTO `appa_user_login_attempt` VALUES ('345', '2015-08-31 01:15:30', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('346', '2015-08-31 14:16:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('347', '2015-08-31 14:24:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('348', '2015-08-31 14:25:08', 'AAAAAaa', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('349', '2015-08-31 14:25:14', 'asasa', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('350', '2015-08-31 14:25:18', 'asasa', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('351', '2015-08-31 14:25:23', 'no ssad', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('352', '2015-08-31 14:25:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('353', '2015-08-31 14:29:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('354', '2015-08-31 14:29:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:101]');
INSERT INTO `appa_user_login_attempt` VALUES ('355', '2015-08-31 14:29:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('356', '2015-08-31 14:29:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:127]');
INSERT INTO `appa_user_login_attempt` VALUES ('357', '2015-08-31 14:29:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:128]');
INSERT INTO `appa_user_login_attempt` VALUES ('358', '2015-08-31 14:33:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:38]');
INSERT INTO `appa_user_login_attempt` VALUES ('359', '2015-08-31 15:04:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('360', '2015-08-31 15:52:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('361', '2015-08-31 15:52:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:23]');
INSERT INTO `appa_user_login_attempt` VALUES ('362', '2015-08-31 15:52:44', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('363', '2015-08-31 15:52:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('364', '2015-08-31 15:52:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:20]');
INSERT INTO `appa_user_login_attempt` VALUES ('365', '2015-08-31 15:53:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:19]');
INSERT INTO `appa_user_login_attempt` VALUES ('295', '2015-08-30 23:52:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ConsumoInter, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('296', '2015-08-30 23:52:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('297', '2015-08-30 23:53:02', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ConsumoInter, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('298', '2015-08-30 23:53:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('299', '2015-08-30 23:53:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:115]');
INSERT INTO `appa_user_login_attempt` VALUES ('300', '2015-08-30 23:53:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:94]');
INSERT INTO `appa_user_login_attempt` VALUES ('301', '2015-08-30 23:56:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('302', '2015-08-30 23:56:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:125]');
INSERT INTO `appa_user_login_attempt` VALUES ('303', '2015-08-30 23:56:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:125]');
INSERT INTO `appa_user_login_attempt` VALUES ('304', '2015-08-30 23:57:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:100]');
INSERT INTO `appa_user_login_attempt` VALUES ('305', '2015-08-30 23:57:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('306', '2015-08-30 23:57:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:126]');
INSERT INTO `appa_user_login_attempt` VALUES ('307', '2015-08-31 00:17:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:46]');
INSERT INTO `appa_user_login_attempt` VALUES ('308', '2015-08-31 00:18:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Inventario, Fila eliminada [id:71]');
INSERT INTO `appa_user_login_attempt` VALUES ('309', '2015-08-31 00:18:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:34]');
INSERT INTO `appa_user_login_attempt` VALUES ('310', '2015-08-31 00:23:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('311', '2015-08-31 00:23:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:35]');
INSERT INTO `appa_user_login_attempt` VALUES ('312', '2015-08-31 00:27:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla OrgNominalizado, Fila eliminada [id:74]');
INSERT INTO `appa_user_login_attempt` VALUES ('313', '2015-08-31 00:29:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('314', '2015-08-31 00:30:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ConsumoInter, Fila eliminada [id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('315', '2015-08-31 00:31:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('316', '2015-08-31 00:31:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProvincia, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('317', '2015-08-31 00:33:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('318', '2015-08-31 00:39:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomMunicipio, Fila eliminada [id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('319', '2015-08-31 00:40:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('320', '2015-08-31 00:40:44', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('321', '2015-08-31 00:40:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('322', '2015-08-31 00:40:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('323', '2015-08-31 00:41:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('324', '2015-08-31 00:41:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('325', '2015-08-31 00:41:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomOrganismo, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('326', '2015-08-31 00:42:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomEntidad, Fila eliminada [id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('327', '2015-08-31 00:43:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('328', '2015-08-31 00:43:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('329', '2015-08-31 00:46:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('330', '2015-08-31 00:48:14', 'eretwer', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('331', '2015-08-31 00:48:22', 'asasa', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('332', '2015-08-31 00:48:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('333', '2015-08-31 00:49:57', 'auditor', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Usuario bloqueado.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('334', '2015-08-31 00:50:01', 'auditor', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Usuario bloqueado.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('390', '2015-08-31 16:48:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('391', '2015-08-31 16:59:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('392', '2015-08-31 16:59:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('393', '2015-08-31 17:00:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('394', '2015-08-31 17:00:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('395', '2015-08-31 17:00:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:126]');
INSERT INTO `appa_user_login_attempt` VALUES ('396', '2015-08-31 17:10:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('397', '2015-08-31 17:10:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('398', '2015-08-31 17:10:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('399', '2015-08-31 17:11:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:127]');
INSERT INTO `appa_user_login_attempt` VALUES ('400', '2015-08-31 17:11:02', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:128]');
INSERT INTO `appa_user_login_attempt` VALUES ('401', '2015-08-31 17:11:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:101]');
INSERT INTO `appa_user_login_attempt` VALUES ('402', '2015-08-31 17:11:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('403', '2015-08-31 17:11:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:126]');
INSERT INTO `appa_user_login_attempt` VALUES ('404', '2015-08-31 17:11:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:100]');
INSERT INTO `appa_user_login_attempt` VALUES ('405', '2015-08-31 17:11:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('406', '2015-08-31 17:11:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:109]');
INSERT INTO `appa_user_login_attempt` VALUES ('407', '2015-08-31 17:11:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:111]');
INSERT INTO `appa_user_login_attempt` VALUES ('408', '2015-08-31 17:11:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:110]');
INSERT INTO `appa_user_login_attempt` VALUES ('409', '2015-08-31 17:11:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:120]');
INSERT INTO `appa_user_login_attempt` VALUES ('410', '2015-08-31 17:11:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:125]');
INSERT INTO `appa_user_login_attempt` VALUES ('411', '2015-08-31 17:11:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:92]');
INSERT INTO `appa_user_login_attempt` VALUES ('412', '2015-08-31 17:11:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('413', '2015-08-31 17:11:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:102]');
INSERT INTO `appa_user_login_attempt` VALUES ('414', '2015-08-31 17:11:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('415', '2015-08-31 17:11:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:129]');
INSERT INTO `appa_user_login_attempt` VALUES ('416', '2015-08-31 17:12:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:129]');
INSERT INTO `appa_user_login_attempt` VALUES ('417', '2015-08-31 17:12:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:130]');
INSERT INTO `appa_user_login_attempt` VALUES ('418', '2015-08-31 17:12:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('419', '2015-08-31 17:12:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:130]');
INSERT INTO `appa_user_login_attempt` VALUES ('420', '2015-08-31 17:12:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:103]');
INSERT INTO `appa_user_login_attempt` VALUES ('421', '2015-08-31 17:12:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('422', '2015-08-31 17:12:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:131]');
INSERT INTO `appa_user_login_attempt` VALUES ('423', '2015-08-31 17:12:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:131]');
INSERT INTO `appa_user_login_attempt` VALUES ('424', '2015-08-31 17:13:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:132]');
INSERT INTO `appa_user_login_attempt` VALUES ('425', '2015-08-31 17:13:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:132]');
INSERT INTO `appa_user_login_attempt` VALUES ('426', '2015-08-31 17:13:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:133]');
INSERT INTO `appa_user_login_attempt` VALUES ('427', '2015-08-31 17:13:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:133]');
INSERT INTO `appa_user_login_attempt` VALUES ('428', '2015-08-31 17:13:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('429', '2015-08-31 17:13:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('430', '2015-08-31 17:13:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:133]');
INSERT INTO `appa_user_login_attempt` VALUES ('431', '2015-08-31 17:13:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('432', '2015-08-31 17:13:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:132]');
INSERT INTO `appa_user_login_attempt` VALUES ('433', '2015-08-31 17:14:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('434', '2015-08-31 17:14:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:134]');
INSERT INTO `appa_user_login_attempt` VALUES ('435', '2015-08-31 17:14:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:134]');
INSERT INTO `appa_user_login_attempt` VALUES ('436', '2015-08-31 17:14:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:131]');
INSERT INTO `appa_user_login_attempt` VALUES ('437', '2015-08-31 17:14:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('438', '2015-08-31 17:15:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('439', '2015-08-31 17:15:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('440', '2015-08-31 17:15:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:130]');
INSERT INTO `appa_user_login_attempt` VALUES ('441', '2015-08-31 17:15:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:129]');
INSERT INTO `appa_user_login_attempt` VALUES ('442', '2015-08-31 17:15:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:102]');
INSERT INTO `appa_user_login_attempt` VALUES ('443', '2015-08-31 21:56:31', 'norbyn', '127.0.0.1', '0', 'Opera/9.80 (Windows NT 5.1; U; Edition DriverPack; es-ES) Presto/2.10.229 Version/11.61', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('444', '2015-08-31 21:56:44', 'norbyn', '127.0.0.1', '1', 'Opera/9.80 (Windows NT 5.1; U; Edition DriverPack; es-ES) Presto/2.10.229 Version/11.61', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('445', '2015-08-31 21:58:56', 'norbyn', '127.0.0.1', '1', 'Opera/9.80 (Windows NT 5.1; U; Edition DriverPack; es-ES) Presto/2.10.229 Version/11.61', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('446', '2015-08-31 21:59:27', 'norbyn', '127.0.0.1', '1', 'Opera/9.80 (Windows NT 5.1; U; Edition DriverPack; es-ES) Presto/2.10.229 Version/11.61', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('447', '2015-08-31 22:00:46', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('448', '2015-08-31 22:01:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('449', '2015-08-31 22:01:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('450', '2015-08-31 22:02:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('451', '2015-08-31 22:03:47', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('452', '2015-08-31 22:03:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('453', '2015-08-31 22:04:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:104]');
INSERT INTO `appa_user_login_attempt` VALUES ('454', '2015-08-31 22:05:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:105]');
INSERT INTO `appa_user_login_attempt` VALUES ('455', '2015-08-31 22:05:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('456', '2015-08-31 22:05:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:135]');
INSERT INTO `appa_user_login_attempt` VALUES ('457', '2015-08-31 22:05:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:135]');
INSERT INTO `appa_user_login_attempt` VALUES ('458', '2015-08-31 22:05:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('459', '2015-08-31 22:05:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:136]');
INSERT INTO `appa_user_login_attempt` VALUES ('460', '2015-08-31 22:05:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:137]');
INSERT INTO `appa_user_login_attempt` VALUES ('461', '2015-08-31 22:05:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:136]');
INSERT INTO `appa_user_login_attempt` VALUES ('462', '2015-08-31 22:05:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:137]');
INSERT INTO `appa_user_login_attempt` VALUES ('463', '2015-08-31 22:23:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('464', '2015-08-31 22:24:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('465', '2015-08-31 22:24:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('466', '2015-08-31 22:25:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('467', '2015-08-31 22:25:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('468', '2015-08-31 22:26:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('469', '2015-08-31 22:27:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('470', '2015-08-31 22:27:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('471', '2015-08-31 22:31:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('472', '2015-08-31 22:31:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:134]');
INSERT INTO `appa_user_login_attempt` VALUES ('473', '2015-08-31 22:31:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:103]');
INSERT INTO `appa_user_login_attempt` VALUES ('474', '2015-08-31 22:31:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('475', '2015-08-31 22:31:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:136]');
INSERT INTO `appa_user_login_attempt` VALUES ('476', '2015-08-31 22:32:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('477', '2015-08-31 22:32:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('478', '2015-08-31 22:32:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:137]');
INSERT INTO `appa_user_login_attempt` VALUES ('479', '2015-08-31 22:34:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:106]');
INSERT INTO `appa_user_login_attempt` VALUES ('480', '2015-08-31 22:34:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('481', '2015-08-31 22:34:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:138]');
INSERT INTO `appa_user_login_attempt` VALUES ('482', '2015-08-31 22:35:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:138]');
INSERT INTO `appa_user_login_attempt` VALUES ('483', '2015-08-31 22:35:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:107]');
INSERT INTO `appa_user_login_attempt` VALUES ('484', '2015-08-31 22:35:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('485', '2015-08-31 22:35:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:139]');
INSERT INTO `appa_user_login_attempt` VALUES ('486', '2015-08-31 22:35:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:139]');
INSERT INTO `appa_user_login_attempt` VALUES ('487', '2015-08-31 22:35:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:140]');
INSERT INTO `appa_user_login_attempt` VALUES ('488', '2015-08-31 22:35:47', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:140]');
INSERT INTO `appa_user_login_attempt` VALUES ('489', '2015-08-31 22:36:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('490', '2015-08-31 22:36:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:140]');
INSERT INTO `appa_user_login_attempt` VALUES ('491', '2015-08-31 22:36:32', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('492', '2015-08-31 22:36:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('493', '2015-08-31 22:36:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('494', '2015-08-31 22:36:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:139]');
INSERT INTO `appa_user_login_attempt` VALUES ('495', '2015-08-31 22:36:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:141]');
INSERT INTO `appa_user_login_attempt` VALUES ('496', '2015-08-31 22:36:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:141]');
INSERT INTO `appa_user_login_attempt` VALUES ('497', '2015-08-31 22:37:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('498', '2015-08-31 22:37:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:142]');
INSERT INTO `appa_user_login_attempt` VALUES ('499', '2015-08-31 22:37:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:142]');
INSERT INTO `appa_user_login_attempt` VALUES ('500', '2015-08-31 22:37:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('501', '2015-08-31 22:37:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('502', '2015-08-31 22:37:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:141]');
INSERT INTO `appa_user_login_attempt` VALUES ('503', '2015-08-31 22:37:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:143]');
INSERT INTO `appa_user_login_attempt` VALUES ('504', '2015-08-31 22:37:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:143]');
INSERT INTO `appa_user_login_attempt` VALUES ('505', '2015-08-31 22:38:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:144]');
INSERT INTO `appa_user_login_attempt` VALUES ('506', '2015-08-31 22:38:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:144]');
INSERT INTO `appa_user_login_attempt` VALUES ('507', '2015-08-31 22:41:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('508', '2015-08-31 22:41:44', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('509', '2015-08-31 22:41:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('510', '2015-08-31 22:41:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:145]');
INSERT INTO `appa_user_login_attempt` VALUES ('511', '2015-08-31 22:42:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('512', '2015-08-31 22:42:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:142]');
INSERT INTO `appa_user_login_attempt` VALUES ('513', '2015-08-31 22:44:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('514', '2015-08-31 22:45:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('515', '2015-08-31 22:46:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('516', '2015-08-31 22:46:44', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('517', '2015-08-31 22:56:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('518', '2015-08-31 22:56:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('519', '2015-08-31 22:56:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:146]');
INSERT INTO `appa_user_login_attempt` VALUES ('520', '2015-08-31 23:01:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('521', '2015-08-31 23:14:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('522', '2015-08-31 23:14:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:145]');
INSERT INTO `appa_user_login_attempt` VALUES ('523', '2015-08-31 23:14:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('524', '2015-08-31 23:14:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('525', '2015-08-31 23:14:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:147]');
INSERT INTO `appa_user_login_attempt` VALUES ('526', '2015-08-31 23:15:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:148]');
INSERT INTO `appa_user_login_attempt` VALUES ('527', '2015-08-31 23:15:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('528', '2015-08-31 23:15:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:149]');
INSERT INTO `appa_user_login_attempt` VALUES ('529', '2015-08-31 23:19:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('530', '2015-08-31 23:19:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:149]');
INSERT INTO `appa_user_login_attempt` VALUES ('531', '2015-08-31 23:20:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('532', '2015-08-31 23:20:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:150]');
INSERT INTO `appa_user_login_attempt` VALUES ('533', '2015-08-31 23:20:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:150]');
INSERT INTO `appa_user_login_attempt` VALUES ('534', '2015-08-31 23:20:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomProveedor, Fila eliminada [id:12]');
INSERT INTO `appa_user_login_attempt` VALUES ('535', '2015-08-31 23:21:32', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('536', '2015-08-31 23:21:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:151]');
INSERT INTO `appa_user_login_attempt` VALUES ('537', '2015-08-31 23:21:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('538', '2015-08-31 23:21:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('539', '2015-08-31 23:21:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:152]');
INSERT INTO `appa_user_login_attempt` VALUES ('540', '2015-08-31 23:23:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('541', '2015-08-31 23:23:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:146]');
INSERT INTO `appa_user_login_attempt` VALUES ('542', '2015-08-31 23:23:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('543', '2015-08-31 23:23:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:152]');
INSERT INTO `appa_user_login_attempt` VALUES ('544', '2015-08-31 23:46:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('545', '2015-08-31 23:49:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('546', '2015-08-31 23:50:07', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('547', '2015-08-31 23:52:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('548', '2015-08-31 23:52:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('549', '2015-08-31 23:52:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:146]');
INSERT INTO `appa_user_login_attempt` VALUES ('550', '2015-08-31 23:53:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('551', '2015-08-31 23:53:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:153]');
INSERT INTO `appa_user_login_attempt` VALUES ('552', '2015-08-31 23:54:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('553', '2015-08-31 23:54:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:153]');
INSERT INTO `appa_user_login_attempt` VALUES ('554', '2015-08-31 23:55:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('555', '2015-08-31 23:55:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:154]');
INSERT INTO `appa_user_login_attempt` VALUES ('556', '2015-08-31 23:55:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:154]');
INSERT INTO `appa_user_login_attempt` VALUES ('557', '2015-08-31 23:57:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('558', '2015-08-31 23:57:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:154]');
INSERT INTO `appa_user_login_attempt` VALUES ('559', '2015-08-31 23:57:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('560', '2015-08-31 23:57:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:155]');
INSERT INTO `appa_user_login_attempt` VALUES ('561', '2015-08-31 23:57:46', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:155]');
INSERT INTO `appa_user_login_attempt` VALUES ('562', '2015-09-01 00:01:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('563', '2015-09-01 00:01:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:155]');
INSERT INTO `appa_user_login_attempt` VALUES ('564', '2015-09-01 00:01:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:156]');
INSERT INTO `appa_user_login_attempt` VALUES ('565', '2015-09-01 00:01:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('566', '2015-09-01 00:01:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:156]');
INSERT INTO `appa_user_login_attempt` VALUES ('567', '2015-09-01 00:01:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('568', '2015-09-01 00:02:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:150]');
INSERT INTO `appa_user_login_attempt` VALUES ('569', '2015-09-01 00:02:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('570', '2015-09-01 00:02:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:157]');
INSERT INTO `appa_user_login_attempt` VALUES ('571', '2015-09-01 00:02:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('572', '2015-09-01 00:02:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:158]');
INSERT INTO `appa_user_login_attempt` VALUES ('573', '2015-09-01 00:11:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('574', '2015-09-01 00:11:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:147]');
INSERT INTO `appa_user_login_attempt` VALUES ('575', '2015-09-01 00:11:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:148]');
INSERT INTO `appa_user_login_attempt` VALUES ('576', '2015-09-01 00:11:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:151]');
INSERT INTO `appa_user_login_attempt` VALUES ('577', '2015-09-01 00:11:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:158]');
INSERT INTO `appa_user_login_attempt` VALUES ('578', '2015-09-01 00:16:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('579', '2015-09-01 00:21:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('580', '2015-09-01 00:21:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:157]');
INSERT INTO `appa_user_login_attempt` VALUES ('581', '2015-09-01 00:21:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('582', '2015-09-01 00:21:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:159]');
INSERT INTO `appa_user_login_attempt` VALUES ('583', '2015-09-01 00:23:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('584', '2015-09-01 00:23:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:159]');
INSERT INTO `appa_user_login_attempt` VALUES ('585', '2015-09-01 00:38:47', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('586', '2015-09-01 00:38:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:160]');
INSERT INTO `appa_user_login_attempt` VALUES ('587', '2015-09-01 00:38:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:160]');
INSERT INTO `appa_user_login_attempt` VALUES ('588', '2015-09-01 00:39:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('589', '2015-09-01 00:40:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:108]');
INSERT INTO `appa_user_login_attempt` VALUES ('590', '2015-09-01 00:40:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('591', '2015-09-01 00:40:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:161]');
INSERT INTO `appa_user_login_attempt` VALUES ('592', '2015-09-01 00:40:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:162]');
INSERT INTO `appa_user_login_attempt` VALUES ('593', '2015-09-01 00:40:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:162]');
INSERT INTO `appa_user_login_attempt` VALUES ('594', '2015-09-01 00:40:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:161]');
INSERT INTO `appa_user_login_attempt` VALUES ('595', '2015-09-01 00:41:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('596', '2015-09-01 00:43:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('597', '2015-09-01 00:43:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('598', '2015-09-01 01:00:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('599', '2015-09-01 01:00:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:162]');
INSERT INTO `appa_user_login_attempt` VALUES ('600', '2015-09-01 01:00:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:161]');
INSERT INTO `appa_user_login_attempt` VALUES ('601', '2015-09-01 01:01:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('602', '2015-09-01 01:01:29', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:163]');
INSERT INTO `appa_user_login_attempt` VALUES ('603', '2015-09-01 01:01:32', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:163]');
INSERT INTO `appa_user_login_attempt` VALUES ('604', '2015-09-01 01:01:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('605', '2015-09-01 01:08:02', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('606', '2015-09-01 01:08:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:163]');
INSERT INTO `appa_user_login_attempt` VALUES ('607', '2015-09-01 01:08:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:109]');
INSERT INTO `appa_user_login_attempt` VALUES ('608', '2015-09-01 01:08:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('609', '2015-09-01 01:08:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:164]');
INSERT INTO `appa_user_login_attempt` VALUES ('610', '2015-09-01 01:08:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:164]');
INSERT INTO `appa_user_login_attempt` VALUES ('611', '2015-09-01 01:08:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:165]');
INSERT INTO `appa_user_login_attempt` VALUES ('612', '2015-09-01 01:09:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:165]');
INSERT INTO `appa_user_login_attempt` VALUES ('613', '2015-09-01 01:09:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:166]');
INSERT INTO `appa_user_login_attempt` VALUES ('614', '2015-09-01 01:09:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:166]');
INSERT INTO `appa_user_login_attempt` VALUES ('615', '2015-09-01 01:09:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:110]');
INSERT INTO `appa_user_login_attempt` VALUES ('616', '2015-09-01 01:09:29', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('617', '2015-09-01 01:09:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:167]');
INSERT INTO `appa_user_login_attempt` VALUES ('618', '2015-09-01 01:09:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:167]');
INSERT INTO `appa_user_login_attempt` VALUES ('619', '2015-09-01 01:13:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('620', '2015-09-01 01:13:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:111]');
INSERT INTO `appa_user_login_attempt` VALUES ('621', '2015-09-01 01:13:29', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('622', '2015-09-01 01:13:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:168]');
INSERT INTO `appa_user_login_attempt` VALUES ('623', '2015-09-01 01:13:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:168]');
INSERT INTO `appa_user_login_attempt` VALUES ('624', '2015-09-01 01:13:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:169]');
INSERT INTO `appa_user_login_attempt` VALUES ('625', '2015-09-01 01:13:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:170]');
INSERT INTO `appa_user_login_attempt` VALUES ('626', '2015-09-01 01:14:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:169]');
INSERT INTO `appa_user_login_attempt` VALUES ('627', '2015-09-01 01:14:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:170]');
INSERT INTO `appa_user_login_attempt` VALUES ('628', '2015-09-01 01:14:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('629', '2015-09-01 01:14:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:112]');
INSERT INTO `appa_user_login_attempt` VALUES ('630', '2015-09-01 01:14:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('631', '2015-09-01 01:14:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:171]');
INSERT INTO `appa_user_login_attempt` VALUES ('632', '2015-09-01 01:14:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:171]');
INSERT INTO `appa_user_login_attempt` VALUES ('633', '2015-09-01 01:15:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('634', '2015-09-01 01:16:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('635', '2015-09-01 01:17:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('636', '2015-09-01 01:17:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('637', '2015-09-01 01:19:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('638', '2015-09-01 01:19:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:113]');
INSERT INTO `appa_user_login_attempt` VALUES ('639', '2015-09-01 01:19:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('640', '2015-09-01 01:19:44', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('641', '2015-09-01 01:19:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:172]');
INSERT INTO `appa_user_login_attempt` VALUES ('642', '2015-09-01 01:19:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:172]');
INSERT INTO `appa_user_login_attempt` VALUES ('643', '2015-09-01 01:19:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:173]');
INSERT INTO `appa_user_login_attempt` VALUES ('644', '2015-09-01 01:19:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:173]');
INSERT INTO `appa_user_login_attempt` VALUES ('645', '2015-09-01 01:20:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:114]');
INSERT INTO `appa_user_login_attempt` VALUES ('646', '2015-09-01 01:20:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('647', '2015-09-01 01:20:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:174]');
INSERT INTO `appa_user_login_attempt` VALUES ('648', '2015-09-01 01:20:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:175]');
INSERT INTO `appa_user_login_attempt` VALUES ('649', '2015-09-01 01:20:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:174]');
INSERT INTO `appa_user_login_attempt` VALUES ('650', '2015-09-01 01:20:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:175]');
INSERT INTO `appa_user_login_attempt` VALUES ('651', '2015-09-01 01:24:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('652', '2015-09-01 01:24:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('653', '2015-09-01 01:25:32', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('654', '2015-09-01 01:26:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('655', '2015-09-01 01:34:11', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('656', '2015-09-01 01:34:20', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('657', '2015-09-01 01:36:16', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('658', '2015-09-01 01:36:29', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('659', '2015-09-01 01:49:10', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('660', '2015-09-01 01:49:38', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('661', '2015-09-01 01:49:42', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('662', '2015-09-01 01:50:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('663', '2015-09-01 01:52:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('664', '2015-09-01 01:54:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('665', '2015-09-01 01:56:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('666', '2015-09-01 02:15:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('667', '2015-09-01 03:24:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('668', '2015-09-01 03:24:44', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('669', '2015-09-01 03:25:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('670', '2015-09-01 03:25:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('671', '2015-09-01 03:26:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('672', '2015-09-01 11:03:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('673', '2015-09-01 11:18:53', 'norbyn', '127.0.0.1', '1', 'Opera/9.80 (Windows NT 5.1; U; Edition DriverPack; es-ES) Presto/2.10.229 Version/11.61', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('674', '2015-09-01 11:19:21', 'norbyn', '127.0.0.1', '1', 'Opera/9.80 (Windows NT 5.1; U; Edition DriverPack; es-ES) Presto/2.10.229 Version/11.61', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('675', '2015-09-01 12:54:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('676', '2015-09-01 13:55:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomEntidad, Fila eliminada [id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('677', '2015-09-01 14:45:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('678', '2015-09-01 15:05:55', 'n', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('679', '2015-09-01 15:06:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('680', '2015-09-01 15:12:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('681', '2015-09-01 15:15:38', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('682', '2015-09-01 15:16:49', 'Invitado', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('683', '2015-09-01 15:16:53', 'Invitado', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('684', '2015-09-01 15:16:57', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('685', '2015-09-01 15:36:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('686', '2015-09-01 23:59:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('687', '2015-09-02 01:26:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('688', '2015-09-02 14:29:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('689', '2015-09-02 14:32:07', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('690', '2015-09-02 14:45:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('691', '2015-09-02 15:10:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('692', '2015-09-02 15:10:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('693', '2015-09-02 15:10:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Disponibilidad, Fila eliminada [id:53]');
INSERT INTO `appa_user_login_attempt` VALUES ('694', '2015-09-02 15:10:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Disponibilidad, Fila eliminada [id:54]');
INSERT INTO `appa_user_login_attempt` VALUES ('695', '2015-09-02 15:10:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Disponibilidad, Fila eliminada [id:56]');
INSERT INTO `appa_user_login_attempt` VALUES ('696', '2015-09-02 15:10:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Disponibilidad, Fila eliminada [id:57]');
INSERT INTO `appa_user_login_attempt` VALUES ('697', '2015-09-02 15:10:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Disponibilidad, Fila eliminada [id:52]');
INSERT INTO `appa_user_login_attempt` VALUES ('698', '2015-09-02 15:10:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Disponibilidad, Fila eliminada [id:55]');
INSERT INTO `appa_user_login_attempt` VALUES ('699', '2015-09-02 15:10:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('700', '2015-09-02 15:11:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:174]');
INSERT INTO `appa_user_login_attempt` VALUES ('701', '2015-09-02 15:11:02', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:175]');
INSERT INTO `appa_user_login_attempt` VALUES ('702', '2015-09-02 15:11:07', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:114]');
INSERT INTO `appa_user_login_attempt` VALUES ('703', '2015-09-02 15:11:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('704', '2015-09-02 15:11:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:172]');
INSERT INTO `appa_user_login_attempt` VALUES ('705', '2015-09-02 15:11:15', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:173]');
INSERT INTO `appa_user_login_attempt` VALUES ('706', '2015-09-02 15:11:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:113]');
INSERT INTO `appa_user_login_attempt` VALUES ('707', '2015-09-02 15:11:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('708', '2015-09-02 15:11:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:171]');
INSERT INTO `appa_user_login_attempt` VALUES ('709', '2015-09-02 15:11:26', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:112]');
INSERT INTO `appa_user_login_attempt` VALUES ('710', '2015-09-02 15:11:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('711', '2015-09-02 15:11:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:168]');
INSERT INTO `appa_user_login_attempt` VALUES ('712', '2015-09-02 15:11:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BoletaProducto, Fila eliminada [id:169]');
INSERT INTO `appa_user_login_attempt` VALUES ('713', '2015-09-02 15:11:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Boleta, Fila eliminada [id:111]');
INSERT INTO `appa_user_login_attempt` VALUES ('714', '2015-09-02 15:12:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('715', '2015-09-02 15:16:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('716', '2015-09-02 15:16:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('717', '2015-09-02 15:16:32', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('718', '2015-09-02 15:16:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('719', '2015-09-02 15:25:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomUm, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('720', '2015-09-02 23:13:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('721', '2015-09-02 23:14:01', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('722', '2015-09-02 23:24:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('723', '2015-09-02 23:24:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('724', '2015-09-02 23:24:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('725', '2015-09-02 23:24:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:14]');
INSERT INTO `appa_user_login_attempt` VALUES ('726', '2015-09-02 23:33:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('727', '2015-09-02 23:48:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:17]');
INSERT INTO `appa_user_login_attempt` VALUES ('728', '2015-09-02 23:53:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Destino, Fila eliminada [id:19]');
INSERT INTO `appa_user_login_attempt` VALUES ('729', '2015-09-03 00:22:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('730', '2015-09-03 00:22:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('731', '2015-09-03 00:22:52', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('732', '2015-09-03 00:23:34', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('733', '2015-09-03 00:38:31', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('734', '2015-09-03 01:07:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Actividad, Fila eliminada [id:20]');
INSERT INTO `appa_user_login_attempt` VALUES ('735', '2015-09-03 01:15:04', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomActividad, Fila eliminada [id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('736', '2015-09-03 01:18:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('737', '2015-09-03 01:18:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('738', '2015-09-03 02:06:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('739', '2015-09-03 11:41:06', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('740', '2015-09-03 11:41:12', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('741', '2015-09-03 11:42:59', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('742', '2015-09-03 11:52:10', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('743', '2015-09-03 12:00:57', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('744', '2015-09-03 12:01:01', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('745', '2015-09-03 12:01:08', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('746', '2015-09-03 12:01:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ActividadProducto, Fila eliminada [id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('747', '2015-09-03 12:03:02', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('748', '2015-09-03 12:03:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('749', '2015-09-03 12:03:35', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('750', '2015-09-03 12:22:31', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('751', '2015-09-03 12:23:29', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('752', '2015-09-03 12:25:09', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('753', '2015-09-03 12:25:15', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('754', '2015-09-03 12:25:19', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('755', '2015-09-03 12:28:38', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('756', '2015-09-03 12:37:00', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('757', '2015-09-03 12:38:43', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('758', '2015-09-03 12:48:40', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('759', '2015-09-03 13:19:24', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('760', '2015-09-03 13:20:46', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('761', '2015-09-03 13:21:21', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('762', '2015-09-03 13:23:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ActividadProducto, Fila eliminada [id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('763', '2015-09-03 13:27:41', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('764', '2015-09-03 13:28:36', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('765', '2015-09-03 13:34:55', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('766', '2015-09-03 13:35:04', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('767', '2015-09-03 13:35:42', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('768', '2015-09-03 13:36:44', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('769', '2015-09-03 13:37:07', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('770', '2015-09-03 13:37:42', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('771', '2015-09-03 13:38:01', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('772', '2015-09-03 13:44:48', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('773', '2015-09-03 13:45:27', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('774', '2015-09-03 13:46:08', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('775', '2015-09-03 13:48:30', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('776', '2015-09-03 13:48:56', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('777', '2015-09-03 13:51:32', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('778', '2015-09-03 13:52:03', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('779', '2015-09-03 13:55:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomActividad, Fila eliminada [id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('780', '2015-09-03 13:56:03', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('781', '2015-09-03 13:56:06', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('782', '2015-09-03 13:58:10', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('783', '2015-09-03 14:04:09', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('784', '2015-09-03 14:04:52', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('785', '2015-09-03 14:07:20', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('786', '2015-09-03 14:09:28', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('787', '2015-09-03 14:11:50', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('788', '2015-09-03 14:17:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomActividad, Fila eliminada [id:14]');
INSERT INTO `appa_user_login_attempt` VALUES ('789', '2015-09-03 14:17:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomActividad, Fila eliminada [id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('790', '2015-09-03 14:17:51', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('791', '2015-09-03 14:21:55', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('792', '2015-09-03 14:26:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:0]');
INSERT INTO `appa_user_login_attempt` VALUES ('793', '2015-09-03 14:26:32', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:0]');
INSERT INTO `appa_user_login_attempt` VALUES ('794', '2015-09-03 14:48:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomActividad, Fila eliminada [id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('795', '2015-09-03 14:49:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:0]');
INSERT INTO `appa_user_login_attempt` VALUES ('796', '2015-09-03 14:50:06', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('797', '2015-09-03 15:02:40', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('798', '2015-09-03 15:06:05', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('799', '2015-09-03 15:06:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('800', '2015-09-03 15:06:22', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('801', '2015-09-03 15:06:27', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('802', '2015-09-03 15:06:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('803', '2015-09-03 15:06:56', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('804', '2015-09-03 15:07:10', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('805', '2015-09-03 15:07:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('806', '2015-09-03 15:07:28', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('807', '2015-09-03 15:07:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('808', '2015-09-03 15:07:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('809', '2015-09-03 15:08:06', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla ActividadProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('810', '2015-09-03 15:12:47', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('811', '2015-09-03 15:12:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('812', '2015-09-03 15:13:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('813', '2015-09-03 15:13:06', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('814', '2015-09-03 15:13:10', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('815', '2015-09-03 15:15:34', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('816', '2015-09-03 15:15:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('817', '2015-09-03 15:15:41', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('818', '2015-09-03 15:17:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('819', '2015-09-03 15:17:50', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('820', '2015-09-03 15:17:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('821', '2015-09-03 15:17:57', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('822', '2015-09-03 15:17:59', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('823', '2015-09-03 15:18:01', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('824', '2015-09-03 15:18:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('825', '2015-09-03 15:18:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('826', '2015-09-03 15:18:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('827', '2015-09-03 16:10:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('828', '2015-09-03 16:10:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:12]');
INSERT INTO `appa_user_login_attempt` VALUES ('829', '2015-09-03 16:10:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('830', '2015-09-03 16:10:55', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ActividadProducto, Fila eliminada [id:12]');
INSERT INTO `appa_user_login_attempt` VALUES ('831', '2015-09-03 16:11:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('832', '2015-09-03 16:11:13', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('833', '2015-09-03 16:11:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('834', '2015-09-03 16:11:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('835', '2015-09-03 16:11:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('836', '2015-09-04 05:28:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('837', '2015-09-04 05:39:01', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('838', '2015-09-04 05:55:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('839', '2015-09-04 05:56:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('840', '2015-09-04 05:56:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('841', '2015-09-04 05:59:28', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('842', '2015-09-04 07:34:02', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('843', '2015-09-04 13:28:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Inventario, Fila eliminada [id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('844', '2015-09-04 17:23:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('845', '2015-09-04 17:24:04', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('846', '2015-09-04 17:24:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:14]');
INSERT INTO `appa_user_login_attempt` VALUES ('847', '2015-09-04 17:24:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('848', '2015-09-04 17:24:42', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('849', '2015-09-04 17:25:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:17]');
INSERT INTO `appa_user_login_attempt` VALUES ('850', '2015-09-04 17:25:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:18]');
INSERT INTO `appa_user_login_attempt` VALUES ('851', '2015-09-04 17:25:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:19]');
INSERT INTO `appa_user_login_attempt` VALUES ('852', '2015-09-04 17:25:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:14]');
INSERT INTO `appa_user_login_attempt` VALUES ('853', '2015-09-04 17:25:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:14]');
INSERT INTO `appa_user_login_attempt` VALUES ('854', '2015-09-04 17:25:41', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('855', '2015-09-04 17:25:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('856', '2015-09-04 17:25:48', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('857', '2015-09-04 17:25:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('858', '2015-09-04 17:25:54', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('859', '2015-09-04 17:25:57', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('860', '2015-09-04 17:26:04', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('861', '2015-09-04 17:26:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('862', '2015-09-04 17:26:20', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:16]');
INSERT INTO `appa_user_login_attempt` VALUES ('863', '2015-09-04 17:26:30', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:17]');
INSERT INTO `appa_user_login_attempt` VALUES ('864', '2015-09-04 17:26:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:17]');
INSERT INTO `appa_user_login_attempt` VALUES ('865', '2015-09-04 17:26:44', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:18]');
INSERT INTO `appa_user_login_attempt` VALUES ('866', '2015-09-04 17:26:50', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:18]');
INSERT INTO `appa_user_login_attempt` VALUES ('867', '2015-09-04 17:26:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:19]');
INSERT INTO `appa_user_login_attempt` VALUES ('868', '2015-09-04 17:27:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:19]');
INSERT INTO `appa_user_login_attempt` VALUES ('869', '2015-09-04 18:01:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:20]');
INSERT INTO `appa_user_login_attempt` VALUES ('870', '2015-09-04 18:01:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('871', '2015-09-04 18:01:13', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('872', '2015-09-04 18:01:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:23]');
INSERT INTO `appa_user_login_attempt` VALUES ('873', '2015-09-04 18:01:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:20]');
INSERT INTO `appa_user_login_attempt` VALUES ('874', '2015-09-04 18:01:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:20]');
INSERT INTO `appa_user_login_attempt` VALUES ('875', '2015-09-04 18:01:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:20]');
INSERT INTO `appa_user_login_attempt` VALUES ('876', '2015-09-04 18:01:41', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('877', '2015-09-04 18:01:44', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('878', '2015-09-04 18:01:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:23]');
INSERT INTO `appa_user_login_attempt` VALUES ('879', '2015-09-04 18:01:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('880', '2015-09-04 18:01:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('881', '2015-09-04 18:01:54', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('882', '2015-09-04 18:01:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('883', '2015-09-04 18:02:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:23]');
INSERT INTO `appa_user_login_attempt` VALUES ('884', '2015-09-04 18:02:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:23]');
INSERT INTO `appa_user_login_attempt` VALUES ('885', '2015-09-04 18:02:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:23]');
INSERT INTO `appa_user_login_attempt` VALUES ('886', '2015-09-04 18:08:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('887', '2015-09-04 18:08:43', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ActividadProducto, Fila eliminada [id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('888', '2015-09-04 18:09:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomActividad, Fila eliminada [id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('889', '2015-09-05 05:46:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('890', '2015-09-07 13:57:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('891', '2015-09-07 13:58:10', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('892', '2015-09-07 13:58:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('893', '2015-09-07 13:58:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:24]');
INSERT INTO `appa_user_login_attempt` VALUES ('894', '2015-09-07 13:59:23', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:25]');
INSERT INTO `appa_user_login_attempt` VALUES ('895', '2015-09-07 13:59:28', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:25]');
INSERT INTO `appa_user_login_attempt` VALUES ('896', '2015-09-07 13:59:31', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:25]');
INSERT INTO `appa_user_login_attempt` VALUES ('897', '2015-09-07 13:59:43', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:25]');
INSERT INTO `appa_user_login_attempt` VALUES ('898', '2015-09-07 14:07:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:26]');
INSERT INTO `appa_user_login_attempt` VALUES ('899', '2015-09-07 14:07:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:26]');
INSERT INTO `appa_user_login_attempt` VALUES ('900', '2015-09-07 14:07:43', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:26]');
INSERT INTO `appa_user_login_attempt` VALUES ('901', '2015-09-07 14:07:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:26]');
INSERT INTO `appa_user_login_attempt` VALUES ('902', '2015-09-07 14:07:55', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:27]');
INSERT INTO `appa_user_login_attempt` VALUES ('903', '2015-09-07 14:07:59', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:27]');
INSERT INTO `appa_user_login_attempt` VALUES ('904', '2015-09-07 14:08:01', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:27]');
INSERT INTO `appa_user_login_attempt` VALUES ('905', '2015-09-07 14:08:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:27]');
INSERT INTO `appa_user_login_attempt` VALUES ('906', '2015-09-07 14:08:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:28]');
INSERT INTO `appa_user_login_attempt` VALUES ('907', '2015-09-07 14:08:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:28]');
INSERT INTO `appa_user_login_attempt` VALUES ('908', '2015-09-07 14:08:32', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:29]');
INSERT INTO `appa_user_login_attempt` VALUES ('909', '2015-09-07 14:08:43', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:28]');
INSERT INTO `appa_user_login_attempt` VALUES ('910', '2015-09-07 14:08:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:28]');
INSERT INTO `appa_user_login_attempt` VALUES ('911', '2015-09-07 14:09:02', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:29]');
INSERT INTO `appa_user_login_attempt` VALUES ('912', '2015-09-07 14:09:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:29]');
INSERT INTO `appa_user_login_attempt` VALUES ('913', '2015-09-07 14:09:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:30]');
INSERT INTO `appa_user_login_attempt` VALUES ('914', '2015-09-07 14:09:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:30]');
INSERT INTO `appa_user_login_attempt` VALUES ('915', '2015-09-07 14:09:23', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:30]');
INSERT INTO `appa_user_login_attempt` VALUES ('916', '2015-09-07 14:09:25', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:30]');
INSERT INTO `appa_user_login_attempt` VALUES ('917', '2015-09-07 14:09:30', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:31]');
INSERT INTO `appa_user_login_attempt` VALUES ('918', '2015-09-07 14:09:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:31]');
INSERT INTO `appa_user_login_attempt` VALUES ('919', '2015-09-07 14:09:34', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:31]');
INSERT INTO `appa_user_login_attempt` VALUES ('920', '2015-09-07 15:36:00', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('921', '2015-09-07 15:36:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('922', '2015-09-07 15:36:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('923', '2015-09-08 14:12:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('924', '2015-09-08 14:15:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('925', '2015-09-08 14:15:32', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('926', '2015-09-08 14:15:43', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('927', '2015-09-08 14:15:50', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('928', '2015-09-08 14:16:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('929', '2015-09-08 14:16:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('930', '2015-09-08 14:16:12', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('931', '2015-09-08 14:16:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('932', '2015-09-08 14:16:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('933', '2015-09-08 14:16:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('934', '2015-09-08 14:16:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('935', '2015-09-08 15:35:47', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('936', '2015-09-08 17:00:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('937', '2015-09-08 17:00:55', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('938', '2015-09-08 17:12:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('939', '2015-09-08 17:13:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('940', '2015-09-08 17:13:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('941', '2015-09-08 17:37:30', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('942', '2015-09-08 17:37:47', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('943', '2015-09-09 00:54:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('944', '2015-09-09 07:18:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('945', '2015-09-09 08:01:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('946', '2015-09-09 14:22:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('947', '2015-09-09 14:22:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('948', '2015-09-09 17:10:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('949', '2015-09-10 16:17:31', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('950', '2015-09-10 16:33:48', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('951', '2015-09-10 16:44:50', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('952', '2015-09-10 16:45:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('953', '2015-09-10 16:46:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('954', '2015-09-10 16:47:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('955', '2015-09-10 16:48:02', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('956', '2015-09-10 16:53:13', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('957', '2015-09-10 17:05:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('958', '2015-09-10 17:05:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('959', '2015-09-10 17:05:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('960', '2015-09-10 17:05:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('961', '2015-09-10 17:06:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('962', '2015-09-10 17:06:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('963', '2015-09-10 17:07:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('964', '2015-09-10 17:07:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('965', '2015-09-10 17:09:25', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('966', '2015-09-10 17:22:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('967', '2015-09-10 17:22:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('968', '2015-09-11 00:20:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('969', '2015-09-11 01:19:34', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('970', '2015-09-11 15:08:18', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('971', '2015-09-11 15:08:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('972', '2015-09-11 15:08:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('973', '2015-09-11 16:16:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('974', '2015-09-11 16:16:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('975', '2015-09-11 16:17:00', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('976', '2015-09-11 16:17:10', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('977', '2015-09-11 16:17:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('978', '2015-09-11 16:17:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('979', '2015-09-11 16:29:30', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('980', '2015-09-11 16:37:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('981', '2015-09-11 16:37:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('982', '2015-09-11 16:41:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('983', '2015-09-12 00:00:10', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('984', '2015-09-12 07:45:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('985', '2015-09-12 07:45:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:11]');
INSERT INTO `appa_user_login_attempt` VALUES ('986', '2015-09-12 07:45:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('987', '2015-09-12 08:02:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('988', '2015-09-12 08:04:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('989', '2015-09-12 12:21:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('990', '2015-09-12 12:26:20', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('991', '2015-09-12 12:28:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('992', '2015-09-12 22:14:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('993', '2015-09-12 22:32:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('994', '2015-09-12 22:32:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('995', '2015-09-13 00:11:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('996', '2015-09-13 00:13:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('997', '2015-09-13 00:46:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('998', '2015-09-13 00:51:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('999', '2015-09-13 00:52:08', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1000', '2015-09-13 00:52:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1001', '2015-09-13 00:54:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1002', '2015-09-13 00:54:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1003', '2015-09-13 00:54:47', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1004', '2015-09-13 01:01:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1005', '2015-09-13 01:03:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1006', '2015-09-13 01:04:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1007', '2015-09-13 01:04:14', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1008', '2015-09-13 01:04:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1009', '2015-09-13 01:04:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1010', '2015-09-13 01:04:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1011', '2015-09-13 01:04:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1012', '2015-09-13 01:04:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:14]');
INSERT INTO `appa_user_login_attempt` VALUES ('1013', '2015-09-13 01:04:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1014', '2015-09-13 01:05:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1015', '2015-09-13 01:05:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1016', '2015-09-13 01:05:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1017', '2015-09-13 01:05:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1018', '2015-09-13 01:05:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1019', '2015-09-13 01:05:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1020', '2015-09-13 01:06:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1021', '2015-09-13 01:06:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1022', '2015-09-13 01:06:59', 'ddd', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [El campo Clave es requerido.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1023', '2015-09-13 01:07:04', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1024', '2015-09-13 01:07:40', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1025', '2015-09-13 01:07:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1026', '2015-09-14 10:33:46', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1027', '2015-09-15 21:53:48', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomMunicipio, Fila eliminada [id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('1028', '2015-09-15 22:04:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1029', '2015-09-15 22:04:26', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1030', '2015-09-15 22:05:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1031', '2015-09-15 22:05:31', '0', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Error creando/actualizando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1032', '2015-09-15 22:11:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1033', '2015-09-15 22:11:30', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('1034', '2015-09-15 22:11:47', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla Boleta[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1035', '2015-09-15 22:12:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1036', '2015-09-15 22:12:27', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('1037', '2015-09-15 22:12:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1038', '2015-09-15 22:12:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('1039', '2015-09-15 22:12:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1040', '2015-09-16 00:15:13', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:32]');
INSERT INTO `appa_user_login_attempt` VALUES ('1041', '2015-09-16 00:15:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:32]');
INSERT INTO `appa_user_login_attempt` VALUES ('1042', '2015-09-16 00:15:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:32]');
INSERT INTO `appa_user_login_attempt` VALUES ('1043', '2015-09-16 00:43:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1044', '2015-09-16 00:43:48', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('1045', '2015-09-16 00:43:55', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1046', '2015-09-16 00:43:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla Eventos, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1047', '2015-09-16 00:46:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1048', '2015-09-16 00:53:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1049', '2015-09-16 00:57:24', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1050', '2015-09-16 00:58:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1051', '2015-09-16 01:01:09', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1052', '2015-09-16 01:02:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1053', '2015-09-16 01:07:07', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1054', '2015-09-16 01:08:24', 'auditor', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1055', '2015-09-16 01:08:39', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1056', '2015-09-16 01:09:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1057', '2015-09-16 01:10:58', '', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1058', '2015-09-16 23:47:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1059', '2015-09-16 23:47:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1060', '2015-09-16 23:48:50', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1061', '2015-09-16 23:50:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1062', '2015-09-17 01:40:28', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1063', '2015-09-17 01:40:31', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1064', '2015-09-17 01:40:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1065', '2015-09-17 01:40:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('1066', '2015-09-17 01:40:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('1067', '2015-09-17 01:40:41', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoFuentes, Fila eliminada [id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('1068', '2015-09-17 02:50:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1069', '2015-09-17 02:56:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1070', '2015-09-17 02:56:20', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1071', '2015-09-17 02:56:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1072', '2015-09-17 02:59:20', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1073', '2015-09-17 02:59:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1074', '2015-09-17 02:59:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1075', '2015-09-17 03:01:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1076', '2015-09-17 03:01:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1077', '2015-09-17 03:01:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1078', '2015-09-17 03:01:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1079', '2015-09-17 03:01:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ConsumoInter, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1080', '2015-09-17 03:01:41', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ConsumoInter[id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1081', '2015-09-17 03:01:42', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1082', '2015-09-17 12:41:37', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomMercado, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1083', '2015-09-17 13:16:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('1084', '2015-09-17 13:16:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('1085', '2015-09-17 13:16:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1086', '2015-09-17 13:16:25', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomFuentes, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1087', '2015-09-17 13:18:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoMercado, Fila eliminada [id:13]');
INSERT INTO `appa_user_login_attempt` VALUES ('1088', '2015-09-17 13:18:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla ProductoMercado, Fila eliminada [id:12]');
INSERT INTO `appa_user_login_attempt` VALUES ('1089', '2015-09-17 14:33:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1090', '2015-09-17 18:30:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1091', '2015-09-17 18:36:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1092', '2015-09-17 18:37:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1093', '2015-09-17 18:42:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1094', '2015-09-17 18:42:43', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1095', '2015-09-17 18:42:48', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1096', '2015-09-17 18:42:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1097', '2015-09-17 18:43:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1098', '2015-09-17 18:43:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1099', '2015-09-17 18:43:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla BoletaProducto[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1100', '2015-09-17 18:45:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1101', '2015-09-17 18:50:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1102', '2015-09-17 18:53:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomMercado, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1103', '2015-09-17 18:55:46', 'sdddd', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1104', '2015-09-17 18:55:55', 'norbyn', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1105', '2015-09-17 18:55:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1106', '2015-09-18 08:42:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1107', '2015-09-18 08:44:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomSubordinacion, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1108', '2015-09-18 09:04:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1109', '2015-09-18 09:09:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1110', '2015-09-18 10:25:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1111', '2015-09-18 10:26:30', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1112', '2015-09-18 10:37:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1113', '2015-09-18 10:38:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1114', '2015-09-18 10:39:07', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1115', '2015-09-18 10:43:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1116', '2015-09-18 10:43:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1117', '2015-09-18 10:51:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1118', '2015-09-18 10:55:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1119', '2015-09-18 10:57:23', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1120', '2015-09-18 11:03:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1121', '2015-09-18 11:04:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1122', '2015-09-18 11:48:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1123', '2015-09-18 11:49:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1124', '2015-09-20 22:20:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1125', '2015-09-20 22:52:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1126', '2015-09-20 22:55:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1127', '2015-09-20 22:59:21', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1128', '2015-09-21 00:00:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomComedor, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1129', '2015-09-21 00:00:02', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomComedor, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1130', '2015-09-21 00:18:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1131', '2015-09-21 00:28:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1132', '2015-09-21 12:57:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1133', '2015-09-21 12:58:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1134', '2015-09-22 11:16:42', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1135', '2015-09-22 11:33:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1136', '2015-09-22 11:45:44', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1137', '2015-09-22 11:47:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1138', '2015-09-22 11:49:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1139', '2015-09-22 11:51:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1140', '2015-09-22 11:53:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1141', '2015-09-22 11:53:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1142', '2015-09-22 11:56:16', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1143', '2015-09-22 12:15:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1144', '2015-09-22 12:15:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1145', '2015-09-22 12:21:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1146', '2015-09-22 12:21:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:28]');
INSERT INTO `appa_user_login_attempt` VALUES ('1147', '2015-09-22 12:21:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1148', '2015-09-22 12:22:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:30]');
INSERT INTO `appa_user_login_attempt` VALUES ('1149', '2015-09-22 12:22:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla BaseDatos, Fila eliminada [id:29]');
INSERT INTO `appa_user_login_attempt` VALUES ('1150', '2015-09-22 12:31:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1151', '2015-09-22 12:31:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1152', '2015-09-22 12:44:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1153', '2015-09-22 12:53:28', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1154', '2015-09-22 12:56:20', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1155', '2015-09-22 14:34:48', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1156', '2015-09-22 14:46:21', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1157', '2015-09-22 15:19:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1158', '2015-09-22 15:57:46', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1159', '2015-09-22 16:23:12', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomComedor, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1160', '2015-09-22 16:23:52', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomComedor, Fila eliminada [id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1161', '2015-09-22 16:24:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomComedor, Fila eliminada [id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('1162', '2015-09-22 16:25:07', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Tabla NomComedor, Fila eliminada [id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('1163', '2015-09-22 16:45:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1164', '2015-09-22 16:46:09', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1165', '2015-09-22 16:49:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1166', '2015-09-22 16:52:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1167', '2015-09-22 16:53:25', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1168', '2015-09-22 16:54:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1169', '2015-09-22 22:49:25', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1170', '2015-09-22 22:53:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1171', '2015-09-23 02:33:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1172', '2015-09-24 11:08:39', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1173', '2015-09-24 11:11:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1174', '2015-09-24 11:16:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:33]');
INSERT INTO `appa_user_login_attempt` VALUES ('1175', '2015-09-24 11:16:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:33]');
INSERT INTO `appa_user_login_attempt` VALUES ('1176', '2015-09-24 11:16:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:33]');
INSERT INTO `appa_user_login_attempt` VALUES ('1177', '2015-09-24 11:17:02', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Asignando/Actualizando tabla ActividadProducto[id:33]');
INSERT INTO `appa_user_login_attempt` VALUES ('1178', '2015-09-24 12:37:11', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1179', '2015-09-24 12:37:51', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1180', '2015-09-24 12:45:36', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:38.0) Gecko/20100101 Firefox/38.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1181', '2015-09-24 16:11:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1182', '2015-09-24 16:33:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1183', '2015-09-24 17:48:42', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1184', '2015-09-24 23:05:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1185', '2015-09-24 23:14:26', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1186', '2015-09-24 23:46:25', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1187', '2015-09-25 00:10:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1188', '2015-09-25 00:52:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1189', '2015-09-25 00:53:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1190', '2015-09-25 01:46:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1191', '2015-09-25 01:48:47', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1192', '2015-09-25 01:50:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1193', '2015-09-25 02:01:54', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1194', '2015-09-25 02:23:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1195', '2015-09-25 02:39:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1196', '2015-09-25 08:52:55', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1197', '2015-09-25 08:54:39', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1198', '2015-09-25 13:22:30', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1199', '2015-09-25 13:23:00', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1200', '2015-09-26 01:40:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1201', '2015-09-26 12:05:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1202', '2015-09-26 12:57:22', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1203', '2015-09-26 13:40:41', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1204', '2015-09-26 16:23:33', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1205', '2015-09-26 19:19:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1206', '2015-09-26 19:20:33', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1207', '2015-09-26 22:02:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1208', '2015-09-26 22:19:31', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1209', '2015-09-27 00:31:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1210', '2015-09-27 01:32:06', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1211', '2015-09-27 02:06:40', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1212', '2015-09-27 02:07:52', 'norbyn', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1213', '2015-09-27 02:08:11', 'norbyn', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1214', '2015-09-27 02:08:24', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1215', '2015-09-27 02:08:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1216', '2015-09-27 02:40:52', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1217', '2015-09-27 02:52:13', 'Invitado', '127.0.0.1', '1', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.3)', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1218', '2015-09-27 02:53:37', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1219', '2015-09-27 02:57:22', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1220', '2015-09-27 03:12:01', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1221', '2015-09-27 08:29:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1222', '2015-09-27 08:30:05', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1223', '2015-09-27 08:33:36', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1224', '2015-09-27 08:37:05', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1225', '2015-09-27 08:37:20', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1226', '2015-09-27 12:34:45', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1227', '2015-09-27 12:36:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1228', '2015-09-29 17:23:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1229', '2015-09-29 17:24:49', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1230', '2015-09-30 22:43:24', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1231', '2015-09-30 22:43:26', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1232', '2015-09-30 23:30:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1233', '2015-09-30 23:30:51', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1234', '2015-10-01 21:09:34', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1235', '2015-10-01 22:51:31', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1236', '2015-10-01 22:59:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1237', '2015-10-01 23:01:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1238', '2015-10-01 23:11:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1239', '2015-10-01 23:11:58', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1240', '2015-10-01 23:12:04', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1241', '2015-10-01 23:14:19', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1242', '2015-10-01 23:14:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1243', '2015-10-01 23:16:07', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1244', '2015-10-01 23:16:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1245', '2015-10-01 23:16:16', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1246', '2015-10-01 23:19:10', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1247', '2015-10-01 23:23:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1248', '2015-10-01 23:30:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1249', '2015-10-02 00:12:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1250', '2015-10-02 00:41:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1251', '2015-10-02 00:42:20', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1252', '2015-10-02 00:42:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1253', '2015-10-02 00:44:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1254', '2015-10-02 00:45:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1255', '2015-10-02 00:46:01', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1256', '2015-10-02 00:46:22', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1257', '2015-10-02 00:47:32', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1258', '2015-10-02 00:47:35', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1259', '2015-10-02 00:48:13', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1260', '2015-10-02 00:48:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1261', '2015-10-02 00:48:50', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1262', '2015-10-02 00:48:56', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1263', '2015-10-02 00:49:47', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1264', '2015-10-02 00:49:53', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1265', '2015-10-02 00:49:57', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1266', '2015-10-02 00:51:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1267', '2015-10-02 00:51:33', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1268', '2015-10-02 00:51:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1269', '2015-10-02 00:52:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1270', '2015-10-02 00:52:45', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1271', '2015-10-02 00:53:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1272', '2015-10-02 00:53:54', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1273', '2015-10-02 00:55:03', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1274', '2015-10-02 00:55:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1275', '2015-10-02 00:56:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1276', '2015-10-02 00:57:12', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1277', '2015-10-02 00:57:17', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1278', '2015-10-02 00:59:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1279', '2015-10-02 01:01:07', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1280', '2015-10-02 01:02:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1281', '2015-10-02 01:03:29', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1282', '2015-10-02 01:06:18', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1283', '2015-10-02 01:06:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1284', '2015-10-02 01:06:46', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1285', '2015-10-02 01:06:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1286', '2015-10-02 01:07:28', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1287', '2015-10-02 01:07:38', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1288', '2015-10-02 01:07:43', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1289', '2015-10-02 01:07:48', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1290', '2015-10-02 01:07:52', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1291', '2015-10-02 01:07:59', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1292', '2015-10-02 01:08:05', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1293', '2015-10-02 01:08:27', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1294', '2015-10-02 01:10:37', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1295', '2015-10-02 01:10:42', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1296', '2015-10-02 01:10:49', 'norbyn', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1297', '2015-10-02 01:11:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1298', '2015-10-02 01:12:00', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1299', '2015-10-02 01:13:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1300', '2015-10-02 01:13:59', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1301', '2015-10-02 01:14:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1302', '2015-10-02 01:14:10', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1303', '2015-10-02 01:14:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1304', '2015-10-02 01:14:19', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1305', '2015-10-02 01:23:27', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1306', '2015-10-02 01:23:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1307', '2015-10-02 01:24:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1308', '2015-10-02 01:24:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1309', '2015-10-02 01:24:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1310', '2015-10-02 01:24:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1311', '2015-10-02 01:25:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1312', '2015-10-02 01:25:23', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1313', '2015-10-02 01:25:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1314', '2015-10-02 01:25:34', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1315', '2015-10-02 01:25:38', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1316', '2015-10-02 01:43:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1317', '2015-10-02 01:46:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1318', '2015-10-02 01:46:29', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1319', '2015-10-02 01:46:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1320', '2015-10-02 01:46:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1321', '2015-10-02 01:46:55', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1322', '2015-10-02 01:47:20', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1323', '2015-10-02 01:47:31', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1324', '2015-10-02 01:47:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1325', '2015-10-02 01:49:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1326', '2015-10-02 01:51:24', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1327', '2015-10-02 01:51:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1328', '2015-10-02 01:53:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla ProductoMercado, Fila eliminada [id:15]');
INSERT INTO `appa_user_login_attempt` VALUES ('1329', '2015-10-02 01:53:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1330', '2015-10-02 01:53:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1331', '2015-10-02 01:54:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1332', '2015-10-02 01:54:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1333', '2015-10-02 01:54:17', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BaseDatos, Fila eliminada [id:32]');
INSERT INTO `appa_user_login_attempt` VALUES ('1334', '2015-10-02 01:56:26', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1335', '2015-10-02 01:56:31', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BaseDatos, Fila eliminada [id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('1336', '2015-10-02 01:56:33', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BaseDatos, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1337', '2015-10-02 01:57:02', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1338', '2015-10-02 01:57:52', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1339', '2015-10-02 01:58:04', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1340', '2015-10-02 02:54:44', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1341', '2015-10-02 02:58:35', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1342', '2015-10-02 02:58:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1343', '2015-10-02 02:58:50', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BalanceMes, Fila eliminada [id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('1344', '2015-10-02 02:58:53', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1345', '2015-10-02 02:58:57', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BalanceMes, Fila eliminada [id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('1346', '2015-10-02 02:58:59', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BalanceMes, Fila eliminada [id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1347', '2015-10-02 02:59:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Tabla BalanceMes, Fila eliminada [id:2]');
INSERT INTO `appa_user_login_attempt` VALUES ('1348', '2015-10-02 02:59:06', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1349', '2015-10-02 02:59:10', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1350', '2015-10-02 02:59:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1351', '2015-10-02 02:59:36', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1352', '2015-10-02 08:14:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla ConsumoInter');
INSERT INTO `appa_user_login_attempt` VALUES ('1353', '2015-10-02 08:34:52', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1354', '2015-10-02 08:34:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1355', '2015-10-02 08:35:01', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1356', '2015-10-02 08:35:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1357', '2015-10-02 08:35:08', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1358', '2015-10-02 09:34:52', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1359', '2015-10-02 09:35:34', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Tabla BalanceMes, Fila eliminada [id:12]');
INSERT INTO `appa_user_login_attempt` VALUES ('1360', '2015-10-02 09:49:32', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Tabla NomComedor, Fila eliminada [id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1361', '2015-10-02 09:53:13', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1362', '2015-10-02 10:58:00', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Tabla Comedor, Fila eliminada [id:21]');
INSERT INTO `appa_user_login_attempt` VALUES ('1363', '2015-10-02 10:58:11', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Tabla Comedor, Fila eliminada [id:22]');
INSERT INTO `appa_user_login_attempt` VALUES ('1364', '2015-10-02 11:06:02', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BalanceMes');
INSERT INTO `appa_user_login_attempt` VALUES ('1365', '2015-10-02 11:08:59', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1366', '2015-10-02 11:12:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1367', '2015-10-02 11:18:42', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1368', '2015-10-02 11:23:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Listando tabla BaseDatos');
INSERT INTO `appa_user_login_attempt` VALUES ('1369', '2015-10-02 11:32:40', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1370', '2015-10-02 11:33:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla Boleta[id:3]');
INSERT INTO `appa_user_login_attempt` VALUES ('1371', '2015-10-02 11:33:25', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1372', '2015-10-02 11:33:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('1373', '2015-10-02 11:33:52', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('1374', '2015-10-02 11:33:58', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('1375', '2015-10-02 11:34:05', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('1376', '2015-10-02 11:35:55', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla Boleta[id:4]');
INSERT INTO `appa_user_login_attempt` VALUES ('1377', '2015-10-02 11:35:59', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1378', '2015-10-02 11:36:09', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1379', '2015-10-02 11:36:14', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:7]');
INSERT INTO `appa_user_login_attempt` VALUES ('1380', '2015-10-02 11:41:45', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla Boleta[id:5]');
INSERT INTO `appa_user_login_attempt` VALUES ('1381', '2015-10-02 11:41:56', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1382', '2015-10-02 11:42:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1383', '2015-10-02 11:42:23', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:8]');
INSERT INTO `appa_user_login_attempt` VALUES ('1384', '2015-10-02 11:44:00', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla Boleta[id:6]');
INSERT INTO `appa_user_login_attempt` VALUES ('1385', '2015-10-02 11:44:03', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1386', '2015-10-02 11:44:15', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1387', '2015-10-02 11:44:39', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Listando tabla BoletaProducto');
INSERT INTO `appa_user_login_attempt` VALUES ('1388', '2015-10-02 11:44:44', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('1389', '2015-10-02 11:44:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('1390', '2015-10-02 11:44:54', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:9]');
INSERT INTO `appa_user_login_attempt` VALUES ('1391', '2015-10-02 11:44:57', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Asignando/Actualizando tabla BoletaProducto[id:10]');
INSERT INTO `appa_user_login_attempt` VALUES ('1392', '2015-10-03 12:52:49', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22', 'Tabla OrgNominalizado, Fila eliminada [id:1]');
INSERT INTO `appa_user_login_attempt` VALUES ('1393', '2015-12-21 23:10:28', '0', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', 'Listando tabla Boleta');
INSERT INTO `appa_user_login_attempt` VALUES ('1394', '2016-01-10 11:01:56', 'admin', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1395', '2016-01-10 11:02:13', 'administrador', '127.0.0.1', '0', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', 'Intento de inicio de sesión: [Error de usuario y/o clave.]\n');
INSERT INTO `appa_user_login_attempt` VALUES ('1396', '2016-01-10 11:04:53', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1397', '2016-01-10 11:05:00', 'auditor', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1398', '2016-01-10 11:11:31', 'Invitado', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', 'Sesión iniciada.');
INSERT INTO `appa_user_login_attempt` VALUES ('1399', '2016-01-10 11:12:46', 'administrador', '127.0.0.1', '1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', 'Sesión iniciada.');

-- ----------------------------
-- Table structure for `appa_user_permission`
-- ----------------------------
DROP TABLE IF EXISTS `appa_user_permission`;
CREATE TABLE `appa_user_permission` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `appa_user_permission_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `appa_permission` (`id`),
  CONSTRAINT `appa_user_permission_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `appa_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appa_user_permission
-- ----------------------------
INSERT INTO `appa_user_permission` VALUES ('1', '1');
INSERT INTO `appa_user_permission` VALUES ('2', '2');
INSERT INTO `appa_user_permission` VALUES ('1', '2');
INSERT INTO `appa_user_permission` VALUES ('1', '3');
INSERT INTO `appa_user_permission` VALUES ('3', '3');

-- ----------------------------
-- Table structure for `appa_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `appa_user_role`;
CREATE TABLE `appa_user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `appa_user_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `appa_role` (`id`),
  CONSTRAINT `appa_user_role_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `appa_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appa_user_role
-- ----------------------------
INSERT INTO `appa_user_role` VALUES ('1', '1');
INSERT INTO `appa_user_role` VALUES ('2', '2');
INSERT INTO `appa_user_role` VALUES ('3', '3');

-- ----------------------------
-- Table structure for `balance_alim`
-- ----------------------------
DROP TABLE IF EXISTS `balance_alim`;
CREATE TABLE `balance_alim` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comedor_id` int(11) NOT NULL,
  `fisico` int(11) NOT NULL COMMENT 'fisico = cantidad de trabajadores aprobados en el plan',
  `nivel_act` int(11) NOT NULL DEFAULT '0' COMMENT 'nivel_act = Nivel de Actividad: cantidad de hombres reales\nnivel_act <= fisico',
  `almuerzo_evt` int(11) DEFAULT NULL,
  `merienda_evt` int(11) DEFAULT NULL,
  `comida_evt` int(11) DEFAULT NULL,
  `indice_comensal` float(11,4) DEFAULT NULL,
  `norma` float(11,4) DEFAULT NULL,
  `created_at` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comedor_id` (`comedor_id`),
  CONSTRAINT `balance_alim_fk1` FOREIGN KEY (`comedor_id`) REFERENCES `comedor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='Nivel de Actividad';

-- ----------------------------
-- Records of balance_alim
-- ----------------------------
INSERT INTO `balance_alim` VALUES ('20', '19', '330', '22', '0', '0', '0', '0.0000', null, '2015-10-02', '2015-10-02 15:00:58');
INSERT INTO `balance_alim` VALUES ('21', '20', '1455', '22', '0', '0', '0', '0.0000', null, '2015-10-02', '2015-10-02 15:01:51');
INSERT INTO `balance_alim` VALUES ('22', '23', '450', '22', '459', '450', '200', '0.0000', null, '2015-10-02', '2015-10-02 15:02:35');

-- ----------------------------
-- Table structure for `balance_mes`
-- ----------------------------
DROP TABLE IF EXISTS `balance_mes`;
CREATE TABLE `balance_mes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `balance_id` bigint(20) NOT NULL,
  `real_mes` float(18,4) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_id_idx` (`balance_id`),
  CONSTRAINT `balance_id_idx` FOREIGN KEY (`balance_id`) REFERENCES `balance_alim` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of balance_mes
-- ----------------------------
INSERT INTO `balance_mes` VALUES ('14', '20', '22.0000', '2015-10-02', '2015-10-02 15:06:22');

-- ----------------------------
-- Table structure for `base_datos`
-- ----------------------------
DROP TABLE IF EXISTS `base_datos`;
CREATE TABLE `base_datos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `balance_alim_id` bigint(20) NOT NULL,
  `ajuste` float(11,4) NOT NULL,
  `created_at` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbase-datos341008` (`balance_alim_id`),
  KEY `FKbase-datos552420` (`producto_id`),
  CONSTRAINT `FKbase-datos341008` FOREIGN KEY (`balance_alim_id`) REFERENCES `balance_alim` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FKbase-datos552420` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of base_datos
-- ----------------------------
INSERT INTO `base_datos` VALUES ('32', '21', '20', '0.0000', '2015-10-02', '2015-10-02 15:09:18');
INSERT INTO `base_datos` VALUES ('33', '23', '20', '0.0000', '2015-10-02', '2015-10-02 15:23:22');

-- ----------------------------
-- Table structure for `boleta`
-- ----------------------------
DROP TABLE IF EXISTS `boleta`;
CREATE TABLE `boleta` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `entidad_id` int(4) NOT NULL,
  `consec` int(4) NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `consec` (`consec`) USING BTREE,
  KEY `entidad_id` (`entidad_id`) USING BTREE,
  KEY `proveedor_id` (`proveedor_id`) USING BTREE,
  CONSTRAINT `boleta_ibfk_1` FOREIGN KEY (`entidad_id`) REFERENCES `nom_entidad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `boleta_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `nom_proveedor` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of boleta
-- ----------------------------
INSERT INTO `boleta` VALUES ('3', '8', '1', '2015-10-02', '12');
INSERT INTO `boleta` VALUES ('4', '8', '2', '2015-10-02', '13');
INSERT INTO `boleta` VALUES ('5', '9', '3', '2015-10-02', '12');
INSERT INTO `boleta` VALUES ('6', '9', '4', '2015-10-02', '14');

-- ----------------------------
-- Table structure for `boleta_producto`
-- ----------------------------
DROP TABLE IF EXISTS `boleta_producto`;
CREATE TABLE `boleta_producto` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `producto_id` int(4) NOT NULL,
  `cantidad` float(11,4) NOT NULL,
  `boleta_id` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`) USING BTREE,
  KEY `boleta_id` (`boleta_id`) USING BTREE,
  CONSTRAINT `boleta_producto_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `boleta_producto_ibfk_2` FOREIGN KEY (`boleta_id`) REFERENCES `boleta` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of boleta_producto
-- ----------------------------
INSERT INTO `boleta_producto` VALUES ('5', '21', '40.0000', '3');
INSERT INTO `boleta_producto` VALUES ('6', '23', '56.0000', '3');
INSERT INTO `boleta_producto` VALUES ('7', '35', '22.0000', '4');
INSERT INTO `boleta_producto` VALUES ('8', '21', '3.0000', '5');
INSERT INTO `boleta_producto` VALUES ('9', '44', '10.0000', '6');
INSERT INTO `boleta_producto` VALUES ('10', '45', '10.0000', '6');

-- ----------------------------
-- Table structure for `ci_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192;

-- ----------------------------
-- Records of ci_sessions
-- ----------------------------
INSERT INTO `ci_sessions` VALUES ('0fc6b7afb0caf924bae06612b1c4b9a4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2071.0 Safari/537.36', '1452443519', 'a:7:{s:9:\"user_data\";s:0:\"\";s:7:\"user_id\";s:1:\"2\";s:8:\"username\";s:8:\"Invitado\";s:5:\"email\";s:15:\"guess@gmail.com\";s:4:\"role\";s:8:\"Operador\";s:9:\"logged_in\";b:1;s:8:\"prev_url\";s:60:\"http://localhost/alimentos/index.php/appunto-auth/user/login\";}');
INSERT INTO `ci_sessions` VALUES ('1df4aaeee4c38ddcf9ef2482d607a473', '127.0.0.1', 'Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0', '1452443515', 'a:6:{s:7:\"user_id\";s:1:\"4\";s:8:\"username\";s:13:\"administrador\";s:5:\"email\";s:25:\"administrador@ejemplo.com\";s:4:\"role\";N;s:9:\"logged_in\";b:1;s:8:\"prev_url\";s:60:\"http://localhost/alimentos/index.php/appunto-auth/user/login\";}');

-- ----------------------------
-- Table structure for `comedor`
-- ----------------------------
DROP TABLE IF EXISTS `comedor`;
CREATE TABLE `comedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entidad_id` int(4) NOT NULL,
  `nombre_comedor_id` int(4) NOT NULL,
  `reup` varchar(10) DEFAULT NULL,
  `tc` char(4) DEFAULT NULL COMMENT 'Tipo de Comedor',
  PRIMARY KEY (`id`),
  KEY `FKcomedor507410` (`entidad_id`),
  KEY `FKcomedor903041` (`nombre_comedor_id`),
  KEY `id` (`id`),
  CONSTRAINT `comedor_fk1` FOREIGN KEY (`nombre_comedor_id`) REFERENCES `nom_comedor` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FKcomedor507410` FOREIGN KEY (`entidad_id`) REFERENCES `nom_entidad` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comedor
-- ----------------------------
INSERT INTO `comedor` VALUES ('19', '8', '9', '', 'E/M');
INSERT INTO `comedor` VALUES ('20', '8', '11', '', 'E/G');
INSERT INTO `comedor` VALUES ('23', '8', '14', '', '');

-- ----------------------------
-- Table structure for `consumo_inter`
-- ----------------------------
DROP TABLE IF EXISTS `consumo_inter`;
CREATE TABLE `consumo_inter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entidad_id` int(4) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cant` float NOT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  PRIMARY KEY (`id`),
  KEY `FKconsumo_in944547` (`entidad_id`),
  KEY `FKconsumo_in972135` (`producto_id`),
  CONSTRAINT `FKconsumo_in944547` FOREIGN KEY (`entidad_id`) REFERENCES `nom_entidad` (`id`),
  CONSTRAINT `FKconsumo_in972135` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of consumo_inter
-- ----------------------------

-- ----------------------------
-- Table structure for `disponibilidad`
-- ----------------------------
DROP TABLE IF EXISTS `disponibilidad`;
CREATE TABLE `disponibilidad` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `producto_id` int(4) NOT NULL,
  `saldo` float(11,4) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `disponibilidad_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of disponibilidad
-- ----------------------------
INSERT INTO `disponibilidad` VALUES ('1', '21', '12.3434', '2015-09-15');
INSERT INTO `disponibilidad` VALUES ('2', '37', '78.8787', '2015-09-15');
INSERT INTO `disponibilidad` VALUES ('3', '22', '17.3454', '2015-09-17');
INSERT INTO `disponibilidad` VALUES ('4', '21', '423.0000', '2015-10-02');
INSERT INTO `disponibilidad` VALUES ('5', '35', '5.0000', '2015-10-02');

-- ----------------------------
-- Table structure for `eventos`
-- ----------------------------
DROP TABLE IF EXISTS `eventos`;
CREATE TABLE `eventos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entidad_id` int(4) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `cant` float NOT NULL,
  `ajuste` int(3) DEFAULT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  PRIMARY KEY (`id`),
  KEY `FKeventos155465` (`entidad_id`),
  KEY `FKeventos872122` (`producto_id`),
  CONSTRAINT `FKeventos155465` FOREIGN KEY (`entidad_id`) REFERENCES `nom_entidad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FKeventos872122` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eventos
-- ----------------------------

-- ----------------------------
-- Table structure for `inventario`
-- ----------------------------
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entidad_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cant` float(11,4) NOT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  PRIMARY KEY (`id`),
  KEY `FKinventario86335` (`producto_id`),
  KEY `entidad_id` (`entidad_id`),
  CONSTRAINT `FKinventario86335` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `inventario_fk1` FOREIGN KEY (`entidad_id`) REFERENCES `nom_entidad` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of inventario
-- ----------------------------

-- ----------------------------
-- Table structure for `nom_actividad`
-- ----------------------------
DROP TABLE IF EXISTS `nom_actividad`;
CREATE TABLE `nom_actividad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_actividad
-- ----------------------------
INSERT INTO `nom_actividad` VALUES ('12', 'Consumo Intermedio');
INSERT INTO `nom_actividad` VALUES ('8', 'Cultura');
INSERT INTO `nom_actividad` VALUES ('9', 'Deportes');
INSERT INTO `nom_actividad` VALUES ('4', 'Educación');
INSERT INTO `nom_actividad` VALUES ('6', 'Educación  Superior');
INSERT INTO `nom_actividad` VALUES ('10', 'Gastronomía');
INSERT INTO `nom_actividad` VALUES ('5', 'Merienda Escolar');
INSERT INTO `nom_actividad` VALUES ('11', 'Otros Destinos');
INSERT INTO `nom_actividad` VALUES ('3', 'Salud Pública');

-- ----------------------------
-- Table structure for `nom_comedor`
-- ----------------------------
DROP TABLE IF EXISTS `nom_comedor`;
CREATE TABLE `nom_comedor` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `is_evento` tinyint(1) NOT NULL,
  `periodo` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_comedor
-- ----------------------------
INSERT INTO `nom_comedor` VALUES ('9', 'Camas Asistencia Médicas Pediatricas', '0', '12');
INSERT INTO `nom_comedor` VALUES ('10', ' Camas Asist Médica Hogares Materno', '0', '12');
INSERT INTO `nom_comedor` VALUES ('11', ' Camas Asist Médica Resto', '0', '12');
INSERT INTO `nom_comedor` VALUES ('12', 'El Tinajón', '1', '0');
INSERT INTO `nom_comedor` VALUES ('13', 'Fiestas Populares', '1', '0');
INSERT INTO `nom_comedor` VALUES ('14', 'Carnaval del psiquiátrico', '1', '0');

-- ----------------------------
-- Table structure for `nom_entidad`
-- ----------------------------
DROP TABLE IF EXISTS `nom_entidad`;
CREATE TABLE `nom_entidad` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `organismo_id` int(4) NOT NULL,
  `reeup` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FKentidad955948` (`organismo_id`),
  CONSTRAINT `FKentidad955948` FOREIGN KEY (`organismo_id`) REFERENCES `nom_organismo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_entidad
-- ----------------------------
INSERT INTO `nom_entidad` VALUES ('8', ' Dirección Provincial de Salud', '6', '23123');
INSERT INTO `nom_entidad` VALUES ('9', 'Dirección Municipales de Salud', '6', '3333');

-- ----------------------------
-- Table structure for `nom_fuentes`
-- ----------------------------
DROP TABLE IF EXISTS `nom_fuentes`;
CREATE TABLE `nom_fuentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_fuentes
-- ----------------------------
INSERT INTO `nom_fuentes` VALUES ('1', 'Inventario inicial');
INSERT INTO `nom_fuentes` VALUES ('3', 'Otras Fuentes');
INSERT INTO `nom_fuentes` VALUES ('2', 'Producción');

-- ----------------------------
-- Table structure for `nom_mercado`
-- ----------------------------
DROP TABLE IF EXISTS `nom_mercado`;
CREATE TABLE `nom_mercado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_mercado
-- ----------------------------
INSERT INTO `nom_mercado` VALUES ('1', 'MERCADO IDEAL');
INSERT INTO `nom_mercado` VALUES ('2', 'VENTAS LIBERADAS');
INSERT INTO `nom_mercado` VALUES ('3', 'CUENTA PROPIA');
INSERT INTO `nom_mercado` VALUES ('4', 'CANASTA FAMILIAR');
INSERT INTO `nom_mercado` VALUES ('5', '     Niños o Cuota');
INSERT INTO `nom_mercado` VALUES ('6', 'DIETAS MEDICAS');

-- ----------------------------
-- Table structure for `nom_municipio`
-- ----------------------------
DROP TABLE IF EXISTS `nom_municipio`;
CREATE TABLE `nom_municipio` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `provincia_id` int(2) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FKmunicipio214480` (`provincia_id`),
  CONSTRAINT `FKmunicipio214480` FOREIGN KEY (`provincia_id`) REFERENCES `nom_provincia` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_municipio
-- ----------------------------
INSERT INTO `nom_municipio` VALUES ('1', '1', 'Céspedes');
INSERT INTO `nom_municipio` VALUES ('2', '1', 'Minas');
INSERT INTO `nom_municipio` VALUES ('3', '1', 'Esmeralda');
INSERT INTO `nom_municipio` VALUES ('4', '1', 'Florida');
INSERT INTO `nom_municipio` VALUES ('5', '1', 'Santa Cruz del Sur');
INSERT INTO `nom_municipio` VALUES ('6', '1', 'Nuevitas');
INSERT INTO `nom_municipio` VALUES ('7', '1', 'Guáimaro');
INSERT INTO `nom_municipio` VALUES ('8', '1', 'Vertientes');
INSERT INTO `nom_municipio` VALUES ('9', '1', 'Camagüey');
INSERT INTO `nom_municipio` VALUES ('15', '1', 'Sierra de Cubitas');
INSERT INTO `nom_municipio` VALUES ('16', '1', 'Sibanicú');
INSERT INTO `nom_municipio` VALUES ('18', '1', 'Jimaguayú');
INSERT INTO `nom_municipio` VALUES ('19', '1', 'Najasa');
INSERT INTO `nom_municipio` VALUES ('20', '2', 'CARDENAS');

-- ----------------------------
-- Table structure for `nom_organismo`
-- ----------------------------
DROP TABLE IF EXISTS `nom_organismo`;
CREATE TABLE `nom_organismo` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `subordinacion_id` int(2) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `is_cap` tinyint(1) NOT NULL DEFAULT '0',
  `is_nominalizado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FKorganismo30463` (`subordinacion_id`),
  CONSTRAINT `FKorganismo30463` FOREIGN KEY (`subordinacion_id`) REFERENCES `nom_subordinacion` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_organismo
-- ----------------------------
INSERT INTO `nom_organismo` VALUES ('6', '2', 'Salud', '0', '0');
INSERT INTO `nom_organismo` VALUES ('7', '1', 'Educación', '0', '0');
INSERT INTO `nom_organismo` VALUES ('8', '2', 'Universidades', '0', '0');

-- ----------------------------
-- Table structure for `nom_producto`
-- ----------------------------
DROP TABLE IF EXISTS `nom_producto`;
CREATE TABLE `nom_producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `um_id` int(11) NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `norma` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`,`proveedor_id`) USING BTREE,
  KEY `FKproducto611882` (`proveedor_id`),
  KEY `FKproducto361287` (`um_id`),
  CONSTRAINT `FKproducto361287` FOREIGN KEY (`um_id`) REFERENCES `nom_um` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FKproducto611882` FOREIGN KEY (`proveedor_id`) REFERENCES `nom_proveedor` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_producto
-- ----------------------------
INSERT INTO `nom_producto` VALUES ('21', 'Arroz', '5', '12', '0.3445');
INSERT INTO `nom_producto` VALUES ('22', 'Granos', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('23', 'Aceite', '7', '12', '0.44');
INSERT INTO `nom_producto` VALUES ('24', 'Azúcar refino', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('25', 'Azúcar Crudo', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('26', 'Sal', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('27', 'Pastas Alimenticias', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('28', 'Harina de Maíz', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('29', 'Harina Integral de Maíz', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('30', 'Proteína Vegetal', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('31', 'Compota', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('32', 'Harina de Integral de Trigo ', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('33', 'Harina de Trigo Blanca', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('34', 'Fideo', '5', '12', '0');
INSERT INTO `nom_producto` VALUES ('35', 'Carne de Res', '5', '13', '2');
INSERT INTO `nom_producto` VALUES ('36', 'Carne de ave', '5', '13', '0.033');
INSERT INTO `nom_producto` VALUES ('37', 'Carne de Cerdo', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('38', 'Otras Carnes', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('39', 'Masa de Croqueta', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('40', 'Jamonada Especial', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('41', 'Ahumados', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('42', 'Vísceras de Res', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('43', 'Vísceras de Cerdo', '5', '13', '0');
INSERT INTO `nom_producto` VALUES ('44', 'Productos Pesqueros', '5', '14', '0');
INSERT INTO `nom_producto` VALUES ('45', 'Picadillo de Pescado', '5', '14', '0');
INSERT INTO `nom_producto` VALUES ('46', 'Gallina', '5', '15', '0');
INSERT INTO `nom_producto` VALUES ('47', 'Huevo', '6', '15', '0');
INSERT INTO `nom_producto` VALUES ('48', 'Lactosoy', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('49', 'Queso', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('50', 'Queso Crema', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('51', 'Yogurt Natural', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('52', 'Yogurt Soya', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('53', 'Helado', '8', '16', '0');
INSERT INTO `nom_producto` VALUES ('54', 'Mantequilla', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('55', 'Refresco Instantáneo', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('56', 'Leche en polvo', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('57', 'Leche Fluida', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('58', 'Mezcla Física', '5', '16', '0');
INSERT INTO `nom_producto` VALUES ('59', 'Sirope', '7', '17', '0');
INSERT INTO `nom_producto` VALUES ('60', 'Refresco Embotellado', '9', '17', '0');
INSERT INTO `nom_producto` VALUES ('61', 'Ron Embotellado', '9', '17', '0');
INSERT INTO `nom_producto` VALUES ('62', 'Ron Granel', '9', '17', '0');
INSERT INTO `nom_producto` VALUES ('63', 'Refresco total', '9', '17', '0');
INSERT INTO `nom_producto` VALUES ('64', 'Vinagre ', '7', '17', '0');
INSERT INTO `nom_producto` VALUES ('65', 'Vino Seco', '7', '17', '0');
INSERT INTO `nom_producto` VALUES ('66', 'Conservas de Tomate', '5', '18', '0');
INSERT INTO `nom_producto` VALUES ('67', 'Sofrito', '5', '18', '0');
INSERT INTO `nom_producto` VALUES ('68', 'Dulce en Almíbar', '5', '18', '0');
INSERT INTO `nom_producto` VALUES ('69', 'Mayonesa', '5', '18', '0');
INSERT INTO `nom_producto` VALUES ('70', 'Panqué', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('71', 'Galleta de Sal', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('72', 'Galleta de Dulce', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('73', 'Caramelo ', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('74', 'Natilla', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('78', 'Refresco Instantáneo', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('80', 'Mezcla para pizzas', '5', '19', '0');
INSERT INTO `nom_producto` VALUES ('81', 'Pan', '5', '20', '0.4659');
INSERT INTO `nom_producto` VALUES ('82', 'Pechuga', '5', '13', '0');

-- ----------------------------
-- Table structure for `nom_proveedor`
-- ----------------------------
DROP TABLE IF EXISTS `nom_proveedor`;
CREATE TABLE `nom_proveedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_proveedor
-- ----------------------------
INSERT INTO `nom_proveedor` VALUES ('22', 'Cervecería Tínima');
INSERT INTO `nom_proveedor` VALUES ('20', 'Empresa Alimentaria');
INSERT INTO `nom_proveedor` VALUES ('15', 'Empresa Avícola');
INSERT INTO `nom_proveedor` VALUES ('13', 'Empresa Cárnica');
INSERT INTO `nom_proveedor` VALUES ('19', 'Empresa Confitera');
INSERT INTO `nom_proveedor` VALUES ('21', 'Empresa de Aceite');
INSERT INTO `nom_proveedor` VALUES ('17', 'Empresa de Bebidas');
INSERT INTO `nom_proveedor` VALUES ('18', 'Empresa de Conservas');
INSERT INTO `nom_proveedor` VALUES ('16', 'Empresa de Productos Lácteos');
INSERT INTO `nom_proveedor` VALUES ('12', 'Empresa Mayorista');
INSERT INTO `nom_proveedor` VALUES ('14', 'Empresa Pesquera');

-- ----------------------------
-- Table structure for `nom_provincia`
-- ----------------------------
DROP TABLE IF EXISTS `nom_provincia`;
CREATE TABLE `nom_provincia` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_provincia
-- ----------------------------
INSERT INTO `nom_provincia` VALUES ('1', 'CAMAGUEY');
INSERT INTO `nom_provincia` VALUES ('2', 'MATANZAS');

-- ----------------------------
-- Table structure for `nom_subordinacion`
-- ----------------------------
DROP TABLE IF EXISTS `nom_subordinacion`;
CREATE TABLE `nom_subordinacion` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_subordinacion
-- ----------------------------
INSERT INTO `nom_subordinacion` VALUES ('2', 'Local');
INSERT INTO `nom_subordinacion` VALUES ('1', 'Nacional');

-- ----------------------------
-- Table structure for `nom_um`
-- ----------------------------
DROP TABLE IF EXISTS `nom_um`;
CREATE TABLE `nom_um` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  UNIQUE KEY `nombre_2` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nom_um
-- ----------------------------
INSERT INTO `nom_um` VALUES ('9', 'cja');
INSERT INTO `nom_um` VALUES ('8', 'gls');
INSERT INTO `nom_um` VALUES ('7', 'lts');
INSERT INTO `nom_um` VALUES ('10', 'mu');
INSERT INTO `nom_um` VALUES ('5', 'tn');
INSERT INTO `nom_um` VALUES ('6', 'u');

-- ----------------------------
-- Table structure for `org_nominalizado`
-- ----------------------------
DROP TABLE IF EXISTS `org_nominalizado`;
CREATE TABLE `org_nominalizado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entidad_id` int(4) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `ctd` float NOT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  PRIMARY KEY (`id`),
  KEY `FKorg_nomina966129` (`entidad_id`),
  KEY `FKorg_nomina977872` (`producto_id`),
  CONSTRAINT `FKorg_nomina966129` FOREIGN KEY (`entidad_id`) REFERENCES `nom_entidad` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FKorg_nomina977872` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of org_nominalizado
-- ----------------------------

-- ----------------------------
-- Table structure for `producto_fuentes`
-- ----------------------------
DROP TABLE IF EXISTS `producto_fuentes`;
CREATE TABLE `producto_fuentes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `fuentes_id` int(11) NOT NULL,
  `cant` float NOT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  PRIMARY KEY (`id`),
  KEY `FKproducto_f460462` (`producto_id`),
  KEY `FKproducto_f652947` (`fuentes_id`),
  CONSTRAINT `FKproducto_f460462` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FKproducto_f652947` FOREIGN KEY (`fuentes_id`) REFERENCES `nom_fuentes` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of producto_fuentes
-- ----------------------------

-- ----------------------------
-- Table structure for `producto_mercado`
-- ----------------------------
DROP TABLE IF EXISTS `producto_mercado`;
CREATE TABLE `producto_mercado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `mercado_id` int(11) NOT NULL,
  `cant` float NOT NULL,
  `fecha` date NOT NULL COMMENT 'Fecha en la que se guarda el dato',
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `mercado_id` (`mercado_id`),
  CONSTRAINT `producto_mercado_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `nom_producto` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `producto_mercado_ibfk_2` FOREIGN KEY (`mercado_id`) REFERENCES `nom_mercado` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of producto_mercado
-- ----------------------------
INSERT INTO `producto_mercado` VALUES ('7', '36', '1', '44', '2015-09-17');
INSERT INTO `producto_mercado` VALUES ('8', '35', '1', '55', '2015-09-17');
INSERT INTO `producto_mercado` VALUES ('9', '23', '1', '56', '2015-09-17');
INSERT INTO `producto_mercado` VALUES ('10', '21', '1', '77', '2015-09-17');
INSERT INTO `producto_mercado` VALUES ('11', '22', '1', '6.67', '2015-09-17');
INSERT INTO `producto_mercado` VALUES ('14', '21', '2', '45.5655', '2015-09-17');
