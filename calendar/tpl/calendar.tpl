<!-- BEGIN: MAIN -->
<link rel="stylesheet" href="{PHP.cfg.plugins_dir}/calendar/lib/css/bootstrap.min.css">
<script>
var cotXS          = '{PHP.sys.xk}';
var cotUser        = '{PHP.usr.id}';
var cotStart       = '{PHP.L.cal_start}';
var cotEnd         = '{PHP.L.cal_end}';
var fetchError     = '{PHP.L.cal_fetcherror}';
var cotMonths      = ['{PHP.L.January}', '{PHP.L.February}', '{PHP.L.March}', '{PHP.L.April}', '{PHP.L.May}', '{PHP.L.June}', '{PHP.L.July}', '{PHP.L.August}', '{PHP.L.September}', '{PHP.L.October}', '{PHP.L.November}', '{PHP.L.December}'];
var cotMonthsShort = ['{PHP.L.January_s}', '{PHP.L.February_s}', '{PHP.L.March_s}', '{PHP.L.April_s}', '{PHP.L.May_s}', '{PHP.L.June_s}', '{PHP.L.July_s}', '{PHP.L.August_s}', '{PHP.L.September_s}', '{PHP.L.October_s}', '{PHP.L.November_s}', '{PHP.L.December_s}'];

var cotDays        = ['{PHP.L.Sunday}', '{PHP.L.Monday}', '{PHP.L.Tuesday}', '{PHP.L.Wednesday}', '{PHP.L.Thursday}', '{PHP.L.Friday}', '{PHP.L.Saturday}'];
var cotDaysShort   = ['{PHP.L.Sunday_s}', '{PHP.L.Monday_s}', '{PHP.L.Tuesday_s}', '{PHP.L.Wednesday_s}', '{PHP.L.Thursday_s}', '{PHP.L.Friday_s}', '{PHP.L.Saturday_s}'];
</script>
<!-- BEGIN: MODAL_EDIT -->
<div class="modal fade" id="calEditModal" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="calEditModalLabel">{PHP.L.cal_editevent}</h4>
      </div>
      <!-- BEGIN: FORM -->
      <form id="formEditCal" method="POST" class="ajax" role="form">
        <div class="modal-body">
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_title}</label>
            {FORM_EDIT_TITLE}
          </div>
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_desc}</label>
            {FORM_EDIT_DESC}
          </div>
          <div class="form-group">
            {FORM_EDIT_ALLDAY} {PHP.L.cal_allday}
          </div>
          <div class="form-group">
            {FORM_EDIT_PUBLIC} {PHP.L.cal_public}
          </div>
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_startdate}</label>
            {FORM_EDIT_STDATE}
          </div>
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_enddate}</label>
            {FORM_EDIT_ENDATE}
          </div>
          <div class="form-group">
            <select name="colorpicker" id="colorpicker-inline" class="form-control">
              <option value="#7bd148">{PHP.L.green}</option>
              <option value="#5484ed">{PHP.L.boldblue}</option>
              <option value="#a4bdfc">{PHP.L.blue}</option>
              <option value="#46d6db">{PHP.L.turquoise}</option>
              <option value="#7ae7bf">{PHP.L.lightgreen}</option>
              <option value="#51b749">{PHP.L.boldgreen}</option>
              <option value="#fbd75b">{PHP.L.yellow}</option>
              <option value="#ffb878">{PHP.L.orange}</option>
              <option value="#ff887c">{PHP.L.red}</option>
              <option value="#dc2127">{PHP.L.boldred}</option>
              <option value="#dbadff">{PHP.L.purple}</option>
              <option value="#e1e1e1">{PHP.L.gray}</option>
            </select>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" name="delEvent" class="btn btn-sm btn-danger pull-left" title="{PHP.L.cal_delete}">&times;</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">{PHP.L.cal_close}</button>
          <input type="submit" class="btn btn-primary" value="{PHP.L.cal_save}" />
        </div>
      </form>
      <!-- END: FORM -->
    </div>
  </div>
</div>
<!-- END: MODAL_EDIT -->

<!-- BEGIN: MODAL_ADD -->
<div class="modal fade" id="calAddModal" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="calAddModalLabel">{PHP.L.cal_addevent}</h4>
      </div>
      <!-- BEGIN: FORM -->
      <form id="formAddCal" method="POST" class="ajax" role="form">
        <div class="modal-body">
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_title}</label>
            {FORM_ADD_TITLE}
          </div>
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_desc}</label>
            {FORM_ADD_DESC}
          </div>
          <div class="form-group">
            {FORM_ADD_ALLDAY} {PHP.L.cal_allday}
          </div>
          <div class="form-group">
            {FORM_ADD_PUBLIC} {PHP.L.cal_public}
          </div>
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_startdate}</label>
            {FORM_ADD_STDATE}
          </div>
          <div class="form-group">
            <label class="control-label">{PHP.L.cal_enddate}</label>
            {FORM_ADD_ENDATE}
          </div>
          <div class="form-group">
            <select name="colorpicker" class="form-control">
              <option value="#7bd148">{PHP.L.green}</option>
              <option value="#5484ed">{PHP.L.boldblue}</option>
              <option value="#a4bdfc">{PHP.L.blue}</option>
              <option value="#46d6db">{PHP.L.turquoise}</option>
              <option value="#7ae7bf">{PHP.L.lightgreen}</option>
              <option value="#51b749">{PHP.L.boldgreen}</option>
              <option value="#fbd75b">{PHP.L.yellow}</option>
              <option value="#ffb878">{PHP.L.orange}</option>
              <option value="#ff887c">{PHP.L.red}</option>
              <option value="#dc2127">{PHP.L.boldred}</option>
              <option value="#dbadff">{PHP.L.purple}</option>
              <option value="#e1e1e1">{PHP.L.gray}</option>
            </select>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">{PHP.L.cal_close}</button>
          <input type="submit" class="btn btn-primary" value="{PHP.L.cal_save}" />
        </div>
      </form>
      <!-- END: FORM -->
    </div>
  </div>
</div>
<!-- END: MODAL_ADD -->

<div class="modal fade" id="calErrorModal" tabindex="-1" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">{PHP.L.cal_close}</button>
      </div>
    </div>
  </div>
</div>

<div id="loading"></div>
<div id="calendar"></div>

<script src="{PHP.cfg.plugins_dir}/calendar/lib/js/bootstrap.min.js"></script>
<!-- END: MAIN -->