-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: newsplus-pro
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

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
-- Table structure for table `accesslog`
--

DROP TABLE IF EXISTS `accesslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesslog` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique accesslog ID.',
  `sid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Browser session ID of user that visited page.',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title of page visited.',
  `path` varchar(255) DEFAULT NULL COMMENT 'Internal path to page visited (relative to Drupal root.)',
  `url` text COMMENT 'Referrer URI.',
  `hostname` varchar(128) DEFAULT NULL COMMENT 'Hostname of user that visited the page.',
  `uid` int(10) unsigned DEFAULT '0' COMMENT 'User users.uid that visited the page.',
  `timer` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Time in milliseconds that the page took to load.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the page was visited.',
  PRIMARY KEY (`aid`),
  KEY `accesslog_timestamp` (`timestamp`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores site access information for statistics.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accesslog`
--

LOCK TABLES `accesslog` WRITE;
/*!40000 ALTER TABLE `accesslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `accesslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES ('comment_publish_action','comment','comment_publish_action','','Publish comment'),('comment_save_action','comment','comment_save_action','','Save comment'),('comment_unpublish_action','comment','comment_unpublish_action','','Unpublish comment'),('node_make_sticky_action','node','node_make_sticky_action','','Make content sticky'),('node_make_unsticky_action','node','node_make_unsticky_action','','Make content unsticky'),('node_promote_action','node','node_promote_action','','Promote content to front page'),('node_publish_action','node','node_publish_action','','Publish content'),('node_save_action','node','node_save_action','','Save content'),('node_unpromote_action','node','node_unpromote_action','','Remove content from front page'),('node_unpublish_action','node','node_unpublish_action','','Unpublish content'),('system_block_ip_action','user','system_block_ip_action','','Ban IP address of current user'),('user_block_user_action','user','user_block_user_action','','Block current user');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
INSERT INTO `block` VALUES (1,'system','main','bartik',1,0,'content',0,0,'','',-1),(2,'search','form','bartik',1,-1,'sidebar_first',0,0,'contact*\r\nnode/16\r\nnode/11\r\n<front>\r\nproducts*','',-1),(3,'node','recent','seven',1,10,'dashboard_main',0,0,'','',-1),(4,'user','login','bartik',1,0,'sidebar_first',0,0,'contact*\r\nproducts*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(5,'system','navigation','bartik',1,0,'sidebar_first',0,0,'','',-1),(6,'system','powered-by','bartik',1,10,'footer',0,0,'','',-1),(7,'system','help','bartik',1,0,'help',0,0,'','',-1),(8,'system','main','seven',1,0,'content',0,0,'','',-1),(9,'system','help','seven',1,0,'help',0,0,'','',-1),(10,'user','login','seven',1,10,'content',0,0,'contact*\r\nproducts*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(11,'user','new','seven',1,0,'dashboard_sidebar',0,0,'','',-1),(12,'search','form','seven',1,-10,'dashboard_sidebar',0,0,'contact*\r\nnode/16\r\nnode/11\r\n<front>\r\nproducts*','',-1),(13,'comment','recent','bartik',0,0,'-1',0,0,'','',1),(14,'node','syndicate','bartik',0,0,'-1',0,0,'','',-1),(15,'node','recent','bartik',0,0,'-1',0,0,'','',1),(16,'shortcut','shortcuts','bartik',0,0,'-1',0,0,'','',-1),(17,'system','management','bartik',0,0,'-1',0,0,'','',-1),(18,'system','user-menu','bartik',0,0,'-1',0,0,'','',-1),(19,'system','main-menu','bartik',0,0,'-1',0,0,'','',-1),(20,'user','new','bartik',0,0,'-1',0,0,'','',1),(21,'user','online','bartik',0,0,'-1',0,0,'','',-1),(22,'comment','recent','seven',1,0,'dashboard_inactive',0,0,'','',1),(23,'node','syndicate','seven',0,0,'-1',0,0,'','',-1),(24,'shortcut','shortcuts','seven',0,0,'-1',0,0,'','',-1),(25,'system','powered-by','seven',0,10,'-1',0,0,'','',-1),(26,'system','navigation','seven',0,0,'-1',0,0,'','',-1),(27,'system','management','seven',0,0,'-1',0,0,'','',-1),(28,'system','user-menu','seven',0,0,'-1',0,0,'','',-1),(29,'system','main-menu','seven',0,0,'-1',0,0,'','',-1),(30,'user','online','seven',1,0,'dashboard_inactive',0,0,'','',-1),(31,'blog','recent','bartik',0,0,'-1',0,0,'','',1),(32,'blog','recent','seven',1,0,'dashboard_inactive',0,0,'','',1),(33,'superfish','1','bartik',0,0,'-1',0,0,'','<none>',-1),(34,'superfish','2','bartik',0,0,'-1',0,0,'','<none>',-1),(35,'superfish','3','bartik',0,0,'-1',0,0,'','',-1),(36,'superfish','4','bartik',0,0,'-1',0,0,'','',-1),(37,'superfish','1','seven',0,0,'-1',0,0,'','<none>',-1),(38,'superfish','2','seven',0,0,'-1',0,0,'','<none>',-1),(39,'superfish','3','seven',0,0,'-1',0,0,'','',-1),(40,'superfish','4','seven',0,0,'-1',0,0,'','',-1),(41,'blog','recent','newsplus',0,0,'-1',0,0,'','',1),(42,'comment','recent','newsplus',0,0,'-1',0,0,'','',1),(43,'node','recent','newsplus',0,0,'-1',0,0,'','',1),(44,'node','syndicate','newsplus',0,0,'-1',0,0,'','',-1),(45,'search','form','newsplus',1,-16,'sidebar_second',0,0,'contact*\r\nnode/16\r\nnode/11\r\n<front>\r\nproducts*','',-1),(46,'shortcut','shortcuts','newsplus',0,0,'-1',0,0,'','',-1),(47,'superfish','1','newsplus',1,-21,'navigation',0,0,'','<none>',-1),(48,'superfish','2','newsplus',1,0,'pre_header_left',0,0,'','<none>',-1),(49,'superfish','3','newsplus',0,0,'-1',0,0,'','',-1),(50,'superfish','4','newsplus',0,0,'-1',0,0,'','',-1),(51,'system','help','newsplus',1,0,'help',0,0,'','',-1),(52,'system','main','newsplus',1,0,'content',0,0,'','',-1),(53,'system','main-menu','newsplus',0,0,'-1',0,0,'','',-1),(54,'system','management','newsplus',0,0,'-1',0,0,'','',-1),(55,'system','navigation','newsplus',0,-10,'-1',0,0,'','',-1),(56,'system','powered-by','newsplus',0,10,'-1',0,0,'','',-1),(57,'system','user-menu','newsplus',0,0,'-1',0,0,'','',-1),(58,'user','login','newsplus',1,-20,'sidebar_second',0,0,'contact*\r\nproducts*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(59,'user','new','newsplus',0,0,'-1',0,0,'','',1),(60,'user','online','newsplus',0,0,'-1',0,0,'','',-1),(61,'views','comments_recent-block','bartik',0,0,'-1',0,0,'','',-1),(62,'views','archive-block','bartik',0,0,'-1',0,0,'','',-1),(63,'views','comments_recent-block','newsplus',0,0,'-1',0,0,'','',-1),(64,'views','archive-block','newsplus',0,0,'-1',0,0,'','',-1),(65,'views','comments_recent-block','seven',0,0,'-1',0,0,'','',-1),(66,'views','archive-block','seven',0,0,'-1',0,0,'','',-1),(67,'views','mt_hot_posts-block','newsplus',1,-15,'highlighted',0,1,'<front>','',-1),(68,'views','mt_hot_posts-block','bartik',0,0,'-1',0,1,'<front>','',-1),(69,'views','mt_hot_posts-block','seven',0,0,'-1',0,1,'<front>','',-1),(70,'views','mt_latest-block','bartik',0,0,'-1',0,0,'','',-1),(71,'views','mt_latest-block','newsplus',0,0,'-1',0,0,'','',-1),(72,'views','mt_latest-block','seven',0,0,'-1',0,0,'','',-1),(73,'quicktabs','sidebar_tabs','seven',0,0,'-1',0,0,'contact*\r\nproducts*\r\nnode/16\r\nnode/11','<none>',-1),(74,'quicktabs','sidebar_tabs','newsplus',1,-22,'sidebar_second',0,0,'contact*\r\nproducts*\r\nnode/16\r\nnode/11','<none>',-1),(75,'quicktabs','sidebar_tabs','bartik',0,0,'-1',0,0,'contact*\r\nproducts*\r\nnode/16\r\nnode/11','<none>',-1),(76,'views','mt_most_popular-block','bartik',0,0,'-1',0,0,'contact*\r\nnode/16\r\nnode/11\r\nproducts*','',-1),(77,'views','mt_most_popular-block','newsplus',1,-21,'sidebar_second',0,0,'contact*\r\nnode/16\r\nnode/11\r\nproducts*','',-1),(78,'views','mt_most_popular-block','seven',0,0,'-1',0,0,'contact*\r\nnode/16\r\nnode/11\r\nproducts*','',-1),(79,'views','mt_user_latest_posts-block','bartik',0,0,'-1',0,0,'','',-1),(80,'views','mt_user_latest_posts-block','newsplus',1,0,'content',0,0,'','',-1),(81,'views','mt_user_latest_posts-block','seven',0,0,'-1',0,0,'','',-1),(82,'views','mt_tags_cloud-block','newsplus',1,-17,'footer_third',0,0,'','',-1),(83,'block','1','bartik',0,0,'-1',0,0,'','About',-1),(84,'block','1','newsplus',1,-18,'footer_first',0,0,'','About',-1),(85,'block','1','seven',0,0,'-1',0,0,'','About',-1),(89,'views','mt_tags_cloud-block','bartik',0,0,'-1',0,0,'','',-1),(90,'views','mt_tags_cloud-block','seven',0,0,'-1',0,0,'','',-1),(94,'block','4','bartik',0,0,'-1',0,0,'','',-1),(95,'block','4','newsplus',1,0,'sub_footer_left',0,0,'','',-1),(96,'block','4','seven',0,0,'-1',0,0,'','',-1),(97,'views','slideshow-block','bartik',0,0,'-1',0,1,'<front>','<none>',-1),(98,'views','slideshow-block','newsplus',1,-19,'banner',0,1,'<front>','<none>',-1),(99,'views','slideshow-block','seven',0,0,'-1',0,1,'<front>','<none>',-1),(100,'statistics','popular','bartik',0,0,'-1',0,0,'','',-1),(101,'statistics','popular','newsplus',0,0,'-1',0,0,'','',-1),(102,'statistics','popular','seven',0,0,'-1',0,0,'','',-1),(103,'block','5','bartik',0,0,'-1',0,0,'','Stay tuned with us',-1),(104,'block','5','newsplus',1,-16,'footer_third',0,0,'','Stay tuned with us',-1),(105,'block','5','seven',0,0,'-1',0,0,'','Stay tuned with us',-1),(106,'menu','menu-subfooter-menu','newsplus',1,0,'footer',0,0,'','<none>',-1),(107,'menu','menu-subfooter-menu','bartik',0,0,'-1',0,0,'','<none>',-1),(108,'menu','menu-subfooter-menu','seven',0,0,'-1',0,0,'','<none>',-1),(109,'block','6','bartik',0,0,'-1',0,1,'contact*','<none>',-1),(110,'block','6','newsplus',1,-18,'sidebar_second',0,1,'contact*','<none>',-1),(111,'block','6','seven',0,0,'-1',0,1,'contact*','<none>',-1),(112,'block','7','bartik',0,0,'-1',0,1,'contact*','<none>',-1),(113,'block','7','newsplus',1,-17,'sidebar_second',0,1,'contact*','<none>',-1),(114,'block','7','seven',0,0,'-1',0,1,'contact*','<none>',-1),(115,'menu','menu-sidebar-menu','bartik',0,0,'-1',0,0,'<front>\r\ncontact*\r\nnode/16\r\nnode/11\r\nproducts*','',-1),(116,'menu','menu-sidebar-menu','newsplus',1,-19,'sidebar_second',0,0,'<front>\r\ncontact*\r\nnode/16\r\nnode/11\r\nproducts*','',-1),(117,'menu','menu-sidebar-menu','seven',0,0,'-1',0,0,'<front>\r\ncontact*\r\nnode/16\r\nnode/11\r\nproducts*','',-1),(118,'views','mt_news_in_images-block','bartik',0,0,'-1',0,1,'<front>','',-1),(119,'views','mt_news_in_images-block','newsplus',1,-19,'promoted',0,1,'<front>','',-1),(120,'views','mt_news_in_images-block','seven',0,0,'-1',0,1,'<front>','',-1),(121,'block','8','bartik',0,0,'-1',0,0,'','',-1),(122,'block','8','newsplus',1,0,'header',0,0,'','',-1),(123,'block','8','seven',0,0,'-1',0,0,'','',-1),(124,'block','9','bartik',0,0,'-1',0,1,'node/12','Text Block',-1),(125,'block','9','newsplus',1,-20,'sidebar_first',0,1,'node/12','Text Block',-1),(126,'block','9','seven',0,0,'-1',0,1,'node/12','Text Block',-1),(127,'views','mt_breaking-block','newsplus',1,-20,'top_content',0,1,'<front>','',-1),(128,'views','mt_breaking-block','bartik',0,0,'-1',0,1,'<front>','',-1),(129,'views','mt_breaking-block','seven',0,0,'-1',0,1,'<front>','',-1),(130,'views','mt_latest-block_1','newsplus',1,-20,'promoted',0,1,'<front>','',-1),(131,'views','mt_latest-block_1','bartik',0,0,'-1',0,1,'<front>','',-1),(132,'views','mt_latest-block_1','seven',0,0,'-1',0,1,'<front>','',-1),(133,'block','10','bartik',0,0,'-1',0,0,'','',-1),(134,'block','10','newsplus',1,-20,'header_top_right',0,0,'','',-1),(135,'block','10','seven',0,0,'-1',0,0,'','',-1),(136,'views','mt_most_popular-block_1','seven',0,0,'-1',0,0,'','',-1),(137,'views','mt_most_popular-block_1','bartik',0,0,'-1',0,0,'','',-1),(138,'views','mt_most_popular-block_1','newsplus',0,0,'-1',0,0,'','',-1),(139,'block','11','bartik',0,0,'-1',0,1,'contact*','<none>',-1),(140,'block','11','newsplus',1,0,'banner',0,1,'contact*','<none>',-1),(141,'block','11','seven',0,0,'-1',0,1,'contact*','<none>',-1),(142,'menu','menu-secondary-menu','newsplus',0,0,'-1',0,0,'','',-1),(143,'menu','menu-secondary-menu','bartik',0,0,'-1',0,0,'','',-1),(144,'menu','menu-secondary-menu','seven',0,0,'-1',0,0,'','',-1),(145,'views','mt_internal_banner-block','bartik',0,0,'-1',0,0,'','<none>',-1),(146,'views','mt_internal_banner-block','newsplus',1,-23,'page_intro',0,0,'','<none>',-1),(147,'views','mt_internal_banner-block','seven',0,0,'-1',0,0,'','<none>',-1),(148,'views','mt_node_navigation-block','newsplus',0,-25,'',0,0,'','<none>',-1),(149,'views','mt_node_navigation-block','bartik',0,0,'',0,0,'','<none>',-1),(150,'views','mt_node_navigation-block','seven',0,0,'',0,0,'','<none>',-1),(151,'commerce_cart','cart','bartik',0,0,'-1',0,0,'contact*\r\nproducts*\r\ncheckout*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(152,'commerce_cart','cart','newsplus',1,-24,'sidebar_second',0,0,'contact*\r\nproducts*\r\ncheckout*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(153,'commerce_cart','cart','seven',0,0,'-1',0,0,'contact*\r\nproducts*\r\ncheckout*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(154,'views','mt_products-block_1','newsplus',1,-23,'sidebar_second',0,0,'contact*\r\nproducts*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(155,'views','mt_products-block_1','bartik',0,0,'-1',0,0,'contact*\r\nproducts*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(156,'views','mt_products-block_1','seven',0,0,'-1',0,0,'contact*\r\nproducts*\r\n<front>\r\nnode/16\r\nnode/11','',-1),(157,'views','tweets-block','bartik',0,0,'-1',0,0,'','',-1),(158,'views','tweets-block','newsplus',0,0,'-1',0,0,'','',-1),(159,'views','tweets-block','seven',0,0,'-1',0,0,'','',-1),(160,'views','mt_tweets-block','newsplus',1,0,'footer_second',0,0,'','',-1),(161,'views','mt_tweets-block','bartik',0,0,'-1',0,0,'','',-1),(162,'views','mt_tweets-block','seven',0,0,'-1',0,0,'','',-1),(163,'flippy','flippy_pager','bartik',0,0,'-1',0,0,'','',-1),(164,'flippy','flippy_pager','newsplus',0,0,'-1',0,0,'','',-1),(165,'flippy','flippy_pager','seven',0,0,'-1',0,0,'','',-1),(166,'flippy','flippy_pager-node_type-mt_post','newsplus',1,-24,'page_intro',0,0,'','',-1),(167,'flippy','flippy_pager-node_type-mt_post','bartik',0,0,'-1',0,0,'','',-1),(168,'flippy','flippy_pager-node_type-mt_post','seven',0,0,'-1',0,0,'','',-1);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_custom`
--

LOCK TABLES `block_custom` WRITE;
/*!40000 ALTER TABLE `block_custom` DISABLE KEYS */;
INSERT INTO `block_custom` VALUES (1,'<p>Dramatically expedite functional quality vectors and impactful technologies. Authoritatively productivate <a href=\"#\">next-generation resources</a> via cutting-edge methods of empowerment. Seamlessly predominate wireless markets rather than cutting-edge total linkage.</p>\r\n<p>Phos-fluorescently incentivize <a href=\"#\">adaptive methods of empowerment</a> for bricks-and-clicks supply chains.</p>\r\n<div class=\"more-link\"><?php print l(t(\'More \'), \'contact-us\'); ?></div>\r\n<br>\r\n<div id=\"footer-logo\" class=\"logo\">\r\n<img src=\"<?php print base_path() . drupal_get_path(\'theme\', \'newsplus\') ;?>/images/footer-logo.png\" alt=\"\" />\r\n</div>\r\n<div id=\"footer-site-name\" class=\"site-name\">\r\nNEWS+\r\n</div>\r\n<div id=\"footer-site-slogan\" class=\"site-slogan\">\r\nA news theme for Drupal\r\n</div>','About','php_code'),(4,'<p class=\"copyright\">Copyright © 2014 News+. All rights reserved.</p>','Copyright','full_html'),(5,'<ul class=\"social-bookmarks\">\r\n<li>\r\n<a href=\"http://www.facebook.com/morethan.just.themes/\"><i class=\"fa fa-facebook\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://twitter.com/morethanthemes/\"><i class=\"fa fa-twitter\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"https://plus.google.com/118354321025436191714/posts\"><i class=\"fa fa-google-plus\"></i></a>\r\n</li>                        \r\n<li>\r\n<a href=\"http://www.linkedin.com/company/more-than-themes/\"><i class=\"fa fa-linkedin\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://www.youtube.com/morethanthemes/\"><i class=\"fa fa-youtube-play\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://instagram.com/\"><i class=\"fa fa-instagram\"></i></a>\r\n</li>\r\n<!-- \r\n<li>\r\n<a href=\"http://www.flickr.com/photos/morethanthemes/\"><i class=\"fa fa-flickr\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://vimeo.com/morethanthemes\"><i class=\"fa fa-vimeo-square\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://www.pinterest.com/morethanthemes/\"><i class=\"fa fa-pinterest\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-skype\"></i></a>\r\n</li> -->\r\n</ul>\r\n<div class=\"subscribe-form\">\r\n<form action=\"\">\r\n<div>\r\n<div class=\"form-item form-type-textfield\">\r\n<input type=\"text\" class=\"form-text\" name=\"subscribe\" value=\"Your email address\" onfocus=\"if (this.value == \'Your email address\') {this.value = \'\';}\" onblur=\"if (this.value == \'\') {this.value = \'Your email address\';}\" /></div>\r\n<div class=\"form-actions\">\r\n<input value=\"\" type=\"submit\" id=\"edit-submit\" name=\"subscribe\" class=\"form-submit\">\r\n</div>\r\n</div>\r\n</form>\r\n</div>','Stay tuned with us','php_code'),(6,'<h3 class=\"title\">Stay tuned with us</h3>\r\n<p>Don’t forget that you can connect with us through all major social media, by simply clicking on the corresponding logo below.</p>\r\n<ul class=\"social-bookmarks large\">\r\n<li>\r\n<a href=\"http://www.facebook.com/morethan.just.themes/\"><i class=\"fa fa-facebook\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://twitter.com/morethanthemes/\"><i class=\"fa fa-twitter\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"https://plus.google.com/118354321025436191714/posts\"><i class=\"fa fa-google-plus\"></i></a>\r\n</li>                        \r\n<li>\r\n<a href=\"http://www.linkedin.com/company/more-than-themes/\"><i class=\"fa fa-linkedin\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://www.youtube.com/morethanthemes/\"><i class=\"fa fa-youtube-play\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://www.pinterest.com/morethanthemes/\"><i class=\"fa fa-pinterest\"></i></a>\r\n</li>\r\n</ul>\r\n','Stay tuned with us - Contact page','full_html'),(7,'<h3 class=\"title\">Subscribe to our newsletter</h3>\r\n<div class=\"subscribe-form\">\r\n<form action=\"\">\r\n<div>\r\n<div class=\"form-item form-type-textfield\">\r\n<input type=\"text\" class=\"form-text\" name=\"subscribe\" value=\"Your email address\" onfocus=\"if (this.value == \'Your email address\') {this.value = \'\';}\" onblur=\"if (this.value == \'\') {this.value = \'Your email address\';}\" /></div>\r\n<div class=\"form-actions\">\r\n<input value=\"\" type=\"submit\" id=\"edit-submit\" name=\"subscribe\" class=\"form-submit\">\r\n</div>\r\n</div>\r\n</form>\r\n</div>','Subscribe to our newsletter','php_code'),(8,'<div class=\"navigation-social-bookmarks\">\r\n<ul class=\"social-bookmarks\">\r\n<li>\r\n<a href=\"http://www.facebook.com/morethan.just.themes/\"><i class=\"fa fa-facebook\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"http://twitter.com/morethanthemes/\"><i class=\"fa fa-twitter\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"https://plus.google.com/118354321025436191714/posts\"><i class=\"fa fa-google-plus\"></i></a>\r\n</li>                        \r\n</ul>\r\n<?php if (module_exists(\'search\')): ?>\r\n<div class=\"dropdown search-bar block-search\">\r\n<a data-toggle=\"dropdown\" href=\"#\" class=\"trigger\"></a>\r\n<ul class=\"dropdown-menu\" role=\"menu\" aria-labelledby=\"dLabel\">\r\n<li><?php $block = module_invoke(\'search\', \'block_view\', \'search\'); print render($block);?></li>\r\n</ul>\r\n</div>\r\n <?php endif; ?>\r\n</div>','Navigation Social Bookmarks & Search Box','php_code'),(9,'Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.\r\n\r\nLorem ipsum dolor sit amet, consectetur adipisicing elit. Sit, esse, quo <a href=\"#\">distinctio dolores magni</a> reprerit id est at fugiat veritatis fugit dignios sed ut facere moles illo impedit. Tempora, iure!','Text Block','filtered_html'),(10,'<div class=\"ad-banner\">\r\nAD BANNER\r\n</div>','Ad banner','full_html'),(11,'<!-- #map-canvas --> \r\n<div id=\"map-canvas\">\r\n</div>\r\n<!-- EOF:#map-canvas -->','Google maps','full_html');
/*!40000 ALTER TABLE `block_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_node_type`
--

LOCK TABLES `block_node_type` WRITE;
/*!40000 ALTER TABLE `block_node_type` DISABLE KEYS */;
INSERT INTO `block_node_type` VALUES ('flippy','flippy_pager-node_type-mt_post','mt_post'),('views','mt_node_navigation-block','mt_post'),('views','mt_products-block_1','mt_product');
/*!40000 ALTER TABLE `block_node_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,0,2,1,'Title of the comment','127.0.0.1',1401220326,1401220324,1,'01/','admin','','','und'),(2,0,1,1,'Title of the comment','127.0.0.1',1401220522,1401220520,1,'01/','admin','','','und'),(3,2,1,1,'Title of the comment','127.0.0.1',1401220538,1401220537,1,'01.00/','admin','','','und'),(4,0,1,1,'Title of the comment','127.0.0.1',1401220548,1401220547,1,'02/','admin','','','und');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_calculated_price`
--

DROP TABLE IF EXISTS `commerce_calculated_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_calculated_price` (
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module performing the calculation.',
  `module_key` mediumtext NOT NULL COMMENT 'A module specific key useful for indicating the context of a particular calculation, e.g. the IDs of Rules evaluated to produce the calculated price.',
  `entity_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The type of entity this price belongs to.',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The entity ID of the object this price belongs to.',
  `field_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The name of the field the calculated price relates to.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The languages.language of the entity.',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sequence number for this data item, used for multi-value fields',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `data` longtext COMMENT 'A serialized array of additional price data.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the price was calculated.',
  KEY `module` (`module`),
  KEY `entity_type` (`entity_type`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores pre-calculated dynamic prices.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_calculated_price`
--

LOCK TABLES `commerce_calculated_price` WRITE;
/*!40000 ALTER TABLE `commerce_calculated_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_calculated_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_checkout_pane`
--

DROP TABLE IF EXISTS `commerce_checkout_pane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_checkout_pane` (
  `pane_id` varchar(255) NOT NULL COMMENT 'The machine readable name of the order state.',
  `page` varchar(255) NOT NULL DEFAULT '1' COMMENT 'The ID of the checkout page on which this pane appears.',
  `fieldset` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value indicating whether or not the pane should appear in a fieldset.',
  `collapsible` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating whether or not the pane should appear collapsed.',
  `collapsed` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating whether or not the pane should appear collapsed.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The sorting weight of the status for lists of statuses.',
  `enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value indicating whether or not the pane is enabled.',
  `review` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value indicating whether or not the pane should appear on the checkout review.',
  PRIMARY KEY (`pane_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout pane configuration data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_checkout_pane`
--

LOCK TABLES `commerce_checkout_pane` WRITE;
/*!40000 ALTER TABLE `commerce_checkout_pane` DISABLE KEYS */;
INSERT INTO `commerce_checkout_pane` VALUES ('account','checkout',1,0,0,-19,1,1),('cart_contents','checkout',1,0,0,-20,1,1),('checkout_completion_message','complete',0,0,0,0,1,1),('checkout_review','review',0,0,0,0,1,1),('commerce_payment','review',1,0,0,10,1,0),('commerce_payment_redirect','payment',1,0,0,0,1,1),('commerce_shipping','shipping',1,0,0,2,1,0),('customer_profile_billing','checkout',1,0,0,-17,1,1),('customer_profile_shipping','checkout',1,0,0,-16,1,1),('stock_validation_checkout_pane','checkout',0,0,0,-18,1,1);
/*!40000 ALTER TABLE `commerce_checkout_pane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_customer_profile`
--

DROP TABLE IF EXISTS `commerce_customer_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customer_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a customer profile.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_customer_profile_revision.revision_id version identifier.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The commerce_customer_profile_type.type of this profile.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that this profile belongs to.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the profile is active or not.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the profile was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the profile was most recently saved.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `uid` (`uid`),
  KEY `customer_profile_type` (`type`),
  KEY `uid_by_type` (`uid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for customer profiles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_customer_profile`
--

LOCK TABLES `commerce_customer_profile` WRITE;
/*!40000 ALTER TABLE `commerce_customer_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_customer_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_customer_profile_revision`
--

DROP TABLE IF EXISTS `commerce_customer_profile_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customer_profile_revision` (
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_customer_profile.customer_id of the profile this revision belongs to.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this profile at this revision.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the profile is active or not.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`revision_id`),
  KEY `profile_id` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_customer_profile_revision`
--

LOCK TABLES `commerce_customer_profile_revision` WRITE;
/*!40000 ALTER TABLE `commerce_customer_profile_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_customer_profile_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_line_item`
--

DROP TABLE IF EXISTS `commerce_line_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_line_item` (
  `line_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a line item.',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT 'The unique ID of the order the line item belongs to.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module defined type of this line item.',
  `line_item_label` varchar(255) NOT NULL COMMENT 'The merchant defined label for a line item.',
  `quantity` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the line item was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the line item was most recently saved.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`line_item_id`),
  KEY `order_id` (`order_id`),
  KEY `line_item_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for line items.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_line_item`
--

LOCK TABLES `commerce_line_item` WRITE;
/*!40000 ALTER TABLE `commerce_line_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_line_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_order`
--

DROP TABLE IF EXISTS `commerce_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an order.',
  `order_number` varchar(255) DEFAULT NULL COMMENT 'The order number displayed to the customer.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_order_revision.revision_id version identifier.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The type of this order.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this order.',
  `mail` varchar(255) NOT NULL DEFAULT '' COMMENT 'The e-mail address associated with the order.',
  `status` varchar(255) NOT NULL COMMENT 'The status name of this order.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the order was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the order was most recently saved.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that created this order.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `order_number` (`order_number`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for orders.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_order`
--

LOCK TABLES `commerce_order` WRITE;
/*!40000 ALTER TABLE `commerce_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_order_revision`
--

DROP TABLE IF EXISTS `commerce_order_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_order_revision` (
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_order.order_id of the order this revision belongs to.',
  `order_number` varchar(255) DEFAULT NULL COMMENT 'The order number displayed to the customer for this revision.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns the order at this revision.',
  `mail` varchar(255) NOT NULL COMMENT 'The e-mail address associated with the order at this revision.',
  `status` varchar(255) NOT NULL COMMENT 'The status name of this revision.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `revision_hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that created this order.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`revision_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_order_revision`
--

LOCK TABLES `commerce_order_revision` WRITE;
/*!40000 ALTER TABLE `commerce_order_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_order_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_payment_transaction`
--

DROP TABLE IF EXISTS `commerce_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a transaction.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_payment_transaction_revision.revision_id version identifier.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this transaction.',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_order.order_id of the order this payment is for.',
  `payment_method` varchar(128) NOT NULL COMMENT 'The payment method method_id for this transaction.',
  `instance_id` varchar(255) NOT NULL COMMENT 'The payment method instance ID for this transaction.',
  `remote_id` varchar(255) NOT NULL COMMENT 'The remote identifier for this transaction.',
  `message` longtext NOT NULL COMMENT 'The human-readable message associated to this transaction.',
  `message_variables` longblob NOT NULL COMMENT 'The variables associated with the human-readable message.',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The amount of this transaction.',
  `currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `status` varchar(128) NOT NULL COMMENT 'The status of this transaction (pending, success, or failure).',
  `remote_status` varchar(128) NOT NULL COMMENT 'The status of the transaction at the payment provider.',
  `payload` longblob NOT NULL COMMENT 'The payment-gateway specific payload associated with this transaction.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this transaction was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this transaction was last changed.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `payment_method` (`payment_method`),
  KEY `uid` (`uid`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Transaction information for every attempted payment.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_payment_transaction`
--

LOCK TABLES `commerce_payment_transaction` WRITE;
/*!40000 ALTER TABLE `commerce_payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_payment_transaction_revision`
--

DROP TABLE IF EXISTS `commerce_payment_transaction_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_payment_transaction_revision` (
  `transaction_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary identifier for a transaction.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The current commerce_payment_transaction_revision.revision_id version identifier.',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this revision.',
  `remote_id` varchar(255) NOT NULL COMMENT 'The remote identifier for this transaction.',
  `message` longtext NOT NULL COMMENT 'The human-readable message associated to this transaction.',
  `message_variables` longblob NOT NULL COMMENT 'The variables associated with the human-readable message.',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The amount of this transaction.',
  `currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `status` varchar(128) NOT NULL COMMENT 'The status of this transaction (pending, success, or failure).',
  `remote_status` varchar(128) NOT NULL COMMENT 'The status of the transaction at the payment provider.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`revision_id`),
  KEY `transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_payment_transaction_revision`
--

LOCK TABLES `commerce_payment_transaction_revision` WRITE;
/*!40000 ALTER TABLE `commerce_payment_transaction_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_payment_transaction_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_paypal_ipn`
--

DROP TABLE IF EXISTS `commerce_paypal_ipn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_paypal_ipn` (
  `ipn_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Serial numeric ID of the IPN in the local database.',
  `txn_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The PayPal transaction ID.',
  `txn_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The PayPal transaction type.',
  `receiver_email` varchar(255) NOT NULL DEFAULT '' COMMENT 'The e-mail of the payment receiever.',
  `payer_email` varchar(255) NOT NULL DEFAULT '' COMMENT 'The e-mail of the payer.',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The order ID the payment belongs to.',
  `transaction_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The payment transaction ID the payment belongs to.',
  `mc_gross` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'The gross payment amount.',
  `mc_currency` varchar(255) NOT NULL DEFAULT '' COMMENT 'The currency code of the payment.',
  `mc_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'The amount of fees collected by PayPal for this payment.',
  `payment_status` varchar(255) NOT NULL DEFAULT '' COMMENT 'The status of the payment at PayPal.',
  `payment_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The type of the payment.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the IPN was received.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the IPN was last updated.',
  `test_ipn` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this was a test IPN sent by the Sandbox.',
  PRIMARY KEY (`ipn_id`),
  KEY `txn_id` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores processed IPNs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_paypal_ipn`
--

LOCK TABLES `commerce_paypal_ipn` WRITE;
/*!40000 ALTER TABLE `commerce_paypal_ipn` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_paypal_ipn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_product`
--

DROP TABLE IF EXISTS `commerce_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a product, used internally only.',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The current commerce_product_revision.revision_id version identifier.',
  `sku` varchar(255) NOT NULL COMMENT 'The unique, human-readable identifier for a product.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this product, always treated as non-markup plain text.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The commerce_product_type.type of this product.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The languages.language of this product.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this product.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether or not the product appears in lists and may be added to orders.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the product was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the product was most recently saved.',
  `data` longblob COMMENT 'A serialized array of additional data.',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `sku` (`sku`),
  UNIQUE KEY `revision_id` (`revision_id`),
  KEY `product_type` (`type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='The base table for products.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_product`
--

LOCK TABLES `commerce_product` WRITE;
/*!40000 ALTER TABLE `commerce_product` DISABLE KEYS */;
INSERT INTO `commerce_product` VALUES (1,1,'PRODUCT-001','First Product','product','und',1,1,1403541092,1403541092,NULL),(2,2,'PRODUCT-002','Second Product','product','und',1,1,1403541144,1403541144,NULL),(3,3,'PRODUCT-003','Third Product','product','und',1,1,1403541173,1403541173,NULL),(4,4,'PRODUCT-004','Fourth Product','product','und',1,1,1403541200,1403541200,NULL),(5,5,'PRODUCT-005','Fifth Product','product','und',1,1,1403541226,1403541226,NULL),(6,6,'PRODUCT-006','Sixth Product','product','und',1,1,1403541254,1403541254,NULL);
/*!40000 ALTER TABLE `commerce_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_product_revision`
--

DROP TABLE IF EXISTS `commerce_product_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_product_revision` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The commerce_product.product_id of the product this revision belongs to.',
  `revision_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this revision.',
  `sku` varchar(255) NOT NULL COMMENT 'The unique, human-readable identifier of a product for this revision.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this product for this revision',
  `revision_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns the product at this revision.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The status of this revision.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `revision_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this revision was created.',
  `data` longblob COMMENT 'A serialized array of additional data for this revision.',
  PRIMARY KEY (`revision_id`),
  KEY `product_id` (`product_id`),
  KEY `revision_uid` (`revision_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Saves information about each saved revision of a commerce...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_product_revision`
--

LOCK TABLES `commerce_product_revision` WRITE;
/*!40000 ALTER TABLE `commerce_product_revision` DISABLE KEYS */;
INSERT INTO `commerce_product_revision` VALUES (1,1,'PRODUCT-001','First Product',1,1,'',1403541092,NULL),(2,2,'PRODUCT-002','Second Product',1,1,'',1403541144,NULL),(3,3,'PRODUCT-003','Third Product',1,1,'',1403541173,NULL),(4,4,'PRODUCT-004','Fourth Product',1,1,'',1403541200,NULL),(5,5,'PRODUCT-005','Fifth Product',1,1,'',1403541226,NULL),(6,6,'PRODUCT-006','Sixth Product',1,1,'',1403541254,NULL);
/*!40000 ALTER TABLE `commerce_product_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_product_type`
--

DROP TABLE IF EXISTS `commerce_product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_product_type` (
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a commerce_product of this type.',
  `revision` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Determine whether to create a new revision when a product of this type is updated.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about commerce_product types created...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_product_type`
--

LOCK TABLES `commerce_product_type` WRITE;
/*!40000 ALTER TABLE `commerce_product_type` DISABLE KEYS */;
INSERT INTO `commerce_product_type` VALUES ('product','Product','A basic product type.','',1);
/*!40000 ALTER TABLE `commerce_product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_tax_rate`
--

DROP TABLE IF EXISTS `commerce_tax_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_tax_rate` (
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The machine-name of this rate.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The administrative title of this rate.',
  `display_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The front end display title of this rate.',
  `description` mediumtext COMMENT 'A brief description of this rate.',
  `rate` varchar(64) NOT NULL DEFAULT '0' COMMENT 'The percentage used to calculate this tax expressed as a decimal.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The machine-name of the rate’s commerce_tax_type.',
  `default_rules_component` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this rate should have a default Rules component for applying it to products.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that defines this tax type.',
  PRIMARY KEY (`name`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about tax rates created via Tax UI.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_tax_rate`
--

LOCK TABLES `commerce_tax_rate` WRITE;
/*!40000 ALTER TABLE `commerce_tax_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `commerce_tax_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commerce_tax_type`
--

DROP TABLE IF EXISTS `commerce_tax_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_tax_type` (
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The machine-name of this type.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The administrative title of this type.',
  `display_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The front end display title of this type.',
  `description` mediumtext COMMENT 'A brief description of this type.',
  `display_inclusive` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not taxes of this type display inclusively in product prices.',
  `round_mode` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Integer indicating what type of rounding (if any) should be done for taxes of this type.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that defines this tax type.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about tax types created via Tax UI.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commerce_tax_type`
--

LOCK TABLES `commerce_tax_type` WRITE;
/*!40000 ALTER TABLE `commerce_tax_type` DISABLE KEYS */;
INSERT INTO `commerce_tax_type` VALUES ('sales_tax','Sales tax','Sales tax','A basic type for taxes that do not display inclusive with product prices.',0,0,'commerce_tax_ui'),('vat','VAT','VAT','A basic type for taxes that display inclusive with product prices.',1,1,'commerce_tax_ui');
/*!40000 ALTER TABLE `commerce_tax_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config`
--

LOCK TABLES `field_config` WRITE;
/*!40000 ALTER TABLE `field_config` DISABLE KEYS */;
INSERT INTO `field_config` VALUES (1,'comment_body','text_long','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:7:\"comment\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0),(2,'body','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:4:\"node\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0),(3,'field_tags','taxonomy_term_reference','taxonomy',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:8:\"settings\";a:1:{s:14:\"allowed_values\";a:1:{i:0;a:2:{s:10:\"vocabulary\";s:4:\"tags\";s:6:\"parent\";i:0;}}}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:21:\"field_data_field_tags\";a:1:{s:3:\"tid\";s:14:\"field_tags_tid\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:25:\"field_revision_field_tags\";a:1:{s:3:\"tid\";s:14:\"field_tags_tid\";}}}}}s:12:\"foreign keys\";a:1:{s:3:\"tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:7:\"indexes\";a:1:{s:3:\"tid\";a:1:{i:0;s:3:\"tid\";}}s:2:\"id\";s:1:\"3\";}',-1,0,0),(4,'field_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";i:0;}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:22:\"field_data_field_image\";a:5:{s:3:\"fid\";s:15:\"field_image_fid\";s:3:\"alt\";s:15:\"field_image_alt\";s:5:\"title\";s:17:\"field_image_title\";s:5:\"width\";s:17:\"field_image_width\";s:6:\"height\";s:18:\"field_image_height\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:26:\"field_revision_field_image\";a:5:{s:3:\"fid\";s:15:\"field_image_fid\";s:3:\"alt\";s:15:\"field_image_alt\";s:5:\"title\";s:17:\"field_image_title\";s:5:\"width\";s:17:\"field_image_width\";s:6:\"height\";s:18:\"field_image_height\";}}}}}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";s:1:\"0\";s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:2:\"id\";s:1:\"4\";}',-1,0,0),(5,'field_mt_post_categories','taxonomy_term_reference','taxonomy',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:1:{s:14:\"allowed_values\";a:1:{i:0;a:2:{s:10:\"vocabulary\";s:18:\"mt_post_categories\";s:6:\"parent\";s:1:\"0\";}}}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:35:\"field_data_field_mt_post_categories\";a:1:{s:3:\"tid\";s:28:\"field_mt_post_categories_tid\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:39:\"field_revision_field_mt_post_categories\";a:1:{s:3:\"tid\";s:28:\"field_mt_post_categories_tid\";}}}}}s:12:\"foreign keys\";a:1:{s:3:\"tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:7:\"indexes\";a:1:{s:3:\"tid\";a:1:{i:0;s:3:\"tid\";}}s:2:\"id\";s:1:\"5\";}',1,0,0),(6,'field_mt_subheader_body','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:0:{}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:34:\"field_data_field_mt_subheader_body\";a:3:{s:5:\"value\";s:29:\"field_mt_subheader_body_value\";s:7:\"summary\";s:31:\"field_mt_subheader_body_summary\";s:6:\"format\";s:30:\"field_mt_subheader_body_format\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:38:\"field_revision_field_mt_subheader_body\";a:3:{s:5:\"value\";s:29:\"field_mt_subheader_body_value\";s:7:\"summary\";s:31:\"field_mt_subheader_body_summary\";s:6:\"format\";s:30:\"field_mt_subheader_body_format\";}}}}}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:2:\"id\";s:1:\"6\";}',1,0,0),(7,'field_mt_about','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:0:{}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:25:\"field_data_field_mt_about\";a:3:{s:5:\"value\";s:20:\"field_mt_about_value\";s:7:\"summary\";s:22:\"field_mt_about_summary\";s:6:\"format\";s:21:\"field_mt_about_format\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:29:\"field_revision_field_mt_about\";a:3:{s:5:\"value\";s:20:\"field_mt_about_value\";s:7:\"summary\";s:22:\"field_mt_about_summary\";s:6:\"format\";s:21:\"field_mt_about_format\";}}}}}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:2:\"id\";s:1:\"7\";}',1,0,0),(13,'field_mt_breaking','list_boolean','list',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:2:{s:14:\"allowed_values\";a:2:{i:0;s:3:\"off\";i:1;s:2:\"on\";}s:23:\"allowed_values_function\";s:0:\"\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:28:\"field_data_field_mt_breaking\";a:1:{s:5:\"value\";s:23:\"field_mt_breaking_value\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:32:\"field_revision_field_mt_breaking\";a:1:{s:5:\"value\";s:23:\"field_mt_breaking_value\";}}}}}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:5:\"value\";a:1:{i:0;s:5:\"value\";}}s:2:\"id\";s:2:\"13\";}',1,0,0),(17,'field_mt_facebook','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:28:\"field_data_field_mt_facebook\";a:2:{s:5:\"value\";s:23:\"field_mt_facebook_value\";s:6:\"format\";s:24:\"field_mt_facebook_format\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:32:\"field_revision_field_mt_facebook\";a:2:{s:5:\"value\";s:23:\"field_mt_facebook_value\";s:6:\"format\";s:24:\"field_mt_facebook_format\";}}}}}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:2:\"id\";s:2:\"17\";}',1,0,0),(18,'field_mt_twitter','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:27:\"field_data_field_mt_twitter\";a:2:{s:5:\"value\";s:22:\"field_mt_twitter_value\";s:6:\"format\";s:23:\"field_mt_twitter_format\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:31:\"field_revision_field_mt_twitter\";a:2:{s:5:\"value\";s:22:\"field_mt_twitter_value\";s:6:\"format\";s:23:\"field_mt_twitter_format\";}}}}}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:2:\"id\";s:2:\"18\";}',1,0,0),(19,'field_mt_google_plus','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:31:\"field_data_field_mt_google_plus\";a:2:{s:5:\"value\";s:26:\"field_mt_google_plus_value\";s:6:\"format\";s:27:\"field_mt_google_plus_format\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:35:\"field_revision_field_mt_google_plus\";a:2:{s:5:\"value\";s:26:\"field_mt_google_plus_value\";s:6:\"format\";s:27:\"field_mt_google_plus_format\";}}}}}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:2:\"id\";s:2:\"19\";}',1,0,0),(20,'field_mt_teaser_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";i:0;}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:32:\"field_data_field_mt_teaser_image\";a:5:{s:3:\"fid\";s:25:\"field_mt_teaser_image_fid\";s:3:\"alt\";s:25:\"field_mt_teaser_image_alt\";s:5:\"title\";s:27:\"field_mt_teaser_image_title\";s:5:\"width\";s:27:\"field_mt_teaser_image_width\";s:6:\"height\";s:28:\"field_mt_teaser_image_height\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:36:\"field_revision_field_mt_teaser_image\";a:5:{s:3:\"fid\";s:25:\"field_mt_teaser_image_fid\";s:3:\"alt\";s:25:\"field_mt_teaser_image_alt\";s:5:\"title\";s:27:\"field_mt_teaser_image_title\";s:5:\"width\";s:27:\"field_mt_teaser_image_width\";s:6:\"height\";s:28:\"field_mt_teaser_image_height\";}}}}}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:2:\"id\";s:2:\"20\";}',1,0,0),(21,'field_mt_slideshow','list_boolean','list',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:2:{s:14:\"allowed_values\";a:2:{i:0;s:3:\"off\";i:1;s:2:\"on\";}s:23:\"allowed_values_function\";s:0:\"\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:29:\"field_data_field_mt_slideshow\";a:1:{s:5:\"value\";s:24:\"field_mt_slideshow_value\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:33:\"field_revision_field_mt_slideshow\";a:1:{s:5:\"value\";s:24:\"field_mt_slideshow_value\";}}}}}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:5:\"value\";a:1:{i:0;s:5:\"value\";}}s:2:\"id\";s:2:\"21\";}',1,0,0),(22,'field_mt_slideshow_path','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:34:\"field_data_field_mt_slideshow_path\";a:2:{s:5:\"value\";s:29:\"field_mt_slideshow_path_value\";s:6:\"format\";s:30:\"field_mt_slideshow_path_format\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:38:\"field_revision_field_mt_slideshow_path\";a:2:{s:5:\"value\";s:29:\"field_mt_slideshow_path_value\";s:6:\"format\";s:30:\"field_mt_slideshow_path_format\";}}}}}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:2:\"id\";s:2:\"22\";}',1,0,0),(23,'field_mt_banner_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";i:0;}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:32:\"field_data_field_mt_banner_image\";a:5:{s:3:\"fid\";s:25:\"field_mt_banner_image_fid\";s:3:\"alt\";s:25:\"field_mt_banner_image_alt\";s:5:\"title\";s:27:\"field_mt_banner_image_title\";s:5:\"width\";s:27:\"field_mt_banner_image_width\";s:6:\"height\";s:28:\"field_mt_banner_image_height\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:36:\"field_revision_field_mt_banner_image\";a:5:{s:3:\"fid\";s:25:\"field_mt_banner_image_fid\";s:3:\"alt\";s:25:\"field_mt_banner_image_alt\";s:5:\"title\";s:27:\"field_mt_banner_image_title\";s:5:\"width\";s:27:\"field_mt_banner_image_width\";s:6:\"height\";s:28:\"field_mt_banner_image_height\";}}}}}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:2:\"id\";s:2:\"23\";}',-1,0,0),(24,'commerce_customer_address','addressfield','addressfield',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:25:\"commerce_customer_profile\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:0:{}}',1,0,0),(25,'commerce_line_items','commerce_line_item_reference','commerce_line_item',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:14:\"commerce_order\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:12:\"line_item_id\";a:2:{s:5:\"table\";s:18:\"commerce_line_item\";s:7:\"columns\";a:1:{s:12:\"line_item_id\";s:12:\"line_item_id\";}}}s:7:\"indexes\";a:1:{s:12:\"line_item_id\";a:1:{i:0;s:12:\"line_item_id\";}}}',-1,0,0),(26,'commerce_order_total','commerce_price','commerce_price',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:14:\"commerce_order\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:14:\"currency_price\";a:2:{i:0;s:6:\"amount\";i:1;s:13:\"currency_code\";}}}',1,0,0),(27,'commerce_customer_billing','commerce_customer_profile_reference','commerce_customer',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:14:\"commerce_order\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:2:{s:12:\"profile_type\";s:7:\"billing\";s:18:\"options_list_limit\";i:50;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:10:\"profile_id\";a:2:{s:5:\"table\";s:25:\"commerce_customer_profile\";s:7:\"columns\";a:1:{s:10:\"profile_id\";s:10:\"profile_id\";}}}s:7:\"indexes\";a:1:{s:10:\"profile_id\";a:1:{i:0;s:10:\"profile_id\";}}}',1,0,0),(28,'commerce_unit_price','commerce_price','commerce_price',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:18:\"commerce_line_item\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:14:\"currency_price\";a:2:{i:0;s:6:\"amount\";i:1;s:13:\"currency_code\";}}}',1,0,0),(29,'commerce_total','commerce_price','commerce_price',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:18:\"commerce_line_item\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:14:\"currency_price\";a:2:{i:0;s:6:\"amount\";i:1;s:13:\"currency_code\";}}}',1,0,0),(30,'commerce_product','commerce_product_reference','commerce_product_reference',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:18:\"commerce_line_item\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:1:{s:18:\"options_list_limit\";N;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:10:\"product_id\";a:2:{s:5:\"table\";s:16:\"commerce_product\";s:7:\"columns\";a:1:{s:10:\"product_id\";s:10:\"product_id\";}}}s:7:\"indexes\";a:1:{s:10:\"product_id\";a:1:{i:0;s:10:\"product_id\";}}}',1,0,0),(31,'commerce_display_path','text','text',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:18:\"commerce_line_item\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:1:{s:10:\"max_length\";i:255;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0),(32,'commerce_price','commerce_price','commerce_price',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:16:\"commerce_product\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:14:\"currency_price\";a:2:{i:0;s:6:\"amount\";i:1;s:13:\"currency_code\";}}}',1,0,0),(33,'commerce_shipping_service','list_text','list',1,'field_sql_storage','field_sql_storage',1,1,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:18:\"commerce_line_item\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:2:{s:23:\"allowed_values_function\";s:38:\"commerce_shipping_service_options_list\";s:14:\"allowed_values\";a:0:{}}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:5:\"value\";a:1:{i:0;s:5:\"value\";}}}',1,0,0),(34,'commerce_customer_shipping','commerce_customer_profile_reference','commerce_customer',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:14:\"commerce_order\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:2:{s:12:\"profile_type\";s:8:\"shipping\";s:18:\"options_list_limit\";i:50;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:10:\"profile_id\";a:2:{s:5:\"table\";s:25:\"commerce_customer_profile\";s:7:\"columns\";a:1:{s:10:\"profile_id\";s:10:\"profile_id\";}}}s:7:\"indexes\";a:1:{s:10:\"profile_id\";a:1:{i:0;s:10:\"profile_id\";}}}',1,0,0),(35,'commerce_stock','number_integer','number',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:16:\"commerce_product\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:0:{}}',1,0,0),(36,'field_mt_product','commerce_product_reference','commerce_product_reference',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:1:{s:18:\"options_list_limit\";s:0:\"\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:27:\"field_data_field_mt_product\";a:1:{s:10:\"product_id\";s:27:\"field_mt_product_product_id\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:31:\"field_revision_field_mt_product\";a:1:{s:10:\"product_id\";s:27:\"field_mt_product_product_id\";}}}}}s:12:\"foreign keys\";a:1:{s:10:\"product_id\";a:2:{s:5:\"table\";s:16:\"commerce_product\";s:7:\"columns\";a:1:{s:10:\"product_id\";s:10:\"product_id\";}}}s:7:\"indexes\";a:1:{s:10:\"product_id\";a:1:{i:0;s:10:\"product_id\";}}s:2:\"id\";s:2:\"36\";}',1,0,0);
/*!40000 ALTER TABLE `field_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config_instance`
--

LOCK TABLES `field_config_instance` WRITE;
/*!40000 ALTER TABLE `field_config_instance` DISABLE KEYS */;
INSERT INTO `field_config_instance` VALUES (1,1,'comment_body','comment','comment_node_page','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(2,2,'body','node','page','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(3,1,'comment_body','comment','comment_node_article','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(4,2,'body','node','article','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";s:1:\"2\";s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(5,3,'field_tags','node','article','a:6:{s:5:\"label\";s:4:\"Tags\";s:11:\"description\";s:63:\"Enter a comma-separated list of words to describe your content.\";s:6:\"widget\";a:4:{s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"weight\";s:1:\"6\";s:8:\"settings\";a:2:{s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";}s:6:\"module\";s:8:\"taxonomy\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"3\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:2:\"10\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:8:\"required\";b:0;}',0),(6,4,'field_image','node','article','a:6:{s:5:\"label\";s:16:\"In-page image(s)\";s:11:\"description\";s:97:\"The image(s) you will use in this field will be used in the main content column of the node page.\";s:8:\"required\";i:0;s:8:\"settings\";a:9:{s:14:\"file_directory\";s:11:\"field/image\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"3\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:2:\"-1\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"module\";s:5:\"image\";}}}',0),(7,1,'comment_body','comment','comment_node_blog','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(8,2,'body','node','blog','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";s:1:\"2\";s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(9,1,'comment_body','comment','comment_node_webform','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(10,2,'body','node','webform','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(11,1,'comment_body','comment','comment_node_mt_post','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(12,2,'body','node','mt_post','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";s:1:\"2\";s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(13,4,'field_image','node','mt_post','a:6:{s:5:\"label\";s:16:\"In-page image(s)\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"3\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"module\";s:5:\"image\";}}s:8:\"required\";i:0;s:11:\"description\";s:97:\"The image(s) you will use in this field will be used in the main content column of the node page.\";}',0),(14,4,'field_image','node','blog','a:6:{s:5:\"label\";s:16:\"In-page image(s)\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"3\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"module\";s:5:\"image\";}}s:8:\"required\";i:0;s:11:\"description\";s:97:\"The image(s) you will use in this field will be used in the main content column of the node page.\";}',0),(15,3,'field_tags','node','blog','a:7:{s:5:\"label\";s:4:\"Tags\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"6\";s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"module\";s:8:\"taxonomy\";s:6:\"active\";i:0;s:8:\"settings\";a:2:{s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"3\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(16,5,'field_mt_post_categories','node','blog','a:7:{s:5:\"label\";s:15:\"Post Categories\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"5\";s:4:\"type\";s:14:\"options_select\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:0:{}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"4\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"3\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(17,5,'field_mt_post_categories','node','article','a:7:{s:5:\"label\";s:15:\"Post Categories\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"5\";s:4:\"type\";s:14:\"options_select\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:0:{}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"4\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(18,5,'field_mt_post_categories','node','mt_post','a:7:{s:5:\"label\";s:15:\"Post Categories\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"5\";s:4:\"type\";s:14:\"options_select\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:0:{}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"4\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(19,3,'field_tags','node','mt_post','a:7:{s:5:\"label\";s:4:\"Tags\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"6\";s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"module\";s:8:\"taxonomy\";s:6:\"active\";i:0;s:8:\"settings\";a:2:{s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"3\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(20,6,'field_mt_subheader_body','node','mt_post','a:7:{s:5:\"label\";s:14:\"Subheader body\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"1\";s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"4\";s:12:\"summary_rows\";i:5;}}s:8:\"settings\";a:3:{s:15:\"text_processing\";s:1:\"1\";s:15:\"display_summary\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(21,6,'field_mt_subheader_body','node','blog','a:7:{s:5:\"label\";s:14:\"Subheader body\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"1\";s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"4\";s:12:\"summary_rows\";i:5;}}s:8:\"settings\";a:3:{s:15:\"text_processing\";s:1:\"1\";s:15:\"display_summary\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(22,6,'field_mt_subheader_body','node','article','a:7:{s:5:\"label\";s:14:\"Subheader body\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"1\";s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"4\";s:12:\"summary_rows\";i:5;}}s:8:\"settings\";a:3:{s:15:\"text_processing\";s:1:\"1\";s:15:\"display_summary\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(23,7,'field_mt_about','user','user','a:7:{s:5:\"label\";s:5:\"About\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"7\";s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"4\";s:12:\"summary_rows\";i:5;}}s:8:\"settings\";a:3:{s:15:\"text_processing\";s:1:\"1\";s:15:\"display_summary\";i:0;s:18:\"user_register_form\";i:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(24,1,'comment_body','comment','comment_node_mt_slideshow_entry','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(37,13,'field_mt_breaking','node','article','a:7:{s:5:\"label\";s:8:\"Breaking\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"9\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:50:\"Check this box to add this to the \"Breaking\" news.\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(38,13,'field_mt_breaking','node','blog','a:7:{s:5:\"label\";s:8:\"Breaking\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"9\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:50:\"Check this box to add this to the \"Breaking\" news.\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(39,13,'field_mt_breaking','node','mt_post','a:7:{s:5:\"label\";s:8:\"Breaking\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"9\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:50:\"Check this box to add this to the \"Breaking\" news.\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(47,17,'field_mt_facebook','user','user','a:7:{s:5:\"label\";s:8:\"Facebook\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"8\";s:4:\"type\";s:14:\"text_textfield\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}}s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";i:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";i:0;s:11:\"description\";s:79:\"Enter the URL of your Facebook profile, e.g.: https://facebook.com/your-account\";s:13:\"default_value\";N;}',0),(48,18,'field_mt_twitter','user','user','a:7:{s:5:\"label\";s:7:\"Twitter\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"9\";s:4:\"type\";s:14:\"text_textfield\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}}s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";i:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";i:0;s:11:\"description\";s:77:\"Enter the URL of your Twitter profile, e.g.: https://twitter.com/your-account\";s:13:\"default_value\";N;}',0),(49,19,'field_mt_google_plus','user','user','a:7:{s:5:\"label\";s:7:\"Google+\";s:6:\"widget\";a:5:{s:6:\"weight\";s:2:\"10\";s:4:\"type\";s:14:\"text_textfield\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}}s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";i:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";i:0;s:11:\"description\";s:82:\"Enter the URL of your Google+ profile, e.g.: https://plus.google.com//your-account\";s:13:\"default_value\";N;}',0),(50,20,'field_mt_teaser_image','node','article','a:6:{s:5:\"label\";s:12:\"Teaser image\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"7\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";}',0),(51,21,'field_mt_slideshow','node','article','a:7:{s:5:\"label\";s:21:\"Promoted on slideshow\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"8\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"10\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(52,20,'field_mt_teaser_image','node','blog','a:6:{s:5:\"label\";s:12:\"Teaser image\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"7\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";}',0),(53,21,'field_mt_slideshow','node','blog','a:7:{s:5:\"label\";s:21:\"Promoted on slideshow\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"8\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"10\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(54,20,'field_mt_teaser_image','node','mt_post','a:6:{s:5:\"label\";s:12:\"Teaser image\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"7\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";}',0),(55,21,'field_mt_slideshow','node','mt_post','a:7:{s:5:\"label\";s:21:\"Promoted on slideshow\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"8\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(56,20,'field_mt_teaser_image','node','mt_slideshow_entry','a:6:{s:5:\"label\";s:21:\"Slideshow entry image\";s:6:\"widget\";a:5:{s:6:\"weight\";s:2:\"-3\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"module\";s:5:\"image\";}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";}',0),(57,22,'field_mt_slideshow_path','node','mt_slideshow_entry','a:7:{s:5:\"label\";s:20:\"Slideshow entry path\";s:6:\"widget\";a:5:{s:6:\"weight\";s:2:\"-2\";s:4:\"type\";s:14:\"text_textfield\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}}s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(58,21,'field_mt_slideshow','node','mt_slideshow_entry','a:7:{s:5:\"label\";s:21:\"Promoted on slideshow\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"0\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:1;}}}',0),(59,23,'field_mt_banner_image','node','mt_post','a:6:{s:5:\"label\";s:25:\"Internal banner image(s) \";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"4\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:121:\"The image(s) you will use in this field, will be used on the internal node page, in the slideshow right below the header.\";}',0),(60,23,'field_mt_banner_image','node','blog','a:6:{s:5:\"label\";s:25:\"Internal banner image(s) \";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"4\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:121:\"The image(s) you will use in this field, will be used on the internal node page, in the slideshow right below the header.\";}',0),(61,23,'field_mt_banner_image','node','article','a:6:{s:5:\"label\";s:25:\"Internal banner image(s) \";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"4\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:121:\"The image(s) you will use in this field, will be used on the internal node page, in the slideshow right below the header.\";}',0),(62,24,'commerce_customer_address','commerce_customer_profile','billing','a:6:{s:5:\"label\";s:7:\"Address\";s:8:\"required\";b:1;s:6:\"widget\";a:4:{s:4:\"type\";s:21:\"addressfield_standard\";s:6:\"weight\";i:-10;s:8:\"settings\";a:3:{s:15:\"format_handlers\";a:2:{i:0;s:7:\"address\";i:1;s:12:\"name-oneline\";}s:19:\"available_countries\";a:0:{}s:15:\"default_country\";s:0:\"\";}s:6:\"module\";s:12:\"addressfield\";}s:7:\"display\";a:3:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:20:\"addressfield_default\";s:6:\"weight\";i:-10;s:8:\"settings\";a:2:{s:19:\"use_widget_handlers\";i:1;s:15:\"format_handlers\";a:1:{i:0;s:7:\"address\";}}s:6:\"module\";s:12:\"addressfield\";}s:8:\"customer\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:20:\"addressfield_default\";s:6:\"weight\";i:-10;s:8:\"settings\";a:2:{s:19:\"use_widget_handlers\";i:1;s:15:\"format_handlers\";a:1:{i:0;s:7:\"address\";}}s:6:\"module\";s:12:\"addressfield\";}s:13:\"administrator\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:20:\"addressfield_default\";s:6:\"weight\";i:-10;s:8:\"settings\";a:2:{s:19:\"use_widget_handlers\";i:1;s:15:\"format_handlers\";a:1:{i:0;s:7:\"address\";}}s:6:\"module\";s:12:\"addressfield\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:11:\"description\";s:0:\"\";}',0),(63,25,'commerce_line_items','commerce_order','commerce_order','a:6:{s:5:\"label\";s:10:\"Line items\";s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"commerce_line_item_manager\";s:6:\"weight\";i:-10;s:8:\"settings\";a:0:{}s:6:\"module\";s:18:\"commerce_line_item\";}s:7:\"display\";a:3:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:33:\"commerce_line_item_reference_view\";s:6:\"weight\";i:-10;s:8:\"settings\";a:1:{s:4:\"view\";s:32:\"commerce_line_item_table|default\";}s:6:\"module\";s:18:\"commerce_line_item\";}s:8:\"customer\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:33:\"commerce_line_item_reference_view\";s:6:\"weight\";i:-10;s:8:\"settings\";a:1:{s:4:\"view\";s:32:\"commerce_line_item_table|default\";}s:6:\"module\";s:18:\"commerce_line_item\";}s:13:\"administrator\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:33:\"commerce_line_item_reference_view\";s:6:\"weight\";i:-10;s:8:\"settings\";a:1:{s:4:\"view\";s:32:\"commerce_line_item_table|default\";}s:6:\"module\";s:18:\"commerce_line_item\";}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(64,26,'commerce_order_total','commerce_order','commerce_order','a:6:{s:5:\"label\";s:11:\"Order total\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:19:\"commerce_price_full\";s:6:\"weight\";i:-8;s:8:\"settings\";a:1:{s:13:\"currency_code\";s:7:\"default\";}s:6:\"module\";s:14:\"commerce_price\";}s:7:\"display\";a:4:{s:13:\"administrator\";a:5:{s:4:\"type\";s:35:\"commerce_price_formatted_components\";s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:-8;s:6:\"module\";s:14:\"commerce_price\";}s:8:\"customer\";a:5:{s:4:\"type\";s:35:\"commerce_price_formatted_components\";s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:-8;s:6:\"module\";s:14:\"commerce_price\";}s:7:\"default\";a:5:{s:4:\"type\";s:35:\"commerce_price_formatted_components\";s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:-8;s:6:\"module\";s:14:\"commerce_price\";}s:11:\"node_teaser\";a:5:{s:4:\"type\";s:35:\"commerce_price_formatted_components\";s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:-8;s:6:\"module\";s:14:\"commerce_price\";}}s:11:\"description\";s:0:\"\";}',0),(65,27,'commerce_customer_billing','commerce_order','commerce_order','a:6:{s:5:\"label\";s:19:\"Billing information\";s:6:\"widget\";a:4:{s:4:\"type\";s:33:\"commerce_customer_profile_manager\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}s:7:\"display\";a:3:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:43:\"commerce_customer_profile_reference_display\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}s:8:\"customer\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:43:\"commerce_customer_profile_reference_display\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}s:13:\"administrator\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:43:\"commerce_customer_profile_reference_display\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(66,28,'commerce_unit_price','commerce_line_item','product','a:6:{s:5:\"label\";s:10:\"Unit price\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:19:\"commerce_price_full\";s:6:\"weight\";i:0;s:8:\"settings\";a:1:{s:13:\"currency_code\";s:7:\"default\";}s:6:\"module\";s:14:\"commerce_price\";}s:7:\"display\";a:3:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:11:\"node_teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}}s:11:\"description\";s:0:\"\";}',0),(67,29,'commerce_total','commerce_line_item','product','a:6:{s:5:\"label\";s:5:\"Total\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:19:\"commerce_price_full\";s:6:\"weight\";i:1;s:8:\"settings\";a:1:{s:13:\"currency_code\";s:7:\"default\";}s:6:\"module\";s:14:\"commerce_price\";}s:7:\"display\";a:3:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:1;s:6:\"module\";s:14:\"commerce_price\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:1;s:6:\"module\";s:14:\"commerce_price\";}s:11:\"node_teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:1;s:6:\"module\";s:14:\"commerce_price\";}}s:11:\"description\";s:0:\"\";}',0),(68,30,'commerce_product','commerce_line_item','product','a:6:{s:5:\"label\";s:7:\"Product\";s:8:\"required\";b:1;s:8:\"settings\";a:3:{s:19:\"referenceable_types\";a:0:{}s:15:\"field_injection\";b:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:39:\"commerce_product_reference_autocomplete\";s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:29:\"commerce_product/autocomplete\";}s:6:\"module\";s:26:\"commerce_product_reference\";}s:7:\"display\";a:2:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"weight\";i:0;s:4:\"type\";s:37:\"commerce_product_reference_title_link\";s:8:\"settings\";a:0:{}s:6:\"module\";s:26:\"commerce_product_reference\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:37:\"commerce_product_reference_title_link\";s:8:\"settings\";a:0:{}s:6:\"module\";s:26:\"commerce_product_reference\";s:6:\"weight\";i:2;}}s:11:\"description\";s:0:\"\";}',0),(69,31,'commerce_display_path','commerce_line_item','product','a:6:{s:5:\"label\";s:12:\"Display path\";s:8:\"required\";b:1;s:8:\"settings\";a:2:{s:15:\"text_processing\";i:0;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";i:0;s:8:\"settings\";a:1:{s:4:\"size\";i:60;}s:6:\"module\";s:4:\"text\";}s:7:\"display\";a:2:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"weight\";i:0;s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:3;}}s:11:\"description\";s:0:\"\";}',0),(70,32,'commerce_price','commerce_product','product','a:6:{s:5:\"label\";s:5:\"Price\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:19:\"commerce_price_full\";s:6:\"weight\";i:0;s:8:\"settings\";a:1:{s:13:\"currency_code\";s:7:\"default\";}s:6:\"module\";s:14:\"commerce_price\";}s:7:\"display\";a:5:{s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";s:21:\"calculated_sell_price\";}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:9:\"line_item\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";s:21:\"calculated_sell_price\";}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:26:\"commerce_line_item_display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";s:21:\"calculated_sell_price\";}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";s:21:\"calculated_sell_price\";}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:11:\"node_teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";s:21:\"calculated_sell_price\";}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}}s:11:\"description\";s:0:\"\";}',0),(71,24,'commerce_customer_address','commerce_customer_profile','shipping','a:6:{s:5:\"label\";s:7:\"Address\";s:8:\"required\";b:1;s:6:\"widget\";a:4:{s:4:\"type\";s:21:\"addressfield_standard\";s:6:\"weight\";i:-10;s:8:\"settings\";a:3:{s:15:\"format_handlers\";a:2:{i:0;s:7:\"address\";i:1;s:12:\"name-oneline\";}s:19:\"available_countries\";a:0:{}s:15:\"default_country\";s:0:\"\";}s:6:\"module\";s:12:\"addressfield\";}s:7:\"display\";a:3:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:20:\"addressfield_default\";s:6:\"weight\";i:-10;s:8:\"settings\";a:2:{s:19:\"use_widget_handlers\";i:1;s:15:\"format_handlers\";a:1:{i:0;s:7:\"address\";}}s:6:\"module\";s:12:\"addressfield\";}s:8:\"customer\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:20:\"addressfield_default\";s:6:\"weight\";i:-10;s:8:\"settings\";a:2:{s:19:\"use_widget_handlers\";i:1;s:15:\"format_handlers\";a:1:{i:0;s:7:\"address\";}}s:6:\"module\";s:12:\"addressfield\";}s:13:\"administrator\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:20:\"addressfield_default\";s:6:\"weight\";i:-10;s:8:\"settings\";a:2:{s:19:\"use_widget_handlers\";i:1;s:15:\"format_handlers\";a:1:{i:0;s:7:\"address\";}}s:6:\"module\";s:12:\"addressfield\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:11:\"description\";s:0:\"\";}',0),(72,28,'commerce_unit_price','commerce_line_item','shipping','a:6:{s:5:\"label\";s:10:\"Unit price\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:19:\"commerce_price_full\";s:6:\"weight\";i:0;s:8:\"settings\";a:1:{s:13:\"currency_code\";s:7:\"default\";}s:6:\"module\";s:14:\"commerce_price\";}s:7:\"display\";a:3:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}s:11:\"node_teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:0;s:6:\"module\";s:14:\"commerce_price\";}}s:11:\"description\";s:0:\"\";}',0),(73,29,'commerce_total','commerce_line_item','shipping','a:6:{s:5:\"label\";s:5:\"Total\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:19:\"commerce_price_full\";s:6:\"weight\";i:1;s:8:\"settings\";a:1:{s:13:\"currency_code\";s:7:\"default\";}s:6:\"module\";s:14:\"commerce_price\";}s:7:\"display\";a:3:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:1;s:6:\"module\";s:14:\"commerce_price\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:1;s:6:\"module\";s:14:\"commerce_price\";}s:11:\"node_teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:31:\"commerce_price_formatted_amount\";s:8:\"settings\";a:1:{s:11:\"calculation\";b:0;}s:6:\"weight\";i:1;s:6:\"module\";s:14:\"commerce_price\";}}s:11:\"description\";s:0:\"\";}',0),(74,33,'commerce_shipping_service','commerce_line_item','shipping','a:6:{s:5:\"label\";s:16:\"Shipping service\";s:8:\"required\";b:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:14:\"options_select\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:7:\"options\";}s:7:\"display\";a:2:{s:7:\"display\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"weight\";i:0;s:4:\"type\";s:12:\"list_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"list\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:12:\"list_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"list\";s:6:\"weight\";i:2;}}s:11:\"description\";s:0:\"\";}',0),(75,34,'commerce_customer_shipping','commerce_order','commerce_order','a:6:{s:5:\"label\";s:20:\"Shipping information\";s:6:\"widget\";a:4:{s:4:\"type\";s:33:\"commerce_customer_profile_manager\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}s:7:\"display\";a:3:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:43:\"commerce_customer_profile_reference_display\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}s:8:\"customer\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:43:\"commerce_customer_profile_reference_display\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}s:13:\"administrator\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:43:\"commerce_customer_profile_reference_display\";s:6:\"weight\";i:-5;s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"commerce_customer\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(76,35,'commerce_stock','commerce_product','product','a:7:{s:5:\"label\";s:5:\"Stock\";s:8:\"required\";b:1;s:8:\"settings\";a:5:{s:3:\"min\";s:0:\"\";s:3:\"max\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:14:\"number_integer\";s:8:\"settings\";a:4:{s:18:\"thousand_separator\";s:1:\" \";s:17:\"decimal_separator\";s:1:\".\";s:5:\"scale\";i:0;s:13:\"prefix_suffix\";b:1;}s:6:\"module\";s:6:\"number\";s:6:\"weight\";i:1;}}s:11:\"description\";N;s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";s:1:\"0\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:6:\"number\";s:8:\"settings\";a:0:{}s:6:\"weight\";i:36;s:6:\"module\";s:6:\"number\";}}',0),(77,1,'comment_body','comment','comment_node_mt_product','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0),(78,2,'body','node','mt_product','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";s:1:\"2\";s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(79,6,'field_mt_subheader_body','node','mt_product','a:7:{s:5:\"label\";s:14:\"Subheader body\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"1\";s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"module\";s:4:\"text\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"4\";s:12:\"summary_rows\";i:5;}}s:8:\"settings\";a:3:{s:15:\"text_processing\";s:1:\"1\";s:15:\"display_summary\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0),(80,4,'field_image','node','mt_product','a:6:{s:5:\"label\";s:16:\"In-page image(s)\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"3\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"module\";s:5:\"image\";}}s:8:\"required\";i:0;s:11:\"description\";s:97:\"The image(s) you will use in this field will be used in the main content column of the node page.\";}',0),(81,23,'field_mt_banner_image','node','mt_product','a:6:{s:5:\"label\";s:25:\"Internal banner image(s) \";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"4\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:121:\"The image(s) you will use in this field, will be used on the internal node page, in the slideshow right below the header.\";}',0),(82,20,'field_mt_teaser_image','node','mt_product','a:6:{s:5:\"label\";s:12:\"Teaser image\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"5\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:1;s:11:\"title_field\";i:1;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";}',0),(83,21,'field_mt_slideshow','node','mt_product','a:7:{s:5:\"label\";s:21:\"Promoted on slideshow\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"6\";s:4:\"type\";s:13:\"options_onoff\";s:6:\"module\";s:7:\"options\";s:6:\"active\";i:1;s:8:\"settings\";a:1:{s:13:\"display_label\";i:1;}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";s:8:\"settings\";a:0:{}}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";a:1:{i:0;a:1:{s:5:\"value\";i:0;}}}',0),(84,36,'field_mt_product','node','mt_product','a:7:{s:5:\"label\";s:7:\"Product\";s:6:\"widget\";a:5:{s:6:\"weight\";s:1:\"7\";s:4:\"type\";s:18:\"inline_entity_form\";s:6:\"module\";s:18:\"inline_entity_form\";s:6:\"active\";i:1;s:8:\"settings\";a:2:{s:6:\"fields\";a:0:{}s:13:\"type_settings\";a:7:{s:14:\"allow_existing\";i:1;s:14:\"match_operator\";s:8:\"CONTAINS\";s:17:\"delete_references\";i:0;s:15:\"override_labels\";i:0;s:14:\"label_singular\";s:7:\"product\";s:12:\"label_plural\";s:8:\"products\";s:18:\"autogenerate_title\";i:0;}}}s:8:\"settings\";a:3:{s:15:\"field_injection\";i:1;s:19:\"referenceable_types\";a:1:{s:7:\"product\";s:7:\"product\";}s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:30:\"commerce_cart_add_to_cart_form\";s:6:\"weight\";s:1:\"4\";s:8:\"settings\";a:5:{s:13:\"show_quantity\";i:1;s:16:\"default_quantity\";s:1:\"1\";s:7:\"combine\";i:1;s:30:\"show_single_product_attributes\";i:0;s:14:\"line_item_type\";s:7:\"product\";}s:6:\"module\";s:13:\"commerce_cart\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";s:8:\"settings\";a:0:{}}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";s:13:\"default_value\";N;}',0);
/*!40000 ALTER TABLE `field_config_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_body`
--

LOCK TABLES `field_data_body` WRITE;
/*!40000 ALTER TABLE `field_data_body` DISABLE KEYS */;
INSERT INTO `field_data_body` VALUES ('node','mt_post',0,1,1,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,2,2,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id sapien eu tortor vestibulum venenatis a eget augue. Nam massa nisi, tempor in tortor ut, tincidunt tempus ipsum. Phasellus adipiscing scelerisque sapien, non aliquet massa scelerisque nec. Duis leo arcu, posuere vel purus id, dignissim cursus ante. Nulla nisi lorem, <a href=\"#\">pulvinar non</a> purus sed, molestie faucibus sapien. Donec arcu orci, rhoncus faucibus tempor at, fringilla vitae mauris. Vestibulum laoreet est quis lorem egestas, non ornare sapien blandit. Praesent rutrum aliquam augue et sollicitudin. Proin lobortis pulvinar libero, ac dictum libero blandit eget. Suspendisse pretium, diam sit amet facilisis aliquet, mi augue venenatis nibh, in gravida odio ipsum in nulla.</p>\r\n<p>In quis velit lacus. Suspendisse potenti. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum arcu tellus, semper vitae iaculis id, adipiscing ac est. Curabitur eget laoreet dui. Vestibulum rhoncus vel risus non pharetra. Nulla sagittis nisl vitae nulla facilisis, non imperdiet arcu dignissim. Sed iaculis ligula sed enim rhoncus tincidunt. Sed gravida venenatis lobortis. Praesent porttitor arcu at velit sagittis, id pharetra est tincidunt.</p>\r\n<h3>Interdum et malesuada fames ac ante ipsum</h3>\r\n<p>Suspendisse dapibus rhoncus turpis, vel elementum est vestibulum eget. Nullam luctus non nisi ut tempor. Suspendisse eu pretium tortor, non tristique libero. Quisque vitae mi rutrum, imperdiet neque vel, feugiat orci. Vestibulum cursus rutrum turpis ut facilisis. Proin sed tempus mauris, sit amet facilisis ante. Duis tempus dignissim augue quis sagittis. Vivamus at varius turpis. Proin commodo ante ac velit auctor tincidunt. Praesent euismod lectus ac scelerisque scelerisque. Aliquam suscipit nisi erat, sed posuere lacus scelerisque ac. Praesent lacinia <a href=\"#\">consectetur mi</a>, nec auctor ante blandit ut.</p>\r\n<p>Suspendisse suscipit rutrum leo, ac sodales dolor mattis eu. Vivamus accumsan mattis sem a lacinia. Aliquam erat volutpat. Vivamus volutpat quam sit amet eros gravida, nec fermentum tellus tristique. Suspendisse tincidunt porttitor pulvinar. In pharetra felis quis mauris dapibus sollicitudin. Vestibulum commodo dui ut risus mollis, vel bibendum eros venenatis.</p>\r\n<p>Aenean semper sem vitae libero congue, vel sollicitudin elit porta. Sed massa libero, varius et justo eu, sagittis venenatis libero. Vestibulum adipiscing sit amet risus eu gravida. Duis metus magna, vehicula id arcu ut, suscipit imperdiet dolor. Phasellus consequat urna eros, eu luctus erat rutrum non. Donec ultricies eros sit amet dolor congue, non accumsan risus iaculis. Donec elementum ante vitae sem viverra gravida. Morbi fringilla eget lectus eu lacinia.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,3,3,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,4,4,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,5,5,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,6,6,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,7,7,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','full_html'),('node','mt_post',0,8,8,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','filtered_html'),('node','mt_post',0,9,9,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,10,10,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','How you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','full_html'),('node','mt_post',0,11,11,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,12,12,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','webform',0,13,13,'und',0,'Send us your stories and story suggestions, or any questions by using the form to contact us. For advertisement-related questions please use our <a href=\"#\">Advertising section<a>.','','filtered_html'),('node','page',0,14,14,'und',0,'<p class=\"large\">Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.</p> \r\n<h2>Heading 2</h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h2><a href=\"#\">Linked Heading 2</a></h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipisicing elit. Sit, esse, quo distinctio dolores magni reprehenderit id est at fugiat veritatis fugit dignissimos sed ut facere molestias illo impedit. Tempora, iure!\r\n</p>\r\n<h3>Heading 3</h3>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h4>Heading 4</h4>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h5>Heading 5</h5>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested <a href=\"#\">expertise with quote link</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing.</p>\r\n</blockquote>\r\n<h3>Messages</h3>\r\n<div class=\"messages status\">\r\nSample status message. Page <em><strong>Typography</strong></em> has been updated.\r\n</div>\r\n<div class=\"messages error\">\r\nSample error message. There is a security update available for your version of Drupal. To ensure the security of your server, you should update immediately! See the available updates page for more information.\r\n</div>\r\n<div class=\"messages warning\">\r\nSample warning message. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\r\n</div>\r\n<br/>\r\n<h3>Paragraph With Links</h3>\r\n<p>\r\nLorem ipsum dolor sit amet, <a href=\"#\">consectetuer adipiscing</a> elit. Donec odio. Quisque volutpat mattis eros. <a href=\"#\">Nullam malesuada</a> erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.\r\n</p>\r\n<h3>Ordered List</h3>\r\n<ol>\r\n<li>\r\nThis is a sample Ordered List.\r\n</li>\r\n<li>\r\nLorem ipsum dolor sit amet consectetuer.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ol>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n</li>\r\n</ol>\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor nibh.\r\n</li>\r\n</ol>\r\n\r\n<h3>Unordered List</h3>\r\n<ul>\r\n<li>\r\nThis is a sample <strong>Unordered List</strong>.\r\n</li>\r\n<li>\r\nCondimentum quis.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ul>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n<ul>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nThen one more\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nNunc cursus sem et pretium sapien eget.\r\n</li>\r\n</ul>\r\n\r\n<h3>Fieldset</h3>\r\n<fieldset><legend>Account information</legend></fieldset>\r\n\r\n<h3>Table</h3>\r\n<table>\r\n<tr>\r\n<th>Header 1</th>\r\n<th>Header 2</th>\r\n</tr>\r\n<tr class=\"odd\">\r\n<td>row 1, cell 1</td>\r\n<td>row 1, cell 2</td>\r\n</tr>\r\n<tr class=\"even\">\r\n<td>row 2, cell 1</td>\r\n<td>row 2, cell 2</td>\r\n</tr>\r\n<tr class=\"odd\">\r\n<td>row 3, cell 1</td>\r\n<td>row 3, cell 2</td>\r\n</tr>\r\n</table>','<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.</p> ','full_html'),('node','page',0,15,15,'und',0,'<h2 id=\"brands\">Brands</h2>\r\n<ul class=\"brands\">\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-apple\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-android\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-github\"></i></a>\r\n</li>                        \r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-windows\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-linux\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-skype\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-btc\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-css3\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-html5\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-bitbucket\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-maxcdn\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-dropbox\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-facebook\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-twitter\"></i></a>\r\n</li>\r\n</ul>\r\n<pre>\r\n&lt;ul class=\"brands\"&gt;\r\n\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-apple\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-android\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-github\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-windows\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-linux\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-skype\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-btc\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-css3\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-html5\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-bitbucket\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-maxcdn\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-dropbox\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-facebook\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-twitter\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id=\"tabs\">Tabs</h2>\r\n<!-- Nav tabs -->\r\n<ul class=\"nav nav-tabs\">\r\n<li class=\"active\"><a href=\"#home\" data-toggle=\"tab\"><i class=\"fa fa-home\"></i>Home</a></li>\r\n<li><a href=\"#profile\" data-toggle=\"tab\"><i class=\"fa fa-user\"></i>Profile</a></li>\r\n<li><a href=\"#messages\" data-toggle=\"tab\"><i class=\"fa fa-envelope\"></i>Messages</a></li>\r\n</ul>\r\n<!-- Tab panes -->\r\n<div class=\"tab-content\">\r\n<div class=\"tab-pane active\" id=\"home\">\r\n<p><strong>Home</strong> ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis, exercitationem, quaerat veniam repudiandae illo ratione eaque omnis obcaecati quidem distinctio sapiente quo assumenda amet cumque nobis nulla qui dolore autem.</p>\r\n</div>\r\n<div class=\"tab-pane\" id=\"profile\">\r\n<p><strong>Profile</strong> ipsum dolor sit amet, consectetur adipisicing elit. Ut odio facere minima porro quis. Maiores eius quibusdam et in corrupti necessitatibus consequatur debitis laudantium hic.</p>\r\n</div>\r\n<div class=\"tab-pane\" id=\"messages\">\r\n<p><strong>Messages</strong> ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis, optio error consectetur ullam porro eligendi mollitia odio numquam aut cumque. Sed, possimus recusandae itaque laboriosam nesciunt voluptates veniam aspernatur voluptate eaque ratione totam ipsa optio aliquam incidunt dolorum amet illum.</p>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;!-- Nav tabs --&gt;\r\n&lt;ul class=\"nav nav-tabs\"&gt;\r\n\r\n  &lt;li class=\"active\"&gt;&lt;a href=\"#home\" data-toggle=\"tab\"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#profile\" data-toggle=\"tab\"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#messages\" data-toggle=\"tab\"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n\r\n&lt;!-- Tab panes --&gt;\r\n&lt;div class=\"tab-content\"&gt;\r\n\r\n  &lt;div class=\"tab-pane active\" id=\"home\"&gt; ...  &lt;/div&gt;\r\n  &lt;div class=\"tab-pane\" id=\"profile\"&gt; ... &lt;/div&gt;\r\n  &lt;div class=\"tab-pane\" id=\"messages\"&gt; ... &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id=\"accordion\">Accordion</h2>\r\n<div class=\"panel-group\" id=\"accordion\">\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<h4 class=\"panel-title\">\r\n<a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseOne\"><i class=\"fa fa-home\"></i> Home</a>\r\n</h4>\r\n</div>\r\n<div id=\"collapseOne\" class=\"panel-collapse collapse in\">\r\n<div class=\"panel-body\">\r\n<strong>Home</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven\'t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<h4 class=\"panel-title\">\r\n<a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseTwo\" class=\"collapsed\"><i class=\"fa fa-cog\"></i> Configure</a>\r\n</h4>\r\n</div>\r\n<div id=\"collapseTwo\" class=\"panel-collapse collapse\">\r\n<div class=\"panel-body\">\r\n<strong>Configure</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven\'t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<h4 class=\"panel-title\">\r\n<a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseThree\" class=\"collapsed\"><i class=\"fa fa-cloud-download\"></i> Download</a>\r\n</h4>\r\n</div>\r\n<div id=\"collapseThree\" class=\"panel-collapse collapse\">\r\n<div class=\"panel-body\">\r\n<strong>Download</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven\'t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;div class=\"panel-group\" id=\"accordion\"&gt;\r\n\r\n  &lt;div class=\"panel panel-default\"&gt;\r\n    &lt;div class=\"panel-heading\"&gt;\r\n      &lt;h4 class=\"panel-title\"&gt;\r\n        &lt;a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseOne\"&gt;\r\n          &lt;i class=\"fa fa-home\"&gt;&lt;/i&gt; Home\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id=\"collapseOne\" class=\"panel-collapse collapse in\"&gt;\r\n      &lt;div class=\"panel-body\"&gt; ...  &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class=\"panel panel-default\"&gt;\r\n    &lt;div class=\"panel-heading\"&gt;\r\n      &lt;h4 class=\"panel-title\"&gt;\r\n        &lt;a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseTwo\"&gt;\r\n          &lt;i class=\"fa fa-cog\"&gt;&lt;/i&gt; Configure\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id=\"collapseTwo\" class=\"panel-collapse collapse\"&gt;\r\n      &lt;div class=\"panel-body\"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class=\"panel panel-default\"&gt;\r\n    &lt;div class=\"panel-heading\"&gt;\r\n      &lt;h4 class=\"panel-title\"&gt;\r\n        &lt;a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseThree\"&gt;\r\n          &lt;i class=\"fa fa-cloud-download\"&gt;&lt;/i&gt; Download\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id=\"collapseThree\" class=\"panel-collapse collapse\"&gt;\r\n      &lt;div class=\"panel-body\"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id=\"buttons\">Buttons</h2>\r\n<div>\r\n<a href=\"#\" class=\"button\">Read more</a>\r\n</div>\r\n<pre>\r\n&lt;a href=\"#\" class=\"button\"&gt;Read more&lt;/a&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id=\"progressbars\">Progress Bars</h2>\r\n<h5>40% Complete (success)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" aria-valuenow=\"40\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 40%\">\r\n<span class=\"sr-only\">40% Complete (success)</span>\r\n</div>\r\n</div>\r\n<h5>20% Complete (info)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-info\" role=\"progressbar\" aria-valuenow=\"20\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 20%\">\r\n<span class=\"sr-only\">20% Complete</span>\r\n</div>\r\n</div>\r\n<h5>60% Complete (warning)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" aria-valuenow=\"60\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 60%\">\r\n<span class=\"sr-only\">60% Complete (warning)</span>\r\n</div>\r\n</div>\r\n<h5>80% Complete (danger)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" aria-valuenow=\"80\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 80%\">\r\n<span class=\"sr-only\">80% Complete</span>\r\n</div>\r\n</div>\r\n<h5>Results</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-success\" style=\"width: 40%\">\r\n<span class=\"sr-only\">35% A</span>\r\n</div>\r\n<div class=\"progress-bar progress-bar-info\" style=\"width: 30%\">\r\n<span class=\"sr-only\">20% B</span>\r\n</div>\r\n<div class=\"progress-bar progress-bar-warning\" style=\"width: 20%\">\r\n<span class=\"sr-only\">20% C</span>\r\n</div>\r\n<div class=\"progress-bar progress-bar-danger\" style=\"width: 10%\">\r\n<span class=\"sr-only\">10% D</span>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;h5>40% Complete (success)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-success\" role=\"progressbar\" aria-valuenow=\"40\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 40%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;40% Complete (success)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;20% Complete (info)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-info\" role=\"progressbar\" aria-valuenow=\"20\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 20%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;20% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;60% Complete (warning)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" aria-valuenow=\"60\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 60%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;60% Complete (warning)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;80% Complete (danger)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" aria-valuenow=\"80\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 80%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;80% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;Results&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-success\" style=\"width: 40%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;35% A&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class=\"progress-bar progress-bar-info\" style=\"width: 30%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;20% B&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class=\"progress-bar progress-bar-warning\" style=\"width: 20%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;20% C&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class=\"progress-bar progress-bar-danger\" style=\"width: 10%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;10% D&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<div class=\"alert alert-info\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>Check all available Font Awesome icons at <a  target=\"_blank\" href=\"http://fortawesome.github.io/Font-Awesome/icons/\" class=\"alert-link\">http://fortawesome.github.io/Font-Awesome/icons/</a></div>','Shortcodes phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.','full_html'),('node','page',0,16,16,'und',0,'<h2>Columns</h2>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-6\"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-6\"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>','<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>','full_html'),('node','page',0,17,17,'und',0,'<h2>Columns</h2>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-6\"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-6\"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>','<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>','full_html'),('node','mt_product',0,18,18,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,19,19,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','filtered_html'),('node','mt_product',0,20,20,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>    \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,21,21,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,22,22,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,23,23,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>\r\n','','full_html');
/*!40000 ALTER TABLE `field_data_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_comment_body`
--

DROP TABLE IF EXISTS `field_data_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_comment_body`
--

LOCK TABLES `field_data_comment_body` WRITE;
/*!40000 ALTER TABLE `field_data_comment_body` DISABLE KEYS */;
INSERT INTO `field_data_comment_body` VALUES ('comment','comment_node_mt_post',0,1,1,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html'),('comment','comment_node_mt_post',0,2,2,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html'),('comment','comment_node_mt_post',0,3,3,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html'),('comment','comment_node_mt_post',0,4,4,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html');
/*!40000 ALTER TABLE `field_data_comment_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_customer_address`
--

DROP TABLE IF EXISTS `field_data_commerce_customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_customer_address` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_address_country` varchar(2) DEFAULT '' COMMENT 'Two letter ISO country code of this address.',
  `commerce_customer_address_administrative_area` varchar(255) DEFAULT '' COMMENT 'The administrative area of this address. (i.e. State/Province)',
  `commerce_customer_address_sub_administrative_area` varchar(255) DEFAULT '' COMMENT 'The sub administrative area of this address.',
  `commerce_customer_address_locality` varchar(255) DEFAULT '' COMMENT 'The locality of this address. (i.e. City)',
  `commerce_customer_address_dependent_locality` varchar(255) DEFAULT '' COMMENT 'The dependent locality of this address.',
  `commerce_customer_address_postal_code` varchar(255) DEFAULT '' COMMENT 'The postal code of this address.',
  `commerce_customer_address_thoroughfare` varchar(255) DEFAULT '' COMMENT 'The thoroughfare of this address. (i.e. Street address)',
  `commerce_customer_address_premise` varchar(255) DEFAULT '' COMMENT 'The premise of this address. (i.e. Apartment / Suite number)',
  `commerce_customer_address_sub_premise` varchar(255) DEFAULT '' COMMENT 'The sub_premise of this address.',
  `commerce_customer_address_organisation_name` varchar(255) DEFAULT '' COMMENT 'Contents of a primary OrganisationName element in the xNL XML.',
  `commerce_customer_address_name_line` varchar(255) DEFAULT '' COMMENT 'Contents of a primary NameLine element in the xNL XML.',
  `commerce_customer_address_first_name` varchar(255) DEFAULT '' COMMENT 'Contents of the FirstName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_last_name` varchar(255) DEFAULT '' COMMENT 'Contents of the LastName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_data` longtext COMMENT 'Additional data for this address.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 24 (commerce_customer_address)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_customer_address`
--

LOCK TABLES `field_data_commerce_customer_address` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_customer_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_customer_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_customer_billing`
--

DROP TABLE IF EXISTS `field_data_commerce_customer_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_customer_billing` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_billing_profile_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_customer_billing_profile_id` (`commerce_customer_billing_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 27 (commerce_customer_billing)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_customer_billing`
--

LOCK TABLES `field_data_commerce_customer_billing` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_customer_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_customer_billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_customer_shipping`
--

DROP TABLE IF EXISTS `field_data_commerce_customer_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_customer_shipping` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_shipping_profile_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_customer_shipping_profile_id` (`commerce_customer_shipping_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 34 (commerce_customer_shipping)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_customer_shipping`
--

LOCK TABLES `field_data_commerce_customer_shipping` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_customer_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_customer_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_display_path`
--

DROP TABLE IF EXISTS `field_data_commerce_display_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_display_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_display_path_value` varchar(255) DEFAULT NULL,
  `commerce_display_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_display_path_format` (`commerce_display_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 31 (commerce_display_path)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_display_path`
--

LOCK TABLES `field_data_commerce_display_path` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_display_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_display_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_line_items`
--

DROP TABLE IF EXISTS `field_data_commerce_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_line_items` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_line_items_line_item_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_line_items_line_item_id` (`commerce_line_items_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 25 (commerce_line_items)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_line_items`
--

LOCK TABLES `field_data_commerce_line_items` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_order_total`
--

DROP TABLE IF EXISTS `field_data_commerce_order_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_order_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_order_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_order_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_order_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_order_total_currency_price` (`commerce_order_total_amount`,`commerce_order_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 26 (commerce_order_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_order_total`
--

LOCK TABLES `field_data_commerce_order_total` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_order_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_order_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_price`
--

DROP TABLE IF EXISTS `field_data_commerce_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_price_currency_price` (`commerce_price_amount`,`commerce_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 32 (commerce_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_price`
--

LOCK TABLES `field_data_commerce_price` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_price` DISABLE KEYS */;
INSERT INTO `field_data_commerce_price` VALUES ('commerce_product','product',0,1,1,'und',0,999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,2,2,'und',0,1999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,3,3,'und',0,2999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,4,4,'und',0,3999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,5,5,'und',0,4999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,6,6,'und',0,5999,'USD','a:1:{s:10:\"components\";a:0:{}}');
/*!40000 ALTER TABLE `field_data_commerce_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_product`
--

DROP TABLE IF EXISTS `field_data_commerce_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_product` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_product_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_product_product_id` (`commerce_product_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 30 (commerce_product)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_product`
--

LOCK TABLES `field_data_commerce_product` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_shipping_service`
--

DROP TABLE IF EXISTS `field_data_commerce_shipping_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_shipping_service` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_shipping_service_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_shipping_service_value` (`commerce_shipping_service_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 33 (commerce_shipping_service)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_shipping_service`
--

LOCK TABLES `field_data_commerce_shipping_service` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_shipping_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_shipping_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_stock`
--

DROP TABLE IF EXISTS `field_data_commerce_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_stock` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_stock_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 35 (commerce_stock)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_stock`
--

LOCK TABLES `field_data_commerce_stock` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_stock` DISABLE KEYS */;
INSERT INTO `field_data_commerce_stock` VALUES ('commerce_product','product',0,1,1,'und',0,1000),('commerce_product','product',0,2,2,'und',0,1000),('commerce_product','product',0,3,3,'und',0,1000),('commerce_product','product',0,4,4,'und',0,1000),('commerce_product','product',0,5,5,'und',0,1000),('commerce_product','product',0,6,6,'und',0,1000);
/*!40000 ALTER TABLE `field_data_commerce_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_total`
--

DROP TABLE IF EXISTS `field_data_commerce_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_total_currency_price` (`commerce_total_amount`,`commerce_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 29 (commerce_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_total`
--

LOCK TABLES `field_data_commerce_total` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_commerce_unit_price`
--

DROP TABLE IF EXISTS `field_data_commerce_unit_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_commerce_unit_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_unit_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_unit_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_unit_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_unit_price_currency_price` (`commerce_unit_price_amount`,`commerce_unit_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 28 (commerce_unit_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_commerce_unit_price`
--

LOCK TABLES `field_data_commerce_unit_price` WRITE;
/*!40000 ALTER TABLE `field_data_commerce_unit_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_commerce_unit_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_image`
--

DROP TABLE IF EXISTS `field_data_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_image`
--

LOCK TABLES `field_data_field_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_image` DISABLE KEYS */;
INSERT INTO `field_data_field_image` VALUES ('node','mt_post',0,1,1,'und',0,1,'','And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,1,1,'und',1,16,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',2,17,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',3,18,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',4,19,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',5,20,'','Title of Image',750,499),('node','mt_post',0,2,2,'und',0,22,'','Caption competently expedite standards compliant users and leadership. ',750,499),('node','mt_post',0,3,3,'und',0,3,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,4,4,'und',0,4,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,5,5,'und',0,5,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,6,6,'und',0,6,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,7,7,'und',0,7,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,8,8,'und',0,8,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,9,9,'und',0,9,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,10,10,'und',0,10,'','Caption. Competently expedite standards compliant users and leadership. ',750,499),('node','mt_post',0,11,11,'und',0,11,'','Caption. Competently expedite standards compliant users and leadership. ',750,499),('node','mt_post',0,12,12,'und',0,12,'','And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_product',0,18,18,'und',0,44,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,19,19,'und',0,45,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,20,20,'und',0,46,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,21,21,'und',0,47,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,22,22,'und',0,48,'','Caption competently expedite standards compliant users and leadership. ',750,499),('node','mt_product',0,23,23,'und',0,49,'','Caption competently expedite standards compliant users and leadership.',750,499);
/*!40000 ALTER TABLE `field_data_field_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_about`
--

DROP TABLE IF EXISTS `field_data_field_mt_about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_about` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_about_value` longtext,
  `field_mt_about_summary` longtext,
  `field_mt_about_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_about_format` (`field_mt_about_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 7 (field_mt_about)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_about`
--

LOCK TABLES `field_data_field_mt_about` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_about` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_about` VALUES ('user','user',0,1,1,'und',0,'Quickly extend top-line opportunities for leveraged bandwidth. Conveniently maximize low-risk high-yield ROI rather than cooperative synergy. Appropriately synthesize cooperative portals without backward-compatible total linkage. Seamlessly plagiarize value-added deliverables with customer directed technologies. ','','filtered_html');
/*!40000 ALTER TABLE `field_data_field_mt_about` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_banner_image`
--

DROP TABLE IF EXISTS `field_data_field_mt_banner_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_banner_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_banner_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_banner_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_banner_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_banner_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_banner_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_banner_image_fid` (`field_mt_banner_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 23 (field_mt_banner_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_banner_image`
--

LOCK TABLES `field_data_field_mt_banner_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_banner_image` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_banner_image` VALUES ('node','mt_post',0,1,1,'und',0,37,'Synergistically streamline prospective content whereas turnkey web services. Efficiently formulate enabled processes with granular processes.','Slide 1 title',1170,610),('node','mt_post',0,1,1,'und',1,38,'Efficiently formulate enabled processes with granular processes.','Slide 2 title',1170,610),('node','mt_post',0,1,1,'und',2,39,'Synergistically streamline prospective content whereas turnkey web services.','Slide 3 title',1170,610),('node','mt_post',0,1,1,'und',3,40,'Efficiently formulate enabled processes with granular processes. Synergistically streamline prospective content whereas turnkey web services.','Slide 4 title',1170,610),('node','mt_post',0,1,1,'und',4,41,'Collaboratively engage value-added potentialities rather than quality innovation.','Slide 5 title',1170,610),('node','mt_post',0,1,1,'und',5,42,'Collaboratively repurpose resource-leveling scenarios via integrated functionalities','Slide 6 title',1170,610),('node','mt_post',0,1,1,'und',6,43,'','Slide 7 title',1170,610);
/*!40000 ALTER TABLE `field_data_field_mt_banner_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_breaking`
--

DROP TABLE IF EXISTS `field_data_field_mt_breaking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_breaking` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_breaking_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_breaking_value` (`field_mt_breaking_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 13 (field_mt_breaking)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_breaking`
--

LOCK TABLES `field_data_field_mt_breaking` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_breaking` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_breaking` VALUES ('node','mt_post',0,1,1,'und',0,1),('node','mt_post',0,2,2,'und',0,1),('node','mt_post',0,3,3,'und',0,1),('node','mt_post',0,4,4,'und',0,0),('node','mt_post',0,5,5,'und',0,0),('node','mt_post',0,6,6,'und',0,0),('node','mt_post',0,7,7,'und',0,0),('node','mt_post',0,8,8,'und',0,0),('node','mt_post',0,9,9,'und',0,0),('node','mt_post',0,10,10,'und',0,0),('node','mt_post',0,11,11,'und',0,0),('node','mt_post',0,12,12,'und',0,0);
/*!40000 ALTER TABLE `field_data_field_mt_breaking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_facebook`
--

DROP TABLE IF EXISTS `field_data_field_mt_facebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_facebook` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_facebook_value` varchar(255) DEFAULT NULL,
  `field_mt_facebook_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_facebook_format` (`field_mt_facebook_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 17 (field_mt_facebook)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_facebook`
--

LOCK TABLES `field_data_field_mt_facebook` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_facebook` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_facebook` VALUES ('user','user',0,1,1,'und',0,'https://www.facebook.com/morethan.just.themes',NULL);
/*!40000 ALTER TABLE `field_data_field_mt_facebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_google_plus`
--

DROP TABLE IF EXISTS `field_data_field_mt_google_plus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_google_plus` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_google_plus_value` varchar(255) DEFAULT NULL,
  `field_mt_google_plus_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_google_plus_format` (`field_mt_google_plus_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 19 (field_mt_google_plus)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_google_plus`
--

LOCK TABLES `field_data_field_mt_google_plus` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_google_plus` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_google_plus` VALUES ('user','user',0,1,1,'und',0,'https://plus.google.com/+Morethanthemes/posts',NULL);
/*!40000 ALTER TABLE `field_data_field_mt_google_plus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_post_categories`
--

DROP TABLE IF EXISTS `field_data_field_mt_post_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_post_categories` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_post_categories_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_post_categories_tid` (`field_mt_post_categories_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (field_mt_post_categories)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_post_categories`
--

LOCK TABLES `field_data_field_mt_post_categories` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_post_categories` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_post_categories` VALUES ('node','mt_post',0,1,1,'und',0,2),('node','mt_post',0,2,2,'und',0,3),('node','mt_post',0,3,3,'und',0,5),('node','mt_post',0,4,4,'und',0,6),('node','mt_post',0,5,5,'und',0,4),('node','mt_post',0,6,6,'und',0,1),('node','mt_post',0,7,7,'und',0,2),('node','mt_post',0,8,8,'und',0,3),('node','mt_post',0,9,9,'und',0,5),('node','mt_post',0,10,10,'und',0,6),('node','mt_post',0,11,11,'und',0,4),('node','mt_post',0,12,12,'und',0,1);
/*!40000 ALTER TABLE `field_data_field_mt_post_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_product`
--

DROP TABLE IF EXISTS `field_data_field_mt_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_product` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_product_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_product_product_id` (`field_mt_product_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 36 (field_mt_product)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_product`
--

LOCK TABLES `field_data_field_mt_product` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_product` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_product` VALUES ('node','mt_product',0,18,18,'und',0,6),('node','mt_product',0,19,19,'und',0,5),('node','mt_product',0,20,20,'und',0,4),('node','mt_product',0,21,21,'und',0,3),('node','mt_product',0,22,22,'und',0,2),('node','mt_product',0,23,23,'und',0,1);
/*!40000 ALTER TABLE `field_data_field_mt_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_slideshow`
--

DROP TABLE IF EXISTS `field_data_field_mt_slideshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_slideshow` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_value` (`field_mt_slideshow_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 21 (field_mt_slideshow)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_slideshow`
--

LOCK TABLES `field_data_field_mt_slideshow` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_slideshow` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_slideshow` VALUES ('node','mt_post',0,1,1,'und',0,1),('node','mt_post',0,2,2,'und',0,1),('node','mt_post',0,3,3,'und',0,0),('node','mt_post',0,4,4,'und',0,0),('node','mt_post',0,5,5,'und',0,0),('node','mt_post',0,6,6,'und',0,0),('node','mt_post',0,7,7,'und',0,0),('node','mt_post',0,8,8,'und',0,0),('node','mt_post',0,9,9,'und',0,0),('node','mt_post',0,10,10,'und',0,0),('node','mt_post',0,11,11,'und',0,0),('node','mt_post',0,12,12,'und',0,0),('node','mt_product',0,18,18,'und',0,0),('node','mt_product',0,19,19,'und',0,0),('node','mt_product',0,20,20,'und',0,0),('node','mt_product',0,21,21,'und',0,0),('node','mt_product',0,22,22,'und',0,0),('node','mt_product',0,23,23,'und',0,0);
/*!40000 ALTER TABLE `field_data_field_mt_slideshow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_slideshow_path`
--

DROP TABLE IF EXISTS `field_data_field_mt_slideshow_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_slideshow_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_path_value` varchar(255) DEFAULT NULL,
  `field_mt_slideshow_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_path_format` (`field_mt_slideshow_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 22 (field_mt_slideshow_path)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_slideshow_path`
--

LOCK TABLES `field_data_field_mt_slideshow_path` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_slideshow_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_mt_slideshow_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_subheader_body`
--

DROP TABLE IF EXISTS `field_data_field_mt_subheader_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_subheader_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_subheader_body_value` longtext,
  `field_mt_subheader_body_summary` longtext,
  `field_mt_subheader_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_subheader_body_format` (`field_mt_subheader_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 6 (field_mt_subheader_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_subheader_body`
--

LOCK TABLES `field_data_field_mt_subheader_body` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_subheader_body` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_subheader_body` VALUES ('node','mt_post',0,1,1,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,2,2,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,3,3,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly <a href=\"#\">extend top-line opportunities for leveraged</a> bandwidth.','','filtered_html'),('node','mt_post',0,4,4,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,5,5,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,6,6,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,7,7,'und',0,'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','','filtered_html'),('node','mt_post',0,8,8,'und',0,'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','','filtered_html'),('node','mt_post',0,9,9,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,10,10,'und',0,'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','','filtered_html'),('node','mt_post',0,11,11,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can <a href=\"#\">quickly extend top-line opportunities for leveraged bandwidth</a>. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,12,12,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_product',0,18,18,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,19,19,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,20,20,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,21,21,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,22,22,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,23,23,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html');
/*!40000 ALTER TABLE `field_data_field_mt_subheader_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_teaser_image`
--

DROP TABLE IF EXISTS `field_data_field_mt_teaser_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_teaser_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_teaser_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_teaser_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_teaser_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_teaser_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_teaser_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_teaser_image_fid` (`field_mt_teaser_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 20 (field_mt_teaser_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_teaser_image`
--

LOCK TABLES `field_data_field_mt_teaser_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_teaser_image` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_teaser_image` VALUES ('node','mt_post',0,1,1,'und',0,35,'','',1170,610),('node','mt_post',0,2,2,'und',0,36,'','',1170,610);
/*!40000 ALTER TABLE `field_data_field_mt_teaser_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_mt_twitter`
--

DROP TABLE IF EXISTS `field_data_field_mt_twitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_mt_twitter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_twitter_value` varchar(255) DEFAULT NULL,
  `field_mt_twitter_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_twitter_format` (`field_mt_twitter_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 18 (field_mt_twitter)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_mt_twitter`
--

LOCK TABLES `field_data_field_mt_twitter` WRITE;
/*!40000 ALTER TABLE `field_data_field_mt_twitter` DISABLE KEYS */;
INSERT INTO `field_data_field_mt_twitter` VALUES ('user','user',0,1,1,'und',0,'https://twitter.com/morethanthemes/',NULL);
/*!40000 ALTER TABLE `field_data_field_mt_twitter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_tags`
--

DROP TABLE IF EXISTS `field_data_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_tags`
--

LOCK TABLES `field_data_field_tags` WRITE;
/*!40000 ALTER TABLE `field_data_field_tags` DISABLE KEYS */;
INSERT INTO `field_data_field_tags` VALUES ('node','mt_post',0,1,1,'und',0,7),('node','mt_post',0,1,1,'und',1,8),('node','mt_post',0,1,1,'und',2,9),('node','mt_post',0,2,2,'und',0,7),('node','mt_post',0,2,2,'und',1,8),('node','mt_post',0,2,2,'und',2,9),('node','mt_post',0,3,3,'und',0,7),('node','mt_post',0,3,3,'und',1,9),('node','mt_post',0,4,4,'und',0,7),('node','mt_post',0,4,4,'und',1,10),('node','mt_post',0,4,4,'und',2,11),('node','mt_post',0,5,5,'und',0,8),('node','mt_post',0,5,5,'und',1,9),('node','mt_post',0,5,5,'und',2,10),('node','mt_post',0,6,6,'und',0,7),('node','mt_post',0,6,6,'und',1,8),('node','mt_post',0,6,6,'und',2,11),('node','mt_post',0,7,7,'und',0,7),('node','mt_post',0,7,7,'und',1,8),('node','mt_post',0,7,7,'und',2,9),('node','mt_post',0,7,7,'und',3,10),('node','mt_post',0,8,8,'und',0,10),('node','mt_post',0,8,8,'und',1,11),('node','mt_post',0,9,9,'und',0,8),('node','mt_post',0,9,9,'und',1,9),('node','mt_post',0,9,9,'und',2,10),('node','mt_post',0,9,9,'und',3,11),('node','mt_post',0,10,10,'und',0,7),('node','mt_post',0,10,10,'und',1,10),('node','mt_post',0,10,10,'und',2,11),('node','mt_post',0,11,11,'und',0,8),('node','mt_post',0,11,11,'und',1,9),('node','mt_post',0,11,11,'und',2,11),('node','mt_post',0,12,12,'und',0,7),('node','mt_post',0,12,12,'und',1,8),('node','mt_post',0,12,12,'und',2,9),('node','mt_post',0,12,12,'und',3,10),('node','mt_post',0,12,12,'und',4,11);
/*!40000 ALTER TABLE `field_data_field_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_body`
--

LOCK TABLES `field_revision_body` WRITE;
/*!40000 ALTER TABLE `field_revision_body` DISABLE KEYS */;
INSERT INTO `field_revision_body` VALUES ('node','mt_post',0,1,1,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,2,2,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id sapien eu tortor vestibulum venenatis a eget augue. Nam massa nisi, tempor in tortor ut, tincidunt tempus ipsum. Phasellus adipiscing scelerisque sapien, non aliquet massa scelerisque nec. Duis leo arcu, posuere vel purus id, dignissim cursus ante. Nulla nisi lorem, <a href=\"#\">pulvinar non</a> purus sed, molestie faucibus sapien. Donec arcu orci, rhoncus faucibus tempor at, fringilla vitae mauris. Vestibulum laoreet est quis lorem egestas, non ornare sapien blandit. Praesent rutrum aliquam augue et sollicitudin. Proin lobortis pulvinar libero, ac dictum libero blandit eget. Suspendisse pretium, diam sit amet facilisis aliquet, mi augue venenatis nibh, in gravida odio ipsum in nulla.</p>\r\n<p>In quis velit lacus. Suspendisse potenti. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum arcu tellus, semper vitae iaculis id, adipiscing ac est. Curabitur eget laoreet dui. Vestibulum rhoncus vel risus non pharetra. Nulla sagittis nisl vitae nulla facilisis, non imperdiet arcu dignissim. Sed iaculis ligula sed enim rhoncus tincidunt. Sed gravida venenatis lobortis. Praesent porttitor arcu at velit sagittis, id pharetra est tincidunt.</p>\r\n<h3>Interdum et malesuada fames ac ante ipsum</h3>\r\n<p>Suspendisse dapibus rhoncus turpis, vel elementum est vestibulum eget. Nullam luctus non nisi ut tempor. Suspendisse eu pretium tortor, non tristique libero. Quisque vitae mi rutrum, imperdiet neque vel, feugiat orci. Vestibulum cursus rutrum turpis ut facilisis. Proin sed tempus mauris, sit amet facilisis ante. Duis tempus dignissim augue quis sagittis. Vivamus at varius turpis. Proin commodo ante ac velit auctor tincidunt. Praesent euismod lectus ac scelerisque scelerisque. Aliquam suscipit nisi erat, sed posuere lacus scelerisque ac. Praesent lacinia <a href=\"#\">consectetur mi</a>, nec auctor ante blandit ut.</p>\r\n<p>Suspendisse suscipit rutrum leo, ac sodales dolor mattis eu. Vivamus accumsan mattis sem a lacinia. Aliquam erat volutpat. Vivamus volutpat quam sit amet eros gravida, nec fermentum tellus tristique. Suspendisse tincidunt porttitor pulvinar. In pharetra felis quis mauris dapibus sollicitudin. Vestibulum commodo dui ut risus mollis, vel bibendum eros venenatis.</p>\r\n<p>Aenean semper sem vitae libero congue, vel sollicitudin elit porta. Sed massa libero, varius et justo eu, sagittis venenatis libero. Vestibulum adipiscing sit amet risus eu gravida. Duis metus magna, vehicula id arcu ut, suscipit imperdiet dolor. Phasellus consequat urna eros, eu luctus erat rutrum non. Donec ultricies eros sit amet dolor congue, non accumsan risus iaculis. Donec elementum ante vitae sem viverra gravida. Morbi fringilla eget lectus eu lacinia.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,3,3,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,4,4,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,5,5,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,6,6,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,7,7,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','full_html'),('node','mt_post',0,8,8,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','filtered_html'),('node','mt_post',0,9,9,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,10,10,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','How you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','full_html'),('node','mt_post',0,11,11,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','mt_post',0,12,12,'und',0,'<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href=\"#\">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>','Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','full_html'),('node','webform',0,13,13,'und',0,'Send us your stories and story suggestions, or any questions by using the form to contact us. For advertisement-related questions please use our <a href=\"#\">Advertising section<a>.','','filtered_html'),('node','page',0,14,14,'und',0,'<p class=\"large\">Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.</p> \r\n<h2>Heading 2</h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h2><a href=\"#\">Linked Heading 2</a></h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipisicing elit. Sit, esse, quo distinctio dolores magni reprehenderit id est at fugiat veritatis fugit dignissimos sed ut facere molestias illo impedit. Tempora, iure!\r\n</p>\r\n<h3>Heading 3</h3>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h4>Heading 4</h4>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h5>Heading 5</h5>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href=\"#\">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested <a href=\"#\">expertise with quote link</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing.</p>\r\n</blockquote>\r\n<h3>Messages</h3>\r\n<div class=\"messages status\">\r\nSample status message. Page <em><strong>Typography</strong></em> has been updated.\r\n</div>\r\n<div class=\"messages error\">\r\nSample error message. There is a security update available for your version of Drupal. To ensure the security of your server, you should update immediately! See the available updates page for more information.\r\n</div>\r\n<div class=\"messages warning\">\r\nSample warning message. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\r\n</div>\r\n<br/>\r\n<h3>Paragraph With Links</h3>\r\n<p>\r\nLorem ipsum dolor sit amet, <a href=\"#\">consectetuer adipiscing</a> elit. Donec odio. Quisque volutpat mattis eros. <a href=\"#\">Nullam malesuada</a> erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.\r\n</p>\r\n<h3>Ordered List</h3>\r\n<ol>\r\n<li>\r\nThis is a sample Ordered List.\r\n</li>\r\n<li>\r\nLorem ipsum dolor sit amet consectetuer.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ol>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n</li>\r\n</ol>\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor nibh.\r\n</li>\r\n</ol>\r\n\r\n<h3>Unordered List</h3>\r\n<ul>\r\n<li>\r\nThis is a sample <strong>Unordered List</strong>.\r\n</li>\r\n<li>\r\nCondimentum quis.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ul>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n<ul>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nThen one more\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nNunc cursus sem et pretium sapien eget.\r\n</li>\r\n</ul>\r\n\r\n<h3>Fieldset</h3>\r\n<fieldset><legend>Account information</legend></fieldset>\r\n\r\n<h3>Table</h3>\r\n<table>\r\n<tr>\r\n<th>Header 1</th>\r\n<th>Header 2</th>\r\n</tr>\r\n<tr class=\"odd\">\r\n<td>row 1, cell 1</td>\r\n<td>row 1, cell 2</td>\r\n</tr>\r\n<tr class=\"even\">\r\n<td>row 2, cell 1</td>\r\n<td>row 2, cell 2</td>\r\n</tr>\r\n<tr class=\"odd\">\r\n<td>row 3, cell 1</td>\r\n<td>row 3, cell 2</td>\r\n</tr>\r\n</table>','<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.</p> ','full_html'),('node','page',0,15,15,'und',0,'<h2 id=\"brands\">Brands</h2>\r\n<ul class=\"brands\">\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-apple\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-android\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-github\"></i></a>\r\n</li>                        \r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-windows\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-linux\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-skype\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-btc\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-css3\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-html5\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-bitbucket\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-maxcdn\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-dropbox\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-facebook\"></i></a>\r\n</li>\r\n<li>\r\n<a href=\"#\"><i class=\"fa fa-twitter\"></i></a>\r\n</li>\r\n</ul>\r\n<pre>\r\n&lt;ul class=\"brands\"&gt;\r\n\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-apple\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-android\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-github\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-windows\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-linux\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-skype\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-btc\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-css3\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-html5\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-bitbucket\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-maxcdn\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-dropbox\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-facebook\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#\"&gt;&lt;i class=\"fa fa-twitter\"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id=\"tabs\">Tabs</h2>\r\n<!-- Nav tabs -->\r\n<ul class=\"nav nav-tabs\">\r\n<li class=\"active\"><a href=\"#home\" data-toggle=\"tab\"><i class=\"fa fa-home\"></i>Home</a></li>\r\n<li><a href=\"#profile\" data-toggle=\"tab\"><i class=\"fa fa-user\"></i>Profile</a></li>\r\n<li><a href=\"#messages\" data-toggle=\"tab\"><i class=\"fa fa-envelope\"></i>Messages</a></li>\r\n</ul>\r\n<!-- Tab panes -->\r\n<div class=\"tab-content\">\r\n<div class=\"tab-pane active\" id=\"home\">\r\n<p><strong>Home</strong> ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis, exercitationem, quaerat veniam repudiandae illo ratione eaque omnis obcaecati quidem distinctio sapiente quo assumenda amet cumque nobis nulla qui dolore autem.</p>\r\n</div>\r\n<div class=\"tab-pane\" id=\"profile\">\r\n<p><strong>Profile</strong> ipsum dolor sit amet, consectetur adipisicing elit. Ut odio facere minima porro quis. Maiores eius quibusdam et in corrupti necessitatibus consequatur debitis laudantium hic.</p>\r\n</div>\r\n<div class=\"tab-pane\" id=\"messages\">\r\n<p><strong>Messages</strong> ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis, optio error consectetur ullam porro eligendi mollitia odio numquam aut cumque. Sed, possimus recusandae itaque laboriosam nesciunt voluptates veniam aspernatur voluptate eaque ratione totam ipsa optio aliquam incidunt dolorum amet illum.</p>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;!-- Nav tabs --&gt;\r\n&lt;ul class=\"nav nav-tabs\"&gt;\r\n\r\n  &lt;li class=\"active\"&gt;&lt;a href=\"#home\" data-toggle=\"tab\"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#profile\" data-toggle=\"tab\"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href=\"#messages\" data-toggle=\"tab\"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n\r\n&lt;!-- Tab panes --&gt;\r\n&lt;div class=\"tab-content\"&gt;\r\n\r\n  &lt;div class=\"tab-pane active\" id=\"home\"&gt; ...  &lt;/div&gt;\r\n  &lt;div class=\"tab-pane\" id=\"profile\"&gt; ... &lt;/div&gt;\r\n  &lt;div class=\"tab-pane\" id=\"messages\"&gt; ... &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id=\"accordion\">Accordion</h2>\r\n<div class=\"panel-group\" id=\"accordion\">\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<h4 class=\"panel-title\">\r\n<a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseOne\"><i class=\"fa fa-home\"></i> Home</a>\r\n</h4>\r\n</div>\r\n<div id=\"collapseOne\" class=\"panel-collapse collapse in\">\r\n<div class=\"panel-body\">\r\n<strong>Home</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven\'t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<h4 class=\"panel-title\">\r\n<a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseTwo\" class=\"collapsed\"><i class=\"fa fa-cog\"></i> Configure</a>\r\n</h4>\r\n</div>\r\n<div id=\"collapseTwo\" class=\"panel-collapse collapse\">\r\n<div class=\"panel-body\">\r\n<strong>Configure</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven\'t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"panel panel-default\">\r\n<div class=\"panel-heading\">\r\n<h4 class=\"panel-title\">\r\n<a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseThree\" class=\"collapsed\"><i class=\"fa fa-cloud-download\"></i> Download</a>\r\n</h4>\r\n</div>\r\n<div id=\"collapseThree\" class=\"panel-collapse collapse\">\r\n<div class=\"panel-body\">\r\n<strong>Download</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven\'t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;div class=\"panel-group\" id=\"accordion\"&gt;\r\n\r\n  &lt;div class=\"panel panel-default\"&gt;\r\n    &lt;div class=\"panel-heading\"&gt;\r\n      &lt;h4 class=\"panel-title\"&gt;\r\n        &lt;a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseOne\"&gt;\r\n          &lt;i class=\"fa fa-home\"&gt;&lt;/i&gt; Home\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id=\"collapseOne\" class=\"panel-collapse collapse in\"&gt;\r\n      &lt;div class=\"panel-body\"&gt; ...  &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class=\"panel panel-default\"&gt;\r\n    &lt;div class=\"panel-heading\"&gt;\r\n      &lt;h4 class=\"panel-title\"&gt;\r\n        &lt;a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseTwo\"&gt;\r\n          &lt;i class=\"fa fa-cog\"&gt;&lt;/i&gt; Configure\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id=\"collapseTwo\" class=\"panel-collapse collapse\"&gt;\r\n      &lt;div class=\"panel-body\"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class=\"panel panel-default\"&gt;\r\n    &lt;div class=\"panel-heading\"&gt;\r\n      &lt;h4 class=\"panel-title\"&gt;\r\n        &lt;a data-toggle=\"collapse\" data-parent=\"#accordion\" href=\"#collapseThree\"&gt;\r\n          &lt;i class=\"fa fa-cloud-download\"&gt;&lt;/i&gt; Download\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id=\"collapseThree\" class=\"panel-collapse collapse\"&gt;\r\n      &lt;div class=\"panel-body\"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id=\"buttons\">Buttons</h2>\r\n<div>\r\n<a href=\"#\" class=\"button\">Read more</a>\r\n</div>\r\n<pre>\r\n&lt;a href=\"#\" class=\"button\"&gt;Read more&lt;/a&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id=\"progressbars\">Progress Bars</h2>\r\n<h5>40% Complete (success)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" aria-valuenow=\"40\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 40%\">\r\n<span class=\"sr-only\">40% Complete (success)</span>\r\n</div>\r\n</div>\r\n<h5>20% Complete (info)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-info\" role=\"progressbar\" aria-valuenow=\"20\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 20%\">\r\n<span class=\"sr-only\">20% Complete</span>\r\n</div>\r\n</div>\r\n<h5>60% Complete (warning)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" aria-valuenow=\"60\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 60%\">\r\n<span class=\"sr-only\">60% Complete (warning)</span>\r\n</div>\r\n</div>\r\n<h5>80% Complete (danger)</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" aria-valuenow=\"80\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 80%\">\r\n<span class=\"sr-only\">80% Complete</span>\r\n</div>\r\n</div>\r\n<h5>Results</h5>\r\n<div class=\"progress\">\r\n<div class=\"progress-bar progress-bar-success\" style=\"width: 40%\">\r\n<span class=\"sr-only\">35% A</span>\r\n</div>\r\n<div class=\"progress-bar progress-bar-info\" style=\"width: 30%\">\r\n<span class=\"sr-only\">20% B</span>\r\n</div>\r\n<div class=\"progress-bar progress-bar-warning\" style=\"width: 20%\">\r\n<span class=\"sr-only\">20% C</span>\r\n</div>\r\n<div class=\"progress-bar progress-bar-danger\" style=\"width: 10%\">\r\n<span class=\"sr-only\">10% D</span>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;h5>40% Complete (success)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-success\" role=\"progressbar\" aria-valuenow=\"40\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 40%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;40% Complete (success)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;20% Complete (info)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-info\" role=\"progressbar\" aria-valuenow=\"20\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 20%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;20% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;60% Complete (warning)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" aria-valuenow=\"60\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 60%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;60% Complete (warning)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;80% Complete (danger)&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" aria-valuenow=\"80\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 80%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;80% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;Results&lt;/h5&gt;\r\n&lt;div class=\"progress\"&gt;\r\n  &lt;div class=\"progress-bar progress-bar-success\" style=\"width: 40%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;35% A&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class=\"progress-bar progress-bar-info\" style=\"width: 30%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;20% B&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class=\"progress-bar progress-bar-warning\" style=\"width: 20%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;20% C&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class=\"progress-bar progress-bar-danger\" style=\"width: 10%\"&gt;\r\n    &lt;span class=\"sr-only\"&gt;10% D&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<div class=\"alert alert-info\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>Check all available Font Awesome icons at <a  target=\"_blank\" href=\"http://fortawesome.github.io/Font-Awesome/icons/\" class=\"alert-link\">http://fortawesome.github.io/Font-Awesome/icons/</a></div>','Shortcodes phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.','full_html'),('node','page',0,16,16,'und',0,'<h2>Columns</h2>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-6\"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-6\"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>','<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>','full_html'),('node','page',0,17,17,'und',0,'<h2>Columns</h2>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-6\"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-6\"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-8\"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-4\"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-8\"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-4\"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class=\"row\">\r\n<div class=\"col-md-9\"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class=\"col-md-3\"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style=\"margin-bottom:40px;\">\r\n&lt;div class=\"row\"&gt;\r\n\r\n&lt;div class=\"col-md-9\"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class=\"col-md-3\"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>','<div class=\"row\">\r\n<div class=\"col-md-6\">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class=\"col-md-6\"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>','full_html'),('node','mt_product',0,18,18,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,19,19,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','filtered_html'),('node','mt_product',0,20,20,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>    \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,21,21,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,22,22,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>','','full_html'),('node','mt_product',0,23,23,'und',0,'<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise. Appropriately communicate adaptive imperatives rather than value-added <a href=\"#\">with competitive technologies</a> potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>  \r\n<blockquote>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies. Appropriately communicate adaptive imperatives rather than value-added potentialities.</blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise <a href=\"#\">with competitive technologies</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing whereas state of the art interfaces. Quickly enable prospective technology rather than open-source technologies.</p>\r\n<h3>Reprehenderit in voluptate velit</h3>\r\n<ul class=\"list\">\r\n	<li><strong>Chapter 1</strong> - Lorem ipsum dolor sit amet</li>\r\n	<li><strong>Chapter 2</strong> - Praesent luctus fermentum tincidunt</li>\r\n	<li><strong>Chapter 3</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 4</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 5</strong> - Morbi venenatis, ligula ut tincidunt</li>\r\n	<li><strong>Chapter 6</strong> - Duis vitae odio ac ante faucibus faucibus</li>\r\n	<li><strong>Chapter 7</strong> - Lorem ipsum dolor sit amet</li>	\r\n</ul>\r\n<h3>Lorem ipsum dolor sit amed consetatur</h3>\r\n<p>Compellingly <a href=\"#\">recaptiualize enterprise-wide web-readiness</a> for robust strategic theme areas. Synergistically reconceptualize user-centric functionalities via revolutionary strategic theme areas. Progressively transition out-of-the-box leadership skills rather than top-line and <a href=\"#\">this is a hover link</a>.</p>\r\n','','full_html');
/*!40000 ALTER TABLE `field_revision_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_comment_body`
--

DROP TABLE IF EXISTS `field_revision_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_comment_body`
--

LOCK TABLES `field_revision_comment_body` WRITE;
/*!40000 ALTER TABLE `field_revision_comment_body` DISABLE KEYS */;
INSERT INTO `field_revision_comment_body` VALUES ('comment','comment_node_mt_post',0,1,1,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html'),('comment','comment_node_mt_post',0,2,2,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html'),('comment','comment_node_mt_post',0,3,3,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html'),('comment','comment_node_mt_post',0,4,4,'und',0,'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.','filtered_html');
/*!40000 ALTER TABLE `field_revision_comment_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_customer_address`
--

DROP TABLE IF EXISTS `field_revision_commerce_customer_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_customer_address` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_address_country` varchar(2) DEFAULT '' COMMENT 'Two letter ISO country code of this address.',
  `commerce_customer_address_administrative_area` varchar(255) DEFAULT '' COMMENT 'The administrative area of this address. (i.e. State/Province)',
  `commerce_customer_address_sub_administrative_area` varchar(255) DEFAULT '' COMMENT 'The sub administrative area of this address.',
  `commerce_customer_address_locality` varchar(255) DEFAULT '' COMMENT 'The locality of this address. (i.e. City)',
  `commerce_customer_address_dependent_locality` varchar(255) DEFAULT '' COMMENT 'The dependent locality of this address.',
  `commerce_customer_address_postal_code` varchar(255) DEFAULT '' COMMENT 'The postal code of this address.',
  `commerce_customer_address_thoroughfare` varchar(255) DEFAULT '' COMMENT 'The thoroughfare of this address. (i.e. Street address)',
  `commerce_customer_address_premise` varchar(255) DEFAULT '' COMMENT 'The premise of this address. (i.e. Apartment / Suite number)',
  `commerce_customer_address_sub_premise` varchar(255) DEFAULT '' COMMENT 'The sub_premise of this address.',
  `commerce_customer_address_organisation_name` varchar(255) DEFAULT '' COMMENT 'Contents of a primary OrganisationName element in the xNL XML.',
  `commerce_customer_address_name_line` varchar(255) DEFAULT '' COMMENT 'Contents of a primary NameLine element in the xNL XML.',
  `commerce_customer_address_first_name` varchar(255) DEFAULT '' COMMENT 'Contents of the FirstName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_last_name` varchar(255) DEFAULT '' COMMENT 'Contents of the LastName element of a primary PersonName element in the xNL XML.',
  `commerce_customer_address_data` longtext COMMENT 'Additional data for this address.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 24 (commerce_customer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_customer_address`
--

LOCK TABLES `field_revision_commerce_customer_address` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_customer_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_customer_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_customer_billing`
--

DROP TABLE IF EXISTS `field_revision_commerce_customer_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_customer_billing` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_billing_profile_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_customer_billing_profile_id` (`commerce_customer_billing_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 27 (commerce_customer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_customer_billing`
--

LOCK TABLES `field_revision_commerce_customer_billing` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_customer_billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_customer_billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_customer_shipping`
--

DROP TABLE IF EXISTS `field_revision_commerce_customer_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_customer_shipping` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_customer_shipping_profile_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_customer_shipping_profile_id` (`commerce_customer_shipping_profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 34 (commerce_customer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_customer_shipping`
--

LOCK TABLES `field_revision_commerce_customer_shipping` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_customer_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_customer_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_display_path`
--

DROP TABLE IF EXISTS `field_revision_commerce_display_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_display_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_display_path_value` varchar(255) DEFAULT NULL,
  `commerce_display_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_display_path_format` (`commerce_display_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 31 (commerce_display...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_display_path`
--

LOCK TABLES `field_revision_commerce_display_path` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_display_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_display_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_line_items`
--

DROP TABLE IF EXISTS `field_revision_commerce_line_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_line_items` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_line_items_line_item_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_line_items_line_item_id` (`commerce_line_items_line_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 25 (commerce_line_items)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_line_items`
--

LOCK TABLES `field_revision_commerce_line_items` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_line_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_order_total`
--

DROP TABLE IF EXISTS `field_revision_commerce_order_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_order_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_order_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_order_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_order_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_order_total_currency_price` (`commerce_order_total_amount`,`commerce_order_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 26 (commerce_order_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_order_total`
--

LOCK TABLES `field_revision_commerce_order_total` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_order_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_order_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_price`
--

DROP TABLE IF EXISTS `field_revision_commerce_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_price_currency_price` (`commerce_price_amount`,`commerce_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 32 (commerce_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_price`
--

LOCK TABLES `field_revision_commerce_price` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_price` DISABLE KEYS */;
INSERT INTO `field_revision_commerce_price` VALUES ('commerce_product','product',0,1,1,'und',0,999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,2,2,'und',0,1999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,3,3,'und',0,2999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,4,4,'und',0,3999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,5,5,'und',0,4999,'USD','a:1:{s:10:\"components\";a:0:{}}'),('commerce_product','product',0,6,6,'und',0,5999,'USD','a:1:{s:10:\"components\";a:0:{}}');
/*!40000 ALTER TABLE `field_revision_commerce_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_product`
--

DROP TABLE IF EXISTS `field_revision_commerce_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_product` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_product_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_product_product_id` (`commerce_product_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 30 (commerce_product)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_product`
--

LOCK TABLES `field_revision_commerce_product` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_shipping_service`
--

DROP TABLE IF EXISTS `field_revision_commerce_shipping_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_shipping_service` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_shipping_service_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_shipping_service_value` (`commerce_shipping_service_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 33 (commerce_shipping...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_shipping_service`
--

LOCK TABLES `field_revision_commerce_shipping_service` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_shipping_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_shipping_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_stock`
--

DROP TABLE IF EXISTS `field_revision_commerce_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_stock` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_stock_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 35 (commerce_stock)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_stock`
--

LOCK TABLES `field_revision_commerce_stock` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_stock` DISABLE KEYS */;
INSERT INTO `field_revision_commerce_stock` VALUES ('commerce_product','product',0,1,1,'und',0,1000),('commerce_product','product',0,2,2,'und',0,1000),('commerce_product','product',0,3,3,'und',0,1000),('commerce_product','product',0,4,4,'und',0,1000),('commerce_product','product',0,5,5,'und',0,1000),('commerce_product','product',0,6,6,'und',0,1000);
/*!40000 ALTER TABLE `field_revision_commerce_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_total`
--

DROP TABLE IF EXISTS `field_revision_commerce_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_total` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_total_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_total_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_total_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_total_currency_price` (`commerce_total_amount`,`commerce_total_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 29 (commerce_total)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_total`
--

LOCK TABLES `field_revision_commerce_total` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_total` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_commerce_unit_price`
--

DROP TABLE IF EXISTS `field_revision_commerce_unit_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_commerce_unit_price` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `commerce_unit_price_amount` int(11) NOT NULL DEFAULT '0' COMMENT 'The price amount.',
  `commerce_unit_price_currency_code` varchar(32) NOT NULL COMMENT 'The currency code for the price.',
  `commerce_unit_price_data` longtext COMMENT 'A serialized array of additional price data.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `commerce_unit_price_currency_price` (`commerce_unit_price_amount`,`commerce_unit_price_currency_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 28 (commerce_unit_price)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_commerce_unit_price`
--

LOCK TABLES `field_revision_commerce_unit_price` WRITE;
/*!40000 ALTER TABLE `field_revision_commerce_unit_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_commerce_unit_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_image`
--

DROP TABLE IF EXISTS `field_revision_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_image`
--

LOCK TABLES `field_revision_field_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_image` DISABLE KEYS */;
INSERT INTO `field_revision_field_image` VALUES ('node','mt_post',0,1,1,'und',0,1,'','And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,1,1,'und',1,16,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',2,17,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',3,18,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',4,19,'','Title of Image',750,499),('node','mt_post',0,1,1,'und',5,20,'','Title of Image',750,499),('node','mt_post',0,2,2,'und',0,22,'','Caption competently expedite standards compliant users and leadership. ',750,499),('node','mt_post',0,3,3,'und',0,3,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,4,4,'und',0,4,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,5,5,'und',0,5,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,6,6,'und',0,6,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,7,7,'und',0,7,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,8,8,'und',0,8,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,9,9,'und',0,9,'','This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_post',0,10,10,'und',0,10,'','Caption. Competently expedite standards compliant users and leadership. ',750,499),('node','mt_post',0,11,11,'und',0,11,'','Caption. Competently expedite standards compliant users and leadership. ',750,499),('node','mt_post',0,12,12,'und',0,12,'','And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.',750,499),('node','mt_product',0,18,18,'und',0,44,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,19,19,'und',0,45,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,20,20,'und',0,46,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,21,21,'und',0,47,'','Caption competently expedite standards compliant users and leadership.',750,499),('node','mt_product',0,22,22,'und',0,48,'','Caption competently expedite standards compliant users and leadership. ',750,499),('node','mt_product',0,23,23,'und',0,49,'','Caption competently expedite standards compliant users and leadership.',750,499);
/*!40000 ALTER TABLE `field_revision_field_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_about`
--

DROP TABLE IF EXISTS `field_revision_field_mt_about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_about` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_about_value` longtext,
  `field_mt_about_summary` longtext,
  `field_mt_about_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_about_format` (`field_mt_about_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 7 (field_mt_about)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_about`
--

LOCK TABLES `field_revision_field_mt_about` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_about` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_about` VALUES ('user','user',0,1,1,'und',0,'Quickly extend top-line opportunities for leveraged bandwidth. Conveniently maximize low-risk high-yield ROI rather than cooperative synergy. Appropriately synthesize cooperative portals without backward-compatible total linkage. Seamlessly plagiarize value-added deliverables with customer directed technologies. ','','filtered_html');
/*!40000 ALTER TABLE `field_revision_field_mt_about` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_banner_image`
--

DROP TABLE IF EXISTS `field_revision_field_mt_banner_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_banner_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_banner_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_banner_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_banner_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_banner_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_banner_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_banner_image_fid` (`field_mt_banner_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 23 (field_mt_banner...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_banner_image`
--

LOCK TABLES `field_revision_field_mt_banner_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_banner_image` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_banner_image` VALUES ('node','mt_post',0,1,1,'und',0,37,'Synergistically streamline prospective content whereas turnkey web services. Efficiently formulate enabled processes with granular processes.','Slide 1 title',1170,610),('node','mt_post',0,1,1,'und',1,38,'Efficiently formulate enabled processes with granular processes.','Slide 2 title',1170,610),('node','mt_post',0,1,1,'und',2,39,'Synergistically streamline prospective content whereas turnkey web services.','Slide 3 title',1170,610),('node','mt_post',0,1,1,'und',3,40,'Efficiently formulate enabled processes with granular processes. Synergistically streamline prospective content whereas turnkey web services.','Slide 4 title',1170,610),('node','mt_post',0,1,1,'und',4,41,'Collaboratively engage value-added potentialities rather than quality innovation.','Slide 5 title',1170,610),('node','mt_post',0,1,1,'und',5,42,'Collaboratively repurpose resource-leveling scenarios via integrated functionalities','Slide 6 title',1170,610),('node','mt_post',0,1,1,'und',6,43,'','Slide 7 title',1170,610);
/*!40000 ALTER TABLE `field_revision_field_mt_banner_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_breaking`
--

DROP TABLE IF EXISTS `field_revision_field_mt_breaking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_breaking` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_breaking_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_breaking_value` (`field_mt_breaking_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 13 (field_mt_breaking)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_breaking`
--

LOCK TABLES `field_revision_field_mt_breaking` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_breaking` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_breaking` VALUES ('node','mt_post',0,1,1,'und',0,1),('node','mt_post',0,2,2,'und',0,1),('node','mt_post',0,3,3,'und',0,1),('node','mt_post',0,4,4,'und',0,0),('node','mt_post',0,5,5,'und',0,0),('node','mt_post',0,6,6,'und',0,0),('node','mt_post',0,7,7,'und',0,0),('node','mt_post',0,8,8,'und',0,0),('node','mt_post',0,9,9,'und',0,0),('node','mt_post',0,10,10,'und',0,0),('node','mt_post',0,11,11,'und',0,0),('node','mt_post',0,12,12,'und',0,0);
/*!40000 ALTER TABLE `field_revision_field_mt_breaking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_facebook`
--

DROP TABLE IF EXISTS `field_revision_field_mt_facebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_facebook` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_facebook_value` varchar(255) DEFAULT NULL,
  `field_mt_facebook_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_facebook_format` (`field_mt_facebook_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 17 (field_mt_facebook)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_facebook`
--

LOCK TABLES `field_revision_field_mt_facebook` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_facebook` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_facebook` VALUES ('user','user',0,1,1,'und',0,'https://www.facebook.com/morethan.just.themes',NULL);
/*!40000 ALTER TABLE `field_revision_field_mt_facebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_google_plus`
--

DROP TABLE IF EXISTS `field_revision_field_mt_google_plus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_google_plus` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_google_plus_value` varchar(255) DEFAULT NULL,
  `field_mt_google_plus_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_google_plus_format` (`field_mt_google_plus_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 19 (field_mt_google_plus)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_google_plus`
--

LOCK TABLES `field_revision_field_mt_google_plus` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_google_plus` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_google_plus` VALUES ('user','user',0,1,1,'und',0,'https://plus.google.com/+Morethanthemes/posts',NULL);
/*!40000 ALTER TABLE `field_revision_field_mt_google_plus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_post_categories`
--

DROP TABLE IF EXISTS `field_revision_field_mt_post_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_post_categories` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_post_categories_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_post_categories_tid` (`field_mt_post_categories_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (field_mt_post...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_post_categories`
--

LOCK TABLES `field_revision_field_mt_post_categories` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_post_categories` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_post_categories` VALUES ('node','mt_post',0,1,1,'und',0,2),('node','mt_post',0,2,2,'und',0,3),('node','mt_post',0,3,3,'und',0,5),('node','mt_post',0,4,4,'und',0,6),('node','mt_post',0,5,5,'und',0,4),('node','mt_post',0,6,6,'und',0,1),('node','mt_post',0,7,7,'und',0,2),('node','mt_post',0,8,8,'und',0,3),('node','mt_post',0,9,9,'und',0,5),('node','mt_post',0,10,10,'und',0,6),('node','mt_post',0,11,11,'und',0,4),('node','mt_post',0,12,12,'und',0,1);
/*!40000 ALTER TABLE `field_revision_field_mt_post_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_product`
--

DROP TABLE IF EXISTS `field_revision_field_mt_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_product` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_product_product_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_product_product_id` (`field_mt_product_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 36 (field_mt_product)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_product`
--

LOCK TABLES `field_revision_field_mt_product` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_product` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_product` VALUES ('node','mt_product',0,18,18,'und',0,6),('node','mt_product',0,19,19,'und',0,5),('node','mt_product',0,20,20,'und',0,4),('node','mt_product',0,21,21,'und',0,3),('node','mt_product',0,22,22,'und',0,2),('node','mt_product',0,23,23,'und',0,1);
/*!40000 ALTER TABLE `field_revision_field_mt_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_slideshow`
--

DROP TABLE IF EXISTS `field_revision_field_mt_slideshow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_slideshow` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_value` (`field_mt_slideshow_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 21 (field_mt_slideshow)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_slideshow`
--

LOCK TABLES `field_revision_field_mt_slideshow` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_slideshow` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_slideshow` VALUES ('node','mt_post',0,1,1,'und',0,1),('node','mt_post',0,2,2,'und',0,1),('node','mt_post',0,3,3,'und',0,0),('node','mt_post',0,4,4,'und',0,0),('node','mt_post',0,5,5,'und',0,0),('node','mt_post',0,6,6,'und',0,0),('node','mt_post',0,7,7,'und',0,0),('node','mt_post',0,8,8,'und',0,0),('node','mt_post',0,9,9,'und',0,0),('node','mt_post',0,10,10,'und',0,0),('node','mt_post',0,11,11,'und',0,0),('node','mt_post',0,12,12,'und',0,0),('node','mt_product',0,18,18,'und',0,0),('node','mt_product',0,19,19,'und',0,0),('node','mt_product',0,20,20,'und',0,0),('node','mt_product',0,21,21,'und',0,0),('node','mt_product',0,22,22,'und',0,0),('node','mt_product',0,23,23,'und',0,0);
/*!40000 ALTER TABLE `field_revision_field_mt_slideshow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_slideshow_path`
--

DROP TABLE IF EXISTS `field_revision_field_mt_slideshow_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_slideshow_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_path_value` varchar(255) DEFAULT NULL,
  `field_mt_slideshow_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_path_format` (`field_mt_slideshow_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 22 (field_mt_slideshow...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_slideshow_path`
--

LOCK TABLES `field_revision_field_mt_slideshow_path` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_slideshow_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_mt_slideshow_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_subheader_body`
--

DROP TABLE IF EXISTS `field_revision_field_mt_subheader_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_subheader_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_subheader_body_value` longtext,
  `field_mt_subheader_body_summary` longtext,
  `field_mt_subheader_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_subheader_body_format` (`field_mt_subheader_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 6 (field_mt_subheader...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_subheader_body`
--

LOCK TABLES `field_revision_field_mt_subheader_body` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_subheader_body` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_subheader_body` VALUES ('node','mt_post',0,1,1,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,2,2,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,3,3,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly <a href=\"#\">extend top-line opportunities for leveraged</a> bandwidth.','','filtered_html'),('node','mt_post',0,4,4,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,5,5,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,6,6,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,7,7,'und',0,'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','','filtered_html'),('node','mt_post',0,8,8,'und',0,'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','','filtered_html'),('node','mt_post',0,9,9,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,10,10,'und',0,'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.','','filtered_html'),('node','mt_post',0,11,11,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can <a href=\"#\">quickly extend top-line opportunities for leveraged bandwidth</a>. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_post',0,12,12,'und',0,'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.','','filtered_html'),('node','mt_product',0,18,18,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,19,19,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,20,20,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,21,21,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,22,22,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html'),('node','mt_product',0,23,23,'und',0,'Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.','','filtered_html');
/*!40000 ALTER TABLE `field_revision_field_mt_subheader_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_teaser_image`
--

DROP TABLE IF EXISTS `field_revision_field_mt_teaser_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_teaser_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_teaser_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_teaser_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_teaser_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_teaser_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_teaser_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_teaser_image_fid` (`field_mt_teaser_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 20 (field_mt_teaser...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_teaser_image`
--

LOCK TABLES `field_revision_field_mt_teaser_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_teaser_image` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_teaser_image` VALUES ('node','mt_post',0,1,1,'und',0,35,'','',1170,610),('node','mt_post',0,2,2,'und',0,36,'','',1170,610);
/*!40000 ALTER TABLE `field_revision_field_mt_teaser_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_mt_twitter`
--

DROP TABLE IF EXISTS `field_revision_field_mt_twitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_mt_twitter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_twitter_value` varchar(255) DEFAULT NULL,
  `field_mt_twitter_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_twitter_format` (`field_mt_twitter_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 18 (field_mt_twitter)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_mt_twitter`
--

LOCK TABLES `field_revision_field_mt_twitter` WRITE;
/*!40000 ALTER TABLE `field_revision_field_mt_twitter` DISABLE KEYS */;
INSERT INTO `field_revision_field_mt_twitter` VALUES ('user','user',0,1,1,'und',0,'https://twitter.com/morethanthemes/',NULL);
/*!40000 ALTER TABLE `field_revision_field_mt_twitter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_tags`
--

DROP TABLE IF EXISTS `field_revision_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_tags`
--

LOCK TABLES `field_revision_field_tags` WRITE;
/*!40000 ALTER TABLE `field_revision_field_tags` DISABLE KEYS */;
INSERT INTO `field_revision_field_tags` VALUES ('node','mt_post',0,1,1,'und',0,7),('node','mt_post',0,1,1,'und',1,8),('node','mt_post',0,1,1,'und',2,9),('node','mt_post',0,2,2,'und',0,7),('node','mt_post',0,2,2,'und',1,8),('node','mt_post',0,2,2,'und',2,9),('node','mt_post',0,3,3,'und',0,7),('node','mt_post',0,3,3,'und',1,9),('node','mt_post',0,4,4,'und',0,7),('node','mt_post',0,4,4,'und',1,10),('node','mt_post',0,4,4,'und',2,11),('node','mt_post',0,5,5,'und',0,8),('node','mt_post',0,5,5,'und',1,9),('node','mt_post',0,5,5,'und',2,10),('node','mt_post',0,6,6,'und',0,7),('node','mt_post',0,6,6,'und',1,8),('node','mt_post',0,6,6,'und',2,11),('node','mt_post',0,7,7,'und',0,7),('node','mt_post',0,7,7,'und',1,8),('node','mt_post',0,7,7,'und',2,9),('node','mt_post',0,7,7,'und',3,10),('node','mt_post',0,8,8,'und',0,10),('node','mt_post',0,8,8,'und',1,11),('node','mt_post',0,9,9,'und',0,8),('node','mt_post',0,9,9,'und',1,9),('node','mt_post',0,9,9,'und',2,10),('node','mt_post',0,9,9,'und',3,11),('node','mt_post',0,10,10,'und',0,7),('node','mt_post',0,10,10,'und',1,10),('node','mt_post',0,10,10,'und',2,11),('node','mt_post',0,11,11,'und',0,8),('node','mt_post',0,11,11,'und',1,9),('node','mt_post',0,11,11,'und',2,11),('node','mt_post',0,12,12,'und',0,7),('node','mt_post',0,12,12,'und',1,8),('node','mt_post',0,12,12,'und',2,9),('node','mt_post',0,12,12,'und',3,10),('node','mt_post',0,12,12,'und',4,11);
/*!40000 ALTER TABLE `field_revision_field_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_managed`
--

LOCK TABLES `file_managed` WRITE;
/*!40000 ALTER TABLE `file_managed` DISABLE KEYS */;
INSERT INTO `file_managed` VALUES (1,1,'post-1.jpg','public://post-1.jpg','image/jpeg',9878,1,1400661966),(3,1,'post-3.jpg','public://post-3.jpg','image/jpeg',9878,1,1400662489),(4,1,'post-4.jpg','public://post-4.jpg','image/jpeg',9878,1,1400662688),(5,1,'post-5.jpg','public://post-5.jpg','image/jpeg',9878,1,1400662828),(6,1,'post-6.jpg','public://post-6.jpg','image/jpeg',9878,1,1400662950),(7,1,'post-7.jpg','public://post-7.jpg','image/jpeg',9878,1,1400663182),(8,1,'post-8.jpg','public://post-8.jpg','image/jpeg',9878,1,1400663373),(9,1,'post-9.jpg','public://post-9.jpg','image/jpeg',9878,1,1400663471),(10,1,'post-10.jpg','public://post-10.jpg','image/jpeg',9878,1,1400663582),(11,1,'post-11.jpg','public://post-11.jpg','image/jpeg',9878,1,1400663706),(12,1,'post-12.jpg','public://post-12.jpg','image/jpeg',9878,1,1400663842),(16,1,'post-1-1.jpg','public://post-1-1.jpg','image/jpeg',9878,1,1401439326),(17,1,'post-1-2.jpg','public://post-1-2.jpg','image/jpeg',9878,1,1401439326),(18,1,'post-1-3.jpg','public://post-1-3.jpg','image/jpeg',9878,1,1401439326),(19,1,'post-1-4.jpg','public://post-1-4.jpg','image/jpeg',9878,1,1401439326),(20,1,'post-1-5.jpg','public://post-1-5.jpg','image/jpeg',9878,1,1401439326),(22,1,'post-2.jpg','public://post-2.jpg','image/jpeg',9878,1,1401457831),(35,1,'slide-1.png','public://slide-1.png','image/png',7127,1,1403010554),(36,1,'slide-2.png','public://slide-2.png','image/png',7127,1,1403010662),(37,1,'post-1-banner-1.png','public://post-1-banner-1.png','image/png',7127,1,1403012190),(38,1,'post-1-banner-2.png','public://post-1-banner-2.png','image/png',7127,1,1403012190),(39,1,'post-1-banner-3.png','public://post-1-banner-3.png','image/png',7127,1,1403012190),(40,1,'post-1-banner-4.png','public://post-1-banner-4.png','image/png',7127,1,1403012190),(41,1,'post-1-banner-5.png','public://post-1-banner-5.png','image/png',7127,1,1403012190),(42,1,'post-1-banner-6.png','public://post-1-banner-6.png','image/png',7127,1,1403012190),(43,1,'post-1-banner-7.png','public://post-1-banner-7.png','image/png',7127,1,1403012190),(44,1,'product-6.jpg','public://product-6.jpg','image/jpeg',9878,1,1403541527),(45,1,'product-5.jpg','public://product-5.jpg','image/jpeg',9878,1,1403543007),(46,1,'product-4.jpg','public://product-4.jpg','image/jpeg',9878,1,1403543127),(47,1,'product-3.jpg','public://product-3.jpg','image/jpeg',9878,1,1403543198),(48,1,'product-2.jpg','public://product-2.jpg','image/jpeg',9878,1,1403543395),(49,1,'product-1.jpg','public://product-1.jpg','image/jpeg',9878,1,1403543450);
/*!40000 ALTER TABLE `file_managed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_usage`
--

LOCK TABLES `file_usage` WRITE;
/*!40000 ALTER TABLE `file_usage` DISABLE KEYS */;
INSERT INTO `file_usage` VALUES (1,'file','node',1,1),(3,'file','node',3,1),(4,'file','node',4,1),(5,'file','node',5,1),(6,'file','node',6,1),(7,'file','node',7,1),(8,'file','node',8,1),(9,'file','node',9,1),(10,'file','node',10,1),(11,'file','node',11,1),(12,'file','node',12,1),(16,'file','node',1,1),(17,'file','node',1,1),(18,'file','node',1,1),(19,'file','node',1,1),(20,'file','node',1,1),(22,'file','node',2,1),(35,'file','node',1,1),(36,'file','node',2,1),(37,'file','node',1,1),(38,'file','node',1,1),(39,'file','node',1,1),(40,'file','node',1,1),(41,'file','node',1,1),(42,'file','node',1,1),(43,'file','node',1,1),(44,'file','node',18,1),(45,'file','node',19,1),(46,'file','node',20,1),(47,'file','node',21,1),(48,'file','node',22,1),(49,'file','node',23,1);
/*!40000 ALTER TABLE `file_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter`
--

LOCK TABLES `filter` WRITE;
/*!40000 ALTER TABLE `filter` DISABLE KEYS */;
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_autop',2,1,'a:0:{}'),('filtered_html','filter','filter_html',1,1,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('filtered_html','filter','filter_htmlcorrector',10,1,'a:0:{}'),('filtered_html','filter','filter_html_escape',-10,0,'a:0:{}'),('filtered_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";i:72;}'),('full_html','filter','filter_autop',1,1,'a:0:{}'),('full_html','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('full_html','filter','filter_htmlcorrector',10,1,'a:0:{}'),('full_html','filter','filter_html_escape',-10,0,'a:0:{}'),('full_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";i:72;}'),('php_code','filter','filter_autop',0,0,'a:0:{}'),('php_code','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('php_code','filter','filter_htmlcorrector',10,0,'a:0:{}'),('php_code','filter','filter_html_escape',-10,0,'a:0:{}'),('php_code','filter','filter_url',0,0,'a:1:{s:17:\"filter_url_length\";i:72;}'),('php_code','php','php_code',0,1,'a:0:{}'),('plain_text','filter','filter_autop',2,1,'a:0:{}'),('plain_text','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('plain_text','filter','filter_htmlcorrector',10,0,'a:0:{}'),('plain_text','filter','filter_html_escape',0,1,'a:0:{}'),('plain_text','filter','filter_url',1,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
/*!40000 ALTER TABLE `filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_format`
--

LOCK TABLES `filter_format` WRITE;
/*!40000 ALTER TABLE `filter_format` DISABLE KEYS */;
INSERT INTO `filter_format` VALUES ('filtered_html','Filtered HTML',1,1,0),('full_html','Full HTML',1,1,1),('php_code','PHP code',0,1,11),('plain_text','Plain text',1,1,10);
/*!40000 ALTER TABLE `filter_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_effects`
--

LOCK TABLES `image_effects` WRITE;
/*!40000 ALTER TABLE `image_effects` DISABLE KEYS */;
INSERT INTO `image_effects` VALUES (2,1,1,'image_scale_and_crop','a:2:{s:5:\"width\";s:3:\"750\";s:6:\"height\";s:3:\"499\";}'),(3,2,1,'image_scale_and_crop','a:2:{s:5:\"width\";s:4:\"1170\";s:6:\"height\";s:3:\"610\";}'),(4,3,1,'image_scale_and_crop','a:2:{s:5:\"width\";s:3:\"230\";s:6:\"height\";s:3:\"153\";}'),(6,4,1,'image_scale_and_crop','a:2:{s:5:\"width\";s:3:\"480\";s:6:\"height\";s:3:\"319\";}');
/*!40000 ALTER TABLE `image_effects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_styles`
--

LOCK TABLES `image_styles` WRITE;
/*!40000 ALTER TABLE `image_styles` DISABLE KEYS */;
INSERT INTO `image_styles` VALUES (1,'large','Large (750x499)'),(2,'mt_slideshow','Slideshow (1170x610)'),(3,'mt_thumbnails','Thumbnails (230x153)'),(4,'medium','Medium (480x319)');
/*!40000 ALTER TABLE `image_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_custom`
--

LOCK TABLES `menu_custom` WRITE;
/*!40000 ALTER TABLE `menu_custom` DISABLE KEYS */;
INSERT INTO `menu_custom` VALUES ('main-menu','Main menu','The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),('management','Management','The <em>Management</em> menu contains links for administrative tasks.'),('menu-secondary-menu','Secondary menu','Secondary menu'),('menu-sidebar-menu','Sidebar Menu','Sidebar Menu'),('menu-subfooter-menu','Subfooter menu','Subfooter menu'),('navigation','Navigation','The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),('user-menu','User menu','The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');
/*!40000 ALTER TABLE `menu_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=1013 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_links`
--

LOCK TABLES `menu_links` WRITE;
/*!40000 ALTER TABLE `menu_links` DISABLE KEYS */;
INSERT INTO `menu_links` VALUES ('management',1,0,'admin','admin','Administration','a:0:{}','system',0,0,1,0,9,1,0,1,0,0,0,0,0,0,0,0,0),('user-menu',2,0,'user','user','User account','a:1:{s:5:\"alter\";b:1;}','system',0,0,0,0,-10,1,0,2,0,0,0,0,0,0,0,0,0),('navigation',4,0,'filter/tips','filter/tips','Compose tips','a:0:{}','system',1,0,1,0,0,1,0,4,0,0,0,0,0,0,0,0,0),('navigation',5,0,'node/%','node/%','','a:0:{}','system',0,0,0,0,0,1,0,5,0,0,0,0,0,0,0,0,0),('navigation',6,0,'node/add','node/add','Add content','a:0:{}','system',0,0,1,0,0,1,0,6,0,0,0,0,0,0,0,0,0),('management',7,1,'admin/appearance','admin/appearance','Appearance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Select and configure your themes.\";}}','system',0,0,0,0,-6,2,0,1,7,0,0,0,0,0,0,0,0),('management',8,1,'admin/config','admin/config','Configuration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:20:\"Administer settings.\";}}','system',0,0,1,0,0,2,0,1,8,0,0,0,0,0,0,0,0),('management',9,1,'admin/content','admin/content','Content','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Administer content and comments.\";}}','system',0,0,1,0,-10,2,0,1,9,0,0,0,0,0,0,0,0),('user-menu',10,2,'user/register','user/register','Create new account','a:0:{}','system',-1,0,0,0,0,2,0,2,10,0,0,0,0,0,0,0,0),('management',11,1,'admin/dashboard','admin/dashboard','Dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View and customize your dashboard.\";}}','system',0,0,0,0,-15,2,0,1,11,0,0,0,0,0,0,0,0),('management',12,1,'admin/help','admin/help','Help','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Reference for usage, configuration, and modules.\";}}','system',0,0,0,0,9,2,0,1,12,0,0,0,0,0,0,0,0),('management',13,1,'admin/index','admin/index','Index','a:0:{}','system',-1,0,0,0,-18,2,0,1,13,0,0,0,0,0,0,0,0),('user-menu',14,2,'user/login','user/login','Log in','a:0:{}','system',-1,0,0,0,0,2,0,2,14,0,0,0,0,0,0,0,0),('user-menu',15,0,'user/logout','user/logout','Log out','a:0:{}','system',0,0,0,0,10,1,0,15,0,0,0,0,0,0,0,0,0),('management',16,1,'admin/modules','admin/modules','Modules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:26:\"Extend site functionality.\";}}','system',0,0,0,0,-2,2,0,1,16,0,0,0,0,0,0,0,0),('navigation',17,0,'user/%','user/%','My account','a:0:{}','system',0,0,1,0,0,1,0,17,0,0,0,0,0,0,0,0,0),('management',18,1,'admin/people','admin/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage user accounts, roles, and permissions.\";}}','system',0,0,0,0,-4,2,0,1,18,0,0,0,0,0,0,0,0),('management',19,1,'admin/reports','admin/reports','Reports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View reports, updates, and errors.\";}}','system',0,0,1,0,5,2,0,1,19,0,0,0,0,0,0,0,0),('user-menu',20,2,'user/password','user/password','Request new password','a:0:{}','system',-1,0,0,0,0,2,0,2,20,0,0,0,0,0,0,0,0),('management',21,1,'admin/structure','admin/structure','Structure','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Administer blocks, content types, menus, etc.\";}}','system',0,0,1,0,-8,2,0,1,21,0,0,0,0,0,0,0,0),('management',22,1,'admin/tasks','admin/tasks','Tasks','a:0:{}','system',-1,0,0,0,-20,2,0,1,22,0,0,0,0,0,0,0,0),('navigation',27,0,'taxonomy/term/%','taxonomy/term/%','Taxonomy term','a:0:{}','system',0,0,0,0,0,1,0,27,0,0,0,0,0,0,0,0,0),('management',29,18,'admin/people/create','admin/people/create','Add user','a:0:{}','system',-1,0,0,0,0,3,0,1,18,29,0,0,0,0,0,0,0),('management',30,21,'admin/structure/block','admin/structure/block','Blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:79:\"Configure what block content appears in your site\'s sidebars and other regions.\";}}','system',0,0,1,0,0,3,0,1,21,30,0,0,0,0,0,0,0),('navigation',31,17,'user/%/cancel','user/%/cancel','Cancel account','a:0:{}','system',0,0,1,0,0,2,0,17,31,0,0,0,0,0,0,0,0),('management',33,11,'admin/dashboard/configure','admin/dashboard/configure','Configure available dashboard blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure which blocks can be shown on the dashboard.\";}}','system',-1,0,0,0,0,3,0,1,11,33,0,0,0,0,0,0,0),('management',34,9,'admin/content/node','admin/content/node','Content','a:0:{}','system',-1,0,0,0,-10,3,0,1,9,34,0,0,0,0,0,0,0),('management',35,8,'admin/config/content','admin/config/content','Content authoring','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings related to formatting and authoring content.\";}}','system',0,0,1,0,-15,3,0,1,8,35,0,0,0,0,0,0,0),('management',36,21,'admin/structure/types','admin/structure/types','Content types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Manage content types, including default status, front page promotion, comment settings, etc.\";}}','system',0,0,1,0,0,3,0,1,21,36,0,0,0,0,0,0,0),('management',37,11,'admin/dashboard/customize','admin/dashboard/customize','Customize dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Customize your dashboard.\";}}','system',-1,0,0,0,0,3,0,1,11,37,0,0,0,0,0,0,0),('navigation',38,5,'node/%/delete','node/%/delete','Delete','a:0:{}','system',-1,0,0,0,1,2,0,5,38,0,0,0,0,0,0,0,0),('management',39,8,'admin/config/development','admin/config/development','Development','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Development tools.\";}}','system',0,0,1,0,-10,3,0,1,8,39,0,0,0,0,0,0,0),('navigation',40,17,'user/%/edit','user/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,17,40,0,0,0,0,0,0,0,0),('navigation',41,5,'node/%/edit','node/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,5,41,0,0,0,0,0,0,0,0),('management',42,19,'admin/reports/fields','admin/reports/fields','Field list','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Overview of fields on all entity types.\";}}','system',0,0,0,0,0,3,0,1,19,42,0,0,0,0,0,0,0),('management',43,7,'admin/appearance/list','admin/appearance/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Select and configure your theme\";}}','system',-1,0,0,0,-1,3,0,1,7,43,0,0,0,0,0,0,0),('management',44,16,'admin/modules/list','admin/modules/list','List','a:0:{}','system',-1,0,0,0,0,3,0,1,16,44,0,0,0,0,0,0,0),('management',45,18,'admin/people/people','admin/people/people','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Find and manage people interacting with your site.\";}}','system',-1,0,0,0,-10,3,0,1,18,45,0,0,0,0,0,0,0),('management',46,8,'admin/config/media','admin/config/media','Media','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:12:\"Media tools.\";}}','system',0,0,1,0,-10,3,0,1,8,46,0,0,0,0,0,0,0),('management',47,21,'admin/structure/menu','admin/structure/menu','Menus','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"Add new menus to your site, edit existing menus, and rename and reorganize menu links.\";}}','system',0,0,1,0,0,3,0,1,21,47,0,0,0,0,0,0,0),('management',48,8,'admin/config/people','admin/config/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configure user accounts.\";}}','system',0,0,1,0,-20,3,0,1,8,48,0,0,0,0,0,0,0),('management',49,18,'admin/people/permissions','admin/people/permissions','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,0,3,0,1,18,49,0,0,0,0,0,0,0),('management',50,19,'admin/reports/dblog','admin/reports/dblog','Recent log messages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View events that have recently been logged.\";}}','system',0,0,0,0,-1,3,0,1,19,50,0,0,0,0,0,0,0),('management',51,8,'admin/config/regional','admin/config/regional','Regional and language','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Regional settings, localization and translation.\";}}','system',0,0,1,0,-5,3,0,1,8,51,0,0,0,0,0,0,0),('navigation',52,5,'node/%/revisions','node/%/revisions','Revisions','a:0:{}','system',-1,0,1,0,2,2,0,5,52,0,0,0,0,0,0,0,0),('management',53,8,'admin/config/search','admin/config/search','Search and metadata','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Local site search, metadata and SEO.\";}}','system',0,0,1,0,-10,3,0,1,8,53,0,0,0,0,0,0,0),('management',54,7,'admin/appearance/settings','admin/appearance/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Configure default and theme specific settings.\";}}','system',-1,0,0,0,20,3,0,1,7,54,0,0,0,0,0,0,0),('management',55,19,'admin/reports/status','admin/reports/status','Status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Get a status report about your site\'s operation and any detected problems.\";}}','system',0,0,0,0,-60,3,0,1,19,55,0,0,0,0,0,0,0),('management',56,8,'admin/config/system','admin/config/system','System','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"General system related configuration.\";}}','system',0,0,1,0,-20,3,0,1,8,56,0,0,0,0,0,0,0),('management',57,21,'admin/structure/taxonomy','admin/structure/taxonomy','Taxonomy','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Manage tagging, categorization, and classification of your content.\";}}','system',0,0,1,0,0,3,0,1,21,57,0,0,0,0,0,0,0),('management',58,19,'admin/reports/access-denied','admin/reports/access-denied','Top \'access denied\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"View \'access denied\' errors (403s).\";}}','system',0,0,0,0,0,3,0,1,19,58,0,0,0,0,0,0,0),('management',59,19,'admin/reports/page-not-found','admin/reports/page-not-found','Top \'page not found\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View \'page not found\' errors (404s).\";}}','system',0,0,0,0,0,3,0,1,19,59,0,0,0,0,0,0,0),('management',60,16,'admin/modules/uninstall','admin/modules/uninstall','Uninstall','a:0:{}','system',-1,0,0,0,20,3,0,1,16,60,0,0,0,0,0,0,0),('management',61,8,'admin/config/user-interface','admin/config/user-interface','User interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Tools that enhance the user interface.\";}}','system',0,0,1,0,-15,3,0,1,8,61,0,0,0,0,0,0,0),('navigation',62,5,'node/%/view','node/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,5,62,0,0,0,0,0,0,0,0),('navigation',63,17,'user/%/view','user/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,17,63,0,0,0,0,0,0,0,0),('management',64,8,'admin/config/services','admin/config/services','Web services','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Tools related to web services.\";}}','system',0,0,1,0,0,3,0,1,8,64,0,0,0,0,0,0,0),('management',65,8,'admin/config/workflow','admin/config/workflow','Workflow','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Content workflow, editorial workflow tools.\";}}','system',0,0,1,0,5,3,0,1,8,65,0,0,0,0,0,0,0),('management',66,12,'admin/help/block','admin/help/block','block','a:0:{}','system',-1,0,0,0,0,3,0,1,12,66,0,0,0,0,0,0,0),('management',67,12,'admin/help/color','admin/help/color','color','a:0:{}','system',-1,0,0,0,0,3,0,1,12,67,0,0,0,0,0,0,0),('management',69,12,'admin/help/contextual','admin/help/contextual','contextual','a:0:{}','system',-1,0,0,0,0,3,0,1,12,69,0,0,0,0,0,0,0),('management',70,12,'admin/help/dashboard','admin/help/dashboard','dashboard','a:0:{}','system',-1,0,0,0,0,3,0,1,12,70,0,0,0,0,0,0,0),('management',71,12,'admin/help/dblog','admin/help/dblog','dblog','a:0:{}','system',-1,0,0,0,0,3,0,1,12,71,0,0,0,0,0,0,0),('management',72,12,'admin/help/field','admin/help/field','field','a:0:{}','system',-1,0,0,0,0,3,0,1,12,72,0,0,0,0,0,0,0),('management',73,12,'admin/help/field_sql_storage','admin/help/field_sql_storage','field_sql_storage','a:0:{}','system',-1,0,0,0,0,3,0,1,12,73,0,0,0,0,0,0,0),('management',74,12,'admin/help/field_ui','admin/help/field_ui','field_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,74,0,0,0,0,0,0,0),('management',75,12,'admin/help/file','admin/help/file','file','a:0:{}','system',-1,0,0,0,0,3,0,1,12,75,0,0,0,0,0,0,0),('management',76,12,'admin/help/filter','admin/help/filter','filter','a:0:{}','system',-1,0,0,0,0,3,0,1,12,76,0,0,0,0,0,0,0),('management',77,12,'admin/help/help','admin/help/help','help','a:0:{}','system',-1,0,0,0,0,3,0,1,12,77,0,0,0,0,0,0,0),('management',78,12,'admin/help/image','admin/help/image','image','a:0:{}','system',-1,0,0,0,0,3,0,1,12,78,0,0,0,0,0,0,0),('management',79,12,'admin/help/list','admin/help/list','list','a:0:{}','system',-1,0,0,0,0,3,0,1,12,79,0,0,0,0,0,0,0),('management',80,12,'admin/help/menu','admin/help/menu','menu','a:0:{}','system',-1,0,0,0,0,3,0,1,12,80,0,0,0,0,0,0,0),('management',81,12,'admin/help/node','admin/help/node','node','a:0:{}','system',-1,0,0,0,0,3,0,1,12,81,0,0,0,0,0,0,0),('management',82,12,'admin/help/options','admin/help/options','options','a:0:{}','system',-1,0,0,0,0,3,0,1,12,82,0,0,0,0,0,0,0),('management',83,12,'admin/help/system','admin/help/system','system','a:0:{}','system',-1,0,0,0,0,3,0,1,12,83,0,0,0,0,0,0,0),('management',84,12,'admin/help/taxonomy','admin/help/taxonomy','taxonomy','a:0:{}','system',-1,0,0,0,0,3,0,1,12,84,0,0,0,0,0,0,0),('management',85,12,'admin/help/text','admin/help/text','text','a:0:{}','system',-1,0,0,0,0,3,0,1,12,85,0,0,0,0,0,0,0),('management',86,12,'admin/help/user','admin/help/user','user','a:0:{}','system',-1,0,0,0,0,3,0,1,12,86,0,0,0,0,0,0,0),('navigation',87,27,'taxonomy/term/%/edit','taxonomy/term/%/edit','Edit','a:0:{}','system',-1,0,0,0,10,2,0,27,87,0,0,0,0,0,0,0,0),('navigation',88,27,'taxonomy/term/%/view','taxonomy/term/%/view','View','a:0:{}','system',-1,0,0,0,0,2,0,27,88,0,0,0,0,0,0,0,0),('management',89,57,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','','a:0:{}','system',0,0,0,0,0,4,0,1,21,57,89,0,0,0,0,0,0),('management',90,48,'admin/config/people/accounts','admin/config/people/accounts','Account settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:109:\"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.\";}}','system',0,0,0,0,-10,4,0,1,8,48,90,0,0,0,0,0,0),('management',91,56,'admin/config/system/actions','admin/config/system/actions','Actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',0,0,1,0,0,4,0,1,8,56,91,0,0,0,0,0,0),('management',92,30,'admin/structure/block/add','admin/structure/block/add','Add block','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,92,0,0,0,0,0,0),('management',93,36,'admin/structure/types/add','admin/structure/types/add','Add content type','a:0:{}','system',-1,0,0,0,0,4,0,1,21,36,93,0,0,0,0,0,0),('management',94,47,'admin/structure/menu/add','admin/structure/menu/add','Add menu','a:0:{}','system',-1,0,0,0,0,4,0,1,21,47,94,0,0,0,0,0,0),('management',95,57,'admin/structure/taxonomy/add','admin/structure/taxonomy/add','Add vocabulary','a:0:{}','system',-1,0,0,0,0,4,0,1,21,57,95,0,0,0,0,0,0),('management',96,54,'admin/appearance/settings/bartik','admin/appearance/settings/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,96,0,0,0,0,0,0),('management',97,53,'admin/config/search/clean-urls','admin/config/search/clean-urls','Clean URLs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Enable or disable clean URLs for your site.\";}}','system',0,0,0,0,5,4,0,1,8,53,97,0,0,0,0,0,0),('management',98,56,'admin/config/system/cron','admin/config/system/cron','Cron','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:40:\"Manage automatic site maintenance tasks.\";}}','system',0,0,0,0,20,4,0,1,8,56,98,0,0,0,0,0,0),('management',99,51,'admin/config/regional/date-time','admin/config/regional/date-time','Date and time','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',0,0,0,0,-15,4,0,1,8,51,99,0,0,0,0,0,0),('management',100,19,'admin/reports/event/%','admin/reports/event/%','Details','a:0:{}','system',0,0,0,0,0,3,0,1,19,100,0,0,0,0,0,0,0),('management',101,46,'admin/config/media/file-system','admin/config/media/file-system','File system','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Tell Drupal where to store uploaded files and how they are accessed.\";}}','system',0,0,0,0,-10,4,0,1,8,46,101,0,0,0,0,0,0),('management',102,54,'admin/appearance/settings/garland','admin/appearance/settings/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,102,0,0,0,0,0,0),('management',103,54,'admin/appearance/settings/global','admin/appearance/settings/global','Global settings','a:0:{}','system',-1,0,0,0,-1,4,0,1,7,54,103,0,0,0,0,0,0),('management',104,48,'admin/config/people/ip-blocking','admin/config/people/ip-blocking','IP address blocking','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Manage blocked IP addresses.\";}}','system',0,0,1,0,10,4,0,1,8,48,104,0,0,0,0,0,0),('management',105,46,'admin/config/media/image-styles','admin/config/media/image-styles','Image styles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:78:\"Configure styles that can be used for resizing or adjusting images on display.\";}}','system',0,0,1,0,0,4,0,1,8,46,105,0,0,0,0,0,0),('management',106,46,'admin/config/media/image-toolkit','admin/config/media/image-toolkit','Image toolkit','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Choose which image toolkit to use if you have installed optional toolkits.\";}}','system',0,0,0,0,20,4,0,1,8,46,106,0,0,0,0,0,0),('management',107,44,'admin/modules/list/confirm','admin/modules/list/confirm','List','a:0:{}','system',-1,0,0,0,0,4,0,1,16,44,107,0,0,0,0,0,0),('management',108,36,'admin/structure/types/list','admin/structure/types/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,36,108,0,0,0,0,0,0),('management',109,57,'admin/structure/taxonomy/list','admin/structure/taxonomy/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,57,109,0,0,0,0,0,0),('management',110,47,'admin/structure/menu/list','admin/structure/menu/list','List menus','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,47,110,0,0,0,0,0,0),('management',111,39,'admin/config/development/logging','admin/config/development/logging','Logging and errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.\";}}','system',0,0,0,0,-15,4,0,1,8,39,111,0,0,0,0,0,0),('management',112,39,'admin/config/development/maintenance','admin/config/development/maintenance','Maintenance mode','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Take the site offline for maintenance or bring it back online.\";}}','system',0,0,0,0,-10,4,0,1,8,39,112,0,0,0,0,0,0),('management',113,39,'admin/config/development/performance','admin/config/development/performance','Performance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:101:\"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.\";}}','system',0,0,0,0,-20,4,0,1,8,39,113,0,0,0,0,0,0),('management',114,49,'admin/people/permissions/list','admin/people/permissions/list','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,-8,4,0,1,18,49,114,0,0,0,0,0,0),('management',116,64,'admin/config/services/rss-publishing','admin/config/services/rss-publishing','RSS publishing','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:114:\"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.\";}}','system',0,0,0,0,0,4,0,1,8,64,116,0,0,0,0,0,0),('management',117,51,'admin/config/regional/settings','admin/config/regional/settings','Regional settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"Settings for the site\'s default time zone and country.\";}}','system',0,0,0,0,-20,4,0,1,8,51,117,0,0,0,0,0,0),('management',118,49,'admin/people/permissions/roles','admin/people/permissions/roles','Roles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"List, edit, or add user roles.\";}}','system',-1,0,1,0,-5,4,0,1,18,49,118,0,0,0,0,0,0),('management',119,47,'admin/structure/menu/settings','admin/structure/menu/settings','Settings','a:0:{}','system',-1,0,0,0,5,4,0,1,21,47,119,0,0,0,0,0,0),('management',120,54,'admin/appearance/settings/seven','admin/appearance/settings/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,120,0,0,0,0,0,0),('management',121,56,'admin/config/system/site-information','admin/config/system/site-information','Site information','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:104:\"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.\";}}','system',0,0,0,0,-20,4,0,1,8,56,121,0,0,0,0,0,0),('management',122,54,'admin/appearance/settings/stark','admin/appearance/settings/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,122,0,0,0,0,0,0),('management',123,35,'admin/config/content/formats','admin/config/content/formats','Text formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:127:\"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.\";}}','system',0,0,1,0,0,4,0,1,8,35,123,0,0,0,0,0,0),('management',125,60,'admin/modules/uninstall/confirm','admin/modules/uninstall/confirm','Uninstall','a:0:{}','system',-1,0,0,0,0,4,0,1,16,60,125,0,0,0,0,0,0),('navigation',126,40,'user/%/edit/account','user/%/edit/account','Account','a:0:{}','system',-1,0,0,0,0,3,0,17,40,126,0,0,0,0,0,0,0),('management',127,123,'admin/config/content/formats/%','admin/config/content/formats/%','','a:0:{}','system',0,0,1,0,0,5,0,1,8,35,123,127,0,0,0,0,0),('management',128,105,'admin/config/media/image-styles/add','admin/config/media/image-styles/add','Add style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Add a new image style.\";}}','system',-1,0,0,0,2,5,0,1,8,46,105,128,0,0,0,0,0),('management',129,89,'admin/structure/taxonomy/%/add','admin/structure/taxonomy/%/add','Add term','a:0:{}','system',-1,0,0,0,0,5,0,1,21,57,89,129,0,0,0,0,0),('management',130,123,'admin/config/content/formats/add','admin/config/content/formats/add','Add text format','a:0:{}','system',-1,0,0,0,1,5,0,1,8,35,123,130,0,0,0,0,0),('management',131,30,'admin/structure/block/list/bartik','admin/structure/block/list/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,131,0,0,0,0,0,0),('management',132,91,'admin/config/system/actions/configure','admin/config/system/actions/configure','Configure an advanced action','a:0:{}','system',-1,0,0,0,0,5,0,1,8,56,91,132,0,0,0,0,0),('management',133,47,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Customize menu','a:0:{}','system',0,0,1,0,0,4,0,1,21,47,133,0,0,0,0,0,0),('management',134,89,'admin/structure/taxonomy/%/edit','admin/structure/taxonomy/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,57,89,134,0,0,0,0,0),('management',135,36,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit content type','a:0:{}','system',0,0,1,0,0,4,0,1,21,36,135,0,0,0,0,0,0),('management',136,99,'admin/config/regional/date-time/formats','admin/config/regional/date-time/formats','Formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Configure display format strings for date and time.\";}}','system',-1,0,1,0,-9,5,0,1,8,51,99,136,0,0,0,0,0),('management',137,30,'admin/structure/block/list/garland','admin/structure/block/list/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,137,0,0,0,0,0,0),('management',138,123,'admin/config/content/formats/list','admin/config/content/formats/list','List','a:0:{}','system',-1,0,0,0,0,5,0,1,8,35,123,138,0,0,0,0,0),('management',139,89,'admin/structure/taxonomy/%/list','admin/structure/taxonomy/%/list','List','a:0:{}','system',-1,0,0,0,-20,5,0,1,21,57,89,139,0,0,0,0,0),('management',140,105,'admin/config/media/image-styles/list','admin/config/media/image-styles/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"List the current image styles on the site.\";}}','system',-1,0,0,0,1,5,0,1,8,46,105,140,0,0,0,0,0),('management',141,91,'admin/config/system/actions/manage','admin/config/system/actions/manage','Manage actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',-1,0,0,0,-2,5,0,1,8,56,91,141,0,0,0,0,0),('management',142,90,'admin/config/people/accounts/settings','admin/config/people/accounts/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,1,8,48,90,142,0,0,0,0,0),('management',143,30,'admin/structure/block/list/seven','admin/structure/block/list/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,143,0,0,0,0,0,0),('management',144,30,'admin/structure/block/list/stark','admin/structure/block/list/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,144,0,0,0,0,0,0),('management',145,99,'admin/config/regional/date-time/types','admin/config/regional/date-time/types','Types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',-1,0,1,0,-10,5,0,1,8,51,99,145,0,0,0,0,0),('navigation',146,52,'node/%/revisions/%/delete','node/%/revisions/%/delete','Delete earlier revision','a:0:{}','system',0,0,0,0,0,3,0,5,52,146,0,0,0,0,0,0,0),('navigation',147,52,'node/%/revisions/%/revert','node/%/revisions/%/revert','Revert to earlier revision','a:0:{}','system',0,0,0,0,0,3,0,5,52,147,0,0,0,0,0,0,0),('navigation',148,52,'node/%/revisions/%/view','node/%/revisions/%/view','Revisions','a:0:{}','system',0,0,0,0,0,3,0,5,52,148,0,0,0,0,0,0,0),('management',149,137,'admin/structure/block/list/garland/add','admin/structure/block/list/garland/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,137,149,0,0,0,0,0),('management',150,143,'admin/structure/block/list/seven/add','admin/structure/block/list/seven/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,143,150,0,0,0,0,0),('management',151,144,'admin/structure/block/list/stark/add','admin/structure/block/list/stark/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,144,151,0,0,0,0,0),('management',152,145,'admin/config/regional/date-time/types/add','admin/config/regional/date-time/types/add','Add date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Add new date type.\";}}','system',-1,0,0,0,-10,6,0,1,8,51,99,145,152,0,0,0,0),('management',153,136,'admin/config/regional/date-time/formats/add','admin/config/regional/date-time/formats/add','Add format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Allow users to add additional date formats.\";}}','system',-1,0,0,0,-10,6,0,1,8,51,99,136,153,0,0,0,0),('management',154,133,'admin/structure/menu/manage/%/add','admin/structure/menu/manage/%/add','Add link','a:0:{}','system',-1,0,0,0,0,5,0,1,21,47,133,154,0,0,0,0,0),('management',155,30,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','a:0:{}','system',0,0,0,0,0,4,0,1,21,30,155,0,0,0,0,0,0),('navigation',156,31,'user/%/cancel/confirm/%/%','user/%/cancel/confirm/%/%','Confirm account cancellation','a:0:{}','system',0,0,0,0,0,3,0,17,31,156,0,0,0,0,0,0,0),('management',157,135,'admin/structure/types/manage/%/delete','admin/structure/types/manage/%/delete','Delete','a:0:{}','system',0,0,0,0,0,5,0,1,21,36,135,157,0,0,0,0,0),('management',158,104,'admin/config/people/ip-blocking/delete/%','admin/config/people/ip-blocking/delete/%','Delete IP address','a:0:{}','system',0,0,0,0,0,5,0,1,8,48,104,158,0,0,0,0,0),('management',159,91,'admin/config/system/actions/delete/%','admin/config/system/actions/delete/%','Delete action','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Delete an action.\";}}','system',0,0,0,0,0,5,0,1,8,56,91,159,0,0,0,0,0),('management',160,133,'admin/structure/menu/manage/%/delete','admin/structure/menu/manage/%/delete','Delete menu','a:0:{}','system',0,0,0,0,0,5,0,1,21,47,133,160,0,0,0,0,0),('management',161,47,'admin/structure/menu/item/%/delete','admin/structure/menu/item/%/delete','Delete menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,161,0,0,0,0,0,0),('management',162,118,'admin/people/permissions/roles/delete/%','admin/people/permissions/roles/delete/%','Delete role','a:0:{}','system',0,0,0,0,0,5,0,1,18,49,118,162,0,0,0,0,0),('management',163,127,'admin/config/content/formats/%/disable','admin/config/content/formats/%/disable','Disable text format','a:0:{}','system',0,0,0,0,0,6,0,1,8,35,123,127,163,0,0,0,0),('management',164,135,'admin/structure/types/manage/%/edit','admin/structure/types/manage/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,1,21,36,135,164,0,0,0,0,0),('management',165,133,'admin/structure/menu/manage/%/edit','admin/structure/menu/manage/%/edit','Edit menu','a:0:{}','system',-1,0,0,0,0,5,0,1,21,47,133,165,0,0,0,0,0),('management',166,47,'admin/structure/menu/item/%/edit','admin/structure/menu/item/%/edit','Edit menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,166,0,0,0,0,0,0),('management',167,118,'admin/people/permissions/roles/edit/%','admin/people/permissions/roles/edit/%','Edit role','a:0:{}','system',0,0,0,0,0,5,0,1,18,49,118,167,0,0,0,0,0),('management',168,105,'admin/config/media/image-styles/edit/%','admin/config/media/image-styles/edit/%','Edit style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure an image style.\";}}','system',0,0,1,0,0,5,0,1,8,46,105,168,0,0,0,0,0),('management',169,133,'admin/structure/menu/manage/%/list','admin/structure/menu/manage/%/list','List links','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,47,133,169,0,0,0,0,0),('management',170,47,'admin/structure/menu/item/%/reset','admin/structure/menu/item/%/reset','Reset menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,170,0,0,0,0,0,0),('management',171,105,'admin/config/media/image-styles/delete/%','admin/config/media/image-styles/delete/%','Delete style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Delete an image style.\";}}','system',0,0,0,0,0,5,0,1,8,46,105,171,0,0,0,0,0),('management',172,105,'admin/config/media/image-styles/revert/%','admin/config/media/image-styles/revert/%','Revert style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Revert an image style.\";}}','system',0,0,0,0,0,5,0,1,8,46,105,172,0,0,0,0,0),('management',175,155,'admin/structure/block/manage/%/%/configure','admin/structure/block/manage/%/%/configure','Configure block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,155,175,0,0,0,0,0),('management',176,155,'admin/structure/block/manage/%/%/delete','admin/structure/block/manage/%/%/delete','Delete block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,155,176,0,0,0,0,0),('management',177,136,'admin/config/regional/date-time/formats/%/delete','admin/config/regional/date-time/formats/%/delete','Delete date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Allow users to delete a configured date format.\";}}','system',0,0,0,0,0,6,0,1,8,51,99,136,177,0,0,0,0),('management',178,145,'admin/config/regional/date-time/types/%/delete','admin/config/regional/date-time/types/%/delete','Delete date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to delete a configured date type.\";}}','system',0,0,0,0,0,6,0,1,8,51,99,145,178,0,0,0,0),('management',179,136,'admin/config/regional/date-time/formats/%/edit','admin/config/regional/date-time/formats/%/edit','Edit date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to edit a configured date format.\";}}','system',0,0,0,0,0,6,0,1,8,51,99,136,179,0,0,0,0),('management',180,168,'admin/config/media/image-styles/edit/%/add/%','admin/config/media/image-styles/edit/%/add/%','Add image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add a new effect to a style.\";}}','system',0,0,0,0,0,6,0,1,8,46,105,168,180,0,0,0,0),('management',181,168,'admin/config/media/image-styles/edit/%/effects/%','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Edit an existing effect within a style.\";}}','system',0,0,1,0,0,6,0,1,8,46,105,168,181,0,0,0,0),('management',182,181,'admin/config/media/image-styles/edit/%/effects/%/delete','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Delete an existing effect from a style.\";}}','system',0,0,0,0,0,7,0,1,8,46,105,168,181,182,0,0,0),('management',183,47,'admin/structure/menu/manage/main-menu','admin/structure/menu/manage/%','Main menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,183,0,0,0,0,0,0),('management',184,47,'admin/structure/menu/manage/management','admin/structure/menu/manage/%','Management','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,184,0,0,0,0,0,0),('management',185,47,'admin/structure/menu/manage/navigation','admin/structure/menu/manage/%','Navigation','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,185,0,0,0,0,0,0),('management',186,47,'admin/structure/menu/manage/user-menu','admin/structure/menu/manage/%','User menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,186,0,0,0,0,0,0),('navigation',187,0,'search','search','Search','a:0:{}','system',1,0,0,0,0,1,0,187,0,0,0,0,0,0,0,0,0),('navigation',188,187,'search/node','search/node','Content','a:0:{}','system',-1,0,0,0,-10,2,0,187,188,0,0,0,0,0,0,0,0),('navigation',189,187,'search/user','search/user','Users','a:0:{}','system',-1,0,0,0,0,2,0,187,189,0,0,0,0,0,0,0,0),('navigation',190,188,'search/node/%','search/node/%','Content','a:0:{}','system',-1,0,0,0,0,3,0,187,188,190,0,0,0,0,0,0,0),('navigation',191,17,'user/%/shortcuts','user/%/shortcuts','Shortcuts','a:0:{}','system',-1,0,0,0,0,2,0,17,191,0,0,0,0,0,0,0,0),('management',192,19,'admin/reports/search','admin/reports/search','Top search phrases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"View most popular search phrases.\";}}','system',0,0,0,0,0,3,0,1,19,192,0,0,0,0,0,0,0),('navigation',193,189,'search/user/%','search/user/%','Users','a:0:{}','system',-1,0,0,0,0,3,0,187,189,193,0,0,0,0,0,0,0),('management',194,12,'admin/help/number','admin/help/number','number','a:0:{}','system',-1,0,0,0,0,3,0,1,12,194,0,0,0,0,0,0,0),('management',195,12,'admin/help/overlay','admin/help/overlay','overlay','a:0:{}','system',-1,0,0,0,0,3,0,1,12,195,0,0,0,0,0,0,0),('management',196,12,'admin/help/path','admin/help/path','path','a:0:{}','system',-1,0,0,0,0,3,0,1,12,196,0,0,0,0,0,0,0),('management',197,12,'admin/help/rdf','admin/help/rdf','rdf','a:0:{}','system',-1,0,0,0,0,3,0,1,12,197,0,0,0,0,0,0,0),('management',198,12,'admin/help/search','admin/help/search','search','a:0:{}','system',-1,0,0,0,0,3,0,1,12,198,0,0,0,0,0,0,0),('management',199,12,'admin/help/shortcut','admin/help/shortcut','shortcut','a:0:{}','system',-1,0,0,0,0,3,0,1,12,199,0,0,0,0,0,0,0),('management',200,53,'admin/config/search/settings','admin/config/search/settings','Search settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Configure relevance settings for search and other indexing options.\";}}','system',0,0,0,0,-10,4,0,1,8,53,200,0,0,0,0,0,0),('management',201,61,'admin/config/user-interface/shortcut','admin/config/user-interface/shortcut','Shortcuts','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Add and modify shortcut sets.\";}}','system',0,0,1,0,0,4,0,1,8,61,201,0,0,0,0,0,0),('management',202,53,'admin/config/search/path','admin/config/search/path','URL aliases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Change your site\'s URL paths by aliasing them.\";}}','system',0,0,1,0,-5,4,0,1,8,53,202,0,0,0,0,0,0),('management',203,202,'admin/config/search/path/add','admin/config/search/path/add','Add alias','a:0:{}','system',-1,0,0,0,0,5,0,1,8,53,202,203,0,0,0,0,0),('management',204,201,'admin/config/user-interface/shortcut/add-set','admin/config/user-interface/shortcut/add-set','Add shortcut set','a:0:{}','system',-1,0,0,0,0,5,0,1,8,61,201,204,0,0,0,0,0),('management',205,200,'admin/config/search/settings/reindex','admin/config/search/settings/reindex','Clear index','a:0:{}','system',-1,0,0,0,0,5,0,1,8,53,200,205,0,0,0,0,0),('management',206,201,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Edit shortcuts','a:0:{}','system',0,0,1,0,0,5,0,1,8,61,201,206,0,0,0,0,0),('management',207,202,'admin/config/search/path/list','admin/config/search/path/list','List','a:0:{}','system',-1,0,0,0,-10,5,0,1,8,53,202,207,0,0,0,0,0),('management',208,206,'admin/config/user-interface/shortcut/%/add-link','admin/config/user-interface/shortcut/%/add-link','Add shortcut','a:0:{}','system',-1,0,0,0,0,6,0,1,8,61,201,206,208,0,0,0,0),('management',209,202,'admin/config/search/path/delete/%','admin/config/search/path/delete/%','Delete alias','a:0:{}','system',0,0,0,0,0,5,0,1,8,53,202,209,0,0,0,0,0),('management',210,206,'admin/config/user-interface/shortcut/%/delete','admin/config/user-interface/shortcut/%/delete','Delete shortcut set','a:0:{}','system',0,0,0,0,0,6,0,1,8,61,201,206,210,0,0,0,0),('management',211,202,'admin/config/search/path/edit/%','admin/config/search/path/edit/%','Edit alias','a:0:{}','system',0,0,0,0,0,5,0,1,8,53,202,211,0,0,0,0,0),('management',212,206,'admin/config/user-interface/shortcut/%/edit','admin/config/user-interface/shortcut/%/edit','Edit set name','a:0:{}','system',-1,0,0,0,10,6,0,1,8,61,201,206,212,0,0,0,0),('management',213,201,'admin/config/user-interface/shortcut/link/%','admin/config/user-interface/shortcut/link/%','Edit shortcut','a:0:{}','system',0,0,1,0,0,5,0,1,8,61,201,213,0,0,0,0,0),('management',214,206,'admin/config/user-interface/shortcut/%/links','admin/config/user-interface/shortcut/%/links','List links','a:0:{}','system',-1,0,0,0,0,6,0,1,8,61,201,206,214,0,0,0,0),('management',215,213,'admin/config/user-interface/shortcut/link/%/delete','admin/config/user-interface/shortcut/link/%/delete','Delete shortcut','a:0:{}','system',0,0,0,0,0,6,0,1,8,61,201,213,215,0,0,0,0),('shortcut-set-1',216,0,'node/add','node/add','Add content','a:0:{}','menu',0,0,0,0,-20,1,0,216,0,0,0,0,0,0,0,0,0),('shortcut-set-1',217,0,'admin/content','admin/content','Find content','a:0:{}','menu',0,0,0,0,-19,1,0,217,0,0,0,0,0,0,0,0,0),('main-menu',218,0,'taxonomy/term/1','taxonomy/term/%','World','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,1,1,218,0,0,0,0,0,0,0,0,0),('navigation',219,6,'node/add/article','node/add/article','Article','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:89:\"Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.\";}}','system',0,0,0,0,0,2,0,6,219,0,0,0,0,0,0,0,0),('navigation',220,6,'node/add/page','node/add/page','Basic page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:77:\"Use <em>basic pages</em> for your static content, such as an \'About us\' page.\";}}','system',0,0,0,0,0,2,0,6,220,0,0,0,0,0,0,0,0),('management',221,12,'admin/help/toolbar','admin/help/toolbar','toolbar','a:0:{}','system',-1,0,0,0,0,3,0,1,12,221,0,0,0,0,0,0,0),('management',260,19,'admin/reports/updates','admin/reports/updates','Available updates','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:82:\"Get a status report about available updates for your installed modules and themes.\";}}','system',0,0,0,0,-50,3,0,1,19,260,0,0,0,0,0,0,0),('management',261,7,'admin/appearance/install','admin/appearance/install','Install new theme','a:0:{}','system',-1,0,0,0,25,3,0,1,7,261,0,0,0,0,0,0,0),('management',262,16,'admin/modules/update','admin/modules/update','Update','a:0:{}','system',-1,0,0,0,10,3,0,1,16,262,0,0,0,0,0,0,0),('management',263,16,'admin/modules/install','admin/modules/install','Install new module','a:0:{}','system',-1,0,0,0,25,3,0,1,16,263,0,0,0,0,0,0,0),('management',264,7,'admin/appearance/update','admin/appearance/update','Update','a:0:{}','system',-1,0,0,0,10,3,0,1,7,264,0,0,0,0,0,0,0),('management',265,12,'admin/help/update','admin/help/update','update','a:0:{}','system',-1,0,0,0,0,3,0,1,12,265,0,0,0,0,0,0,0),('management',266,260,'admin/reports/updates/install','admin/reports/updates/install','Install new module or theme','a:0:{}','system',-1,0,0,0,25,4,0,1,19,260,266,0,0,0,0,0,0),('management',267,260,'admin/reports/updates/update','admin/reports/updates/update','Update','a:0:{}','system',-1,0,0,0,10,4,0,1,19,260,267,0,0,0,0,0,0),('management',268,260,'admin/reports/updates/list','admin/reports/updates/list','List','a:0:{}','system',-1,0,0,0,0,4,0,1,19,260,268,0,0,0,0,0,0),('management',269,260,'admin/reports/updates/settings','admin/reports/updates/settings','Settings','a:0:{}','system',-1,0,0,0,50,4,0,1,19,260,269,0,0,0,0,0,0),('management',308,21,'admin/structure/quicktabs','admin/structure/quicktabs','Quicktabs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Create blocks of tabbed content.\";}}','system',0,0,1,0,0,3,0,1,21,308,0,0,0,0,0,0,0),('management',309,12,'admin/help/quicktabs','admin/help/quicktabs','quicktabs','a:0:{}','system',-1,0,0,0,0,3,0,1,12,309,0,0,0,0,0,0,0),('management',310,308,'admin/structure/quicktabs/add','admin/structure/quicktabs/add','Add Quicktabs Instance','a:0:{}','system',-1,0,0,0,0,4,0,1,21,308,310,0,0,0,0,0,0),('management',311,308,'admin/structure/quicktabs/list','admin/structure/quicktabs/list','List quicktabs','a:0:{}','system',-1,0,0,0,0,4,0,1,21,308,311,0,0,0,0,0,0),('management',312,308,'admin/structure/quicktabs/manage/%','admin/structure/quicktabs/manage/%','Edit quicktab','a:0:{}','system',0,0,0,0,0,4,0,1,21,308,312,0,0,0,0,0,0),('management',313,312,'admin/structure/quicktabs/manage/%/clone','admin/structure/quicktabs/manage/%/clone','Clone quicktab','a:0:{}','system',-1,0,0,0,0,5,0,1,21,308,312,313,0,0,0,0,0),('management',314,312,'admin/structure/quicktabs/manage/%/delete','admin/structure/quicktabs/manage/%/delete','Delete quicktab','a:0:{}','system',-1,0,0,0,0,5,0,1,21,308,312,314,0,0,0,0,0),('management',315,312,'admin/structure/quicktabs/manage/%/edit','admin/structure/quicktabs/manage/%/edit','Edit quicktab','a:0:{}','system',-1,0,0,0,0,5,0,1,21,308,312,315,0,0,0,0,0),('management',316,312,'admin/structure/quicktabs/manage/%/export','admin/structure/quicktabs/manage/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,1,21,308,312,316,0,0,0,0,0),('navigation',321,5,'node/%/webform-results','node/%/webform-results','Results','a:0:{}','system',-1,0,0,0,2,2,0,5,321,0,0,0,0,0,0,0,0),('navigation',322,6,'node/add/webform','node/add/webform','Webform','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:138:\"Create a new form or questionnaire accessible to users. Submission results and statistics are recorded and accessible to privileged users.\";}}','system',0,0,0,0,0,2,0,6,322,0,0,0,0,0,0,0,0),('navigation',323,5,'node/%/webform','node/%/webform','Webform','a:0:{}','system',-1,0,0,0,1,2,0,5,323,0,0,0,0,0,0,0,0),('management',324,9,'admin/content/webform','admin/content/webform','Webforms','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"View and edit all the available webforms on your site.\";}}','system',-1,0,0,0,0,3,0,1,9,324,0,0,0,0,0,0,0),('management',325,12,'admin/help/webform','admin/help/webform','webform','a:0:{}','system',-1,0,0,0,0,3,0,1,12,325,0,0,0,0,0,0,0),('navigation',326,321,'node/%/webform-results/analysis','node/%/webform-results/analysis','Analysis','a:0:{}','system',-1,0,0,0,5,3,0,5,321,326,0,0,0,0,0,0,0),('navigation',327,321,'node/%/webform-results/clear','node/%/webform-results/clear','Clear','a:0:{}','system',-1,0,0,0,8,3,0,5,321,327,0,0,0,0,0,0,0),('navigation',328,321,'node/%/webform-results/download','node/%/webform-results/download','Download','a:0:{}','system',-1,0,0,0,7,3,0,5,321,328,0,0,0,0,0,0,0),('navigation',329,323,'node/%/webform/emails','node/%/webform/emails','E-mails','a:0:{}','system',-1,0,0,0,1,3,0,5,323,329,0,0,0,0,0,0,0),('navigation',330,323,'node/%/webform/components','node/%/webform/components','Form components','a:0:{}','system',-1,0,0,0,0,3,0,5,323,330,0,0,0,0,0,0,0),('navigation',331,323,'node/%/webform/configure','node/%/webform/configure','Form settings','a:0:{}','system',-1,0,0,0,2,3,0,5,323,331,0,0,0,0,0,0,0),('navigation',332,321,'node/%/webform-results/submissions','node/%/webform-results/submissions','Submissions','a:0:{}','system',-1,0,0,0,4,3,0,5,321,332,0,0,0,0,0,0,0),('navigation',333,321,'node/%/webform-results/table','node/%/webform-results/table','Table','a:0:{}','system',-1,0,0,0,6,3,0,5,321,333,0,0,0,0,0,0,0),('management',334,35,'admin/config/content/webform','admin/config/content/webform','Webform settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Global configuration of webform functionality.\";}}','system',0,0,0,0,0,4,0,1,8,35,334,0,0,0,0,0,0),('navigation',335,5,'node/%/submission/%/delete','node/%/submission/%/delete','Delete','a:0:{}','system',-1,0,0,0,2,2,0,5,335,0,0,0,0,0,0,0,0),('navigation',336,5,'node/%/submission/%/edit','node/%/submission/%/edit','Edit','a:0:{}','system',-1,0,0,0,1,2,0,5,336,0,0,0,0,0,0,0,0),('navigation',337,329,'node/%/webform/emails/%','node/%/webform/emails/%','Edit e-mail settings','a:0:{}','system',-1,0,0,0,0,4,0,5,323,329,337,0,0,0,0,0,0),('navigation',338,5,'node/%/submission/%/view','node/%/submission/%/view','View','a:0:{}','system',-1,0,0,0,0,2,0,5,338,0,0,0,0,0,0,0,0),('navigation',339,330,'node/%/webform/components/%','node/%/webform/components/%','','a:0:{}','system',-1,0,0,0,0,4,0,5,323,330,339,0,0,0,0,0,0),('navigation',340,337,'node/%/webform/emails/%/delete','node/%/webform/emails/%/delete','Delete e-mail settings','a:0:{}','system',-1,0,0,0,0,5,0,5,323,329,337,340,0,0,0,0,0),('navigation',341,339,'node/%/webform/components/%/delete','node/%/webform/components/%/delete','','a:0:{}','system',-1,0,0,0,0,5,0,5,323,330,339,341,0,0,0,0,0),('navigation',342,339,'node/%/webform/components/%/clone','node/%/webform/components/%/clone','','a:0:{}','system',-1,0,0,0,0,5,0,5,323,330,339,342,0,0,0,0,0),('management',343,12,'admin/help/jquery_update','admin/help/jquery_update','jquery_update','a:0:{}','system',-1,0,0,0,0,3,0,1,12,343,0,0,0,0,0,0,0),('management',344,39,'admin/config/development/jquery_update','admin/config/development/jquery_update','jQuery update','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:83:\"Configure settings related to the jQuery upgrade, the library path and compression.\";}}','system',0,0,0,0,0,4,0,1,8,39,344,0,0,0,0,0,0),('management',345,12,'admin/help/superfish','admin/help/superfish','superfish','a:0:{}','system',-1,0,0,0,0,3,0,1,12,345,0,0,0,0,0,0,0),('management',346,61,'admin/config/user-interface/superfish','admin/config/user-interface/superfish','Superfish','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure Superfish Menus\";}}','system',0,0,0,0,0,4,0,1,8,61,346,0,0,0,0,0,0),('management',347,54,'admin/appearance/settings/newsplus','admin/appearance/settings/newsplus','News+','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,347,0,0,0,0,0,0),('management',348,30,'admin/structure/block/list/newsplus','admin/structure/block/list/newsplus','News+','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,30,348,0,0,0,0,0,0),('navigation',351,6,'node/add/mt-post','node/add/mt-post','Post','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:128:\"Use the Post content type to create and publish articles making use of all the special functionality built into the News+ theme.\";}}','system',0,0,0,0,0,2,0,6,351,0,0,0,0,0,0,0,0),('management',352,19,'admin/reports/hits','admin/reports/hits','Recent hits','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View pages that have recently been visited.\";}}','system',0,0,0,0,0,3,0,1,19,352,0,0,0,0,0,0,0),('management',353,19,'admin/reports/pages','admin/reports/pages','Top pages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"View pages that have been hit frequently.\";}}','system',0,0,0,0,1,3,0,1,19,353,0,0,0,0,0,0,0),('management',354,19,'admin/reports/referrers','admin/reports/referrers','Top referrers','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:19:\"View top referrers.\";}}','system',0,0,0,0,0,3,0,1,19,354,0,0,0,0,0,0,0),('management',355,19,'admin/reports/visitors','admin/reports/visitors','Top visitors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View visitors that hit many pages.\";}}','system',0,0,0,0,2,3,0,1,19,355,0,0,0,0,0,0,0),('navigation',356,5,'node/%/track','node/%/track','Track','a:0:{}','system',-1,0,0,0,2,2,0,5,356,0,0,0,0,0,0,0,0),('management',357,12,'admin/help/statistics','admin/help/statistics','statistics','a:0:{}','system',-1,0,0,0,0,3,0,1,12,357,0,0,0,0,0,0,0),('management',358,19,'admin/reports/access/%','admin/reports/access/%','Details','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:16:\"View access log.\";}}','system',0,0,0,0,0,3,0,1,19,358,0,0,0,0,0,0,0),('management',359,56,'admin/config/system/statistics','admin/config/system/statistics','Statistics','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Control details about what and how your site logs access statistics.\";}}','system',0,0,0,0,-15,4,0,1,8,56,359,0,0,0,0,0,0),('navigation',360,17,'user/%/track/navigation','user/%/track/navigation','Track page visits','a:0:{}','system',-1,0,0,0,2,2,0,17,360,0,0,0,0,0,0,0,0),('management',382,12,'admin/help/php','admin/help/php','php','a:0:{}','system',-1,0,0,0,0,3,0,1,12,382,0,0,0,0,0,0,0),('management',383,21,'admin/structure/views','admin/structure/views','Views','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"Manage customized lists of content.\";}}','system',0,0,1,0,0,3,0,1,21,383,0,0,0,0,0,0,0),('management',384,19,'admin/reports/views-plugins','admin/reports/views-plugins','Views plugins','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Overview of plugins used in all views.\";}}','system',0,0,0,0,0,3,0,1,19,384,0,0,0,0,0,0,0),('management',385,383,'admin/structure/views/add','admin/structure/views/add','Add new view','a:0:{}','system',-1,0,0,0,0,4,0,1,21,383,385,0,0,0,0,0,0),('management',386,383,'admin/structure/views/add-template','admin/structure/views/add-template','Add view from template','a:0:{}','system',-1,0,0,0,0,4,0,1,21,383,386,0,0,0,0,0,0),('management',387,383,'admin/structure/views/import','admin/structure/views/import','Import','a:0:{}','system',-1,0,0,0,0,4,0,1,21,383,387,0,0,0,0,0,0),('management',388,383,'admin/structure/views/list','admin/structure/views/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,383,388,0,0,0,0,0,0),('management',389,383,'admin/structure/views/settings','admin/structure/views/settings','Settings','a:0:{}','system',-1,0,0,0,0,4,0,1,21,383,389,0,0,0,0,0,0),('management',390,42,'admin/reports/fields/list','admin/reports/fields/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,19,42,390,0,0,0,0,0,0),('management',391,42,'admin/reports/fields/views-fields','admin/reports/fields/views-fields','Used in views','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Overview of fields used in all views.\";}}','system',-1,0,0,0,0,4,0,1,19,42,391,0,0,0,0,0,0),('management',392,389,'admin/structure/views/settings/advanced','admin/structure/views/settings/advanced','Advanced','a:0:{}','system',-1,0,0,0,1,5,0,1,21,383,389,392,0,0,0,0,0),('management',393,389,'admin/structure/views/settings/basic','admin/structure/views/settings/basic','Basic','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,389,393,0,0,0,0,0),('management',394,383,'admin/structure/views/view/%','admin/structure/views/view/%','','a:0:{}','system',0,0,0,0,0,4,0,1,21,383,394,0,0,0,0,0,0),('management',395,394,'admin/structure/views/view/%/break-lock','admin/structure/views/view/%/break-lock','Break lock','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,394,395,0,0,0,0,0),('management',396,394,'admin/structure/views/view/%/edit','admin/structure/views/view/%/edit','Edit view','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,383,394,396,0,0,0,0,0),('management',397,394,'admin/structure/views/view/%/clone','admin/structure/views/view/%/clone','Clone','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,394,397,0,0,0,0,0),('management',398,394,'admin/structure/views/view/%/delete','admin/structure/views/view/%/delete','Delete','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,394,398,0,0,0,0,0),('management',399,394,'admin/structure/views/view/%/export','admin/structure/views/view/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,394,399,0,0,0,0,0),('management',400,394,'admin/structure/views/view/%/revert','admin/structure/views/view/%/revert','Revert','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,394,400,0,0,0,0,0),('management',401,383,'admin/structure/views/nojs/preview/%/%','admin/structure/views/nojs/preview/%/%','','a:0:{}','system',0,0,0,0,0,4,0,1,21,383,401,0,0,0,0,0,0),('management',402,383,'admin/structure/views/ajax/preview/%/%','admin/structure/views/ajax/preview/%/%','','a:0:{}','system',0,0,0,0,0,4,0,1,21,383,402,0,0,0,0,0,0),('management',403,394,'admin/structure/views/view/%/preview/%','admin/structure/views/view/%/preview/%','','a:0:{}','system',-1,0,0,0,0,5,0,1,21,383,394,403,0,0,0,0,0),('main-menu',405,0,'taxonomy/term/2','taxonomy/term/%','Finance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,1,1,405,0,0,0,0,0,0,0,0,0),('main-menu',406,0,'taxonomy/term/3','taxonomy/term/%','Health','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-48,1,1,406,0,0,0,0,0,0,0,0,0),('main-menu',407,0,'taxonomy/term/4','taxonomy/term/%','Tech','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-47,1,1,407,0,0,0,0,0,0,0,0,0),('main-menu',408,0,'taxonomy/term/5','taxonomy/term/%','Lifestyle','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-46,1,1,408,0,0,0,0,0,0,0,0,0),('main-menu',409,0,'taxonomy/term/6','taxonomy/term/%','Sports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-45,1,1,409,0,0,0,0,0,0,0,0,0),('navigation',448,6,'node/add/mt-slideshow-entry','node/add/mt-slideshow-entry','Slideshow entry','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:268:\"A Slideshow entry is ideal for creating commercial banners as well as messages for your website. Use it to promote any page of your website or URL into the front page slide show. It can carry a title, a teaser and an image linking to an internal path or external link.\";}}','system',0,0,0,0,0,2,0,6,448,0,0,0,0,0,0,0,0),('management',449,47,'admin/structure/menu/manage/menu-subfooter-menu','admin/structure/menu/manage/%','Subfooter menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,449,0,0,0,0,0,0),('menu-subfooter-menu',450,0,'node/13','node/%','Contact','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-47,1,1,450,0,0,0,0,0,0,0,0,0),('menu-subfooter-menu',451,0,'<front>','','Home','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,1,0,0,-50,1,1,451,0,0,0,0,0,0,0,0,0),('menu-subfooter-menu',452,0,'<front>','','Advertise with us','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,1,0,0,-49,1,1,452,0,0,0,0,0,0,0,0,0),('menu-subfooter-menu',453,0,'<front>','','Privacy Statement','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,1,0,0,-48,1,1,453,0,0,0,0,0,0,0,0,0),('management',454,47,'admin/structure/menu/manage/menu-sidebar-menu','admin/structure/menu/manage/%','Sidebar Menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,454,0,0,0,0,0,0),('menu-sidebar-menu',458,0,'taxonomy/term/1','taxonomy/term/%','World','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-50,1,1,458,0,0,0,0,0,0,0,0,0),('menu-sidebar-menu',459,0,'taxonomy/term/2','taxonomy/term/%','Finance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,0,1,1,459,0,0,0,0,0,0,0,0,0),('menu-sidebar-menu',460,0,'taxonomy/term/3','taxonomy/term/%','Health','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,0,1,1,460,0,0,0,0,0,0,0,0,0),('menu-sidebar-menu',461,0,'taxonomy/term/4','taxonomy/term/%','Tech','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,0,1,1,461,0,0,0,0,0,0,0,0,0),('menu-sidebar-menu',462,0,'taxonomy/term/5','taxonomy/term/%','Lifestyle','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,0,1,1,462,0,0,0,0,0,0,0,0,0),('menu-sidebar-menu',463,0,'taxonomy/term/6','taxonomy/term/%','Sports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,0,1,1,463,0,0,0,0,0,0,0,0,0),('menu-sidebar-menu',464,458,'node/6','node/%','Title of the sixth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,458,464,0,0,0,0,0,0,0,0),('menu-sidebar-menu',465,458,'node/12','node/%','Title of the twelfth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,458,465,0,0,0,0,0,0,0,0),('menu-sidebar-menu',466,459,'node/1','node/%','Title of the first article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,459,466,0,0,0,0,0,0,0,0),('menu-sidebar-menu',467,459,'node/7','node/%','Title of the seventh article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,459,467,0,0,0,0,0,0,0,0),('menu-sidebar-menu',468,460,'node/2','node/%','Title of the second article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,2,1,460,468,0,0,0,0,0,0,0,0),('menu-sidebar-menu',469,460,'node/8','node/%','Title of the eighth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,460,469,0,0,0,0,0,0,0,0),('menu-sidebar-menu',470,461,'node/5','node/%','Title of the fifth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,461,470,0,0,0,0,0,0,0,0),('menu-sidebar-menu',471,461,'node/11','node/%','Title of the eleventh article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,461,471,0,0,0,0,0,0,0,0),('menu-sidebar-menu',472,462,'node/3','node/%','Title of the third article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,2,1,462,472,0,0,0,0,0,0,0,0),('menu-sidebar-menu',473,462,'node/9','node/%','Title of the ninth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,2,1,462,473,0,0,0,0,0,0,0,0),('menu-sidebar-menu',474,463,'node/4','node/%','Title of the fourth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,2,1,463,474,0,0,0,0,0,0,0,0),('menu-sidebar-menu',475,463,'node/10','node/%','Title of the tenth article rendered on the article page and throughout the site','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,2,1,463,475,0,0,0,0,0,0,0,0),('main-menu',476,0,'node/15','node/%','Features','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-44,1,1,476,0,0,0,0,0,0,0,0,0),('main-menu',477,476,'node/14','node/%','Typography','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,2,1,476,477,0,0,0,0,0,0,0,0),('management',479,131,'admin/structure/block/list/bartik/add','admin/structure/block/list/bartik/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,131,479,0,0,0,0,0),('main-menu',480,476,'node/15','node/%','Shortcodes','a:0:{}','menu',0,0,1,0,-47,2,1,476,480,0,0,0,0,0,0,0,0),('main-menu',481,480,'node/15','node/%','Brands','a:2:{s:8:\"fragment\";s:6:\"brands\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,3,1,476,480,481,0,0,0,0,0,0,0),('main-menu',482,480,'node/15','node/%','Tabs','a:2:{s:8:\"fragment\";s:4:\"tabs\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,3,1,476,480,482,0,0,0,0,0,0,0),('main-menu',483,480,'node/15','node/%','Accordion','a:2:{s:8:\"fragment\";s:9:\"accordion\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-48,3,1,476,480,483,0,0,0,0,0,0,0),('main-menu',484,480,'node/15','node/%','Buttons','a:2:{s:8:\"fragment\";s:7:\"buttons\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-47,3,1,476,480,484,0,0,0,0,0,0,0),('main-menu',485,480,'node/15','node/%','Progressbars','a:2:{s:8:\"fragment\";s:12:\"progressbars\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-46,3,1,476,480,485,0,0,0,0,0,0,0),('main-menu',486,476,'node/16','node/%','Responsive Grid','a:0:{}','menu',0,0,1,0,-48,2,1,476,486,0,0,0,0,0,0,0,0),('main-menu',487,486,'node/16','node/%','Grid - No Sidebar','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,3,1,476,486,487,0,0,0,0,0,0,0),('main-menu',488,486,'node/17','node/%','Grid - With Sidebar','a:0:{}','menu',0,0,0,0,0,3,0,476,486,488,0,0,0,0,0,0,0),('main-menu',489,476,'node/15','node/%','Pages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-49,2,1,476,489,0,0,0,0,0,0,0,0),('main-menu',490,489,'node/11','node/%','Full Width','a:1:{s:10:\"attributes\";a:0:{}}','menu',0,0,0,0,-50,3,1,476,489,490,0,0,0,0,0,0,0),('main-menu',491,489,'node/1','node/%','One Sidebar','a:1:{s:10:\"attributes\";a:0:{}}','menu',0,0,0,0,-49,3,1,476,489,491,0,0,0,0,0,0,0),('main-menu',492,489,'node/12','node/%','Two Sidebars','a:1:{s:10:\"attributes\";a:0:{}}','menu',0,0,0,0,-48,3,1,476,489,492,0,0,0,0,0,0,0),('main-menu',493,489,'node/1','node/%','Page with comments','a:2:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}s:8:\"fragment\";s:8:\"comments\";}','menu',0,0,0,0,-47,3,1,476,489,493,0,0,0,0,0,0,0),('management',495,47,'admin/structure/menu/manage/menu-secondary-menu','admin/structure/menu/manage/%','Secondary menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,495,0,0,0,0,0,0),('menu-secondary-menu',496,0,'<front>','','Home','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,1,0,0,-50,1,1,496,0,0,0,0,0,0,0,0,0),('menu-secondary-menu',497,0,'node/13','node/%','Contact','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-46,1,1,497,0,0,0,0,0,0,0,0,0),('menu-secondary-menu',498,0,'node/15','node/%','Features','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-48,1,1,498,0,0,0,0,0,0,0,0,0),('menu-secondary-menu',499,498,'node/14','node/%','Typography','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,2,1,498,499,0,0,0,0,0,0,0,0),('menu-secondary-menu',500,498,'node/15','node/%','Pages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-49,2,1,498,500,0,0,0,0,0,0,0,0),('menu-secondary-menu',501,500,'node/11','node/%','Full Width','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,3,1,498,500,501,0,0,0,0,0,0,0),('menu-secondary-menu',502,500,'node/1','node/%','One Sidebar','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,3,1,498,500,502,0,0,0,0,0,0,0),('menu-secondary-menu',503,500,'node/12','node/%','Two Sidebars','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-48,3,1,498,500,503,0,0,0,0,0,0,0),('menu-secondary-menu',504,500,'node/1','node/%','Page with comments','a:2:{s:8:\"fragment\";s:8:\"comments\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-47,3,1,498,500,504,0,0,0,0,0,0,0),('menu-secondary-menu',505,498,'node/16','node/%','Responsive Grid','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-48,2,1,498,505,0,0,0,0,0,0,0,0),('menu-secondary-menu',506,505,'node/16','node/%','Grid - No Sidebar','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,3,1,498,505,506,0,0,0,0,0,0,0),('menu-secondary-menu',507,505,'node/17','node/%','Grid - With Sidebar','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,3,1,498,505,507,0,0,0,0,0,0,0),('menu-secondary-menu',508,498,'node/15','node/%','Shortcodes','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-47,2,1,498,508,0,0,0,0,0,0,0,0),('menu-secondary-menu',509,508,'node/15','node/%','Brands','a:2:{s:8:\"fragment\";s:6:\"brands\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,3,1,498,508,509,0,0,0,0,0,0,0),('menu-secondary-menu',510,508,'node/15','node/%','Tabs','a:2:{s:8:\"fragment\";s:4:\"tabs\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,3,1,498,508,510,0,0,0,0,0,0,0),('menu-secondary-menu',511,508,'node/15','node/%','Accordion','a:2:{s:8:\"fragment\";s:9:\"accordion\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-48,3,1,498,508,511,0,0,0,0,0,0,0),('menu-secondary-menu',512,508,'node/15','node/%','Buttons','a:2:{s:8:\"fragment\";s:7:\"buttons\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-47,3,1,498,508,512,0,0,0,0,0,0,0),('menu-secondary-menu',513,508,'node/15','node/%','Progressbars','a:2:{s:8:\"fragment\";s:12:\"progressbars\";s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-46,3,1,498,508,513,0,0,0,0,0,0,0),('menu-secondary-menu',514,0,'archive','archive','Archive','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-49,1,1,514,0,0,0,0,0,0,0,0,0),('management',515,12,'admin/help/rules','admin/help/rules','rules','a:0:{}','system',-1,0,0,0,0,3,0,1,12,515,0,0,0,0,0,0,0),('management',516,65,'admin/config/workflow/rules','admin/config/workflow/rules','Rules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"Manage reaction rules and rule components.\";}}','system',0,0,0,0,0,4,0,1,8,65,516,0,0,0,0,0,0),('management',517,516,'admin/config/workflow/rules/components','admin/config/workflow/rules/components','Components','a:0:{}','system',-1,0,0,0,0,5,0,1,8,65,516,517,0,0,0,0,0),('management',518,516,'admin/config/workflow/rules/reaction','admin/config/workflow/rules/reaction','Rules','a:0:{}','system',-1,0,0,0,-1,5,0,1,8,65,516,518,0,0,0,0,0),('management',519,516,'admin/config/workflow/rules/settings','admin/config/workflow/rules/settings','Settings','a:0:{}','system',-1,0,0,0,1,5,0,1,8,65,516,519,0,0,0,0,0),('management',520,517,'admin/config/workflow/rules/components/add','admin/config/workflow/rules/components/add','Add new component','a:0:{}','system',-1,0,0,0,0,6,0,1,8,65,516,517,520,0,0,0,0),('management',521,518,'admin/config/workflow/rules/reaction/add','admin/config/workflow/rules/reaction/add','Add new rule','a:0:{}','system',-1,0,0,0,0,6,0,1,8,65,516,518,521,0,0,0,0),('management',522,519,'admin/config/workflow/rules/settings/advanced','admin/config/workflow/rules/settings/advanced','Advanced','a:0:{}','system',-1,0,0,0,0,6,0,1,8,65,516,519,522,0,0,0,0),('management',523,519,'admin/config/workflow/rules/settings/basic','admin/config/workflow/rules/settings/basic','Basic','a:0:{}','system',-1,0,0,0,-10,6,0,1,8,65,516,519,523,0,0,0,0),('management',524,517,'admin/config/workflow/rules/components/import','admin/config/workflow/rules/components/import','Import component','a:0:{}','system',-1,0,0,0,0,6,0,1,8,65,516,517,524,0,0,0,0),('management',525,518,'admin/config/workflow/rules/reaction/import','admin/config/workflow/rules/reaction/import','Import rule','a:0:{}','system',-1,0,0,0,0,6,0,1,8,65,516,518,525,0,0,0,0),('management',526,517,'admin/config/workflow/rules/components/manage/%','admin/config/workflow/rules/components/manage/%','','a:0:{}','system',-1,0,1,0,0,6,0,1,8,65,516,517,526,0,0,0,0),('management',527,518,'admin/config/workflow/rules/reaction/manage/%','admin/config/workflow/rules/reaction/manage/%','','a:0:{}','system',-1,0,1,0,0,6,0,1,8,65,516,518,527,0,0,0,0),('management',528,526,'admin/config/workflow/rules/components/manage/%/clone','admin/config/workflow/rules/components/manage/%/clone','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,528,0,0,0),('management',529,527,'admin/config/workflow/rules/reaction/manage/%/clone','admin/config/workflow/rules/reaction/manage/%/clone','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,529,0,0,0),('management',530,526,'admin/config/workflow/rules/components/manage/%/execute','admin/config/workflow/rules/components/manage/%/execute','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,530,0,0,0),('management',531,527,'admin/config/workflow/rules/reaction/manage/%/execute','admin/config/workflow/rules/reaction/manage/%/execute','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,531,0,0,0),('management',532,526,'admin/config/workflow/rules/components/manage/%/export','admin/config/workflow/rules/components/manage/%/export','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,532,0,0,0),('management',533,527,'admin/config/workflow/rules/reaction/manage/%/export','admin/config/workflow/rules/reaction/manage/%/export','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,533,0,0,0),('management',534,526,'admin/config/workflow/rules/components/manage/%/%','admin/config/workflow/rules/components/manage/%/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,534,0,0,0),('management',535,527,'admin/config/workflow/rules/reaction/manage/%/%','admin/config/workflow/rules/reaction/manage/%/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,535,0,0,0),('management',536,526,'admin/config/workflow/rules/components/manage/%/delete/event','admin/config/workflow/rules/components/manage/%/delete/event','Remove event','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Remove an event from a reaction rule.\";}}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,536,0,0,0),('management',537,527,'admin/config/workflow/rules/reaction/manage/%/delete/event','admin/config/workflow/rules/reaction/manage/%/delete/event','Remove event','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Remove an event from a reaction rule.\";}}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,537,0,0,0),('management',538,526,'admin/config/workflow/rules/components/manage/%/add/event','admin/config/workflow/rules/components/manage/%/add/event','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,538,0,0,0),('management',539,527,'admin/config/workflow/rules/reaction/manage/%/add/event','admin/config/workflow/rules/reaction/manage/%/add/event','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,539,0,0,0),('management',540,526,'admin/config/workflow/rules/components/manage/%/delete/%','admin/config/workflow/rules/components/manage/%/delete/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,540,0,0,0),('management',541,527,'admin/config/workflow/rules/reaction/manage/%/delete/%','admin/config/workflow/rules/reaction/manage/%/delete/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,541,0,0,0),('management',542,526,'admin/config/workflow/rules/components/manage/%/edit/%','admin/config/workflow/rules/components/manage/%/edit/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,542,0,0,0),('management',543,527,'admin/config/workflow/rules/reaction/manage/%/edit/%','admin/config/workflow/rules/reaction/manage/%/edit/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,543,0,0,0),('management',544,526,'admin/config/workflow/rules/components/manage/%/add/%','admin/config/workflow/rules/components/manage/%/add/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,517,526,544,0,0,0),('management',545,527,'admin/config/workflow/rules/reaction/manage/%/add/%','admin/config/workflow/rules/reaction/manage/%/add/%','','a:0:{}','system',0,0,0,0,0,7,0,1,8,65,516,518,527,545,0,0,0),('management',546,1,'admin/commerce','admin/commerce','Store','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Administer your store.\";}}','system',0,0,1,0,-7,2,0,1,546,0,0,0,0,0,0,0,0),('management',547,546,'admin/commerce/config','admin/commerce/config','Configuration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure settings and business rules for your store.\";}}','system',0,0,1,0,50,3,0,1,546,547,0,0,0,0,0,0,0),('management',548,547,'admin/commerce/config/currency','admin/commerce/config/currency','Currency settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:52:\"Configure the default currency and display settings.\";}}','system',0,0,0,0,0,4,0,1,546,547,548,0,0,0,0,0,0),('management',549,12,'admin/help/commerce_customer_ui','admin/help/commerce_customer_ui','commerce_customer_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,549,0,0,0,0,0,0,0),('management',550,546,'admin/commerce/customer-profiles','admin/commerce/customer-profiles','Customer profiles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:56:\"Manage customer profiles and profile types in the store.\";}}','system',0,0,1,0,0,3,0,1,546,550,0,0,0,0,0,0,0),('management',551,550,'admin/commerce/customer-profiles/%','admin/commerce/customer-profiles/%','','a:0:{}','system',0,0,0,0,0,4,0,1,546,550,551,0,0,0,0,0,0),('management',552,550,'admin/commerce/customer-profiles/add','admin/commerce/customer-profiles/add','Add a customer profile','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"Add a new customer profile.\";}}','system',0,0,1,0,10,4,0,1,546,550,552,0,0,0,0,0,0),('management',553,550,'admin/commerce/customer-profiles/types','admin/commerce/customer-profiles/types','Profile types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage customer profile types for your store.\";}}','system',-1,0,1,0,0,4,0,1,546,550,553,0,0,0,0,0,0),('management',554,550,'admin/commerce/customer-profiles/list','admin/commerce/customer-profiles/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,546,550,554,0,0,0,0,0,0),('management',555,553,'admin/commerce/customer-profiles/types/billing','admin/commerce/customer-profiles/types/billing','Billing information','a:0:{}','system',0,0,0,0,0,5,0,1,546,550,553,555,0,0,0,0,0),('management',556,552,'admin/commerce/customer-profiles/add/billing','admin/commerce/customer-profiles/add/billing','Create @name','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:80:\"The profile used to collect billing information on the checkout and order forms.\";}}','system',0,0,0,0,0,5,0,1,546,550,552,556,0,0,0,0,0),('management',557,551,'admin/commerce/customer-profiles/%/delete','admin/commerce/customer-profiles/%/delete','Delete a customer profile','a:0:{}','system',-1,0,0,0,10,5,0,1,546,550,551,557,0,0,0,0,0),('management',558,551,'admin/commerce/customer-profiles/%/edit','admin/commerce/customer-profiles/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,1,546,550,551,558,0,0,0,0,0),('management',559,555,'admin/commerce/customer-profiles/types/billing/display','admin/commerce/customer-profiles/types/billing/display','Manage display','a:0:{}','system',-1,0,0,0,2,6,0,1,546,550,553,555,559,0,0,0,0),('management',560,555,'admin/commerce/customer-profiles/types/billing/fields','admin/commerce/customer-profiles/types/billing/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,6,0,1,546,550,553,555,560,0,0,0,0),('management',569,12,'admin/help/commerce_line_item_ui','admin/help/commerce_line_item_ui','commerce_line_item_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,569,0,0,0,0,0,0,0),('management',570,547,'admin/commerce/config/line-items','admin/commerce/config/line-items','Line item types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Manage line item types for your store.\";}}','system',0,0,1,0,0,4,0,1,546,547,570,0,0,0,0,0,0),('management',571,12,'admin/help/commerce_order_ui','admin/help/commerce_order_ui','commerce_order_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,571,0,0,0,0,0,0,0),('management',572,546,'admin/commerce/orders','admin/commerce/orders','Orders','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"Manage orders in the store.\";}}','system',0,0,1,0,0,3,0,1,546,572,0,0,0,0,0,0,0),('navigation',573,17,'user/%/orders','user/%/orders','Orders','a:0:{}','system',-1,0,1,0,15,2,0,17,573,0,0,0,0,0,0,0,0),('management',574,572,'admin/commerce/orders/%','admin/commerce/orders/%','','a:0:{}','system',0,0,0,0,0,4,0,1,546,572,574,0,0,0,0,0,0),('navigation',575,573,'user/%/orders/%','user/%/orders/%','','a:0:{}','system',0,0,0,0,0,3,0,17,573,575,0,0,0,0,0,0,0),('management',576,572,'admin/commerce/orders/add','admin/commerce/orders/add','Create an order','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:19:\"Create a new order.\";}}','system',0,0,1,0,10,4,0,1,546,572,576,0,0,0,0,0,0),('management',577,547,'admin/commerce/config/order','admin/commerce/config/order','Order settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:55:\"Configure general order settings, fields, and displays.\";}}','system',0,0,0,0,0,4,0,1,546,547,577,0,0,0,0,0,0),('management',578,572,'admin/commerce/orders/list','admin/commerce/orders/list','Orders','a:0:{}','system',-1,0,0,0,-10,4,0,1,546,572,578,0,0,0,0,0,0),('management',579,576,'admin/commerce/orders/add/%','admin/commerce/orders/add/%','Create an order','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"Create a new order for the specified user.\";}}','system',0,0,0,0,0,5,0,1,546,572,576,579,0,0,0,0,0),('management',580,574,'admin/commerce/orders/%/delete','admin/commerce/orders/%/delete','Delete','a:0:{}','system',-1,0,0,0,20,5,0,1,546,572,574,580,0,0,0,0,0),('management',581,574,'admin/commerce/orders/%/edit','admin/commerce/orders/%/edit','Edit','a:0:{}','system',-1,0,0,0,-5,5,0,1,546,572,574,581,0,0,0,0,0),('management',583,577,'admin/commerce/config/order/settings','admin/commerce/config/order/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,1,546,547,577,583,0,0,0,0,0),('management',585,574,'admin/commerce/orders/%/view','admin/commerce/orders/%/view','View','a:0:{}','system',-1,0,0,0,-10,5,0,1,546,572,574,585,0,0,0,0,0),('management',586,574,'admin/commerce/orders/%/revisions','admin/commerce/orders/%/revisions','Revisions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"View revisions of this order.\";}}','system',-1,0,0,0,20,5,0,1,546,572,574,586,0,0,0,0,0),('management',595,12,'admin/help/commerce_checkout','admin/help/commerce_checkout','commerce_checkout','a:0:{}','system',-1,0,0,0,0,3,0,1,12,595,0,0,0,0,0,0,0),('management',596,12,'admin/help/commerce_payment_ui','admin/help/commerce_payment_ui','commerce_payment_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,596,0,0,0,0,0,0,0),('management',597,547,'admin/commerce/config/checkout','admin/commerce/config/checkout','Checkout settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:57:\"Customize the checkout form and configure checkout rules.\";}}','system',0,0,0,0,0,4,0,1,546,547,597,0,0,0,0,0,0),('management',598,547,'admin/commerce/config/payment-methods','admin/commerce/config/payment-methods','Payment methods','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:56:\"Enable and configure payment method rule configurations.\";}}','system',0,0,1,0,0,4,0,1,546,547,598,0,0,0,0,0,0),('management',599,598,'admin/commerce/config/payment-methods/add','admin/commerce/config/payment-methods/add','Add a payment method rule','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Adds an additional payment method rule configuration.\";}}','system',0,0,0,0,0,5,0,1,546,547,598,599,0,0,0,0,0),('management',600,597,'admin/commerce/config/checkout/form','admin/commerce/config/checkout/form','Checkout form','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:70:\"Build your checkout pages using module defined checkout form elements.\";}}','system',-1,0,1,0,0,5,0,1,546,547,597,600,0,0,0,0,0),('management',601,597,'admin/commerce/config/checkout/rules','admin/commerce/config/checkout/rules','Checkout rules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Enable and configure checkout completion rules.\";}}','system',-1,0,0,0,5,5,0,1,546,547,597,601,0,0,0,0,0),('management',602,574,'admin/commerce/orders/%/payment','admin/commerce/orders/%/payment','Payment','a:0:{}','system',-1,0,1,0,10,5,0,1,546,572,574,602,0,0,0,0,0),('management',603,602,'admin/commerce/orders/%/payment/%','admin/commerce/orders/%/payment/%','','a:0:{}','system',0,0,0,0,0,6,0,1,546,572,574,602,603,0,0,0,0),('management',604,598,'admin/commerce/config/payment-methods/manage/%','admin/commerce/config/payment-methods/manage/%','','a:0:{}','system',-1,0,1,0,0,5,0,1,546,547,598,604,0,0,0,0,0),('management',605,601,'admin/commerce/config/checkout/rules/add','admin/commerce/config/checkout/rules/add','Add a checkout rule','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:58:\"Adds an additional checkout completion rule configuration.\";}}','system',-1,0,0,0,0,6,0,1,546,547,597,601,605,0,0,0,0),('management',606,581,'admin/commerce/orders/%/edit/checkout','admin/commerce/orders/%/edit/checkout','Simulate checkout completion','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:60:\"Directly invokes the checkout completion rules on the order.\";}}','system',-1,0,0,0,0,6,0,1,546,572,574,581,606,0,0,0,0),('management',607,600,'admin/commerce/config/checkout/form/pane/%','admin/commerce/config/checkout/form/pane/%','','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Configure the settings for a checkout pane.\";}}','system',0,0,0,0,0,6,0,1,546,547,597,600,607,0,0,0,0),('management',608,604,'admin/commerce/config/payment-methods/manage/%/clone','admin/commerce/config/payment-methods/manage/%/clone','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,608,0,0,0,0),('management',609,601,'admin/commerce/config/checkout/rules/manage/%','admin/commerce/config/checkout/rules/manage/%','','a:0:{}','system',-1,0,1,0,0,6,0,1,546,547,597,601,609,0,0,0,0),('management',610,604,'admin/commerce/config/payment-methods/manage/%/execute','admin/commerce/config/payment-methods/manage/%/execute','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,610,0,0,0,0),('management',611,604,'admin/commerce/config/payment-methods/manage/%/export','admin/commerce/config/payment-methods/manage/%/export','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,611,0,0,0,0),('management',612,603,'admin/commerce/orders/%/payment/%/delete','admin/commerce/orders/%/payment/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,546,572,574,602,603,612,0,0,0),('management',613,603,'admin/commerce/orders/%/payment/%/view','admin/commerce/orders/%/payment/%/view','View','a:0:{}','system',-1,0,0,0,0,7,0,1,546,572,574,602,603,613,0,0,0),('management',614,604,'admin/commerce/config/payment-methods/manage/%/%','admin/commerce/config/payment-methods/manage/%/%','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,614,0,0,0,0),('management',615,609,'admin/commerce/config/checkout/rules/manage/%/clone','admin/commerce/config/checkout/rules/manage/%/clone','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,615,0,0,0),('management',616,609,'admin/commerce/config/checkout/rules/manage/%/execute','admin/commerce/config/checkout/rules/manage/%/execute','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,616,0,0,0),('management',617,609,'admin/commerce/config/checkout/rules/manage/%/export','admin/commerce/config/checkout/rules/manage/%/export','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,617,0,0,0),('management',618,609,'admin/commerce/config/checkout/rules/manage/%/%','admin/commerce/config/checkout/rules/manage/%/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,618,0,0,0),('management',619,604,'admin/commerce/config/payment-methods/manage/%/delete/event','admin/commerce/config/payment-methods/manage/%/delete/event','Remove event','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Remove an event from a reaction rule.\";}}','system',0,0,0,0,0,6,0,1,546,547,598,604,619,0,0,0,0),('management',620,604,'admin/commerce/config/payment-methods/manage/%/delete/%','admin/commerce/config/payment-methods/manage/%/delete/%','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,620,0,0,0,0),('management',621,604,'admin/commerce/config/payment-methods/manage/%/edit/%','admin/commerce/config/payment-methods/manage/%/edit/%','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,621,0,0,0,0),('management',622,604,'admin/commerce/config/payment-methods/manage/%/add/event','admin/commerce/config/payment-methods/manage/%/add/event','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,622,0,0,0,0),('management',623,604,'admin/commerce/config/payment-methods/manage/%/add/%','admin/commerce/config/payment-methods/manage/%/add/%','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,598,604,623,0,0,0,0),('management',624,609,'admin/commerce/config/checkout/rules/manage/%/delete/event','admin/commerce/config/checkout/rules/manage/%/delete/event','Remove event','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Remove an event from a reaction rule.\";}}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,624,0,0,0),('management',625,609,'admin/commerce/config/checkout/rules/manage/%/add/event','admin/commerce/config/checkout/rules/manage/%/add/event','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,625,0,0,0),('management',626,609,'admin/commerce/config/checkout/rules/manage/%/delete/%','admin/commerce/config/checkout/rules/manage/%/delete/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,626,0,0,0),('management',627,609,'admin/commerce/config/checkout/rules/manage/%/edit/%','admin/commerce/config/checkout/rules/manage/%/edit/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,627,0,0,0),('management',628,609,'admin/commerce/config/checkout/rules/manage/%/add/%','admin/commerce/config/checkout/rules/manage/%/add/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,597,601,609,628,0,0,0),('management',629,570,'admin/commerce/config/line-items/product','admin/commerce/config/line-items/product','Product','a:0:{}','system',0,0,0,0,0,5,0,1,546,547,570,629,0,0,0,0,0),('management',630,629,'admin/commerce/config/line-items/product/display','admin/commerce/config/line-items/product/display','Manage display','a:0:{}','system',-1,0,0,0,2,6,0,1,546,547,570,629,630,0,0,0,0),('management',631,629,'admin/commerce/config/line-items/product/fields','admin/commerce/config/line-items/product/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,6,0,1,546,547,570,629,631,0,0,0,0),('navigation',639,0,'cart','cart','Shopping cart','a:0:{}','system',0,0,0,0,0,1,0,639,0,0,0,0,0,0,0,0,0),('navigation',640,639,'cart/my','cart/my','Shopping cart (# items)','a:0:{}','system',1,0,0,0,0,2,0,639,640,0,0,0,0,0,0,0,0),('management',641,12,'admin/help/commerce_product_pricing_ui','admin/help/commerce_product_pricing_ui','commerce_product_pricing_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,641,0,0,0,0,0,0,0),('management',642,547,'admin/commerce/config/product-pricing','admin/commerce/config/product-pricing','Product pricing rules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:63:\"Enable and configure product pricing rules and pre-calculation.\";}}','system',0,0,0,0,0,4,0,1,546,547,642,0,0,0,0,0,0),('management',643,572,'admin/commerce/orders/carts','admin/commerce/orders/carts','Shopping carts','a:0:{}','system',-1,0,0,0,0,4,0,1,546,572,643,0,0,0,0,0,0),('management',644,642,'admin/commerce/config/product-pricing/rules','admin/commerce/config/product-pricing/rules','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Administer the rules used for calculating product sell prices.\";}}','system',-1,0,1,0,0,5,0,1,546,547,642,644,0,0,0,0,0),('management',645,642,'admin/commerce/config/product-pricing/pre-calculation','admin/commerce/config/product-pricing/pre-calculation','Pre-calculation','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Configure the price pre-calculation settings.\";}}','system',-1,0,0,0,5,5,0,1,546,547,642,645,0,0,0,0,0),('management',646,644,'admin/commerce/config/product-pricing/rules/add','admin/commerce/config/product-pricing/rules/add','Add a pricing rule','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:61:\"Adds an additional sell price calculation rule configuration.\";}}','system',0,0,0,0,0,6,0,1,546,547,642,644,646,0,0,0,0),('management',647,581,'admin/commerce/orders/%/edit/refresh','admin/commerce/orders/%/edit/refresh','Apply pricing rules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:89:\"Executes the cart order refresh used to apply all current pricing rules on the front end.\";}}','system',-1,0,0,0,0,6,0,1,546,572,574,581,647,0,0,0,0),('management',648,644,'admin/commerce/config/product-pricing/rules/manage/%','admin/commerce/config/product-pricing/rules/manage/%','','a:0:{}','system',-1,0,1,0,0,6,0,1,546,547,642,644,648,0,0,0,0),('management',649,648,'admin/commerce/config/product-pricing/rules/manage/%/clone','admin/commerce/config/product-pricing/rules/manage/%/clone','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,649,0,0,0),('management',650,648,'admin/commerce/config/product-pricing/rules/manage/%/execute','admin/commerce/config/product-pricing/rules/manage/%/execute','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,650,0,0,0),('management',651,648,'admin/commerce/config/product-pricing/rules/manage/%/export','admin/commerce/config/product-pricing/rules/manage/%/export','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,651,0,0,0),('management',652,648,'admin/commerce/config/product-pricing/rules/manage/%/%','admin/commerce/config/product-pricing/rules/manage/%/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,652,0,0,0),('management',653,648,'admin/commerce/config/product-pricing/rules/manage/%/delete/event','admin/commerce/config/product-pricing/rules/manage/%/delete/event','Remove event','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Remove an event from a reaction rule.\";}}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,653,0,0,0),('management',654,648,'admin/commerce/config/product-pricing/rules/manage/%/add/event','admin/commerce/config/product-pricing/rules/manage/%/add/event','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,654,0,0,0),('management',655,648,'admin/commerce/config/product-pricing/rules/manage/%/delete/%','admin/commerce/config/product-pricing/rules/manage/%/delete/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,655,0,0,0),('management',656,648,'admin/commerce/config/product-pricing/rules/manage/%/edit/%','admin/commerce/config/product-pricing/rules/manage/%/edit/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,656,0,0,0),('management',657,648,'admin/commerce/config/product-pricing/rules/manage/%/add/%','admin/commerce/config/product-pricing/rules/manage/%/add/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,642,644,648,657,0,0,0),('management',658,12,'admin/help/commerce_product_ui','admin/help/commerce_product_ui','commerce_product_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,658,0,0,0,0,0,0,0),('management',659,546,'admin/commerce/products','admin/commerce/products','Products','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Manage products and product types in the store.\";}}','system',0,0,1,0,0,3,0,1,546,659,0,0,0,0,0,0,0),('management',660,659,'admin/commerce/products/%','admin/commerce/products/%','','a:0:{}','system',0,0,0,0,0,4,0,1,546,659,660,0,0,0,0,0,0),('management',661,659,'admin/commerce/products/add','admin/commerce/products/add','Add a product','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"Add a new product for sale.\";}}','system',0,0,1,0,10,4,0,1,546,659,661,0,0,0,0,0,0),('management',662,659,'admin/commerce/products/types','admin/commerce/products/types','Product types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Manage products types for your store.\";}}','system',-1,0,1,0,0,4,0,1,546,659,662,0,0,0,0,0,0),('management',663,659,'admin/commerce/products/list','admin/commerce/products/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,546,659,663,0,0,0,0,0,0),('management',664,662,'admin/commerce/products/types/add','admin/commerce/products/types/add','Add product type','a:0:{}','system',-1,0,0,0,0,5,0,1,546,659,662,664,0,0,0,0,0),('management',665,661,'admin/commerce/products/add/product','admin/commerce/products/add/product','Create !name','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:21:\"A basic product type.\";}}','system',0,0,0,0,0,5,0,1,546,659,661,665,0,0,0,0,0),('management',666,660,'admin/commerce/products/%/delete','admin/commerce/products/%/delete','Delete','a:0:{}','system',-1,0,0,0,20,5,0,1,546,659,660,666,0,0,0,0,0),('management',667,660,'admin/commerce/products/%/edit','admin/commerce/products/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,1,546,659,660,667,0,0,0,0,0),('management',668,662,'admin/commerce/products/types/product','admin/commerce/products/types/product','Product','a:0:{}','system',0,0,0,0,0,5,0,1,546,659,662,668,0,0,0,0,0),('management',669,660,'admin/commerce/products/%/revisions','admin/commerce/products/%/revisions','Revisions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"View revisions of this product.\";}}','system',-1,0,0,0,0,5,0,1,546,659,660,669,0,0,0,0,0),('management',670,668,'admin/commerce/products/types/product/delete','admin/commerce/products/types/product/delete','Delete','a:0:{}','system',-1,0,0,0,10,6,0,1,546,659,662,668,670,0,0,0,0),('management',671,668,'admin/commerce/products/types/product/edit','admin/commerce/products/types/product/edit','Edit','a:0:{}','system',-1,0,0,0,0,6,0,1,546,659,662,668,671,0,0,0,0),('management',672,668,'admin/commerce/products/types/product/display','admin/commerce/products/types/product/display','Manage display','a:0:{}','system',-1,0,0,0,2,6,0,1,546,659,662,668,672,0,0,0,0),('management',673,668,'admin/commerce/products/types/product/fields','admin/commerce/products/types/product/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,6,0,1,546,659,662,668,673,0,0,0,0),('management',683,12,'admin/help/commerce_tax_ui','admin/help/commerce_tax_ui','commerce_tax_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,683,0,0,0,0,0,0,0),('management',684,547,'admin/commerce/config/taxes','admin/commerce/config/taxes','Taxes','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"Manage tax rates and types.\";}}','system',0,0,0,0,0,4,0,1,546,547,684,0,0,0,0,0,0),('management',685,684,'admin/commerce/config/taxes/rates','admin/commerce/config/taxes/rates','Tax rates','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Manage tax rates.\";}}','system',-1,0,0,0,0,5,0,1,546,547,684,685,0,0,0,0,0),('management',686,684,'admin/commerce/config/taxes/types','admin/commerce/config/taxes/types','Tax types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Manage tax types.\";}}','system',-1,0,1,0,5,5,0,1,546,547,684,686,0,0,0,0,0),('management',687,686,'admin/commerce/config/taxes/types/sales-tax','admin/commerce/config/taxes/types/sales-tax','','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:16:\"Edit a tax type.\";}}','system',0,0,0,0,0,6,0,1,546,547,684,686,687,0,0,0,0),('management',688,686,'admin/commerce/config/taxes/types/vat','admin/commerce/config/taxes/types/vat','','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:16:\"Edit a tax type.\";}}','system',0,0,0,0,0,6,0,1,546,547,684,686,688,0,0,0,0),('management',689,685,'admin/commerce/config/taxes/rates/add','admin/commerce/config/taxes/rates/add','Add a tax rate','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Create a new tax rate.\";}}','system',-1,0,0,0,0,6,0,1,546,547,684,685,689,0,0,0,0),('management',690,686,'admin/commerce/config/taxes/types/add','admin/commerce/config/taxes/types/add','Add a tax type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Create a new tax type.\";}}','system',-1,0,0,0,0,6,0,1,546,547,684,686,690,0,0,0,0),('management',691,687,'admin/commerce/config/taxes/types/sales-tax/rule','admin/commerce/config/taxes/types/sales-tax/rule','Configure rule','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:72:\"Add conditions to the rule used to apply taxes of this type to products.\";}}','system',-1,0,0,0,5,7,0,1,546,547,684,686,687,691,0,0,0),('management',692,688,'admin/commerce/config/taxes/types/vat/rule','admin/commerce/config/taxes/types/vat/rule','Configure rule','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:72:\"Add conditions to the rule used to apply taxes of this type to products.\";}}','system',-1,0,0,0,5,7,0,1,546,547,684,686,688,692,0,0,0),('management',693,687,'admin/commerce/config/taxes/types/sales-tax/delete','admin/commerce/config/taxes/types/sales-tax/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,546,547,684,686,687,693,0,0,0),('management',694,688,'admin/commerce/config/taxes/types/vat/delete','admin/commerce/config/taxes/types/vat/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,546,547,684,686,688,694,0,0,0),('management',695,687,'admin/commerce/config/taxes/types/sales-tax/edit','admin/commerce/config/taxes/types/sales-tax/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,684,686,687,695,0,0,0),('management',696,688,'admin/commerce/config/taxes/types/vat/edit','admin/commerce/config/taxes/types/vat/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,684,686,688,696,0,0,0),('management',697,12,'admin/help/commerce_shipping_ui','admin/help/commerce_shipping_ui','commerce_shipping_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,697,0,0,0,0,0,0,0),('management',698,547,'admin/commerce/config/shipping','admin/commerce/config/shipping','Shipping','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Manage shipping methods and services.\";}}','system',0,0,0,0,0,4,0,1,546,547,698,0,0,0,0,0,0),('management',699,698,'admin/commerce/config/shipping/calculation-rules','admin/commerce/config/shipping/calculation-rules','Calculation rules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:55:\"Add and configure your shipping rate calculation rules.\";}}','system',-1,0,1,0,10,5,0,1,546,547,698,699,0,0,0,0,0),('management',700,552,'admin/commerce/customer-profiles/add/shipping','admin/commerce/customer-profiles/add/shipping','Create @name','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:81:\"The profile used to collect shipping information on the checkout and order forms.\";}}','system',0,0,0,0,0,5,0,1,546,550,552,700,0,0,0,0,0),('management',701,570,'admin/commerce/config/line-items/shipping','admin/commerce/config/line-items/shipping','Shipping','a:0:{}','system',0,0,0,0,0,5,0,1,546,547,570,701,0,0,0,0,0),('management',702,553,'admin/commerce/customer-profiles/types/shipping','admin/commerce/customer-profiles/types/shipping','Shipping information','a:0:{}','system',0,0,0,0,0,5,0,1,546,550,553,702,0,0,0,0,0),('management',703,698,'admin/commerce/config/shipping/methods','admin/commerce/config/shipping/methods','Shipping methods','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Manage shipping methods.\";}}','system',-1,0,0,0,5,5,0,1,546,547,698,703,0,0,0,0,0),('management',704,698,'admin/commerce/config/shipping/services','admin/commerce/config/shipping/services','Shipping services','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Manage shipping services.\";}}','system',-1,0,0,0,0,5,0,1,546,547,698,704,0,0,0,0,0),('management',705,699,'admin/commerce/config/shipping/calculation-rules/add','admin/commerce/config/shipping/calculation-rules/add','Add a calculation rule','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Adds an additional shipping rate calculation rule configuration.\";}}','system',0,0,0,0,0,6,0,1,546,547,698,699,705,0,0,0,0),('management',706,702,'admin/commerce/customer-profiles/types/shipping/display','admin/commerce/customer-profiles/types/shipping/display','Manage display','a:0:{}','system',-1,0,0,0,2,6,0,1,546,550,553,702,706,0,0,0,0),('management',707,701,'admin/commerce/config/line-items/shipping/display','admin/commerce/config/line-items/shipping/display','Manage display','a:0:{}','system',-1,0,0,0,2,6,0,1,546,547,570,701,707,0,0,0,0),('management',708,702,'admin/commerce/customer-profiles/types/shipping/fields','admin/commerce/customer-profiles/types/shipping/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,6,0,1,546,550,553,702,708,0,0,0,0),('management',709,701,'admin/commerce/config/line-items/shipping/fields','admin/commerce/config/line-items/shipping/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,6,0,1,546,547,570,701,709,0,0,0,0),('management',710,699,'admin/commerce/config/shipping/calculation-rules/manage/%','admin/commerce/config/shipping/calculation-rules/manage/%','','a:0:{}','system',-1,0,1,0,0,6,0,1,546,547,698,699,710,0,0,0,0),('management',718,710,'admin/commerce/config/shipping/calculation-rules/manage/%/clone','admin/commerce/config/shipping/calculation-rules/manage/%/clone','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,718,0,0,0),('management',719,710,'admin/commerce/config/shipping/calculation-rules/manage/%/execute','admin/commerce/config/shipping/calculation-rules/manage/%/execute','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,719,0,0,0),('management',720,710,'admin/commerce/config/shipping/calculation-rules/manage/%/export','admin/commerce/config/shipping/calculation-rules/manage/%/export','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,720,0,0,0),('management',721,710,'admin/commerce/config/shipping/calculation-rules/manage/%/%','admin/commerce/config/shipping/calculation-rules/manage/%/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,721,0,0,0),('management',730,710,'admin/commerce/config/shipping/calculation-rules/manage/%/delete/event','admin/commerce/config/shipping/calculation-rules/manage/%/delete/event','Remove event','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Remove an event from a reaction rule.\";}}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,730,0,0,0),('management',731,710,'admin/commerce/config/shipping/calculation-rules/manage/%/add/event','admin/commerce/config/shipping/calculation-rules/manage/%/add/event','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,731,0,0,0),('management',732,710,'admin/commerce/config/shipping/calculation-rules/manage/%/delete/%','admin/commerce/config/shipping/calculation-rules/manage/%/delete/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,732,0,0,0),('management',733,710,'admin/commerce/config/shipping/calculation-rules/manage/%/edit/%','admin/commerce/config/shipping/calculation-rules/manage/%/edit/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,733,0,0,0),('management',734,710,'admin/commerce/config/shipping/calculation-rules/manage/%/add/%','admin/commerce/config/shipping/calculation-rules/manage/%/add/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,698,699,710,734,0,0,0),('management',735,547,'admin/commerce/config/stock','admin/commerce/config/stock','Stock management','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"Configure stock management.\";}}','system',0,0,0,0,0,4,0,1,546,547,735,0,0,0,0,0,0),('management',736,603,'admin/commerce/orders/%/payment/%/paypal-wpp-capture','admin/commerce/orders/%/payment/%/paypal-wpp-capture','Capture','a:0:{}','system',-1,0,0,0,2,7,0,1,546,572,574,602,603,736,0,0,0),('management',737,603,'admin/commerce/orders/%/payment/%/cod-payment','admin/commerce/orders/%/payment/%/cod-payment','Cash','a:0:{}','system',-1,0,0,0,2,7,0,1,546,572,574,602,603,737,0,0,0),('navigation',738,6,'node/add/mt-product','node/add/mt-product','Product','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Use the Product content type to create and sell products (e.g.: e-books) making use of all the relevant, special functionality built into the News+ theme.\";}}','system',0,0,0,0,0,2,0,6,738,0,0,0,0,0,0,0,0),('menu-secondary-menu',744,0,'products','products','Store','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,1,0,-47,1,1,744,0,0,0,0,0,0,0,0,0),('menu-secondary-menu',745,744,'products-2c','products-2c','Store - 2 columns','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,744,745,0,0,0,0,0,0,0,0),('menu-secondary-menu',746,744,'products','products','Store - 3 columns','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,744,746,0,0,0,0,0,0,0,0),('menu-secondary-menu',747,744,'products-4c','products-4c','Store - 4 columns','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,0,2,1,744,747,0,0,0,0,0,0,0,0),('navigation',786,0,'comment/%','comment/%','Comment permalink','a:0:{}','system',0,0,1,0,0,1,0,786,0,0,0,0,0,0,0,0,0),('navigation',787,0,'comment/reply/%','comment/reply/%','Add new comment','a:0:{}','system',0,0,0,0,0,1,0,787,0,0,0,0,0,0,0,0,0),('navigation',788,786,'comment/%/approve','comment/%/approve','Approve','a:0:{}','system',0,0,0,0,1,2,0,786,788,0,0,0,0,0,0,0,0),('navigation',789,786,'comment/%/delete','comment/%/delete','Delete','a:0:{}','system',-1,0,0,0,2,2,0,786,789,0,0,0,0,0,0,0,0),('navigation',790,786,'comment/%/edit','comment/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,786,790,0,0,0,0,0,0,0,0),('navigation',791,786,'comment/%/view','comment/%/view','View comment','a:0:{}','system',-1,0,0,0,-10,2,0,786,791,0,0,0,0,0,0,0,0),('management',792,9,'admin/content/comment','admin/content/comment','Comments','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"List and edit site comments and the comment approval queue.\";}}','system',0,0,0,0,0,3,0,1,9,792,0,0,0,0,0,0,0),('management',793,12,'admin/help/comment','admin/help/comment','comment','a:0:{}','system',-1,0,0,0,0,3,0,1,12,793,0,0,0,0,0,0,0),('management',794,792,'admin/content/comment/new','admin/content/comment/new','Published comments','a:0:{}','system',-1,0,0,0,-10,4,0,1,9,792,794,0,0,0,0,0,0),('management',795,792,'admin/content/comment/approval','admin/content/comment/approval','Unapproved comments','a:0:{}','system',-1,0,0,0,0,4,0,1,9,792,795,0,0,0,0,0,0),('management',796,135,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%/comment/display','Comment display','a:0:{}','system',-1,0,0,0,4,5,0,1,21,36,135,796,0,0,0,0,0),('management',797,135,'admin/structure/types/manage/%/comment/fields','admin/structure/types/manage/%/comment/fields','Comment fields','a:0:{}','system',-1,0,1,0,3,5,0,1,21,36,135,797,0,0,0,0,0),('management',805,64,'admin/config/services/oauth','admin/config/services/oauth','OAuth','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Settings for OAuth\";}}','system',0,0,0,0,0,4,0,1,8,64,805,0,0,0,0,0,0),('management',806,805,'admin/config/services/oauth/settings','admin/config/services/oauth/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Settings for OAuth\";}}','system',-1,0,0,0,0,5,0,1,8,64,805,806,0,0,0,0,0),('management',807,64,'admin/config/services/twitter','admin/config/services/twitter','Twitter','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Twitter accounts and settings.\";}}','system',0,0,0,0,0,4,0,1,8,64,807,0,0,0,0,0,0),('navigation',808,40,'user/%/edit/twitter','user/%/edit/twitter','Twitter accounts','a:0:{}','system',-1,0,0,0,10,3,0,17,40,808,0,0,0,0,0,0,0),('management',809,807,'admin/config/services/twitter/settings','admin/config/services/twitter/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Twitter settings.\";}}','system',-1,0,0,0,0,5,0,1,8,64,807,809,0,0,0,0,0),('management',810,807,'admin/config/services/twitter/default','admin/config/services/twitter/default','Twitter','a:0:{}','system',-1,0,0,0,0,5,0,1,8,64,807,810,0,0,0,0,0),('management',811,21,'admin/structure/bulk-export','admin/structure/bulk-export','Bulk Exporter','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:57:\"Bulk-export multiple CTools-handled data objects to code.\";}}','system',0,0,0,0,0,3,0,1,21,811,0,0,0,0,0,0,0),('management',904,577,'admin/commerce/config/order/display','admin/commerce/config/order/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,546,547,577,904,0,0,0,0,0),('management',905,89,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,21,57,89,905,0,0,0,0,0),('management',906,90,'admin/config/people/accounts/display','admin/config/people/accounts/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,8,48,90,906,0,0,0,0,0),('management',907,577,'admin/commerce/config/order/fields','admin/commerce/config/order/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,546,547,577,907,0,0,0,0,0),('management',908,89,'admin/structure/taxonomy/%/fields','admin/structure/taxonomy/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,21,57,89,908,0,0,0,0,0),('management',909,90,'admin/config/people/accounts/fields','admin/config/people/accounts/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,8,48,90,909,0,0,0,0,0),('management',910,904,'admin/commerce/config/order/display/administrator','admin/commerce/config/order/display/administrator','Administrator','a:0:{}','system',-1,0,0,0,0,6,0,1,546,547,577,904,910,0,0,0,0),('management',911,904,'admin/commerce/config/order/display/customer','admin/commerce/config/order/display/customer','Customer','a:0:{}','system',-1,0,0,0,1,6,0,1,546,547,577,904,911,0,0,0,0),('management',912,904,'admin/commerce/config/order/display/default','admin/commerce/config/order/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,546,547,577,904,912,0,0,0,0),('management',913,905,'admin/structure/taxonomy/%/display/default','admin/structure/taxonomy/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,57,89,905,913,0,0,0,0),('management',914,906,'admin/config/people/accounts/display/default','admin/config/people/accounts/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,8,48,90,906,914,0,0,0,0),('management',915,135,'admin/structure/types/manage/%/display','admin/structure/types/manage/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,21,36,135,915,0,0,0,0,0),('management',916,135,'admin/structure/types/manage/%/fields','admin/structure/types/manage/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,21,36,135,916,0,0,0,0,0),('management',917,905,'admin/structure/taxonomy/%/display/full','admin/structure/taxonomy/%/display/full','Taxonomy term page','a:0:{}','system',-1,0,0,0,0,6,0,1,21,57,89,905,917,0,0,0,0),('management',918,906,'admin/config/people/accounts/display/full','admin/config/people/accounts/display/full','User account','a:0:{}','system',-1,0,0,0,0,6,0,1,8,48,90,906,918,0,0,0,0),('management',919,907,'admin/commerce/config/order/fields/%','admin/commerce/config/order/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,546,547,577,907,919,0,0,0,0),('management',920,908,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,57,89,908,920,0,0,0,0),('management',921,909,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,8,48,90,909,921,0,0,0,0),('management',922,672,'admin/commerce/products/types/product/display/full','admin/commerce/products/types/product/display/full','Admin display','a:0:{}','system',-1,0,0,0,0,7,0,1,546,659,662,668,672,922,0,0,0),('management',923,559,'admin/commerce/customer-profiles/types/billing/display/administrator','admin/commerce/customer-profiles/types/billing/display/administrator','Administrator','a:0:{}','system',-1,0,0,0,0,7,0,1,546,550,553,555,559,923,0,0,0),('management',924,706,'admin/commerce/customer-profiles/types/shipping/display/administrator','admin/commerce/customer-profiles/types/shipping/display/administrator','Administrator','a:0:{}','system',-1,0,0,0,0,7,0,1,546,550,553,702,706,924,0,0,0),('management',925,672,'admin/commerce/products/types/product/display/commerce_line_item_display','admin/commerce/products/types/product/display/commerce_line_item_display','Commerce Line item: Display','a:0:{}','system',-1,0,0,0,3,7,0,1,546,659,662,668,672,925,0,0,0),('management',926,559,'admin/commerce/customer-profiles/types/billing/display/customer','admin/commerce/customer-profiles/types/billing/display/customer','Customer','a:0:{}','system',-1,0,0,0,1,7,0,1,546,550,553,555,559,926,0,0,0),('management',927,706,'admin/commerce/customer-profiles/types/shipping/display/customer','admin/commerce/customer-profiles/types/shipping/display/customer','Customer','a:0:{}','system',-1,0,0,0,1,7,0,1,546,550,553,702,706,927,0,0,0),('management',928,559,'admin/commerce/customer-profiles/types/billing/display/default','admin/commerce/customer-profiles/types/billing/display/default','Default','a:0:{}','system',-1,0,0,0,-10,7,0,1,546,550,553,555,559,928,0,0,0),('management',929,706,'admin/commerce/customer-profiles/types/shipping/display/default','admin/commerce/customer-profiles/types/shipping/display/default','Default','a:0:{}','system',-1,0,0,0,-10,7,0,1,546,550,553,702,706,929,0,0,0),('management',930,630,'admin/commerce/config/line-items/product/display/default','admin/commerce/config/line-items/product/display/default','Default','a:0:{}','system',-1,0,0,0,-10,7,0,1,546,547,570,629,630,930,0,0,0),('management',931,707,'admin/commerce/config/line-items/shipping/display/default','admin/commerce/config/line-items/shipping/display/default','Default','a:0:{}','system',-1,0,0,0,-10,7,0,1,546,547,570,701,707,931,0,0,0),('management',932,672,'admin/commerce/products/types/product/display/default','admin/commerce/products/types/product/display/default','Default','a:0:{}','system',-1,0,0,0,-10,7,0,1,546,659,662,668,672,932,0,0,0),('management',933,915,'admin/structure/types/manage/%/display/default','admin/structure/types/manage/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,36,135,915,933,0,0,0,0),('management',934,630,'admin/commerce/config/line-items/product/display/display','admin/commerce/config/line-items/product/display/display','Display','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,570,629,630,934,0,0,0),('management',935,707,'admin/commerce/config/line-items/shipping/display/display','admin/commerce/config/line-items/shipping/display/display','Display','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,570,701,707,935,0,0,0),('management',936,915,'admin/structure/types/manage/%/display/full','admin/structure/types/manage/%/display/full','Full content','a:0:{}','system',-1,0,0,0,0,6,0,1,21,36,135,915,936,0,0,0,0),('management',937,672,'admin/commerce/products/types/product/display/line_item','admin/commerce/products/types/product/display/line_item','Line item','a:0:{}','system',-1,0,0,0,2,7,0,1,546,659,662,668,672,937,0,0,0),('management',938,672,'admin/commerce/products/types/product/display/node_full','admin/commerce/products/types/product/display/node_full','Node: Full content','a:0:{}','system',-1,0,0,0,5,7,0,1,546,659,662,668,672,938,0,0,0),('management',939,672,'admin/commerce/products/types/product/display/node_rss','admin/commerce/products/types/product/display/node_rss','Node: RSS','a:0:{}','system',-1,0,0,0,7,7,0,1,546,659,662,668,672,939,0,0,0),('management',940,672,'admin/commerce/products/types/product/display/node_search_index','admin/commerce/products/types/product/display/node_search_index','Node: Search index','a:0:{}','system',-1,0,0,0,8,7,0,1,546,659,662,668,672,940,0,0,0),('management',941,672,'admin/commerce/products/types/product/display/node_search_result','admin/commerce/products/types/product/display/node_search_result','Node: Search result highlighting input','a:0:{}','system',-1,0,0,0,9,7,0,1,546,659,662,668,672,941,0,0,0),('management',942,672,'admin/commerce/products/types/product/display/node_teaser','admin/commerce/products/types/product/display/node_teaser','Node: Teaser','a:0:{}','system',-1,0,0,0,6,7,0,1,546,659,662,668,672,942,0,0,0),('management',943,915,'admin/structure/types/manage/%/display/rss','admin/structure/types/manage/%/display/rss','RSS','a:0:{}','system',-1,0,0,0,2,6,0,1,21,36,135,915,943,0,0,0,0),('management',944,915,'admin/structure/types/manage/%/display/search_index','admin/structure/types/manage/%/display/search_index','Search index','a:0:{}','system',-1,0,0,0,3,6,0,1,21,36,135,915,944,0,0,0,0),('management',945,915,'admin/structure/types/manage/%/display/search_result','admin/structure/types/manage/%/display/search_result','Search result highlighting input','a:0:{}','system',-1,0,0,0,4,6,0,1,21,36,135,915,945,0,0,0,0),('management',946,915,'admin/structure/types/manage/%/display/teaser','admin/structure/types/manage/%/display/teaser','Teaser','a:0:{}','system',-1,0,0,0,1,6,0,1,21,36,135,915,946,0,0,0,0),('management',947,560,'admin/commerce/customer-profiles/types/billing/fields/%','admin/commerce/customer-profiles/types/billing/fields/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,550,553,555,560,947,0,0,0),('management',948,708,'admin/commerce/customer-profiles/types/shipping/fields/%','admin/commerce/customer-profiles/types/shipping/fields/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,550,553,702,708,948,0,0,0),('management',949,631,'admin/commerce/config/line-items/product/fields/%','admin/commerce/config/line-items/product/fields/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,570,629,631,949,0,0,0),('management',950,709,'admin/commerce/config/line-items/shipping/fields/%','admin/commerce/config/line-items/shipping/fields/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,547,570,701,709,950,0,0,0),('management',951,919,'admin/commerce/config/order/fields/%/delete','admin/commerce/config/order/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,546,547,577,907,919,951,0,0,0),('management',952,919,'admin/commerce/config/order/fields/%/edit','admin/commerce/config/order/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,577,907,919,952,0,0,0),('management',953,919,'admin/commerce/config/order/fields/%/field-settings','admin/commerce/config/order/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,577,907,919,953,0,0,0),('management',954,919,'admin/commerce/config/order/fields/%/widget-type','admin/commerce/config/order/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,546,547,577,907,919,954,0,0,0),('management',955,673,'admin/commerce/products/types/product/fields/%','admin/commerce/products/types/product/fields/%','','a:0:{}','system',0,0,0,0,0,7,0,1,546,659,662,668,673,955,0,0,0),('management',956,916,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,36,135,916,956,0,0,0,0),('management',957,920,'admin/structure/taxonomy/%/fields/%/delete','admin/structure/taxonomy/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,57,89,908,920,957,0,0,0),('management',958,920,'admin/structure/taxonomy/%/fields/%/edit','admin/structure/taxonomy/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,89,908,920,958,0,0,0),('management',959,920,'admin/structure/taxonomy/%/fields/%/field-settings','admin/structure/taxonomy/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,89,908,920,959,0,0,0),('management',960,920,'admin/structure/taxonomy/%/fields/%/widget-type','admin/structure/taxonomy/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,89,908,920,960,0,0,0),('management',961,921,'admin/config/people/accounts/fields/%/delete','admin/config/people/accounts/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,8,48,90,909,921,961,0,0,0),('management',962,921,'admin/config/people/accounts/fields/%/edit','admin/config/people/accounts/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,90,909,921,962,0,0,0),('management',963,921,'admin/config/people/accounts/fields/%/field-settings','admin/config/people/accounts/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,90,909,921,963,0,0,0),('management',964,921,'admin/config/people/accounts/fields/%/widget-type','admin/config/people/accounts/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,90,909,921,964,0,0,0),('management',965,796,'admin/structure/types/manage/%/comment/display/default','admin/structure/types/manage/%/comment/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,36,135,796,965,0,0,0,0),('management',966,796,'admin/structure/types/manage/%/comment/display/full','admin/structure/types/manage/%/comment/display/full','Full comment','a:0:{}','system',-1,0,0,0,0,6,0,1,21,36,135,796,966,0,0,0,0),('management',967,797,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,36,135,797,967,0,0,0,0),('management',968,947,'admin/commerce/customer-profiles/types/billing/fields/%/delete','admin/commerce/customer-profiles/types/billing/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,8,0,1,546,550,553,555,560,947,968,0,0),('management',969,947,'admin/commerce/customer-profiles/types/billing/fields/%/edit','admin/commerce/customer-profiles/types/billing/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,8,0,1,546,550,553,555,560,947,969,0,0),('management',970,947,'admin/commerce/customer-profiles/types/billing/fields/%/field-settings','admin/commerce/customer-profiles/types/billing/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,8,0,1,546,550,553,555,560,947,970,0,0),('management',971,947,'admin/commerce/customer-profiles/types/billing/fields/%/widget-type','admin/commerce/customer-profiles/types/billing/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,8,0,1,546,550,553,555,560,947,971,0,0),('management',972,948,'admin/commerce/customer-profiles/types/shipping/fields/%/delete','admin/commerce/customer-profiles/types/shipping/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,8,0,1,546,550,553,702,708,948,972,0,0),('management',973,948,'admin/commerce/customer-profiles/types/shipping/fields/%/edit','admin/commerce/customer-profiles/types/shipping/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,8,0,1,546,550,553,702,708,948,973,0,0),('management',974,948,'admin/commerce/customer-profiles/types/shipping/fields/%/field-settings','admin/commerce/customer-profiles/types/shipping/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,8,0,1,546,550,553,702,708,948,974,0,0),('management',975,948,'admin/commerce/customer-profiles/types/shipping/fields/%/widget-type','admin/commerce/customer-profiles/types/shipping/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,8,0,1,546,550,553,702,708,948,975,0,0),('management',976,949,'admin/commerce/config/line-items/product/fields/%/delete','admin/commerce/config/line-items/product/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,8,0,1,546,547,570,629,631,949,976,0,0),('management',977,949,'admin/commerce/config/line-items/product/fields/%/edit','admin/commerce/config/line-items/product/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,8,0,1,546,547,570,629,631,949,977,0,0),('management',978,949,'admin/commerce/config/line-items/product/fields/%/field-settings','admin/commerce/config/line-items/product/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,8,0,1,546,547,570,629,631,949,978,0,0),('management',979,949,'admin/commerce/config/line-items/product/fields/%/widget-type','admin/commerce/config/line-items/product/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,8,0,1,546,547,570,629,631,949,979,0,0),('management',980,950,'admin/commerce/config/line-items/shipping/fields/%/delete','admin/commerce/config/line-items/shipping/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,8,0,1,546,547,570,701,709,950,980,0,0),('management',981,950,'admin/commerce/config/line-items/shipping/fields/%/edit','admin/commerce/config/line-items/shipping/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,8,0,1,546,547,570,701,709,950,981,0,0),('management',982,950,'admin/commerce/config/line-items/shipping/fields/%/field-settings','admin/commerce/config/line-items/shipping/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,8,0,1,546,547,570,701,709,950,982,0,0),('management',983,950,'admin/commerce/config/line-items/shipping/fields/%/widget-type','admin/commerce/config/line-items/shipping/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,8,0,1,546,547,570,701,709,950,983,0,0),('management',984,955,'admin/commerce/products/types/product/fields/%/delete','admin/commerce/products/types/product/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,8,0,1,546,659,662,668,673,955,984,0,0),('management',985,955,'admin/commerce/products/types/product/fields/%/edit','admin/commerce/products/types/product/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,8,0,1,546,659,662,668,673,955,985,0,0),('management',986,955,'admin/commerce/products/types/product/fields/%/field-settings','admin/commerce/products/types/product/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,8,0,1,546,659,662,668,673,955,986,0,0),('management',987,955,'admin/commerce/products/types/product/fields/%/widget-type','admin/commerce/products/types/product/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,8,0,1,546,659,662,668,673,955,987,0,0),('management',988,956,'admin/structure/types/manage/%/fields/%/delete','admin/structure/types/manage/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,36,135,916,956,988,0,0,0),('management',989,956,'admin/structure/types/manage/%/fields/%/edit','admin/structure/types/manage/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,916,956,989,0,0,0),('management',990,956,'admin/structure/types/manage/%/fields/%/field-settings','admin/structure/types/manage/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,916,956,990,0,0,0),('management',991,956,'admin/structure/types/manage/%/fields/%/widget-type','admin/structure/types/manage/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,916,956,991,0,0,0),('management',992,967,'admin/structure/types/manage/%/comment/fields/%/delete','admin/structure/types/manage/%/comment/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,36,135,797,967,992,0,0,0),('management',993,967,'admin/structure/types/manage/%/comment/fields/%/edit','admin/structure/types/manage/%/comment/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,797,967,993,0,0,0),('management',994,967,'admin/structure/types/manage/%/comment/fields/%/field-settings','admin/structure/types/manage/%/comment/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,797,967,994,0,0,0),('management',995,967,'admin/structure/types/manage/%/comment/fields/%/widget-type','admin/structure/types/manage/%/comment/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,797,967,995,0,0,0),('management',996,12,'admin/help/token','admin/help/token','token','a:0:{}','system',-1,0,0,0,0,3,0,1,12,996,0,0,0,0,0,0,0),('management',997,904,'admin/commerce/config/order/display/token','admin/commerce/config/order/display/token','Tokens','a:0:{}','system',-1,0,0,0,2,6,0,1,546,547,577,904,997,0,0,0,0),('management',998,905,'admin/structure/taxonomy/%/display/token','admin/structure/taxonomy/%/display/token','Tokens','a:0:{}','system',-1,0,0,0,1,6,0,1,21,57,89,905,998,0,0,0,0),('management',999,906,'admin/config/people/accounts/display/token','admin/config/people/accounts/display/token','Tokens','a:0:{}','system',-1,0,0,0,1,6,0,1,8,48,90,906,999,0,0,0,0),('management',1000,672,'admin/commerce/products/types/product/display/commerce_line_item_token','admin/commerce/products/types/product/display/commerce_line_item_token','Commerce Line item: Tokens','a:0:{}','system',-1,0,0,0,4,7,0,1,546,659,662,668,672,1000,0,0,0),('management',1001,707,'admin/commerce/config/line-items/shipping/display/token','admin/commerce/config/line-items/shipping/display/token','Tokens','a:0:{}','system',-1,0,0,0,1,7,0,1,546,547,570,701,707,1001,0,0,0),('management',1002,559,'admin/commerce/customer-profiles/types/billing/display/token','admin/commerce/customer-profiles/types/billing/display/token','Tokens','a:0:{}','system',-1,0,0,0,2,7,0,1,546,550,553,555,559,1002,0,0,0),('management',1003,706,'admin/commerce/customer-profiles/types/shipping/display/token','admin/commerce/customer-profiles/types/shipping/display/token','Tokens','a:0:{}','system',-1,0,0,0,2,7,0,1,546,550,553,702,706,1003,0,0,0),('management',1004,672,'admin/commerce/products/types/product/display/token','admin/commerce/products/types/product/display/token','Tokens','a:0:{}','system',-1,0,0,0,1,7,0,1,546,659,662,668,672,1004,0,0,0),('management',1005,630,'admin/commerce/config/line-items/product/display/token','admin/commerce/config/line-items/product/display/token','Tokens','a:0:{}','system',-1,0,0,0,1,7,0,1,546,547,570,629,630,1005,0,0,0),('management',1006,915,'admin/structure/types/manage/%/display/token','admin/structure/types/manage/%/display/token','Tokens','a:0:{}','system',-1,0,0,0,5,6,0,1,21,36,135,915,1006,0,0,0,0),('management',1007,672,'admin/commerce/products/types/product/display/node_token','admin/commerce/products/types/product/display/node_token','Node: Tokens','a:0:{}','system',-1,0,0,0,10,7,0,1,546,659,662,668,672,1007,0,0,0),('management',1008,796,'admin/structure/types/manage/%/comment/display/token','admin/structure/types/manage/%/comment/display/token','Tokens','a:0:{}','system',-1,0,0,0,1,6,0,1,21,36,135,796,1008,0,0,0,0),('navigation',1009,4,'filter/tips/%','filter/tips/%','Compose tips','a:0:{}','system',0,0,0,0,0,2,0,4,1009,0,0,0,0,0,0,0,0),('management',1010,19,'admin/reports/libraries','admin/reports/libraries','Libraries','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"An overview of libraries installed on this site.\";}}','system',0,0,1,0,0,3,0,1,19,1010,0,0,0,0,0,0,0),('management',1011,12,'admin/help/libraries','admin/help/libraries','libraries','a:0:{}','system',-1,0,0,0,0,3,0,1,12,1011,0,0,0,0,0,0,0),('management',1012,1010,'admin/reports/libraries/%','admin/reports/libraries/%','Library status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Status overview for a single library\";}}','system',0,0,0,0,0,4,0,1,19,1010,1012,0,0,0,0,0,0);
/*!40000 ALTER TABLE `menu_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node`
--

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` VALUES (1,1,'mt_post','und','Title of the first article rendered on the article page and throughout the site',1,1,1402994826,1403639774,2,1,1,0,0),(2,2,'mt_post','und','Title of the second article rendered on the article page and throughout the site',1,1,1402994717,1403814964,2,1,1,0,0),(3,3,'mt_post','und','Title of the third article rendered on the article page and throughout the site',1,1,1400661889,1403364807,2,1,1,0,0),(4,4,'mt_post','und','Title of the fourth article rendered on the article page and throughout the site',1,1,1400661788,1403080649,2,1,1,0,0),(5,5,'mt_post','und','Title of the fifth article rendered on the article page and throughout the site',1,1,1398069748,1403080665,2,1,0,0,0),(6,6,'mt_post','und','Title of the sixth article rendered on the article page and throughout the site',1,1,1395391290,1403086341,2,1,0,0,0),(7,7,'mt_post','und','Title of the seventh article rendered on the article page and throughout the site',1,1,1392972022,1403086293,2,1,0,0,0),(8,8,'mt_post','und','Title of the eighth article rendered on the article page and throughout the site',1,1,1390293573,1403118839,2,1,0,0,0),(9,9,'mt_post','und','Title of the ninth article rendered on the article page and throughout the site',1,1,1385023091,1403086231,2,1,0,0,0),(10,10,'mt_post','und','Title of the tenth article rendered on the article page and throughout the site',1,1,1382344622,1403086217,2,1,0,0,0),(11,11,'mt_post','und','Title of the eleventh article rendered on the article page and throughout the site',1,1,1379752566,1403086166,2,1,0,0,0),(12,12,'mt_post','und','Title of the twelfth article rendered on the article page and throughout the site',1,1,1377074122,1403086109,2,1,0,0,0),(13,13,'webform','und','Contact',1,1,1400854849,1400855778,1,0,0,0,0),(14,14,'page','und','Typography',1,1,1400857796,1401379699,1,0,0,0,0),(15,15,'page','und','Shortcodes',1,1,1401351693,1401379733,1,0,0,0,0),(16,16,'page','und','Responsive Grid',1,1,1401360960,1401379788,1,0,0,0,0),(17,17,'page','und','Responsive Grid',1,1,1401361205,1401379764,1,0,0,0,0),(18,18,'mt_product','und','Sixth Product',1,1,1403541527,1403558032,1,1,0,0,0),(19,19,'mt_product','und','Fifth Product',1,1,1403543007,1403558027,1,1,0,0,0),(20,20,'mt_product','und','Fourth Product',1,1,1403543127,1403558020,1,1,0,0,0),(21,21,'mt_product','und','Third Product',1,1,1403543198,1403558014,1,1,0,0,0),(22,22,'mt_product','und','Second Product',1,1,1403543395,1403557991,1,1,0,0,0),(23,23,'mt_product','und','First Product',1,1,1403543450,1403558044,1,1,0,0,0);
/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_access`
--

DROP TABLE IF EXISTS `node_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_access`
--

LOCK TABLES `node_access` WRITE;
/*!40000 ALTER TABLE `node_access` DISABLE KEYS */;
INSERT INTO `node_access` VALUES (0,0,'all',1,0,0);
/*!40000 ALTER TABLE `node_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_comment_statistics`
--

LOCK TABLES `node_comment_statistics` WRITE;
/*!40000 ALTER TABLE `node_comment_statistics` DISABLE KEYS */;
INSERT INTO `node_comment_statistics` VALUES (1,4,1401220547,'',1,3),(2,1,1401220324,'',1,1),(3,0,1400662489,NULL,1,0),(4,0,1400662688,NULL,1,0),(5,0,1400662828,NULL,1,0),(6,0,1400662950,NULL,1,0),(7,0,1400663182,NULL,1,0),(8,0,1400663373,NULL,1,0),(9,0,1400663471,NULL,1,0),(10,0,1400663582,NULL,1,0),(11,0,1400663706,NULL,1,0),(12,0,1400663842,NULL,1,0),(13,0,1400854849,NULL,1,0),(14,0,1400857796,NULL,1,0),(15,0,1401351693,NULL,1,0),(16,0,1401360960,NULL,1,0),(17,0,1401361205,NULL,1,0),(18,0,1403541527,NULL,1,0),(19,0,1403543007,NULL,1,0),(20,0,1403543127,NULL,1,0),(21,0,1403543198,NULL,1,0),(22,0,1403543395,NULL,1,0),(23,0,1403543450,NULL,1,0);
/*!40000 ALTER TABLE `node_comment_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_counter`
--

DROP TABLE IF EXISTS `node_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_counter` (
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid for these statistics.',
  `totalcount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of times the node has been viewed.',
  `daycount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of times the node has been viewed today.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The most recent time the node has been viewed.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Access statistics for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_counter`
--

LOCK TABLES `node_counter` WRITE;
/*!40000 ALTER TABLE `node_counter` DISABLE KEYS */;
INSERT INTO `node_counter` VALUES (1,19,0,1447074115),(2,3,0,1447073382),(3,1,0,1447073464);
/*!40000 ALTER TABLE `node_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_revision`
--

LOCK TABLES `node_revision` WRITE;
/*!40000 ALTER TABLE `node_revision` DISABLE KEYS */;
INSERT INTO `node_revision` VALUES (1,1,1,'Title of the first article rendered on the article page and throughout the site','',1403639774,1,2,1,1),(2,2,1,'Title of the second article rendered on the article page and throughout the site','',1403814964,1,2,1,1),(3,3,1,'Title of the third article rendered on the article page and throughout the site','',1403364807,1,2,1,1),(4,4,1,'Title of the fourth article rendered on the article page and throughout the site','',1403080649,1,2,1,1),(5,5,1,'Title of the fifth article rendered on the article page and throughout the site','',1403080665,1,2,1,0),(6,6,1,'Title of the sixth article rendered on the article page and throughout the site','',1403086341,1,2,1,0),(7,7,1,'Title of the seventh article rendered on the article page and throughout the site','',1403086293,1,2,1,0),(8,8,1,'Title of the eighth article rendered on the article page and throughout the site','',1403118839,1,2,1,0),(9,9,1,'Title of the ninth article rendered on the article page and throughout the site','',1403086231,1,2,1,0),(10,10,1,'Title of the tenth article rendered on the article page and throughout the site','',1403086217,1,2,1,0),(11,11,1,'Title of the eleventh article rendered on the article page and throughout the site','',1403086166,1,2,1,0),(12,12,1,'Title of the twelfth article rendered on the article page and throughout the site','',1403086109,1,2,1,0),(13,13,1,'Contact','',1400855778,1,1,0,0),(14,14,1,'Typography','',1401379699,1,1,0,0),(15,15,1,'Shortcodes','',1401379733,1,1,0,0),(16,16,1,'Responsive Grid','',1401379788,1,1,0,0),(17,17,1,'Responsive Grid','',1401379764,1,1,0,0),(18,18,1,'Sixth Product','',1403558032,1,1,1,0),(19,19,1,'Fifth Product','',1403558027,1,1,1,0),(20,20,1,'Fourth Product','',1403558020,1,1,1,0),(21,21,1,'Third Product','',1403558014,1,1,1,0),(22,22,1,'Second Product','',1403557991,1,1,1,0),(23,23,1,'First Product','',1403558044,1,1,1,0);
/*!40000 ALTER TABLE `node_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_type`
--

DROP TABLE IF EXISTS `node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_type`
--

LOCK TABLES `node_type` WRITE;
/*!40000 ALTER TABLE `node_type` DISABLE KEYS */;
INSERT INTO `node_type` VALUES ('article','Article','node_content','node','Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.','',1,'Title',1,1,0,0,'article'),('blog','Blog entry','blog','blog','Use for multi-user blogs. Every user gets a personal blog.','',1,'Title',0,0,1,1,'blog'),('mt_post','Post','node_content','node','Use the Post content type to create and publish articles making use of all the special functionality built into the News+ theme.','',1,'Title',1,1,0,0,'mt_post'),('mt_product','Product','node_content','node','Use the Product content type to create and sell products (e.g.: e-books) making use of all the relevant, special functionality built into the News+ theme.','',1,'Title',1,1,0,0,'mt_product'),('mt_slideshow_entry','Slideshow entry','node_content','node','A Slideshow entry is ideal for creating commercial banners as well as messages for your website. Use it to promote any page of your website or URL into the front page slide show. It can carry a title, a teaser and an image linking to an internal path or external link.','',1,'Title',1,1,0,0,'mt_slideshow_entry'),('page','Basic page','node_content','node','Use <em>basic pages</em> for your static content, such as an \'About us\' page.','',1,'Title',1,1,0,0,'page'),('webform','Webform','node_content','node','Create a new form or questionnaire accessible to users. Submission results and statistics are recorded and accessible to privileged users.','',1,'Title',1,1,0,0,'webform');
/*!40000 ALTER TABLE `node_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_common_consumer`
--

DROP TABLE IF EXISTS `oauth_common_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_common_consumer` (
  `csid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `key_hash` char(40) NOT NULL COMMENT 'SHA1-hash of consumer_key.',
  `consumer_key` text NOT NULL COMMENT 'Consumer key.',
  `secret` text NOT NULL COMMENT 'Consumer secret.',
  `configuration` longtext NOT NULL COMMENT 'Consumer configuration',
  PRIMARY KEY (`csid`),
  KEY `key_hash` (`key_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keys and secrets for OAuth consumers, both those provided...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_common_consumer`
--

LOCK TABLES `oauth_common_consumer` WRITE;
/*!40000 ALTER TABLE `oauth_common_consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_common_consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_common_context`
--

DROP TABLE IF EXISTS `oauth_common_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_common_context` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(32) NOT NULL COMMENT 'The computer-readable name of the context.',
  `title` varchar(100) NOT NULL COMMENT 'The localizable title of the authorization context.',
  `authorization_options` longtext NOT NULL COMMENT 'Authorization options.',
  `authorization_levels` longtext NOT NULL COMMENT 'Authorization levels for the context.',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `context` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contexts for OAuth common';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_common_context`
--

LOCK TABLES `oauth_common_context` WRITE;
/*!40000 ALTER TABLE `oauth_common_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_common_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_common_nonce`
--

DROP TABLE IF EXISTS `oauth_common_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_common_nonce` (
  `nonce` varchar(255) NOT NULL COMMENT 'The random string used on each request.',
  `timestamp` int(11) NOT NULL COMMENT 'The timestamp of the request.',
  `token_key` varchar(32) NOT NULL COMMENT 'Token key.',
  PRIMARY KEY (`nonce`),
  KEY `timekey` (`timestamp`,`token_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores timestamp against nonce for repeat attacks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_common_nonce`
--

LOCK TABLES `oauth_common_nonce` WRITE;
/*!40000 ALTER TABLE `oauth_common_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_common_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_common_provider_consumer`
--

DROP TABLE IF EXISTS `oauth_common_provider_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_common_provider_consumer` (
  `csid` int(10) unsigned DEFAULT '0' COMMENT 'The oauth_common_consumer.csid this data is related to.',
  `consumer_key` char(32) NOT NULL COMMENT 'Consumer key.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the consumer was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The last time the consumer was edited, as a Unix timestamp.',
  `uid` int(10) unsigned NOT NULL COMMENT 'The application owner.',
  `name` varchar(128) NOT NULL COMMENT 'The application name.',
  `context` varchar(32) NOT NULL DEFAULT '' COMMENT 'The application context.',
  `callback_url` varchar(255) NOT NULL COMMENT 'Callback url.',
  PRIMARY KEY (`consumer_key`),
  UNIQUE KEY `csid` (`csid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Additional data for OAuth consumers provided by this site.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_common_provider_consumer`
--

LOCK TABLES `oauth_common_provider_consumer` WRITE;
/*!40000 ALTER TABLE `oauth_common_provider_consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_common_provider_consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_common_provider_token`
--

DROP TABLE IF EXISTS `oauth_common_provider_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_common_provider_token` (
  `tid` int(10) unsigned DEFAULT '0' COMMENT 'The oauth_common_token.tid this data is related to.',
  `token_key` char(32) NOT NULL COMMENT 'Token key.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the token was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The last time the token was edited, as a Unix timestamp.',
  `services` text COMMENT 'An array of services that the user allowed the consumer to access.',
  `authorized` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'In case its a request token, it checks if the user already authorized the consumer to get an access token.',
  PRIMARY KEY (`token_key`),
  UNIQUE KEY `tid` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Additional data for OAuth tokens provided by this site.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_common_provider_token`
--

LOCK TABLES `oauth_common_provider_token` WRITE;
/*!40000 ALTER TABLE `oauth_common_provider_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_common_provider_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_common_token`
--

DROP TABLE IF EXISTS `oauth_common_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_common_token` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `csid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The oauth_common_consumer.csid this token is related to.',
  `key_hash` char(40) NOT NULL COMMENT 'SHA1-hash of token_key.',
  `token_key` text NOT NULL COMMENT 'Token key.',
  `secret` text NOT NULL COMMENT 'Token secret.',
  `expires` int(11) NOT NULL DEFAULT '0' COMMENT 'The expiry time for the token, as a Unix timestamp.',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Token type: request or access.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID from user.uid.',
  PRIMARY KEY (`tid`),
  KEY `key_hash` (`key_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tokens stored on behalf of providers or consumers for...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_common_token`
--

LOCK TABLES `oauth_common_token` WRITE;
/*!40000 ALTER TABLE `oauth_common_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_common_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=515 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quicktabs`
--

DROP TABLE IF EXISTS `quicktabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quicktabs` (
  `machine_name` varchar(255) NOT NULL COMMENT 'The primary identifier for a qt block.',
  `ajax` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether this is an ajax views block.',
  `hide_empty_tabs` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether this tabset hides empty tabs.',
  `default_tab` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Default tab.',
  `title` varchar(255) NOT NULL COMMENT 'The title of this quicktabs block.',
  `tabs` mediumtext NOT NULL COMMENT 'A serialized array of the contents of this qt block.',
  `renderer` varchar(255) NOT NULL COMMENT 'The rendering mechanism.',
  `style` varchar(255) NOT NULL COMMENT 'The tab style.',
  `options` mediumtext COMMENT 'A serialized array of the options for this qt instance.',
  PRIMARY KEY (`machine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The quicktabs table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quicktabs`
--

LOCK TABLES `quicktabs` WRITE;
/*!40000 ALTER TABLE `quicktabs` DISABLE KEYS */;
INSERT INTO `quicktabs` VALUES ('sidebar_tabs',0,0,0,'Sidebar tabs','a:3:{i:0;a:5:{s:3:\"bid\";s:27:\"views_delta_mt_latest-block\";s:10:\"hide_title\";i:1;s:5:\"title\";s:6:\"Latest\";s:6:\"weight\";s:4:\"-100\";s:4:\"type\";s:5:\"block\";}i:1;a:5:{s:3:\"bid\";s:35:\"views_delta_mt_most_popular-block_1\";s:10:\"hide_title\";i:1;s:5:\"title\";s:7:\"Popular\";s:6:\"weight\";s:3:\"-99\";s:4:\"type\";s:5:\"block\";}i:2;a:5:{s:3:\"bid\";s:25:\"views_delta_archive-block\";s:10:\"hide_title\";i:1;s:5:\"title\";s:7:\"Archive\";s:6:\"weight\";s:3:\"-98\";s:4:\"type\";s:5:\"block\";}}','quicktabs','nostyle','a:0:{}');
/*!40000 ALTER TABLE `quicktabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rdf_mapping`
--

DROP TABLE IF EXISTS `rdf_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rdf_mapping`
--

LOCK TABLES `rdf_mapping` WRITE;
/*!40000 ALTER TABLE `rdf_mapping` DISABLE KEYS */;
INSERT INTO `rdf_mapping` VALUES ('node','article','a:11:{s:11:\"field_image\";a:2:{s:10:\"predicates\";a:2:{i:0;s:8:\"og:image\";i:1;s:12:\"rdfs:seeAlso\";}s:4:\"type\";s:3:\"rel\";}s:10:\"field_tags\";a:2:{s:10:\"predicates\";a:1:{i:0;s:10:\"dc:subject\";}s:4:\"type\";s:3:\"rel\";}s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Item\";i:1;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}'),('node','blog','a:9:{s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Post\";i:1;s:14:\"sioct:BlogPost\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}'),('node','page','a:9:{s:7:\"rdftype\";a:1:{i:0;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}');
/*!40000 ALTER TABLE `rdf_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (3,'administrator',2),(1,'anonymous user',0),(2,'authenticated user',1);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,'access checkout','commerce_checkout'),(1,'access comments','comment'),(1,'access content','node'),(1,'access user profiles','user'),(1,'search content','search'),(1,'use advanced search','search'),(1,'use text format filtered_html','filter'),(1,'view any commerce_product entity','commerce_product'),(1,'view own commerce_order entities','commerce_order'),(2,'access checkout','commerce_checkout'),(2,'access comments','comment'),(2,'access content','node'),(2,'access overlay','overlay'),(2,'access toolbar','toolbar'),(2,'access user profiles','user'),(2,'post comments','comment'),(2,'search content','search'),(2,'skip comment approval','comment'),(2,'use advanced search','search'),(2,'use text format filtered_html','filter'),(2,'view any commerce_product entity','commerce_product'),(2,'view own commerce_order entities','commerce_order'),(2,'view the administration theme','system'),(3,'access administration pages','system'),(3,'access all views','views'),(3,'access all webform results','webform'),(3,'access checkout','commerce_checkout'),(3,'access comments','comment'),(3,'access content','node'),(3,'access content overview','node'),(3,'access contextual links','contextual'),(3,'access dashboard','dashboard'),(3,'access overlay','overlay'),(3,'access own authorizations','oauth_common'),(3,'access own consumers','oauth_common'),(3,'access own webform results','webform'),(3,'access own webform submissions','webform'),(3,'access rules debug','rules'),(3,'access site in maintenance mode','system'),(3,'access site reports','system'),(3,'access statistics','statistics'),(3,'access toolbar','toolbar'),(3,'access user profiles','user'),(3,'add authenticated twitter accounts','twitter'),(3,'add twitter accounts','twitter'),(3,'administer actions','system'),(3,'administer blocks','block'),(3,'administer checkout','commerce_checkout'),(3,'administer comments','comment'),(3,'administer commerce_customer_profile entities','commerce_customer'),(3,'administer commerce_order entities','commerce_order'),(3,'administer commerce_product entities','commerce_product'),(3,'administer commerce_stock settings','commerce_stock'),(3,'administer consumers','oauth_common'),(3,'administer content types','node'),(3,'administer customer profile types','commerce_customer'),(3,'administer filters','filter'),(3,'administer image styles','image'),(3,'administer line item types','commerce_line_item'),(3,'administer line items','commerce_line_item'),(3,'administer menu','menu'),(3,'administer modules','system'),(3,'administer nodes','node'),(3,'administer oauth','oauth_common'),(3,'administer payment methods','commerce_payment'),(3,'administer payments','commerce_payment'),(3,'administer permissions','user'),(3,'administer product pricing','commerce_product_pricing_ui'),(3,'administer product types','commerce_product'),(3,'administer quicktabs','quicktabs'),(3,'administer rules','rules'),(3,'administer search','search'),(3,'administer shipping','commerce_shipping'),(3,'administer shortcuts','shortcut'),(3,'administer site configuration','system'),(3,'administer software updates','system'),(3,'administer statistics','statistics'),(3,'administer superfish','superfish'),(3,'administer taxes','commerce_tax_ui'),(3,'administer taxonomy','taxonomy'),(3,'administer themes','system'),(3,'administer twitter','twitter'),(3,'administer twitter accounts','twitter'),(3,'administer url aliases','path'),(3,'administer users','user'),(3,'administer views','views'),(3,'block IP addresses','system'),(3,'bypass node access','node'),(3,'bypass rules access','rules'),(3,'cancel account','user'),(3,'change own username','user'),(3,'configure order settings','commerce_order'),(3,'configure store','commerce'),(3,'create article content','node'),(3,'create commerce_customer_profile entities','commerce_customer'),(3,'create commerce_customer_profile entities of bundle billing','commerce_customer'),(3,'create commerce_customer_profile entities of bundle shipping','commerce_customer'),(3,'create commerce_order entities','commerce_order'),(3,'create commerce_order entities of bundle commerce_order','commerce_order'),(3,'create commerce_product entities','commerce_product'),(3,'create commerce_product entities of bundle product','commerce_product'),(3,'create mt_post content','node'),(3,'create mt_product content','node'),(3,'create mt_slideshow_entry content','node'),(3,'create page content','node'),(3,'create payments','commerce_payment'),(3,'create url aliases','path'),(3,'create webform content','node'),(3,'customize shortcut links','shortcut'),(3,'delete all webform submissions','webform'),(3,'delete any article content','node'),(3,'delete any mt_post content','node'),(3,'delete any mt_product content','node'),(3,'delete any mt_slideshow_entry content','node'),(3,'delete any page content','node'),(3,'delete any webform content','node'),(3,'delete own article content','node'),(3,'delete own mt_post content','node'),(3,'delete own mt_product content','node'),(3,'delete own mt_slideshow_entry content','node'),(3,'delete own page content','node'),(3,'delete own webform content','node'),(3,'delete own webform submissions','webform'),(3,'delete payments','commerce_payment'),(3,'delete revisions','node'),(3,'delete terms in 1','taxonomy'),(3,'delete terms in 2','taxonomy'),(3,'edit all webform submissions','webform'),(3,'edit any article content','node'),(3,'edit any commerce_customer_profile entity','commerce_customer'),(3,'edit any commerce_customer_profile entity of bundle billing','commerce_customer'),(3,'edit any commerce_customer_profile entity of bundle shipping','commerce_customer'),(3,'edit any commerce_order entity','commerce_order'),(3,'edit any commerce_order entity of bundle commerce_order','commerce_order'),(3,'edit any commerce_product entity','commerce_product'),(3,'edit any commerce_product entity of bundle product','commerce_product'),(3,'edit any mt_post content','node'),(3,'edit any mt_product content','node'),(3,'edit any mt_slideshow_entry content','node'),(3,'edit any page content','node'),(3,'edit any webform content','node'),(3,'edit own article content','node'),(3,'edit own comments','comment'),(3,'edit own commerce_customer_profile entities','commerce_customer'),(3,'edit own commerce_customer_profile entities of bundle billing','commerce_customer'),(3,'edit own commerce_customer_profile entities of bundle shipping','commerce_customer'),(3,'edit own commerce_order entities','commerce_order'),(3,'edit own commerce_order entities of bundle commerce_order','commerce_order'),(3,'edit own commerce_product entities','commerce_product'),(3,'edit own commerce_product entities of bundle product','commerce_product'),(3,'edit own mt_post content','node'),(3,'edit own mt_product content','node'),(3,'edit own mt_slideshow_entry content','node'),(3,'edit own page content','node'),(3,'edit own webform content','node'),(3,'edit own webform submissions','webform'),(3,'edit terms in 1','taxonomy'),(3,'edit terms in 2','taxonomy'),(3,'oauth authorize any consumers','oauth_common'),(3,'oauth register any consumers','oauth_common'),(3,'post comments','comment'),(3,'revert revisions','node'),(3,'search content','search'),(3,'select account cancellation method','user'),(3,'skip comment approval','comment'),(3,'switch shortcut sets','shortcut'),(3,'update payments','commerce_payment'),(3,'use advanced search','search'),(3,'use bulk exporter','bulk_export'),(3,'use PHP for settings','php'),(3,'use text format filtered_html','filter'),(3,'use text format full_html','filter'),(3,'use text format php_code','filter'),(3,'view any commerce_customer_profile entity','commerce_customer'),(3,'view any commerce_customer_profile entity of bundle billing','commerce_customer'),(3,'view any commerce_customer_profile entity of bundle shipping','commerce_customer'),(3,'view any commerce_order entity','commerce_order'),(3,'view any commerce_order entity of bundle commerce_order','commerce_order'),(3,'view any commerce_product entity','commerce_product'),(3,'view any commerce_product entity of bundle product','commerce_product'),(3,'view own commerce_customer_profile entities','commerce_customer'),(3,'view own commerce_customer_profile entities of bundle billing','commerce_customer'),(3,'view own commerce_customer_profile entities of bundle shipping','commerce_customer'),(3,'view own commerce_order entities','commerce_order'),(3,'view own commerce_order entities of bundle commerce_order','commerce_order'),(3,'view own commerce_product entities','commerce_product'),(3,'view own commerce_product entities of bundle product','commerce_product'),(3,'view own unpublished content','node'),(3,'view payments','commerce_payment'),(3,'view post access counter','statistics'),(3,'view revisions','node'),(3,'view the administration theme','system');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules_config`
--

DROP TABLE IF EXISTS `rules_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The internal identifier for any configuration.',
  `name` varchar(64) NOT NULL COMMENT 'The name of the configuration.',
  `label` varchar(255) NOT NULL DEFAULT 'unlabeled' COMMENT 'The label of the configuration.',
  `plugin` varchar(127) NOT NULL COMMENT 'The name of the plugin of this configuration.',
  `active` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the configuration is active. Usage depends on how the using module makes use of it.',
  `weight` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Weight of the configuration. Usage depends on how the using module makes use of it.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `dirty` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Dirty configurations fail the integrity check, e.g. due to missing dependencies.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  `owner` varchar(255) NOT NULL DEFAULT 'rules' COMMENT 'The name of the module via which the rule has been configured.',
  `access_exposed` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether to use a permission to control access for using components.',
  `data` longblob COMMENT 'Everything else, serialized.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `plugin` (`plugin`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules_config`
--

LOCK TABLES `rules_config` WRITE;
/*!40000 ALTER TABLE `rules_config` DISABLE KEYS */;
INSERT INTO `rules_config` VALUES (1,'commerce_checkout_order_created_date_update','Set the order created date to the checkout completion date','reaction rule',1,-10,2,0,'commerce_checkout','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"1\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:-10;s:8:\"settings\";a:0:{}s:4:\"name\";s:43:\"commerce_checkout_order_created_date_update\";s:5:\"label\";s:58:\"Set the order created date to the checkout completion date\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:17:\"commerce_checkout\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:17:\"Commerce Checkout\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:22:\"commerce-order:created\";s:12:\"value:select\";s:17:\"site:current-date\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:26:\"commerce_checkout_complete\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(2,'commerce_checkout_order_status_update','Update the order status on checkout completion','reaction rule',1,0,2,0,'commerce_checkout','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"2\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:37:\"commerce_checkout_order_status_update\";s:5:\"label\";s:46:\"Update the order status on checkout completion\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:17:\"commerce_checkout\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:17:\"Commerce Checkout\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:21:\"commerce_order:select\";s:14:\"commerce-order\";s:11:\"order_state\";s:7:\"pending\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:27:\"commerce_order_update_state\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:26:\"commerce_checkout_complete\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(3,'commerce_checkout_order_convert','Assign an anonymous order to a pre-existing user','reaction rule',1,1,2,0,'commerce_checkout','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"3\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:1;s:8:\"settings\";a:0:{}s:4:\"name\";s:31:\"commerce_checkout_order_convert\";s:5:\"label\";s:48:\"Assign an anonymous order to a pre-existing user\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:17:\"commerce_checkout\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:17:\"Commerce Checkout\";}s:11:\"\0*\0children\";a:2:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:7:{s:4:\"type\";s:4:\"user\";s:8:\"property\";s:4:\"mail\";s:12:\"value:select\";s:19:\"commerce-order:mail\";s:5:\"limit\";i:1;s:20:\"entity_fetched:label\";s:15:\"Fetched account\";s:18:\"entity_fetched:var\";s:15:\"account_fetched\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:12:\"entity_query\";}i:1;O:9:\"RulesLoop\":7:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"list:select\";s:15:\"account-fetched\";s:8:\"item:var\";s:9:\"list_item\";s:10:\"item:label\";s:17:\"Current list item\";s:9:\"item:type\";s:4:\"user\";}s:11:\"\0*\0children\";a:3:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:32;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:18:\"commerce-order:uid\";s:12:\"value:select\";s:13:\"list-item:uid\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}i:1;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:32;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:44:\"commerce-order:commerce-customer-billing:uid\";s:12:\"value:select\";s:13:\"list-item:uid\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}i:2;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:32;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:45:\"commerce-order:commerce-customer-shipping:uid\";s:12:\"value:select\";s:13:\"list-item:uid\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}}s:7:\"\0*\0info\";a:0:{}}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:3:{i:0;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:75;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:18:\"commerce-order:uid\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:1:\"0\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:0;}i:1;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:75;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:4:\"type\";s:4:\"user\";s:8:\"property\";s:4:\"mail\";s:12:\"value:select\";s:19:\"commerce-order:mail\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:13:\"entity_exists\";s:9:\"\0*\0negate\";b:0;}i:2;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:75;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:19:\"commerce-order:type\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:14:\"commerce_order\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:0;}}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:26:\"commerce_checkout_complete\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(4,'commerce_checkout_new_account','Create a new account for an anonymous order','reaction rule',1,2,2,0,'commerce_checkout','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"4\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:2;s:8:\"settings\";a:0:{}s:4:\"name\";s:29:\"commerce_checkout_new_account\";s:5:\"label\";s:43:\"Create a new account for an anonymous order\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:17:\"commerce_checkout\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:17:\"Commerce Checkout\";}s:11:\"\0*\0children\";a:5:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:6:{s:4:\"type\";s:4:\"user\";s:17:\"param_name:select\";s:28:\"commerce-order:mail-username\";s:17:\"param_mail:select\";s:19:\"commerce-order:mail\";s:20:\"entity_created:label\";s:15:\"Created account\";s:18:\"entity_created:var\";s:15:\"account_created\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:13:\"entity_create\";}i:1;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:22:\"account-created:status\";s:5:\"value\";i:1;s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}i:2;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:15:\"account-created\";s:9:\"immediate\";i:1;s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:11:\"entity_save\";}i:3;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:7:{s:4:\"type\";s:4:\"user\";s:8:\"property\";s:4:\"mail\";s:12:\"value:select\";s:19:\"commerce-order:mail\";s:5:\"limit\";i:1;s:20:\"entity_fetched:label\";s:15:\"Fetched account\";s:18:\"entity_fetched:var\";s:15:\"account_fetched\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:12:\"entity_query\";}i:4;O:9:\"RulesLoop\":7:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"list:select\";s:15:\"account-fetched\";s:8:\"item:var\";s:9:\"list_item\";s:10:\"item:label\";s:17:\"Current list item\";s:9:\"item:type\";s:4:\"user\";}s:11:\"\0*\0children\";a:4:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:65;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:14:\"account:select\";s:9:\"list-item\";s:10:\"email_type\";s:22:\"register_admin_created\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:18:\"send_account_email\";}i:1;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:65;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:18:\"commerce-order:uid\";s:12:\"value:select\";s:13:\"list-item:uid\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}i:2;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:65;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:44:\"commerce-order:commerce-customer-billing:uid\";s:12:\"value:select\";s:13:\"list-item:uid\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}i:3;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:65;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:11:\"data:select\";s:45:\"commerce-order:commerce-customer-shipping:uid\";s:12:\"value:select\";s:13:\"list-item:uid\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}}s:7:\"\0*\0info\";a:0:{}}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:3:{i:0;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:118;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:18:\"commerce-order:uid\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:1:\"0\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:0;}i:1;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:118;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:4:\"type\";s:4:\"user\";s:8:\"property\";s:4:\"mail\";s:12:\"value:select\";s:19:\"commerce-order:mail\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:13:\"entity_exists\";s:9:\"\0*\0negate\";b:1;}i:2;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:118;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:19:\"commerce-order:type\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:14:\"commerce_order\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:0;}}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:26:\"commerce_checkout_complete\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(5,'commerce_checkout_order_email','Send an order notification e-mail','reaction rule',1,4,2,0,'commerce_checkout','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"5\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:4;s:8:\"settings\";a:0:{}s:4:\"name\";s:29:\"commerce_checkout_order_email\";s:5:\"label\";s:33:\"Send an order notification e-mail\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:17:\"commerce_checkout\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:17:\"Commerce Checkout\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:5:{s:9:\"to:select\";s:19:\"commerce-order:mail\";s:7:\"subject\";s:50:\"Order [commerce-order:order-number] at [site:name]\";s:7:\"message\";s:412:\"Thanks for your order [commerce-order:order-number] at [site:name].\n\nIf this is your first order with us, you will receive a separate e-mail with login instructions. You can view your order history with us at any time by logging into our website at:\n\n[site:login-url]\n\nYou can find the status of your current order at:\n\n[commerce-order:customer-url]\n\nPlease contact us if you have any questions about your order.\";s:4:\"from\";s:0:\"\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:4:\"mail\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:26:\"commerce_checkout_complete\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(6,'commerce_cart_add_to_cart_message','Display an Add to Cart message','reaction rule',1,0,2,0,'commerce_cart','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"6\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:33:\"commerce_cart_add_to_cart_message\";s:5:\"label\";s:30:\"Display an Add to Cart message\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:13:\"commerce_cart\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:13:\"Commerce Cart\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:2:{s:23:\"commerce_product:select\";s:16:\"commerce-product\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:33:\"commerce_cart_add_to_cart_message\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:25:\"commerce_cart_product_add\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(7,'commerce_cart_order_status_reset','Reset the cart order status on product add or remove','reaction rule',1,0,2,0,'commerce_cart','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"7\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:32:\"commerce_cart_order_status_reset\";s:5:\"label\";s:52:\"Reset the cart order status on product add or remove\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:13:\"commerce_cart\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:13:\"Commerce Cart\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:21:\"commerce_order:select\";s:14:\"commerce-order\";s:12:\"order_status\";s:4:\"cart\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:28:\"commerce_order_update_status\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:2:{i:0;s:25:\"commerce_cart_product_add\";i:1;s:28:\"commerce_cart_product_remove\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(8,'commerce_cart_unset_disabled_products','Unset the price of disabled products in the cart','reaction rule',1,10,2,0,'commerce_cart','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"8\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:10;s:8:\"settings\";a:0:{}s:4:\"name\";s:37:\"commerce_cart_unset_disabled_products\";s:5:\"label\";s:48:\"Unset the price of disabled products in the cart\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:13:\"commerce_cart\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:13:\"Commerce Cart\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:2:{s:11:\"data:select\";s:45:\"commerce-line-item:commerce-unit-price:amount\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:8:\"data_set\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:3:{i:0;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:28;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:2:{s:11:\"data:select\";s:31:\"commerce-line-item:line-item-id\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:13:\"data_is_empty\";s:9:\"\0*\0negate\";b:1;}i:1;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:28;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:13:\"entity:select\";s:18:\"commerce-line-item\";s:5:\"field\";s:16:\"commerce_product\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:16:\"entity_has_field\";s:9:\"\0*\0negate\";b:0;}i:2;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:28;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:42:\"commerce-line-item:commerce-product:status\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:1:\"0\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:0;}}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:37:\"commerce_product_calculate_sell_price\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(9,'commerce_tax_type_sales_tax','Calculate taxes: Sales tax','reaction rule',1,0,2,0,'commerce_tax','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:1:\"9\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:27:\"commerce_tax_type_sales_tax\";s:5:\"label\";s:26:\"Calculate taxes: Sales tax\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:12:\"commerce_tax\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:12:\"Commerce Tax\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:25:\"commerce_line_item:select\";s:18:\"commerce-line-item\";s:13:\"tax_type_name\";s:9:\"sales_tax\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:30:\"commerce_tax_calculate_by_type\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:37:\"commerce_product_calculate_sell_price\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(10,'commerce_tax_type_vat','Calculate taxes: VAT','reaction rule',1,0,2,0,'commerce_tax','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:2:\"10\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:21:\"commerce_tax_type_vat\";s:5:\"label\";s:20:\"Calculate taxes: VAT\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:12:\"commerce_tax\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:12:\"Commerce Tax\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:25:\"commerce_line_item:select\";s:18:\"commerce-line-item\";s:13:\"tax_type_name\";s:3:\"vat\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:30:\"commerce_tax_calculate_by_type\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:37:\"commerce_product_calculate_sell_price\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(11,'commerce_shipping_cart_update_delete','Delete shipping line items on shopping cart updates','reaction rule',1,0,2,0,'commerce_shipping','rules',0,'O:17:\"RulesReactionRule\":18:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:2:\"11\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:36:\"commerce_shipping_cart_update_delete\";s:5:\"label\";s:51:\"Delete shipping line items on shopping cart updates\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:17:\"commerce_shipping\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:2:{s:21:\"commerce_order:select\";s:14:\"commerce-order\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:44:\"commerce_shipping_delete_shipping_line_items\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:2:{i:0;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:26;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:21:\"commerce-order:status\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:4:\"cart\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:0;}i:1;O:14:\"RulesCondition\":7:{s:9:\"\0*\0parent\";r:26;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:4:{s:11:\"data:select\";s:31:\"commerce-order-unchanged:status\";s:2:\"op\";s:2:\"==\";s:5:\"value\";s:4:\"cart\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:7:\"data_is\";s:9:\"\0*\0negate\";b:1;}}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:21:\"commerce_order_update\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(12,'rules_decrement_stock_completing_order','Decrease stock when completing the order process','reaction rule',1,0,2,0,'commerce_stock','rules',0,'O:17:\"RulesReactionRule\":17:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:2:\"12\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:38:\"rules_decrement_stock_completing_order\";s:5:\"label\";s:48:\"Decrease stock when completing the order process\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"status\";i:2;s:6:\"module\";s:14:\"commerce_stock\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:11:\"\0*\0children\";a:1:{i:0;O:9:\"RulesLoop\":7:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:8:\"item:var\";s:9:\"list_item\";s:10:\"item:label\";s:17:\"Current list item\";s:11:\"list:select\";s:34:\"commerce_order:commerce-line-items\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:15;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:2:{s:18:\"#_needs_processing\";b:1;s:25:\"commerce_line_item:select\";s:9:\"list-item\";}s:14:\"\0*\0elementName\";s:36:\"commerce_stock_decrease_by_line_item\";}}s:7:\"\0*\0info\";a:0:{}}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:26:\"commerce_checkout_complete\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(13,'commerce_payment_paypal_wpp','PayPal WPP - Credit Card','reaction rule',0,0,2,0,'commerce_payment','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:2:\"13\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:27:\"commerce_payment_paypal_wpp\";s:5:\"label\";s:24:\"PayPal WPP - Credit Card\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:0;s:6:\"status\";i:2;s:6:\"module\";s:16:\"commerce_payment\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:16:\"Commerce Payment\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:21:\"commerce_order:select\";s:14:\"commerce-order\";s:14:\"payment_method\";s:10:\"paypal_wpp\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:34:\"commerce_payment_enable_paypal_wpp\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:24:\"commerce_payment_methods\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(14,'commerce_payment_paypal_wps','PayPal WPS','reaction rule',1,1,3,0,'commerce_payment','rules',0,'O:17:\"RulesReactionRule\":21:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:2:\"14\";s:12:\"\0*\0elementId\";i:1;s:6:\"weight\";s:1:\"1\";s:8:\"settings\";a:0:{}s:4:\"name\";s:27:\"commerce_payment_paypal_wps\";s:5:\"label\";s:10:\"PayPal WPS\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";i:1;s:6:\"status\";i:3;s:5:\"dirty\";b:0;s:6:\"module\";s:16:\"commerce_payment\";s:5:\"owner\";s:5:\"rules\";s:14:\"access_exposed\";b:0;s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:16:\"Commerce Payment\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";i:3;s:6:\"weight\";i:0;s:8:\"settings\";a:2:{s:21:\"commerce_order:select\";s:14:\"commerce-order\";s:14:\"payment_method\";s:10:\"paypal_wps\";}s:14:\"\0*\0elementName\";s:34:\"commerce_payment_enable_paypal_wps\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";i:2;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:24:\"commerce_payment_methods\";}s:16:\"\0*\0eventSettings\";a:0:{}}'),(15,'commerce_payment_commerce_cod','Cash on Delivery','reaction rule',1,0,2,0,'commerce_payment','rules',0,'O:17:\"RulesReactionRule\":19:{s:9:\"\0*\0parent\";N;s:2:\"id\";s:2:\"15\";s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:4:\"name\";s:29:\"commerce_payment_commerce_cod\";s:5:\"label\";s:16:\"Cash on Delivery\";s:6:\"plugin\";s:13:\"reaction rule\";s:6:\"active\";b:1;s:6:\"status\";i:2;s:6:\"module\";s:16:\"commerce_payment\";s:5:\"owner\";s:5:\"rules\";s:4:\"data\";r:1;s:4:\"tags\";a:1:{i:0;s:16:\"Commerce Payment\";}s:11:\"\0*\0children\";a:1:{i:0;O:11:\"RulesAction\":6:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:3:{s:21:\"commerce_order:select\";s:14:\"commerce-order\";s:14:\"payment_method\";s:12:\"commerce_cod\";s:18:\"#_needs_processing\";b:1;}s:14:\"\0*\0elementName\";s:36:\"commerce_payment_enable_commerce_cod\";}}s:7:\"\0*\0info\";a:0:{}s:13:\"\0*\0conditions\";O:8:\"RulesAnd\":8:{s:9:\"\0*\0parent\";r:1;s:2:\"id\";N;s:12:\"\0*\0elementId\";N;s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:11:\"\0*\0children\";a:0:{}s:7:\"\0*\0info\";a:0:{}s:9:\"\0*\0negate\";b:0;}s:9:\"\0*\0events\";a:1:{i:0;s:24:\"commerce_payment_methods\";}s:16:\"\0*\0eventSettings\";a:0:{}}');
/*!40000 ALTER TABLE `rules_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules_dependencies`
--

DROP TABLE IF EXISTS `rules_dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_dependencies` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `module` varchar(255) NOT NULL COMMENT 'The name of the module that is required for the configuration.',
  PRIMARY KEY (`id`,`module`),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules_dependencies`
--

LOCK TABLES `rules_dependencies` WRITE;
/*!40000 ALTER TABLE `rules_dependencies` DISABLE KEYS */;
INSERT INTO `rules_dependencies` VALUES (12,'commerce_checkout'),(14,'commerce_payment'),(12,'commerce_stock');
/*!40000 ALTER TABLE `rules_dependencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules_tags`
--

DROP TABLE IF EXISTS `rules_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_tags` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `tag` varchar(255) NOT NULL COMMENT 'The tag string associated with this configuration',
  PRIMARY KEY (`id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules_tags`
--

LOCK TABLES `rules_tags` WRITE;
/*!40000 ALTER TABLE `rules_tags` DISABLE KEYS */;
INSERT INTO `rules_tags` VALUES (1,'Commerce Checkout'),(2,'Commerce Checkout'),(3,'Commerce Checkout'),(4,'Commerce Checkout'),(5,'Commerce Checkout'),(6,'Commerce Cart'),(7,'Commerce Cart'),(8,'Commerce Cart'),(9,'Commerce Tax'),(10,'Commerce Tax'),(13,'Commerce Payment'),(14,'Commerce Payment'),(15,'Commerce Payment');
/*!40000 ALTER TABLE `rules_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rules_trigger`
--

DROP TABLE IF EXISTS `rules_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules_trigger` (
  `id` int(10) unsigned NOT NULL COMMENT 'The primary identifier of the configuration.',
  `event` varchar(127) NOT NULL DEFAULT '' COMMENT 'The name of the event on which the configuration should be triggered.',
  PRIMARY KEY (`id`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules_trigger`
--

LOCK TABLES `rules_trigger` WRITE;
/*!40000 ALTER TABLE `rules_trigger` DISABLE KEYS */;
INSERT INTO `rules_trigger` VALUES (1,'commerce_checkout_complete'),(2,'commerce_checkout_complete'),(3,'commerce_checkout_complete'),(4,'commerce_checkout_complete'),(5,'commerce_checkout_complete'),(6,'commerce_cart_product_add'),(7,'commerce_cart_product_add'),(7,'commerce_cart_product_remove'),(8,'commerce_product_calculate_sell_price'),(9,'commerce_product_calculate_sell_price'),(10,'commerce_product_calculate_sell_price'),(11,'commerce_order_update'),(12,'commerce_checkout_complete'),(13,'commerce_payment_methods'),(14,'commerce_payment_methods'),(15,'commerce_payment_methods');
/*!40000 ALTER TABLE `rules_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semaphore`
--

LOCK TABLES `semaphore` WRITE;
/*!40000 ALTER TABLE `semaphore` DISABLE KEYS */;
/*!40000 ALTER TABLE `semaphore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
INSERT INTO `sequences` VALUES (12);
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set`
--

LOCK TABLES `shortcut_set` WRITE;
/*!40000 ALTER TABLE `shortcut_set` DISABLE KEYS */;
INSERT INTO `shortcut_set` VALUES ('shortcut-set-1','Default');
/*!40000 ALTER TABLE `shortcut_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_index`
--

LOCK TABLES `taxonomy_index` WRITE;
/*!40000 ALTER TABLE `taxonomy_index` DISABLE KEYS */;
INSERT INTO `taxonomy_index` VALUES (4,6,1,1400661788),(4,7,1,1400661788),(4,10,1,1400661788),(4,11,1,1400661788),(5,4,0,1398069748),(5,8,0,1398069748),(5,9,0,1398069748),(5,10,0,1398069748),(12,1,0,1377074122),(12,7,0,1377074122),(12,8,0,1377074122),(12,9,0,1377074122),(12,10,0,1377074122),(12,11,0,1377074122),(11,4,0,1379752566),(11,8,0,1379752566),(11,9,0,1379752566),(11,11,0,1379752566),(10,6,0,1382344622),(10,7,0,1382344622),(10,10,0,1382344622),(10,11,0,1382344622),(9,5,0,1385023091),(9,8,0,1385023091),(9,9,0,1385023091),(9,10,0,1385023091),(9,11,0,1385023091),(7,2,0,1392972022),(7,7,0,1392972022),(7,8,0,1392972022),(7,9,0,1392972022),(7,10,0,1392972022),(6,1,0,1395391290),(6,7,0,1395391290),(6,8,0,1395391290),(6,11,0,1395391290),(8,3,0,1390293573),(8,10,0,1390293573),(8,11,0,1390293573),(3,5,1,1400661889),(3,7,1,1400661889),(3,9,1,1400661889),(1,2,1,1402994826),(1,7,1,1402994826),(1,8,1,1402994826),(1,9,1,1402994826),(2,3,1,1402994717),(2,7,1,1402994717),(2,8,1,1402994717),(2,9,1,1402994717);
/*!40000 ALTER TABLE `taxonomy_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='Stores term information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_data`
--

LOCK TABLES `taxonomy_term_data` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_data` DISABLE KEYS */;
INSERT INTO `taxonomy_term_data` VALUES (1,2,'World','','filtered_html',0),(2,2,'Finance','','filtered_html',0),(3,2,'Health','','filtered_html',0),(4,2,'Tech','','filtered_html',0),(5,2,'Lifestyle','','filtered_html',0),(6,2,'Sports','','filtered_html',0),(7,1,'Tag1',NULL,NULL,0),(8,1,'Long Tag2',NULL,NULL,0),(9,1,'Very Long Tag3',NULL,NULL,0),(10,1,'Tag4',NULL,NULL,0),(11,1,'Long Tag5',NULL,NULL,0);
/*!40000 ALTER TABLE `taxonomy_term_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_hierarchy`
--

LOCK TABLES `taxonomy_term_hierarchy` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` DISABLE KEYS */;
INSERT INTO `taxonomy_term_hierarchy` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0);
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_vocabulary`
--

LOCK TABLES `taxonomy_vocabulary` WRITE;
/*!40000 ALTER TABLE `taxonomy_vocabulary` DISABLE KEYS */;
INSERT INTO `taxonomy_vocabulary` VALUES (1,'Tags','tags','Use tags to group articles on similar topics into categories.',0,'taxonomy',0),(2,'Post Categories','mt_post_categories','',0,'taxonomy',0);
/*!40000 ALTER TABLE `taxonomy_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twitter`
--

DROP TABLE IF EXISTS `twitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter` (
  `twitter_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique identifier for each twitter post.',
  `screen_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Screen Name of the twitter_account user.',
  `created_at` varchar(64) NOT NULL DEFAULT '' COMMENT 'Date and time the twitter post was created.',
  `created_time` int(11) NOT NULL COMMENT 'A duplicate of twitter.created_at in UNIX timestamp format.',
  `text` blob COMMENT 'The text of the twitter post.',
  `source` varchar(255) DEFAULT NULL COMMENT 'The application that created the twitter post.',
  `in_reply_to_status_id` bigint(20) unsigned DEFAULT '0' COMMENT 'Unique identifier of a status this twitter post was replying to.',
  `in_reply_to_user_id` bigint(20) unsigned DEFAULT '0' COMMENT 'Unique identifier for the twitter_account this post was replying to.',
  `in_reply_to_screen_name` varchar(255) DEFAULT NULL COMMENT 'Screen name of the twitter user this post was replying to.',
  `truncated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter status was cut off to fit in the 140 character limit.',
  `entities` longblob COMMENT 'A serialized array of twitter post entities.',
  PRIMARY KEY (`twitter_id`),
  KEY `screen_name` (`screen_name`),
  KEY `created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores individual Twitter posts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twitter`
--

LOCK TABLES `twitter` WRITE;
/*!40000 ALTER TABLE `twitter` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twitter_account`
--

DROP TABLE IF EXISTS `twitter_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_account` (
  `twitter_uid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier of the twitter_account.',
  `host` varchar(255) DEFAULT NULL COMMENT 'The host for this account can be a laconi.ca instance',
  `screen_name` varchar(255) DEFAULT NULL COMMENT 'The unique login name of the twitter_account user.',
  `oauth_token` varchar(64) DEFAULT NULL COMMENT 'The token_key for oauth-based access.',
  `oauth_token_secret` varchar(64) DEFAULT NULL COMMENT 'The token_secret for oauth-based access.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The full name of the twitter_account user.',
  `description` varchar(255) DEFAULT NULL COMMENT 'The description/biography associated with the twitter_account.',
  `location` varchar(255) DEFAULT NULL COMMENT 'The location of the twitter_account’s owner.',
  `followers_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of users following this twitter_account.',
  `friends_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of users this twitter_account is following.',
  `statuses_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The total number of status updates performed by a user, excluding direct messages sent.',
  `favourites_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The  number of statuses a user has marked as favorite.',
  `url` varchar(255) DEFAULT NULL COMMENT 'The url of the twitter_account’s home page.',
  `profile_image_url` varchar(255) DEFAULT NULL COMMENT 'The url of the twitter_account’s profile image.',
  `protected` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter_account’s posts are publicly accessible.',
  `profile_background_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s background color',
  `profile_text_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s text color',
  `profile_link_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s link color',
  `profile_sidebar_fill_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s sidebar color',
  `profile_sidebar_border_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s border color',
  `profile_background_image_url` varchar(255) DEFAULT NULL COMMENT 'The url of the twitter_account’s profile image.',
  `profile_background_tile` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Boolean indicating if a user’s background is tiled.',
  `verified` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Indicates if a user is verified.',
  `created_at` varchar(64) NOT NULL DEFAULT '' COMMENT 'Date and time the twitter_account was created.',
  `created_time` int(11) NOT NULL COMMENT 'A duplicate of twitter_account.created_at in UNIX timestamp format.',
  `utc_offset` int(11) NOT NULL COMMENT 'A duplicate of twitter_account.created_at in UNIX timestamp format.',
  `import` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter_user’s posts should be pulled in by the site.',
  `mentions` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter_user’s mentions should be pulled in by the site.',
  `last_refresh` int(11) NOT NULL DEFAULT '0' COMMENT 'A UNIX timestamp marking the date Twitter statuses were last fetched on.',
  `is_global` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating if this account is available for global use.',
  `uid` int(10) unsigned DEFAULT '0' COMMENT 'The uid of the user who added this Twitter account.',
  PRIMARY KEY (`twitter_uid`),
  KEY `screen_name` (`screen_name`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information on specific Twitter user accounts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twitter_account`
--

LOCK TABLES `twitter_account` WRITE;
/*!40000 ALTER TABLE `twitter_account` DISABLE KEYS */;
INSERT INTO `twitter_account` VALUES (217204926,NULL,'morethanthemes','217204926-yCZR8eZgKX3QnA0KndxvqxqexnnzC3JxGUm8rGZR','9QWwLKV0OfWCYLm8V7lGk64TGyohv5f6gTWTMAFEJeU','morethanthemes','Creators of some of the best Premium Drupal themes around. Leads of some of the best Free too. Tweeting about Drupal and all things web design & development.','All over the web.',721,250,2716,42,'http://t.co/RvYrlMsuhh','http://pbs.twimg.com/profile_images/3699201333/0e5f99e9cbb483cba6e6b6cfc843660e_normal.jpeg',0,'B2DFDA','333333','448CA6','F0FAFF','EEEEEE','http://pbs.twimg.com/profile_background_images/221997761/2011-03-24_16-34-10.png',1,0,'Thu Nov 18 21:38:21 +0000 2010',1290116301,10800,1,0,1464797888,0,1);
/*!40000 ALTER TABLE `twitter_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_alias`
--

LOCK TABLES `url_alias` WRITE;
/*!40000 ALTER TABLE `url_alias` DISABLE KEYS */;
INSERT INTO `url_alias` VALUES (1,'node/13','contact-us','und');
/*!40000 ALTER TABLE `url_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` VALUES ('additional_settings__active_tab_mt_post','s:11:\"edit-flippy\";'),('additional_settings__active_tab_mt_product','s:15:\"edit-submission\";'),('additional_settings__active_tab_mt_slideshow_entry','s:12:\"edit-comment\";'),('additional_settings__active_tab_webform','s:12:\"edit-comment\";'),('admin_theme','s:5:\"seven\";'),('anonymous','s:9:\"Anonymous\";'),('cache_class_cache_ctools_css','s:14:\"CToolsCssCache\";'),('clean_url','i:0;'),('comment_anonymous_mt_post','i:0;'),('comment_anonymous_mt_product','i:0;'),('comment_anonymous_mt_slideshow_entry','i:0;'),('comment_anonymous_webform','i:0;'),('comment_default_mode_mt_post','i:1;'),('comment_default_mode_mt_product','i:1;'),('comment_default_mode_mt_slideshow_entry','i:1;'),('comment_default_mode_webform','i:1;'),('comment_default_per_page_mt_post','s:2:\"50\";'),('comment_default_per_page_mt_product','s:2:\"50\";'),('comment_default_per_page_mt_slideshow_entry','s:2:\"50\";'),('comment_default_per_page_webform','s:2:\"50\";'),('comment_form_location_mt_post','i:1;'),('comment_form_location_mt_product','i:1;'),('comment_form_location_mt_slideshow_entry','i:1;'),('comment_form_location_webform','i:1;'),('comment_mt_post','s:1:\"2\";'),('comment_mt_product','s:1:\"1\";'),('comment_mt_slideshow_entry','s:1:\"1\";'),('comment_page','i:0;'),('comment_preview_mt_post','s:1:\"1\";'),('comment_preview_mt_product','s:1:\"1\";'),('comment_preview_mt_slideshow_entry','s:1:\"1\";'),('comment_preview_webform','s:1:\"1\";'),('comment_subject_field_mt_post','i:1;'),('comment_subject_field_mt_product','i:1;'),('comment_subject_field_mt_slideshow_entry','i:1;'),('comment_subject_field_webform','i:1;'),('comment_webform','s:1:\"1\";'),('commerce_customer_profile_billing_field','s:25:\"commerce_customer_billing\";'),('commerce_customer_profile_shipping_field','s:26:\"commerce_customer_shipping\";'),('commerce_customer_profile_shipping_profile_copy','i:1;'),('commerce_customer_profile_shipping_profile_copy_default','i:1;'),('commerce_customer_profile_shipping_profile_copy_source','s:7:\"billing\";'),('cron_key','s:43:\"oWu51W-iLj16vdjOjIYxwV2VbQJXthQeqEAaYj496vA\";'),('cron_last','i:1464797888;'),('css_js_query_string','s:6:\"o83ppp\";'),('ctools_last_cron','i:1464713979;'),('date_default_timezone','s:13:\"Europe/Athens\";'),('default_nodes_main','s:1:\"5\";'),('drupal_http_request_fails','b:0;'),('drupal_private_key','s:43:\"UkEADdi13ToeTxKO9vI8L42UUox-dPoyi0ZHGFYeD9U\";'),('email__active_tab','s:24:\"edit-email-admin-created\";'),('field_bundle_settings_node__article','a:2:{s:10:\"view_modes\";a:5:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:0;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:1:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__blog','a:2:{s:10:\"view_modes\";a:5:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:0;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:1:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__mt_post','a:2:{s:10:\"view_modes\";a:6:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:0;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:1:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}}s:7:\"display\";a:1:{s:12:\"flippy_pager\";a:2:{s:7:\"default\";a:2:{s:6:\"weight\";s:1:\"5\";s:7:\"visible\";b:0;}s:6:\"teaser\";a:2:{s:6:\"weight\";s:1:\"3\";s:7:\"visible\";b:0;}}}}}'),('field_bundle_settings_node__mt_product','a:2:{s:10:\"view_modes\";a:5:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:0;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:1:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}}s:7:\"display\";a:5:{s:11:\"product:sku\";a:2:{s:7:\"default\";a:2:{s:6:\"weight\";s:1:\"6\";s:7:\"visible\";b:0;}s:6:\"teaser\";a:2:{s:6:\"weight\";s:1:\"4\";s:7:\"visible\";b:0;}}s:13:\"product:title\";a:2:{s:7:\"default\";a:2:{s:6:\"weight\";s:1:\"7\";s:7:\"visible\";b:0;}s:6:\"teaser\";a:2:{s:6:\"weight\";s:1:\"5\";s:7:\"visible\";b:0;}}s:14:\"product:status\";a:2:{s:7:\"default\";a:2:{s:6:\"weight\";s:2:\"10\";s:7:\"visible\";b:0;}s:6:\"teaser\";a:2:{s:6:\"weight\";s:2:\"10\";s:7:\"visible\";b:0;}}s:22:\"product:commerce_price\";a:2:{s:7:\"default\";a:2:{s:6:\"weight\";s:1:\"3\";s:7:\"visible\";b:1;}s:6:\"teaser\";a:2:{s:6:\"weight\";s:1:\"2\";s:7:\"visible\";b:1;}}s:22:\"product:commerce_stock\";a:2:{s:7:\"default\";a:2:{s:6:\"weight\";s:1:\"5\";s:7:\"visible\";b:0;}s:6:\"teaser\";a:2:{s:6:\"weight\";s:1:\"3\";s:7:\"visible\";b:1;}}}}}'),('field_bundle_settings_node__mt_slideshow_entry','a:2:{s:10:\"view_modes\";a:5:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:0;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:1:{s:5:\"title\";a:1:{s:6:\"weight\";s:2:\"-5\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_user__user','a:2:{s:10:\"view_modes\";a:1:{s:4:\"full\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:7:\"account\";a:1:{s:6:\"weight\";s:3:\"-10\";}s:8:\"timezone\";a:1:{s:6:\"weight\";s:1:\"6\";}}s:7:\"display\";a:1:{s:7:\"summary\";a:1:{s:7:\"default\";a:2:{s:6:\"weight\";s:1:\"5\";s:7:\"visible\";b:0;}}}}}'),('file_default_scheme','s:6:\"public\";'),('file_private_path','s:0:\"\";'),('file_public_path','s:19:\"sites/default/files\";'),('file_temporary_path','s:23:\"sites/default/files/tmp\";'),('filter_fallback_format','s:10:\"plain_text\";'),('flippy_custom_sorting_mt_post','i:1;'),('flippy_ellipse_mt_post','s:3:\"...\";'),('flippy_firstlast_mt_post','i:0;'),('flippy_first_label_mt_post','s:8:\"« First\";'),('flippy_head_mt_post','i:0;'),('flippy_last_label_mt_post','s:7:\"Last »\";'),('flippy_loop_mt_post','i:0;'),('flippy_mt_post','i:1;'),('flippy_next_label_mt_post','s:12:\"[node:title]\";'),('flippy_order_mt_post','s:3:\"ASC\";'),('flippy_prev_label_mt_post','s:12:\"[node:title]\";'),('flippy_random_label_mt_post','s:6:\"Random\";'),('flippy_random_mt_post','i:0;'),('flippy_show_empty_mt_post','i:0;'),('flippy_sort_mt_post','s:3:\"nid\";'),('flippy_truncate_mt_post','s:0:\"\";'),('install_profile','s:8:\"standard\";'),('install_task','s:4:\"done\";'),('install_time','i:1400586951;'),('jquery_update_compression_type','s:3:\"min\";'),('jquery_update_jquery_admin_version','s:0:\"\";'),('jquery_update_jquery_cdn','s:4:\"none\";'),('jquery_update_jquery_version','s:4:\"1.10\";'),('maintenance_mode','b:0;'),('maintenance_mode_message','s:93:\"NEWS+ is currently under maintenance. We should be back shortly. Thank you for your patience.\";'),('menu_expanded','a:0:{}'),('menu_masks','a:46:{i:0;i:507;i:1;i:506;i:2;i:501;i:3;i:493;i:4;i:253;i:5;i:252;i:6;i:251;i:7;i:250;i:8;i:247;i:9;i:246;i:10;i:245;i:11;i:127;i:12;i:126;i:13;i:125;i:14;i:124;i:15;i:123;i:16;i:122;i:17;i:121;i:18;i:117;i:19;i:63;i:20;i:62;i:21;i:61;i:22;i:60;i:23;i:59;i:24;i:58;i:25;i:45;i:26;i:44;i:27;i:31;i:28;i:30;i:29;i:29;i:30;i:28;i:31;i:24;i:32;i:22;i:33;i:21;i:34;i:15;i:35;i:14;i:36;i:13;i:37;i:11;i:38;i:10;i:39;i:7;i:40;i:6;i:41;i:5;i:42;i:4;i:43;i:3;i:44;i:2;i:45;i:1;}'),('menu_options_mt_post','a:1:{i:0;s:9:\"main-menu\";}'),('menu_options_mt_product','a:1:{i:0;s:9:\"main-menu\";}'),('menu_options_mt_slideshow_entry','a:1:{i:0;s:9:\"main-menu\";}'),('menu_options_webform','a:1:{i:0;s:9:\"main-menu\";}'),('menu_parent_mt_post','s:11:\"main-menu:0\";'),('menu_parent_mt_product','s:11:\"main-menu:0\";'),('menu_parent_mt_slideshow_entry','s:11:\"main-menu:0\";'),('menu_parent_webform','s:11:\"main-menu:0\";'),('node_admin_theme','i:1;'),('node_cron_last','s:10:\"1403558044\";'),('node_options_mt_post','a:2:{i:0;s:6:\"status\";i:1;s:7:\"promote\";}'),('node_options_mt_product','a:2:{i:0;s:6:\"status\";i:1;s:7:\"promote\";}'),('node_options_mt_slideshow_entry','a:1:{i:0;s:6:\"status\";}'),('node_options_page','a:1:{i:0;s:6:\"status\";}'),('node_options_webform','a:1:{i:0;s:6:\"status\";}'),('node_preview_mt_post','s:1:\"1\";'),('node_preview_mt_product','s:1:\"1\";'),('node_preview_mt_slideshow_entry','s:1:\"1\";'),('node_preview_webform','s:1:\"1\";'),('node_submitted_mt_post','i:1;'),('node_submitted_mt_product','i:0;'),('node_submitted_mt_slideshow_entry','i:0;'),('node_submitted_page','b:0;'),('node_submitted_webform','i:0;'),('path_alias_whitelist','a:1:{s:4:\"node\";b:1;}'),('save_continue_mt_post','s:19:\"Save and add fields\";'),('save_continue_mt_product','s:19:\"Save and add fields\";'),('save_continue_mt_slideshow_entry','s:19:\"Save and add fields\";'),('site_403','s:0:\"\";'),('site_404','s:0:\"\";'),('site_default_country','s:2:\"GR\";'),('site_frontpage','s:4:\"node\";'),('site_mail','s:34:\"george+newsplus@morethanthemes.com\";'),('site_name','s:5:\"NEWS+\";'),('site_slogan','s:45:\"A news theme for Drupal, based on Bootstrap 3\";'),('statistics_count_content_views','i:1;'),('statistics_count_content_views_ajax','i:0;'),('statistics_day_timestamp','i:1464713978;'),('statistics_enable_access_log','i:0;'),('statistics_flush_accesslog_timer','s:6:\"259200\";'),('superfish_arrow_1','i:0;'),('superfish_arrow_2','i:0;'),('superfish_bgf_1','i:0;'),('superfish_bgf_2','i:0;'),('superfish_delay_1','s:3:\"800\";'),('superfish_delay_2','s:3:\"800\";'),('superfish_depth_1','s:2:\"-1\";'),('superfish_depth_2','s:2:\"-1\";'),('superfish_dfirstlast_1','i:0;'),('superfish_dfirstlast_2','i:0;'),('superfish_dzebra_1','i:0;'),('superfish_dzebra_2','i:0;'),('superfish_expanded_1','i:0;'),('superfish_expanded_2','i:0;'),('superfish_firstlast_1','i:1;'),('superfish_firstlast_2','i:1;'),('superfish_hhldescription_1','i:0;'),('superfish_hhldescription_2','i:0;'),('superfish_hid_1','i:1;'),('superfish_hid_2','i:1;'),('superfish_hlclass_1','s:0:\"\";'),('superfish_hlclass_2','s:0:\"\";'),('superfish_hldescription_1','i:0;'),('superfish_hldescription_2','i:0;'),('superfish_hldexclude_1','s:0:\"\";'),('superfish_hldexclude_2','s:0:\"\";'),('superfish_hldmenus_1','s:0:\"\";'),('superfish_hldmenus_2','s:0:\"\";'),('superfish_itemcounter_1','i:1;'),('superfish_itemcounter_2','i:1;'),('superfish_itemcount_1','i:1;'),('superfish_itemcount_2','i:1;'),('superfish_itemdepth_1','i:1;'),('superfish_itemdepth_2','i:1;'),('superfish_liclass_1','s:0:\"\";'),('superfish_liclass_2','s:0:\"\";'),('superfish_maxwidth_1','s:2:\"27\";'),('superfish_maxwidth_2','s:2:\"27\";'),('superfish_mcdepth_1','s:1:\"1\";'),('superfish_mcdepth_2','s:1:\"1\";'),('superfish_mcexclude_1','s:0:\"\";'),('superfish_mcexclude_2','s:0:\"\";'),('superfish_mclevels_1','s:1:\"1\";'),('superfish_mclevels_2','s:1:\"1\";'),('superfish_menu_1','s:11:\"main-menu:0\";'),('superfish_menu_2','s:21:\"menu-secondary-menu:0\";'),('superfish_minwidth_1','s:2:\"14\";'),('superfish_minwidth_2','s:2:\"14\";'),('superfish_multicolumn_1','i:0;'),('superfish_multicolumn_2','i:0;'),('superfish_name_1','s:11:\"Superfish 1\";'),('superfish_name_2','s:11:\"Superfish 2\";'),('superfish_number','s:1:\"2\";'),('superfish_pathclass_1','s:12:\"active-trail\";'),('superfish_pathclass_2','s:12:\"active-trail\";'),('superfish_pathcss_1','s:0:\"\";'),('superfish_pathcss_2','s:0:\"\";'),('superfish_pathlevels_1','s:1:\"1\";'),('superfish_pathlevels_2','s:1:\"1\";'),('superfish_shadow_1','i:0;'),('superfish_shadow_2','i:0;'),('superfish_slide_1','s:4:\"none\";'),('superfish_slide_2','s:4:\"none\";'),('superfish_slp','s:344:\"sites/all/libraries/superfish/jquery.hoverIntent.minified.js\r\nsites/all/libraries/superfish/jquery.bgiframe.min.js\r\nsites/all/libraries/superfish/superfish.js\r\nsites/all/libraries/superfish/supersubs.js\r\nsites/all/libraries/superfish/supposition.js\r\nsites/all/libraries/superfish/sftouchscreen.js\r\nsites/all/libraries/superfish/sfsmallscreen.js\";'),('superfish_smallasa_1','i:0;'),('superfish_smallasa_2','i:0;'),('superfish_smallbp_1','s:3:\"768\";'),('superfish_smallbp_2','s:3:\"768\";'),('superfish_smallchc_1','i:0;'),('superfish_smallchc_2','i:0;'),('superfish_smallcmc_1','i:0;'),('superfish_smallcmc_2','i:0;'),('superfish_smallech_1','s:0:\"\";'),('superfish_smallech_2','s:0:\"\";'),('superfish_smallecm_1','s:0:\"\";'),('superfish_smallecm_2','s:0:\"\";'),('superfish_smallich_1','s:0:\"\";'),('superfish_smallich_2','s:0:\"\";'),('superfish_smallicm_1','s:0:\"\";'),('superfish_smallicm_2','s:0:\"\";'),('superfish_smallset_1','s:0:\"\";'),('superfish_smallset_2','s:0:\"\";'),('superfish_smallual_1','s:0:\"\";'),('superfish_smallual_2','s:0:\"\";'),('superfish_smalluam_1','s:1:\"0\";'),('superfish_smalluam_2','s:1:\"0\";'),('superfish_smallua_1','s:1:\"0\";'),('superfish_smallua_2','s:1:\"0\";'),('superfish_small_1','s:1:\"0\";'),('superfish_small_2','s:1:\"0\";'),('superfish_speed_1','s:4:\"fast\";'),('superfish_speed_2','s:4:\"fast\";'),('superfish_spp_1','i:1;'),('superfish_spp_2','i:1;'),('superfish_style_1','s:4:\"none\";'),('superfish_style_2','s:4:\"none\";'),('superfish_supersubs_1','i:1;'),('superfish_supersubs_2','i:1;'),('superfish_touchbp_1','s:3:\"768\";'),('superfish_touchbp_2','s:3:\"768\";'),('superfish_touchual_1','s:0:\"\";'),('superfish_touchual_2','s:0:\"\";'),('superfish_touchuam_1','s:1:\"0\";'),('superfish_touchuam_2','s:1:\"0\";'),('superfish_touchua_1','s:1:\"0\";'),('superfish_touchua_2','s:1:\"0\";'),('superfish_touch_1','s:1:\"0\";'),('superfish_touch_2','s:1:\"0\";'),('superfish_type_1','s:10:\"horizontal\";'),('superfish_type_2','s:10:\"horizontal\";'),('superfish_ulclass_1','s:0:\"\";'),('superfish_ulclass_2','s:0:\"\";'),('superfish_use_item_theme_1','i:1;'),('superfish_use_item_theme_2','i:1;'),('superfish_use_link_theme_1','i:1;'),('superfish_use_link_theme_2','i:1;'),('superfish_wraphlt_1','s:0:\"\";'),('superfish_wraphlt_2','s:0:\"\";'),('superfish_wraphl_1','s:0:\"\";'),('superfish_wraphl_2','s:0:\"\";'),('superfish_wrapmul_1','s:0:\"\";'),('superfish_wrapmul_2','s:0:\"\";'),('superfish_wrapul_1','s:0:\"\";'),('superfish_wrapul_2','s:0:\"\";'),('superfish_zebra_1','i:1;'),('superfish_zebra_2','i:1;'),('theme_default','s:8:\"newsplus\";'),('theme_newsplus_settings','a:44:{s:11:\"toggle_logo\";i:1;s:11:\"toggle_name\";i:1;s:13:\"toggle_slogan\";i:1;s:24:\"toggle_node_user_picture\";i:1;s:27:\"toggle_comment_user_picture\";i:1;s:32:\"toggle_comment_user_verification\";i:1;s:14:\"toggle_favicon\";i:1;s:16:\"toggle_main_menu\";i:1;s:21:\"toggle_secondary_menu\";i:1;s:12:\"default_logo\";i:1;s:9:\"logo_path\";s:0:\"\";s:11:\"logo_upload\";s:0:\"\";s:15:\"default_favicon\";i:1;s:12:\"favicon_path\";s:0:\"\";s:14:\"favicon_upload\";s:0:\"\";s:18:\"breadcrumb_display\";i:1;s:20:\"breadcrumb_separator\";s:2:\"/ \";s:12:\"fixed_header\";i:1;s:17:\"scrolltop_display\";i:1;s:23:\"frontpage_content_print\";i:0;s:20:\"bootstrap_js_include\";i:1;s:25:\"three_columns_grid_layout\";s:10:\"grid_3_6_3\";s:12:\"color_scheme\";s:7:\"default\";s:12:\"reading_time\";i:1;s:11:\"share_links\";i:1;s:12:\"print_button\";i:1;s:11:\"font_resize\";i:1;s:13:\"post_progress\";i:1;s:20:\"sitename_font_family\";s:6:\"sff-32\";s:18:\"slogan_font_family\";s:7:\"slff-32\";s:20:\"headings_font_family\";s:5:\"hff-5\";s:21:\"paragraph_font_family\";s:5:\"pff-5\";s:16:\"slideshow_effect\";s:4:\"fade\";s:21:\"slideshow_effect_time\";s:2:\"10\";s:22:\"internal_banner_effect\";s:5:\"slide\";s:15:\"breaking_effect\";s:4:\"fade\";s:20:\"breaking_effect_time\";s:1:\"5\";s:31:\"responsive_multilevelmenu_state\";i:1;s:13:\"google_map_js\";i:1;s:19:\"google_map_latitude\";s:9:\"40.726576\";s:20:\"google_map_longitude\";s:10:\"-74.046822\";s:15:\"google_map_zoom\";s:2:\"13\";s:17:\"google_map_canvas\";s:10:\"map-canvas\";s:16:\"tabs__active_tab\";s:14:\"edit-slideshow\";}'),('twitter_api','s:23:\"https://api.twitter.com\";'),('twitter_consumer_key','s:22:\"D1aWqpXcplUbNzWcksUMqA\";'),('twitter_consumer_secret','s:42:\"RiR5ancU6wit7teq7SiyMjozDkHXGukgvZOmTKE8KQ\";'),('twitter_expire','s:7:\"2592000\";'),('twitter_host','s:18:\"http://twitter.com\";'),('twitter_import','i:1;'),('twitter_search','s:20:\"https://twitter.com/\";'),('twitter_tinyurl','s:18:\"http://tinyurl.com\";'),('update_last_check','i:1464797911;'),('update_last_email_notification','i:1444395041;'),('update_notify_emails','a:1:{i:0;s:34:\"george+newsplus@morethanthemes.com\";}'),('user_admin_role','s:1:\"3\";'),('user_cancel_method','s:17:\"user_cancel_block\";'),('user_email_verification','i:1;'),('user_mail_cancel_confirm_body','s:381:\"[user:name],\r\n\r\nA request to cancel your account has been made at [site:name].\r\n\r\nYou may now cancel your account on [site:url-brief] by clicking this link or copying and pasting it into your browser:\r\n\r\n[user:cancel-url]\r\n\r\nNOTE: The cancellation of your account is not reversible.\r\n\r\nThis link expires in one day and nothing will happen if it is not used.\r\n\r\n--  [site:name] team\";'),('user_mail_cancel_confirm_subject','s:59:\"Account cancellation request for [user:name] at [site:name]\";'),('user_mail_password_reset_body','s:407:\"[user:name],\r\n\r\nA request to reset the password for your account has been made at [site:name].\r\n\r\nYou may now log in by clicking this link or copying and pasting it to your browser:\r\n\r\n[user:one-time-login-url]\r\n\r\nThis link can only be used once to log in and will lead you to a page where you can set your password. It expires after one day and nothing will happen if it\'s not used.\r\n\r\n--  [site:name] team\";'),('user_mail_password_reset_subject','s:60:\"Replacement login information for [user:name] at [site:name]\";'),('user_mail_register_admin_created_body','s:476:\"[user:name],\r\n\r\nA site administrator at [site:name] has created an account for you. You may now log in by clicking this link or copying and pasting it to your browser:\r\n\r\n[user:one-time-login-url]\r\n\r\nThis link can only be used once to log in and will lead you to a page where you can set your password.\r\n\r\nAfter setting your password, you will be able to log in at [site:login-url] in the future using:\r\n\r\nusername: [user:name]\r\npassword: Your password\r\n\r\n--  [site:name] team\";'),('user_mail_register_admin_created_subject','s:58:\"An administrator created an account for you at [site:name]\";'),('user_mail_register_no_approval_required_body','s:450:\"[user:name],\r\n\r\nThank you for registering at [site:name]. You may now log in by clicking this link or copying and pasting it to your browser:\r\n\r\n[user:one-time-login-url]\r\n\r\nThis link can only be used once to log in and will lead you to a page where you can set your password.\r\n\r\nAfter setting your password, you will be able to log in at [site:login-url] in the future using:\r\n\r\nusername: [user:name]\r\npassword: Your password\r\n\r\n--  [site:name] team\";'),('user_mail_register_no_approval_required_subject','s:46:\"Account details for [user:name] at [site:name]\";'),('user_mail_register_pending_approval_body','s:287:\"[user:name],\r\n\r\nThank you for registering at [site:name]. Your application for an account is currently pending approval. Once it has been approved, you will receive another e-mail containing information about how to log in, set your password, and other details.\r\n\r\n\r\n--  [site:name] team\";'),('user_mail_register_pending_approval_subject','s:71:\"Account details for [user:name] at [site:name] (pending admin approval)\";'),('user_mail_status_activated_body','s:461:\"[user:name],\r\n\r\nYour account at [site:name] has been activated.\r\n\r\nYou may now log in by clicking this link or copying and pasting it into your browser:\r\n\r\n[user:one-time-login-url]\r\n\r\nThis link can only be used once to log in and will lead you to a page where you can set your password.\r\n\r\nAfter setting your password, you will be able to log in at [site:login-url] in the future using:\r\n\r\nusername: [user:name]\r\npassword: Your password\r\n\r\n--  [site:name] team\";'),('user_mail_status_activated_notify','i:1;'),('user_mail_status_activated_subject','s:57:\"Account details for [user:name] at [site:name] (approved)\";'),('user_mail_status_blocked_body','s:85:\"[user:name],\r\n\r\nYour account on [site:name] has been blocked.\r\n\r\n--  [site:name] team\";'),('user_mail_status_blocked_notify','i:0;'),('user_mail_status_blocked_subject','s:56:\"Account details for [user:name] at [site:name] (blocked)\";'),('user_mail_status_canceled_body','s:86:\"[user:name],\r\n\r\nYour account on [site:name] has been canceled.\r\n\r\n--  [site:name] team\";'),('user_mail_status_canceled_notify','i:0;'),('user_mail_status_canceled_subject','s:57:\"Account details for [user:name] at [site:name] (canceled)\";'),('user_pictures','i:1;'),('user_picture_default','s:39:\"sites/default/files/pictures/avatar.png\";'),('user_picture_dimensions','s:9:\"1024x1024\";'),('user_picture_file_size','s:3:\"800\";'),('user_picture_guidelines','s:0:\"\";'),('user_picture_path','s:8:\"pictures\";'),('user_picture_style','s:6:\"medium\";'),('user_register','s:1:\"0\";'),('user_signatures','i:0;'),('views_defaults','a:3:{s:7:\"archive\";b:0;s:15:\"comments_recent\";b:1;s:6:\"tweets\";b:1;}'),('webform_node_types','a:1:{i:0;s:7:\"webform\";}');
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform`
--

DROP TABLE IF EXISTS `webform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform` (
  `nid` int(10) unsigned NOT NULL COMMENT 'The node identifier of a webform.',
  `confirmation` text NOT NULL COMMENT 'The confirmation message or URL displayed to the user after submitting a form.',
  `confirmation_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the confirmation message.',
  `redirect_url` varchar(255) DEFAULT '<confirmation>' COMMENT 'The URL a user is redirected to after submitting a form.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value of a webform for open (1) or closed (0).',
  `block` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether this form be available as a block.',
  `teaser` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether the entire form should be displayed on the teaser.',
  `allow_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form be saved as a draft.',
  `auto_save` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form should be auto-saved between pages.',
  `submit_notice` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value for whether to show or hide the previous submissions notification.',
  `submit_text` varchar(255) DEFAULT NULL COMMENT 'The title of the submit button on the form.',
  `submit_limit` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'The number of submissions a single user is allowed to submit within an interval. -1 is unlimited.',
  `submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before a user can submit another submission within the set limit.',
  `total_submit_limit` int(11) NOT NULL DEFAULT '-1' COMMENT 'The total number of submissions allowed within an interval. -1 is unlimited.',
  `total_submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before another submission can be submitted within the set limit.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing additional properties for webform nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform`
--

LOCK TABLES `webform` WRITE;
/*!40000 ALTER TABLE `webform` DISABLE KEYS */;
INSERT INTO `webform` VALUES (13,'',NULL,'<confirmation>',1,0,0,0,0,1,'',-1,-1,-1,-1);
/*!40000 ALTER TABLE `webform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform_component`
--

DROP TABLE IF EXISTS `webform_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_component` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If this component has a parent fieldset, the cid of that component.',
  `form_key` varchar(128) DEFAULT NULL COMMENT 'When the form is displayed and processed, this key can be used to reference the results.',
  `name` varchar(255) DEFAULT NULL COMMENT 'The label for this component.',
  `type` varchar(16) DEFAULT NULL COMMENT 'The field type of this component (textfield, select, hidden, etc.).',
  `value` text NOT NULL COMMENT 'The default value of the component when displayed to the end-user.',
  `extra` text NOT NULL COMMENT 'Additional information unique to the display or processing of this component.',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean flag for if this component is required.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this component in the form.',
  PRIMARY KEY (`nid`,`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about components for webform nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform_component`
--

LOCK TABLES `webform_component` WRITE;
/*!40000 ALTER TABLE `webform_component` DISABLE KEYS */;
INSERT INTO `webform_component` VALUES (13,1,0,'name','Your name','textfield','Your Name','a:5:{s:13:\"title_display\";s:4:\"none\";s:7:\"private\";i:0;s:8:\"disabled\";i:0;s:6:\"unique\";i:0;s:20:\"conditional_operator\";s:1:\"=\";}',1,5),(13,2,0,'email','Your email','email','Your e-mail','a:5:{s:13:\"title_display\";s:4:\"none\";s:7:\"private\";i:0;s:8:\"disabled\";i:0;s:6:\"unique\";i:0;s:20:\"conditional_operator\";s:1:\"=\";}',1,6),(13,3,0,'subject','Subject','textfield','Subject','a:5:{s:13:\"title_display\";s:4:\"none\";s:7:\"private\";i:0;s:8:\"disabled\";i:0;s:6:\"unique\";i:0;s:20:\"conditional_operator\";s:1:\"=\";}',1,7),(13,4,0,'message','Message','textarea','Message','a:6:{s:13:\"title_display\";s:4:\"none\";s:7:\"private\";i:0;s:4:\"rows\";s:2:\"12\";s:9:\"resizable\";i:1;s:8:\"disabled\";i:0;s:20:\"conditional_operator\";s:1:\"=\";}',1,9),(13,5,0,'about_you','Tell us about you','markup','<h4>Tell us about you</h4>','a:3:{s:20:\"conditional_operator\";s:1:\"=\";s:6:\"format\";s:9:\"full_html\";s:7:\"private\";i:0;}',0,4),(13,6,0,'message_label','What are you writing to us about?','markup','<h4>What are you writing to us about?</h4>','a:3:{s:20:\"conditional_operator\";s:1:\"=\";s:6:\"format\";s:9:\"full_html\";s:7:\"private\";i:0;}',0,8);
/*!40000 ALTER TABLE `webform_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform_emails`
--

DROP TABLE IF EXISTS `webform_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_emails` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `eid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The e-mail identifier for this row’s settings.',
  `email` text COMMENT 'The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `subject` varchar(255) DEFAULT NULL COMMENT 'The e-mail subject that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_name` varchar(255) DEFAULT NULL COMMENT 'The e-mail "from" name that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_address` varchar(255) DEFAULT NULL COMMENT 'The e-mail "from" e-mail address that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `template` text COMMENT 'A template that will be used for the sent e-mail. This may be a string or the special key "default", which will use the template provided by the theming layer.',
  `excluded_components` text NOT NULL COMMENT 'A list of components that will not be included in the %email_values token. A list of CIDs separated by commas.',
  `html` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.',
  `attachments` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include file attachments. Requires Mime Mail module.',
  PRIMARY KEY (`nid`,`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information regarding e-mails that should be sent...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform_emails`
--

LOCK TABLES `webform_emails` WRITE;
/*!40000 ALTER TABLE `webform_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `webform_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform_last_download`
--

DROP TABLE IF EXISTS `webform_last_download`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_last_download` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user identifier.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The last downloaded submission number.',
  `requested` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of last download request.',
  PRIMARY KEY (`nid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores last submission number per user download.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform_last_download`
--

LOCK TABLES `webform_last_download` WRITE;
/*!40000 ALTER TABLE `webform_last_download` DISABLE KEYS */;
/*!40000 ALTER TABLE `webform_last_download` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform_roles`
--

DROP TABLE IF EXISTS `webform_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_roles` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The role identifier.',
  PRIMARY KEY (`nid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds access information regarding which roles are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform_roles`
--

LOCK TABLES `webform_roles` WRITE;
/*!40000 ALTER TABLE `webform_roles` DISABLE KEYS */;
INSERT INTO `webform_roles` VALUES (13,1),(13,2);
/*!40000 ALTER TABLE `webform_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform_submissions`
--

DROP TABLE IF EXISTS `webform_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_submissions` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for this submission.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The id of the user that completed this submission.',
  `is_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this a draft of the submission?',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the form was submitted.',
  `remote_addr` varchar(128) DEFAULT NULL COMMENT 'The IP address of the user that submitted the form.',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sid_nid` (`sid`,`nid`),
  KEY `nid_uid_sid` (`nid`,`uid`,`sid`),
  KEY `nid_sid` (`nid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds general information about submissions outside of...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform_submissions`
--

LOCK TABLES `webform_submissions` WRITE;
/*!40000 ALTER TABLE `webform_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `webform_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webform_submitted_data`
--

DROP TABLE IF EXISTS `webform_submitted_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webform_submitted_data` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier for this submission.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `no` varchar(128) NOT NULL DEFAULT '0' COMMENT 'Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database.',
  `data` mediumtext NOT NULL COMMENT 'The submitted value of this field, may be serialized for some components.',
  PRIMARY KEY (`nid`,`sid`,`cid`,`no`),
  KEY `nid` (`nid`),
  KEY `sid_nid` (`sid`,`nid`),
  KEY `data` (`data`(64))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all submitted field data for webform submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webform_submitted_data`
--

LOCK TABLES `webform_submitted_data` WRITE;
/*!40000 ALTER TABLE `webform_submitted_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `webform_submitted_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-01 19:27:46
