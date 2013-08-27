CREATE TABLE IF NOT EXISTS `cot_calendar` (
  `cal_id` int unsigned NOT NULL auto_increment,
  `cal_owner` int unsigned NOT NULL,
  `cal_title` varchar(255) NOT NULL,
  `cal_desc` varchar(255) NOT NULL,
  `cal_start` int(11) NOT NULL default '0',
  `cal_end` int(11) NOT NULL default '0',
  `cal_allday` tinyint(1) NOT NULL,
  `cal_color` varchar(7) NOT NULL,
  `cal_public` tinyint(1) NOT NULL,
  `cal_url` varchar(255) NOT NULL,
  PRIMARY KEY (`cal_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;