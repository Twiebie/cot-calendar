<?php defined('COT_CODE') or die('Wrong URL.');
/* ====================
[BEGIN_COT_EXT]
Hooks=standalone
[END_COT_EXT]
==================== */

/**
 * Calendar
 *
 * @package calendar
 * @author Twiebie
 * @copyright Copyright (c) www.digital-balance.net 2013
 * @license BSD
 */

require_once cot_incfile('calendar', 'plug');
require_once cot_langfile('calendar', 'plug');

// CSS
cot_rc_link_file($cfg['plugins_dir'].'/calendar/css/fullcalendar.css');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/css/datetimepicker.css');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/css/simplecolorpicker.css');

// JS
cot_rc_link_file($cfg['plugins_dir'].'/calendar/js/jquery-ui.min.js');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/js/jquery.form.js');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/js/fullcalendar.min.js');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/js/datetimepicker.min.js');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/js/simplecolorpicker.js');
cot_rc_link_file($cfg['plugins_dir'].'/calendar/js/js.js');

$out['subtitle'] = $L['cal_maintitle'];

$t = new XTemplate(cot_tplfile('calendar', 'plug'));

if ($usr['auth_write'])
{
    $t->assign(array(
        'FORM_EDIT_TITLE'  => cot_inputbox('text', 'title', '', array('size' => '32', 'maxlength' => '255', 'required' => 'required')),
        'FORM_EDIT_DESC'   => cot_inputbox('text', 'desc', '', array('size' => '32', 'maxlength' => '255')),
        'FORM_EDIT_STDATE' => cot_inputbox('text', 'start', '', array('size' => '32', 'maxlength' => '255', 'required' => 'required', 'data-date-format' => 'yyyy-mm-dd hh:ii')),
        'FORM_EDIT_ENDATE' => cot_inputbox('text', 'end', '', array('size' => '32', 'maxlength' => '255', 'required' => 'required', 'data-date-format' => 'yyyy-mm-dd hh:ii')),
        'FORM_EDIT_ALLDAY' => cot_checkbox('', 'allday'),
        'FORM_EDIT_PUBLIC' => cot_checkbox('', 'pub')
    ));
    $t->parse('MAIN.MODAL_EDIT.FORM');
    $t->parse('MAIN.MODAL_EDIT');

    $t->assign(array(
        'FORM_ADD_TITLE'  => cot_inputbox('text', 'title', '', array('size' => '32', 'maxlength' => '255', 'required' => 'required')),
        'FORM_ADD_DESC'   => cot_inputbox('text', 'desc', '', array('size' => '32', 'maxlength' => '255')),
        'FORM_ADD_STDATE' => cot_inputbox('text', 'start', '', array('size' => '32', 'maxlength' => '255', 'required' => 'required', 'data-date-format' => 'yyyy-mm-dd hh:ii')),
        'FORM_ADD_ENDATE' => cot_inputbox('text', 'end', '', array('size' => '32', 'maxlength' => '255', 'required' => 'required', 'data-date-format' => 'yyyy-mm-dd hh:ii')),
        'FORM_ADD_ALLDAY' => cot_checkbox('', 'allday'),
        'FORM_ADD_PUBLIC' => cot_checkbox('', 'pub')
    ));
    $t->parse('MAIN.MODAL_ADD.FORM');
    $t->parse('MAIN.MODAL_ADD');
}