<?php defined('COT_CODE') or die('Wrong URL.');
/* ====================
[BEGIN_COT_EXT]
Hooks=ajax
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

switch ($a)
{
    case 'fetch':
        $json = calFetch();
        cot_sendheaders('application/json');
        echo json_encode($json);
        break;

    case 'update':
        $id = cot_import('id', 'P', 'INT');

        if (isset($id) && $usr['auth_write'])
        {
            $owner = cot_import('owner', 'P', 'INT');
            $start = cot_import('start', 'P', 'TXT');
            $end   = cot_import('end', 'P', 'TXT');

            if (calUpdate($id, $owner, $start, $end))
            {
                calError(true);
            }
            else
            {
                calError(false, $L['msg930_title'], $L['msg930_body']);
            }
        }
        else
        {
            calError(false, $L['msg930_title'], $L['msg930_body']);
        }
        break;

    case 'add';
        if ($usr['auth_write'])
        {
            $start  = cot_import('start', 'P', 'TXT');
            $end    = cot_import('end', 'P', 'TXT');
            $title  = cot_import('title', 'P', 'TXT');
            $desc   = cot_import('desc', 'P', 'TXT');
            $color  = cot_import('colorpicker', 'P', 'TXT');
            $allday = cot_import('allday', 'P', 'BOL');
            $public = cot_import('pub', 'P', 'BOL');

            if (calAdd($start, $end, $title, $desc, $color, $allday, $public))
            {
                calError(true);
            }
            else
            {
                calError(false, $L['msg930_title'], $L['msg930_body']);
            }
        }
        else
        {
            calError(false, $L['msg930_title'], $L['msg930_body']);
        }
        break;

    case 'edit';
        $id = cot_import('id', 'P', 'INT');

        if (isset($id) && $usr['auth_write'])
        {
            $owner  = cot_import('owner', 'P', 'INT');
            $start  = cot_import('start', 'P', 'TXT');
            $end    = cot_import('end', 'P', 'TXT');
            $title  = cot_import('title', 'P', 'TXT');
            $desc   = cot_import('desc', 'P', 'TXT');
            $color  = cot_import('colorpicker', 'P', 'TXT');
            $allday = cot_import('allday', 'P', 'BOL');
            $public = cot_import('pub', 'P', 'BOL');

            if (calEdit($id, $owner, $start, $end, $title, $desc, $color, $allday, $public))
            {
                calError(true);
            }
            else
            {
                calError(false, $L['msg930_title'], $L['msg930_body']);
            }
        }
        else
        {
            calError(false, $L['msg930_title'], $L['msg930_body']);
        }
        break;

    case 'delete';
        $id = cot_import('id', 'P', 'INT');

        if (isset($id) && $usr['auth_write'])
        {
            $owner = cot_import('owner', 'P', 'INT');
            if (calDelete($id, $owner))
            {
                calError(true);
            }
            else
            {
                calError(false, $L['msg930_title'], $L['msg930_body']);
            }
        }
        else
        {
            calError(false, $L['msg930_title'], $L['msg930_body']);
        }
        break;
}