<?php defined('COT_CODE') or die('Wrong URL.');
/**
 * Calendar functions
 *
 * @package calendar
 * @author Twiebie
 * @copyright Copyright (c) www.digital-balance.net 2013
 * @license BSD
 */

require_once cot_incfile('forms');
require_once cot_langfile('calendar', 'plug');
require_once cot_langfile('message', 'core');

global $sys, $cfg, $db, $db_x, $L;
$db_calendar = (isset($db_calendar)) ? $db_calendar : $db_x . 'calendar';

list($usr['auth_read'], $usr['auth_write'], $usr['isadmin']) = cot_auth('plug', 'calendar');

/**
 * Fetch events
 *
 * @return array $eventArray List of events
 */
function calFetch()
{
    global $cfg, $db, $db_x, $db_calendar, $usr;

    $res = $db->query("SELECT * FROM $db_calendar")->fetchAll();

    if ($res)
    {
        foreach ($res as $event)
        {
            if ($event['cal_owner'] == $usr['id'] || $event['cal_public'])
            {
                $eventArray[] = array(
                    'id'          => $event['cal_id'],
                    'owner'       => $event['cal_owner'],
                    'title'       => $event['cal_title'],
                    'description' => $event['cal_desc'],
                    'start'       => cot_date('c', $event['cal_start']),
                    'end'         => cot_date('c', $event['cal_end']),
                    'allDay'      => ($event['cal_allday'] == 0) ? false : true,
                    'pub'         => ($event['cal_public'] == 0) ? false : true,
                    'color'       => $event['cal_color']
                    //'url'       => $event['cal_url'] // Todo.
                );
            }
        }
    }
    return $eventArray;
}

/**
 * Update event
 *
 * @param  int    $id    Event ID
 * @param  int    $owner Event owner
 * @param  string $start Start date/time
 * @param  string $end   End date/time
 * @return bool
 */
function calUpdate($id, $owner, $stDate, $enDate)
{
    global $db, $db_x, $db_calendar, $id, $usr;

    if ($owner == $usr['id'])
    {
        $start = strtotime($stDate);
        $end   = strtotime($enDate);

        $event['cal_id']    = $id;
        $event['cal_start'] = $start;
        $event['cal_end']   = $end;

        $db->update($db_calendar, $event, "cal_id = $id AND cal_owner = {$usr['id']}");
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * Add event
 *
 * @param  string $stDate Start date/time
 * @param  string $enDate End date/time
 * @param  string $title  Event title
 * @param  string $desc   Event description
 * @param  string $color  Event color
 * @param  string $allday All day event
 * @param  string $public Public event
 * @return bool
 */
function calAdd($stDate, $enDate, $title, $desc, $color, $allday, $public)
{
    global $db, $db_x, $db_calendar, $id, $usr;

    $start = strtotime($stDate);
    $end   = strtotime($enDate);

    $event['cal_owner']  = $usr['id'];
    $event['cal_start']  = $start;
    $event['cal_end']    = $end;
    $event['cal_title']  = $title;
    $event['cal_desc']   = $desc;
    $event['cal_color']  = $color;
    $event['cal_allday'] = $allday;
    $event['cal_public'] = $public;

    if (!cot_error_found())
    {
        $db->insert($db_calendar, $event);
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * Edit event
 *
 * @param  int    $id        Event ID
 * @param  int    $owner     Event owner
 * @param  string $startDate Start date/time
 * @param  string $endDate   End date/time
 * @param  string $title     Event title
 * @param  string $desc      Event description
 * @param  string $color     Event color
 * @param  string $allday    All day event
 * @param  string $public    Public event
 * @return bool
 */
function calEdit($id, $owner, $stDate, $enDate, $title, $desc, $color, $allday, $public)
{
    global $db, $db_x, $db_calendar, $id, $usr;

    if ($owner == $usr['id'])
    {
        $start = strtotime($stDate);
        $end   = strtotime($enDate);

        $event['cal_id']     = $id;
        $event['cal_start']  = $start;
        $event['cal_end']    = $end;
        $event['cal_title']  = $title;
        $event['cal_desc']   = $desc;
        $event['cal_color']  = $color;
        $event['cal_allday'] = $allday;
        $event['cal_public'] = $public;

        $db->update($db_calendar, $event, "cal_id = $id AND cal_owner = {$usr['id']}");
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * Delete event
 *
 * @param  string $id    Event ID
 * @param  string $owner Event owner
 * @return bool
 */
function calDelete($id, $owner)
{
    global $db, $db_x, $db_calendar, $id, $usr;

    if ($owner == $usr['id'])
    {
        $db->delete($db_calendar, "cal_id = $id AND cal_owner = {$usr['id']}");
        return true;
    }
    else
    {
        return false;
    }
}

/**
 * Return error
 *
 * @param  bool   $status   True or false
 * @param  string $title    Error title
 * @param  string $message  Error message
 * @return array  $response JSON
 */
function calError($status, $title = '', $message = '')
{
    global $L;
    $response = array(
        'errorStatus'  => $status,
        'errorTitle'   => $title,
        'errorMessage' => $message
    );
    cot_clear_messages();

    cot_sendheaders('application/json', '200 OK');
    echo json_encode($response);
}