-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: retailstore
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `Address_ID` char(10) NOT NULL,
  `Address_Field1` varchar(50) NOT NULL,
  `Address_Field2` varchar(50) DEFAULT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `Zipcode` char(10) NOT NULL,
  PRIMARY KEY (`Address_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES ('A1','1167 Boylston Street',NULL,'Boston','MA','USA','2215'),('A2','360 Huntington Ave ',NULL,'Boston','MA','USA','2115'),('A3','400 Bedford Street ',NULL,'SanFransisco','CA','USA','94016'),('A4','35 Queensberry Street','Apt 23','Verona','PA','USA','15147'),('A5','1163 Boyslton Street','Apt 31','Boston','MA','USA','2215');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `Customer_ID` char(10) NOT NULL,
  `First_Name` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `PhoneNumber` char(10) DEFAULT NULL,
  `StoreCard_Number` char(10) DEFAULT NULL,
  `Address_ID` char(10) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`),
  KEY `IX_Relationship25` (`Address_ID`),
  CONSTRAINT `FK_Customer_ID_Address_ID` FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('C1','James','Bell','8677463746','SC1','A4'),('C2','Sonia','Anthony','6178374846','SC2','A5');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_order`
--

DROP TABLE IF EXISTS `customer_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_order` (
  `CustomerOrder_ID` char(10) NOT NULL,
  `TotalAmount` double NOT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `Customer_ID` char(10) DEFAULT NULL,
  `Payment_ID` char(10) DEFAULT NULL,
  PRIMARY KEY (`CustomerOrder_ID`),
  KEY `IX_Relationship37` (`Customer_ID`),
  KEY `IX_Relationship43` (`Payment_ID`),
  CONSTRAINT `FK_CustomerOrder_ID_CustomerPayment_ID` FOREIGN KEY (`Payment_ID`) REFERENCES `customer_payment_details` (`CustomerPayment_ID`),
  CONSTRAINT `FK_CustomerOrder_ID_Customer_ID` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order`
--

