<?php
/* ====================
[BEGIN_COT_EXT]
Hooks=rc
[END_COT_EXT]
==================== */

/**
 * Calendar JS and CSS loader
 *
 * @package calendar
 * @author Twiebie
 * @copyright Copyright (c) www.digital-balance.net 2013
 * @license BSD
 */

defined('COT_CODE') or die('Wrong URL.');

// CSS
cot_rc_add_file($cfg['plugins_dir'].'/calendar/css/fullcalendar.css');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/css/datetimepicker.css');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/css/simplecolorpicker.css');

// JS
cot_rc_add_file($cfg['plugins_dir'].'/calendar/js/jquery-ui.min.js');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/js/jquery.form.js');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/js/fullcalendar.min.js');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/js/datetimepicker.min.js');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/js/simplecolorpicker.js');
cot_rc_add_file($cfg['plugins_dir'].'/calendar/js/js.js');