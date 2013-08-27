<!-- BEGIN: MAIN -->
<script src="{PHP.cfg.plugins_dir}/calendar/js/jquery-ui.min.js"></script>
<script src="{PHP.cfg.plugins_dir}/calendar/js/fullcalendar.min.js"></script>
<script src="{PHP.cfg.plugins_dir}/calendar/js/datetimepicker.min.js"></script>
<script src="{PHP.cfg.plugins_dir}/calendar/js/simplecolorpicker.js"></script>
<script src="{PHP.cfg.plugins_dir}/calendar/js/js.js"></script>
<link href="{PHP.cfg.plugins_dir}/calendar/css/fullcalendar.css" rel="stylesheet" type="text/css" />
<link href="{PHP.cfg.plugins_dir}/calendar/css/datetimepicker.css" rel="stylesheet" type="text/css" />
<link href="{PHP.cfg.plugins_dir}/calendar/css/simplecolorpicker.css" rel="stylesheet" type="text/css" />
<script>
// We need some stuff from Cotonti for our JS file.
var cotXS          = '{PHP.sys.xk}';
var fetchError     = '{PHP.L.cal_fetcherror}';
var cotMonths      = ['{PHP.L.January}', '{PHP.L.February}', '{PHP.L.March}', '{PHP.L.April}', '{PHP.L.May}', '{PHP.L.June}', '{PHP.L.July}', '{PHP.L.August}', '{PHP.L.September}', '{PHP.L.October}', '{PHP.L.November}', '{PHP.L.December}'];
var cotMonthsShort = ['{PHP.L.January_s}', '{PHP.L.February_s}', '{PHP.L.March_s}', '{PHP.L.April_s}', '{PHP.L.May_s}', '{PHP.L.June_s}', '{PHP.L.July_s}', '{PHP.L.August_s}', '{PHP.L.September_s}', '{PHP.L.October_s}', '{PHP.L.November_s}', '{PHP.L.December_s}'];

var cotDays      = ['{PHP.L.Sunday}', '{PHP.L.Monday}', '{PHP.L.Tuesday}', '{PHP.L.Wednesday}', '{PHP.L.Thursday}', '{PHP.L.Friday}', '{PHP.L.Saturday}'];
var cotDaysShort = ['{PHP.L.Sunday_s}', '{PHP.L.Monday_s}', '{PHP.L.Tuesday_s}', '{PHP.L.Wednesday_s}', '{PHP.L.Thursday_s}', '{PHP.L.Friday_s}', '{PHP.L.Saturday_s}'];
</script>
<style>
#calAddModal .modal-body, #calEditModal .modal-body {
  overflow: visible;
}
#calendar { width: 400px; height: 400px; }
#calendar h2 { font-size: 12px; }
.fc-button {
  padding: 0 .5em;
  height: 1.2em;
  line-height: 1.2em;
}
</style>
<!-- BEGIN: MODAL_EDIT -->
<div id="calEditModal" class="modal hide fade" tabindex="-1" role="dialog">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3 id="myModalLabel">{PHP.L.cal_editevent}</h3>
  </div>
  <div class="modal-body">
    <!-- BEGIN: FORM -->
    <form id="formEditCal" class="form-horizontal">
      <div class="control-group">
        <label class="control-label">{PHP.L.cal_title}</label>
        <div class="controls">
          {FORM_EDIT_TITLE}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">{PHP.L.cal_desc}</label>
        <div class="controls">
          {FORM_EDIT_DESC}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">Color</label>
        <div class="controls">
          <select name="colorpicker" id="colorpicker-inline">
            <option value="#7bd148">Green</option>
            <option value="#5484ed">Bold blue</option>
            <option value="#a4bdfc">Blue</option>
            <option value="#46d6db">Turquoise</option>
            <option value="#7ae7bf">Light green</option>
            <option value="#51b749">Bold green</option>
            <option value="#fbd75b">Yellow</option>
            <option value="#ffb878">Orange</option>
            <option value="#ff887c">Red</option>
            <option value="#dc2127">Bold red</option>
            <option value="#dbadff">Purple</option>
            <option value="#e1e1e1">Gray</option>
          </select>
        </div>
      </div>
      <div class="control-group">
        <div class="controls">
          <button class="btn btn-small" data-dismiss="modal">{PHP.L.cal_close}</button>
          <input type="submit" class="btn btn-small btn-primary" value="{PHP.L.cal_save}" />
        </div>
      </div>
    </form>
    <button class="btn btn-small btn-danger" id="editDelete">{PHP.L.cal_delete}</button>
    <!-- END: FORM -->
  </div>
</div>
<!-- END: MODAL_EDIT -->

<!-- BEGIN: MODAL_ADD -->
<div id="calAddModal" class="modal hide fade" tabindex="-1" role="dialog">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3 id="myModalLabel">{PHP.L.cal_addevent}</h3>
  </div>
  <div class="modal-body">
    <!-- BEGIN: FORM -->
    <form id="formAddCal" class="form-horizontal">
      <div class="control-group">
        <label class="control-label">{PHP.L.cal_title}</label>
        <div class="controls">
          {FORM_ADD_TITLE}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">{PHP.L.cal_desc}</label>
        <div class="controls">
          {FORM_ADD_DESC}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">All day</label>
        <div class="controls">
          {FORM_ADD_ALLDAY}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">Start date</label>
        <div class="controls">
          {FORM_ADD_STDATE}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">End date</label>
        <div class="controls">
          {FORM_ADD_ENDATE}
        </div>
      </div>
      <div class="control-group">
        <label class="control-label">Color</label>
        <div class="controls">
          <select name="colorpicker">
            <option value="#7bd148">Green</option>
            <option value="#5484ed">Bold blue</option>
            <option value="#a4bdfc">Blue</option>
            <option value="#46d6db">Turquoise</option>
            <option value="#7ae7bf">Light green</option>
            <option value="#51b749">Bold green</option>
            <option value="#fbd75b">Yellow</option>
            <option value="#ffb878">Orange</option>
            <option value="#ff887c">Red</option>
            <option value="#dc2127">Bold red</option>
            <option value="#dbadff">Purple</option>
            <option value="#e1e1e1">Gray</option>
          </select>
        </div>
      </div>
      <div class="control-group">
        <div class="controls">
          <button class="btn" data-dismiss="modal">{PHP.L.cal_close}</button>
          <input type="submit" class="btn btn-primary" value="{PHP.L.cal_save}" />
        </div>
      </div>
    </form>
    <!-- END: FORM -->
  </div>
</div>
<!-- END: MODAL_ADD -->

<div id="calErrorModal" class="modal hide fade" tabindex="-1" role="dialog">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3 id="myModalLabel"></h3>
  </div>
  <div class="modal-body"></div>
  <div class="modal-footer">
    <button class="btn btn-primary" data-dismiss="modal">{PHP.L.cal_close}</button>
  </div>
</div>

<div id="loading"></div>
<div id="calendar"></div>
<!-- END: MAIN -->