LOCK TABLES `customer_order` WRITE;
/*!40000 ALTER TABLE `customer_order` DISABLE KEYS */;
INSERT INTO `customer_order` VALUES ('CO1',27,'Pending','C2','CP2'),('CO2',22,'Pending','C1','CP1'),('CO3',6,'Pending','C1','CP4'),('CO4',0,NULL,'C2','CP3');
/*!40000 ALTER TABLE `customer_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_order_details`
--

DROP TABLE IF EXISTS `customer_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_order_details` (
  `CustOrder_ID` char(10) NOT NULL,
  `Amount` double(38,2) DEFAULT NULL,
  `Date` date NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Customer_Order_ID` char(10) NOT NULL,
  `Product_ID` char(10) NOT NULL,
  PRIMARY KEY (`CustOrder_ID`),
  KEY `IX_Relationship10` (`Product_ID`),
  CONSTRAINT `FK_Product_ID_CustOrder_ID` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_order_details`
--

LOCK TABLES `customer_order_details` WRITE;
/*!40000 ALTER TABLE `customer_order_details` DISABLE KEYS */;
INSERT INTO `customer_order_details` VALUES ('O1',6.00,'2017-04-20',2,'CO1','P1'),('O2',12.00,'2017-04-20',6,'CO1','P2'),('O3',6.00,'2017-04-20',3,'CO2','P3'),('O4',16.00,'2017-04-20',4,'CO2','P4'),('O5',6.00,'2017-04-20',2,'CO3','P5'),('O6',9.00,'2017-04-20',3,'CO1','P1');
/*!40000 ALTER TABLE `customer_order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_payment_details`
--

DROP TABLE IF EXISTS `customer_payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_payment_details` (
  `CustomerPayment_ID` char(10) NOT NULL,
  `NetAmount` double(38,2) DEFAULT NULL,
  `Customer_ID` char(10) DEFAULT NULL,
  `CustomerModeID` char(10) DEFAULT NULL,
  PRIMARY KEY (`CustomerPayment_ID`),
  KEY `IX_Relationship44` (`Customer_ID`),
  KEY `IX_Relationship47` (`CustomerModeID`),
  CONSTRAINT `FK_CustomerModeID_CustomerPayment_ID` FOREIGN KEY (`CustomerModeID`) REFERENCES `customerpaymentmode` (`CustomerModeID`),
  CONSTRAINT `FK_Customer_ID_CustomerPayment_ID` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_payment_details`
--

LOCK TABLES `customer_payment_details` WRITE;
/*!40000 ALTER TABLE `customer_payment_details` DISABLE KEYS */;
INSERT INTO `customer_payment_details` VALUES ('CP1',NULL,'C1','CM1'),('CP2',NULL,'C2','CM3'),('CP3',NULL,'C2','CM4'),('CP4',NULL,'C1','CM2');
/*!40000 ALTER TABLE `customer_payment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerpaymentmode`
--

DROP TABLE IF EXISTS `customerpaymentmode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customerpaymentmode` (
  `CustomerModeID` char(10) NOT NULL,
  `Mode` char(20) NOT NULL,
  `Discount` int(10) NOT NULL,
  PRIMARY KEY (`CustomerModeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerpaymentmode`
--

LOCK TABLES `customerpaymentmode` WRITE;
/*!40000 ALTER TABLE `customerpaymentmode` DISABLE KEYS */;
INSERT INTO `customerpaymentmode` VALUES ('CM1','CreditCard',5),('CM2','DebitCard',4),('CM3','Check',10),('CM4','Cash',6);
/*!40000 ALTER TABLE `customerpaymentmode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `expiredproductdetails`
--

DROP TABLE IF EXISTS `expiredproductdetails`;
/*!50001 DROP VIEW IF EXISTS `expiredproductdetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `expiredproductdetails` AS SELECT 
 1 AS `Product_ID`,
 1 AS `ProductName`,
 1 AS `Expiry_Date`,
 1 AS `remaining_quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `Inventory_ID` char(10) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Product_ID` char(10) DEFAULT NULL,
  PRIMARY KEY (`Inventory_ID`),
  KEY `IX_Relationship27` (`Product_ID`),
  CONSTRAINT `FK_Product_ID_Inventory_ID` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES ('I1',0,'P1'),('I2',0,'P3'),('I3',0,'P2');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `Product_ID` char(10) NOT NULL,
  `ProductName` varchar(20) NOT NULL,
  `Price` double(38,2) NOT NULL,
  `Manufactured_Date` date DEFAULT NULL,
  `Expiry_Date` date DEFAULT NULL,
  `Category_ID` char(10) NOT NULL,
  `Margin` int(11) DEFAULT NULL,
  `Subcategory_ID` char(10) DEFAULT NULL,
  PRIMARY KEY (`Product_ID`),
  KEY `IX_Relationship1` (`Category_ID`),
  KEY `IX_Relationship36` (`Subcategory_ID`),
  CONSTRAINT `FK_Category_ID_Product_ID` FOREIGN KEY (`Category_ID`) REFERENCES `productcategory` (`Category_ID`),
  CONSTRAINT `FK_Subcategory_ID_Product_ID` FOREIGN KEY (`Subcategory_ID`) REFERENCES `product_subcategory` (`Subcategory_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('P1','hood milk',2.99,'2017-04-19','2017-04-29','1',50,'1'),('P10','iphone7',749.00,'2017-04-11',NULL,'5',50,'10'),('P2','brown bread ',1.74,'2017-04-04','2017-04-10','1',30,'2'),('P3','white bread ',1.50,'2017-04-07','2017-04-14','1',30,'2'),('P4','carrots',3.50,'2017-04-04','2017-04-09','1',20,'3'),('P5','potatoes',2.99,'2017-04-05','2017-04-10','1',20,'3'),('P6','mens shirt',10.00,'2017-04-06',NULL,'2',50,'5'),('P7','wall clock',15.00,'2017-04-10',NULL,'3',10,'7'),('P8','kellogs',5.00,'2017-04-08','2017-05-20','1',20,'4'),('P9','womens dress',15.00,'2017-04-09',NULL,'2',50,'6');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `product_qunatity_inventory`
--

DROP TABLE IF EXISTS `product_qunatity_inventory`;
/*!50001 DROP VIEW IF EXISTS `product_qunatity_inventory`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `product_qunatity_inventory` AS SELECT 
 1 AS `Product_ID`,
 1 AS `ProductName`,
 1 AS `quantity_sold`,
 1 AS `Ordered_quantity`,
 1 AS `remaining_quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `product_subcategory`
--

DROP TABLE IF EXISTS `product_subcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_subcategory` (
  `Subcategory_ID` char(10) NOT NULL,
  `SubcategoryName` varchar(50) NOT NULL,
  `Category_ID` char(10) NOT NULL,
  PRIMARY KEY (`Subcategory_ID`),
  KEY `IX_Relationship2` (`Category_ID`),
  CONSTRAINT `FK_Subcategory_ID_Category_ID` FOREIGN KEY (`Category_ID`) REFERENCES `productcategory` (`Category_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_subcategory`
--

LOCK TABLES `product_subcategory` WRITE;
/*!40000 ALTER TABLE `product_subcategory` DISABLE KEYS */;
INSERT INTO `product_subcategory` VALUES ('1','dairy','1'),('10','cellphones','5'),('2','bread/bakery','1'),('3','vegetables','1'),('4','cereals','1'),('5','mens clothing','2'),('6','womens clothing','2'),('7','clocks','3'),('8','decorative storage','3'),('9','cookware','4');
/*!40000 ALTER TABLE `product_subcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productcategory`
--

DROP TABLE IF EXISTS `productcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productcategory` (
  `Category_ID` char(10) NOT NULL,
  `Category` varchar(50) NOT NULL,
  PRIMARY KEY (`Category_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productcategory`
--

LOCK TABLES `productcategory` WRITE;
/*!40000 ALTER TABLE `productcategory` DISABLE KEYS */;
INSERT INTO `productcategory` VALUES ('1','Food'),('2','Clothing'),('3','home décor'),('4','kitchen and dining'),('5','electronics');
/*!40000 ALTER TABLE `productcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store` (
  `Store_ID` char(10) NOT NULL,
  `StoreName` varchar(50) NOT NULL,
  `Address_ID` char(10) NOT NULL,
  PRIMARY KEY (`Store_ID`),
  KEY `IX_Relationship24` (`Address_ID`),
  CONSTRAINT `Relationship24` FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES ('S1','Target1','A3'),('S2','Target2','A2');
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_has_customer`
--

DROP TABLE IF EXISTS `store_has_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_has_customer` (
  `Store_ID` char(10) NOT NULL,
  `Customer_ID` char(10) NOT NULL,
  PRIMARY KEY (`Store_ID`,`Customer_ID`),
  KEY `Relationship55` (`Customer_ID`),
  CONSTRAINT `Relationship54` FOREIGN KEY (`Store_ID`) REFERENCES `store` (`Store_ID`),
  CONSTRAINT `Relationship55` FOREIGN KEY (`Customer_ID`) REFERENCES `customer` (`Customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_has_customer`
--

LOCK TABLES `store_has_customer` WRITE;
/*!40000 ALTER TABLE `store_has_customer` DISABLE KEYS */;
INSERT INTO `store_has_customer` VALUES ('S1','C1'),('S2','C1'),('S1','C2');
/*!40000 ALTER TABLE `store_has_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_has_supplier`
--

DROP TABLE IF EXISTS `store_has_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_has_supplier` (
  `Store_ID` char(10) NOT NULL,
  `Supplier_ID` char(10) NOT NULL,
  PRIMARY KEY (`Store_ID`,`Supplier_ID`),
  KEY `Relationship52` (`Supplier_ID`),
  CONSTRAINT `Relationship51` FOREIGN KEY (`Store_ID`) REFERENCES `store` (`Store_ID`),
  CONSTRAINT `Relationship52` FOREIGN KEY (`Supplier_ID`) REFERENCES `supplier` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_has_supplier`
--

LOCK TABLES `store_has_supplier` WRITE;
/*!40000 ALTER TABLE `store_has_supplier` DISABLE KEYS */;
INSERT INTO `store_has_supplier` VALUES ('S1','1'),('S2','1');
/*!40000 ALTER TABLE `store_has_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_order`
--

DROP TABLE IF EXISTS `store_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_order` (
  `StoreOrder_ID` char(10) NOT NULL,
  `TotalAmount` double(38,2) DEFAULT NULL,
  `Status` char(20) DEFAULT NULL,
  `Store_ID` char(10) DEFAULT NULL,
  `StorePayment_ID` char(10) DEFAULT NULL,
  PRIMARY KEY (`StoreOrder_ID`),
  KEY `IX_Relationship9` (`Store_ID`),
  KEY `IX_Relationship38` (`StorePayment_ID`),
  CONSTRAINT `FK_StoreOrder_ID_Store_ID` FOREIGN KEY (`Store_ID`) REFERENCES `store` (`Store_ID`),
  CONSTRAINT `FK_StorePayment_ID_StoreOrder_ID` FOREIGN KEY (`StorePayment_ID`) REFERENCES `store_payment_details` (`StorePayment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_order`
--

LOCK TABLES `store_order` WRITE;
/*!40000 ALTER TABLE `store_order` DISABLE KEYS */;
INSERT INTO `store_order` VALUES ('SO1',850.00,NULL,'S2','SP2'),('SO2',800.00,NULL,'S1','SP1'),('SO3',600.00,NULL,'S1','SP4'),('SO4',NULL,NULL,'S2','SP3'),('SO6',NULL,'','S1','SP5');
/*!40000 ALTER TABLE `store_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_order_details`
--

DROP TABLE IF EXISTS `store_order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_order_details` (
  `Order_ID` char(10) NOT NULL,
  `Amount` double(38,2) DEFAULT NULL,
  `Date` date NOT NULL,
  `Quantity` int(11) NOT NULL,
  `StoreOrder_ID` char(10) NOT NULL,
  `Product_ID` char(10) NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `IX_Relationship7` (`StoreOrder_ID`),
  KEY `IX_Relationship8` (`Product_ID`),
  CONSTRAINT `FK_Product_ID_Order_ID` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`),
  CONSTRAINT `FK_StoreOrder_ID_Order_ID` FOREIGN KEY (`StoreOrder_ID`) REFERENCES `store_order` (`StoreOrder_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_order_details`
--

LOCK TABLES `store_order_details` WRITE;
/*!40000 ALTER TABLE `store_order_details` DISABLE KEYS */;
INSERT INTO `store_order_details` VALUES ('O1',450.00,'2017-04-18',150,'SO1','P1'),('O2',400.00,'2017-04-18',200,'SO1','P2'),('O3',400.00,'2017-04-20',200,'SO2','P3'),('O4',400.00,'2017-04-20',100,'SO2','P4'),('O5',400.00,'2017-04-20',100,'SO2','P4');
/*!40000 ALTER TABLE `store_order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_payment_details`
--

DROP TABLE IF EXISTS `store_payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store_payment_details` (
  `StorePayment_ID` char(10) NOT NULL,
  `NetAmount` double(38,2) DEFAULT NULL,
  `StoreModeID` char(10) DEFAULT NULL,
  `Store_ID` char(10) DEFAULT NULL,
  PRIMARY KEY (`StorePayment_ID`),
  KEY `IX_Relationship36` (`StoreModeID`),
  KEY `IX_Relationship39` (`Store_ID`),
  CONSTRAINT `FK_StoreModeID_StorePayment_ID` FOREIGN KEY (`StoreModeID`) REFERENCES `storepaymentmode` (`StoreModeID`),
  CONSTRAINT `FK_StorePayment_ID_Store_ID` FOREIGN KEY (`Store_ID`) REFERENCES `store` (`Store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_payment_details`
--

LOCK TABLES `store_payment_details` WRITE;
/*!40000 ALTER TABLE `store_payment_details` DISABLE KEYS */;
INSERT INTO `store_payment_details` VALUES ('SP1',920.00,'SM1','S1'),('SP2',1003.00,'SM3','S2'),('SP3',NULL,'SM4','S2'),('SP4',660.00,'SM2','S1'),('SP5',NULL,'SM2','S1');
/*!40000 ALTER TABLE `store_payment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storepaymentmode`
--

DROP TABLE IF EXISTS `storepaymentmode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storepaymentmode` (
  `StoreModeID` char(10) NOT NULL,
  `Mode` char(20) NOT NULL,
  `Discount` int(10) NOT NULL,
  PRIMARY KEY (`StoreModeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storepaymentmode`
--

LOCK TABLES `storepaymentmode` WRITE;
/*!40000 ALTER TABLE `storepaymentmode` DISABLE KEYS */;
INSERT INTO `storepaymentmode` VALUES ('SM1','CreditCard',15),('SM2','DebitCard',10),('SM3','Check',18),('SM4','Cash',20);
/*!40000 ALTER TABLE `storepaymentmode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `Supplier_ID` char(10) NOT NULL,
  `SupplierName` varchar(50) NOT NULL,
  `Address_ID` char(10) NOT NULL,
  PRIMARY KEY (`Supplier_ID`),
  KEY `IX_Relationship23` (`Address_ID`),
  CONSTRAINT `FK_Store_ID_Address_ID` FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES ('1','Supplier 1 ','A1');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `expiredproductdetails`
--

/*!50001 DROP VIEW IF EXISTS `expiredproductdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `expiredproductdetails` AS select `p`.`Product_ID` AS `Product_ID`,`p`.`ProductName` AS `ProductName`,`p`.`Expiry_Date` AS `Expiry_Date`,(`supl_orders`.`Ordered_quantity` - `cust_orders`.`quantity_sold`) AS `remaining_quantity` from ((`retailstore`.`product` `p` join (select `retailstore`.`customer_order_details`.`Product_ID` AS `Product_ID`,sum(`retailstore`.`customer_order_details`.`Quantity`) AS `quantity_sold` from `retailstore`.`customer_order_details` group by `retailstore`.`customer_order_details`.`Product_ID`) `cust_orders`) join (select `s`.`Product_ID` AS `Product_ID`,sum(`s`.`Quantity`) AS `Ordered_quantity` from `retailstore`.`store_order_details` `s` group by `s`.`Product_ID`) `supl_orders`) where ((`p`.`Product_ID` = `cust_orders`.`Product_ID`) and (`cust_orders`.`Product_ID` = `supl_orders`.`Product_ID`) and (`p`.`Expiry_Date` < now())) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `product_qunatity_inventory`
--

/*!50001 DROP VIEW IF EXISTS `product_qunatity_inventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `product_qunatity_inventory` AS select `p`.`Product_ID` AS `Product_ID`,`p`.`ProductName` AS `ProductName`,`cust_orders`.`quantity_sold` AS `quantity_sold`,`supl_orders`.`Ordered_quantity` AS `Ordered_quantity`,(`supl_orders`.`Ordered_quantity` - `cust_orders`.`quantity_sold`) AS `remaining_quantity` from ((`retailstore`.`product` `p` join (select `retailstore`.`customer_order_details`.`Product_ID` AS `Product_ID`,sum(`retailstore`.`customer_order_details`.`Quantity`) AS `quantity_sold` from `retailstore`.`customer_order_details` group by `retailstore`.`customer_order_details`.`Product_ID`) `cust_orders`) join (select `s`.`Product_ID` AS `Product_ID`,sum(`s`.`Quantity`) AS `Ordered_quantity` from `retailstore`.`store_order_details` `s` group by `s`.`Product_ID`) `supl_orders`) where ((`p`.`Product_ID` = `cust_orders`.`Product_ID`) and (`cust_orders`.`Product_ID` = `supl_orders`.`Product_ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-21  8:56:52
