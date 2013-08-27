$(document).ready(function () {
    /**
     * Show loader after set time
     */
    var timeLoader = $('#loading'),
        timer;

    function showLoader() {
        timer && clearTimeout(timer);
        timer = setTimeout(function () {
                timeLoader.show();
            },
            1000);
    }

    /**
     * Update calendar with events
     * @param  {Array}   upEvent  Event data
     * @param  {String}  upStDate Start date
     * @param  {String}  upEnDate End date
     * @return {Boolean}          Return false
     */
    function doUpdate(upEvent, upStDate, upEnDate) {
        $.ajax({
            type: 'POST',
            url: 'index.php?r=calendar&a=update',
            dataType: 'JSON',
            data: {
                x: cotXS,
                id: upEvent.id,
                owner: upEvent.owner,
                start: upStDate,
                end: upEnDate
            },
            beforeSend: function () {
                showLoader();
            },
            success: function (data) {
                if (data.errorStatus == false) {
                    $('#calendar').fullCalendar('refetchEvents');
                    showError(data);
                }
                clearTimeout(timer);
                $('#loading').hide();
            }
        });
        return false;
    }

    /**
     * Show error in modal
     * @param {Array} data Error data
     */
    function showError(data) {
        $('#calErrorModal h4').text(data.errorTitle);
        $('#calErrorModal .modal-body').text(data.errorMessage);
        $('#calErrorModal').modal('show');
    }

    $('select[name=colorpicker]').simplecolorpicker({
        picker: true
    });

    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        dragOpacity: {
            '': .5
        },
        editable: true,
        timeFormat: 'HH:mm',
        ignoreTimezone: true,
        monthNames: cotMonths,
        monthNamesShort: cotMonthsShort,
        dayNames: cotDays,
        dayNamesShort: cotDaysShort,
        gcal: false,
        selectable: false,

        // Loading
        loading: function (bool) {
            if (bool) $('#loading').show();
            else $('#loading').hide();
        },

        // Fetch
        events: {
            url: 'index.php?r=calendar&a=fetch',
            type: 'GET',
            error: function () {
                alert(fetchError);
            }
        },

        // Resize
        eventResize: function (event, dayDelta, minuteDelta) {
            if (event.owner == cotUser) {
                var stDate = $.fullCalendar.formatDate(event.start, 'u');
                var enDate = $.fullCalendar.formatDate(event.end, 'u');
                doUpdate(event, stDate, enDate);
            } else {
                $('#calendar').fullCalendar('refetchEvents');
            }
        },

        // Drag & drop
        eventDrop: function (event, delta) {
            if (event.owner == cotUser) {
                var stDate = $.fullCalendar.formatDate(event.start, 'u');
                var enDate = $.fullCalendar.formatDate(event.end, 'u');
                doUpdate(event, stDate, enDate);
            } else {
                $('#calendar').fullCalendar('refetchEvents');
            }
        },

        // Click on day
        dayClick: function (date, allDay, jsEvent, view) {
            $('#formAddCal').resetForm();
            $('#calAddModal').modal('show');
            $('input[name=start]').datetimepicker('setDate', new Date(date));
            $('input[name=end]').datetimepicker();
            $('#formAddCal').unbind().submit(function () {
                var dataString = $('#formAddCal').serialize();

                // Add
                $.ajax({
                    type: 'POST',
                    url: 'index.php?r=calendar&a=add',
                    formId: 'formAddCal',
                    dataType: 'JSON',
                    data: dataString,
                    beforeSend: function () {
                        showLoader();
                    },
                    success: function (data) {
                        if (data.errorStatus == true) {
                            $('#calAddModal').modal('hide');
                            $('#calendar').fullCalendar('refetchEvents');
                        } else {
                            showError(data);
                        }
                        clearTimeout(timer);
                        $('#loading').hide();
                    }
                });
                return false;
            });
        },

        // Click on event
        eventClick: function (event, jsEvent, view) {

            if (event.owner == cotUser) {
                $('#calEditModal').modal('show');

                // Delete
                $('button[name=delEvent]').unbind().click(function () {
                    $('#calendar').fullCalendar('removeEvents', event.id);

                    $.ajax({
                        type: 'POST',
                        url: 'index.php?r=calendar&a=delete',
                        data: {
                            x: cotXS,
                            id: event.id,
                            owner: event.owner
                        },
                        beforeSend: function (data) {
                            showLoader();
                        },
                        success: function (data) {
                            if (data.errorStatus == true) {
                                $('#calendar').fullCalendar('refetchEvents');
                            } else {
                                $('#calendar').fullCalendar('refetchEvents');
                                showError(data);
                            }
                            $('#calEditModal').modal('hide');
                            clearTimeout(timer);
                            $('#loading').hide();
                        }
                    });
                    return false;
                });

                $('input[name=title]').val(event.title);
                $('input[name=desc]').val(event.description);
                $('input:checkbox[name=allday]').attr('checked', event.allDay);
                $('input:checkbox[name=pub]').attr('checked', event.pub);
                $('input[name=start]').datetimepicker('setDate', new Date(event.start));
                $('input[name=end]').datetimepicker('setDate', new Date(event.end));
                $('select[name=colorpicker]').simplecolorpicker('selectColor', event.color);

                $('#formEditCal').unbind().submit(function () {
                    $('#calendar').fullCalendar('updateEvent', event);

                    var formTitle = $('input[name=title]').val();
                    var formDesc = $('input[name=desc]').val();
                    var formStart = $('input[name=start]').val();
                    var formEnd = $('input[name=end]').val();
                    var formAllday = $('input:checkbox[name=allday]').prop('checked') ? 1 : 0;
                    var formPublic = $('input:checkbox[name=pub]').prop('checked') ? 1 : 0;
                    var formColor = $('select[name=colorpicker]').val();

                    // Edit
                    $.ajax({
                        type: 'POST',
                        url: 'index.php?r=calendar&a=edit',
                        formId: 'formEditCal',
                        dataType: 'JSON',
                        data: {
                            x: cotXS,
                            id: event.id,
                            owner: event.owner,
                            title: formTitle,
                            desc: formDesc,
                            allday: formAllday,
                            pub: formPublic,
                            start: formStart,
                            end: formEnd,
                            colorpicker: formColor
                        },
                        beforeSend: function (data) {
                            showLoader();
                        },
                        success: function (data) {
                            if (data.errorStatus == false) {
                                showError(data);
                            }
                            $('#calEditModal').modal('hide');
                            $('#calendar').fullCalendar('refetchEvents');
                            clearTimeout(timer);
                            $('#loading').hide();
                        }
                    });
                    return false;
                });
            }
        },

        eventMouseover: function (event, jsEvent, view) {

            var popStart = $.fullCalendar.formatDate(event.start, 'ddd dd MMM yyyy HH:mm');
            var popEnd = $.fullCalendar.formatDate(event.end, 'ddd dd MMM yyyy HH:mm');

            $('.fc-event-inner', this).popover({
                title: event.title,
                html: true,
                container: '#calendar',
                placement: 'auto',
                content: event.description + '<br>' + '<h4>' + cotStart + '</h4>' + popStart + '<br><h4>' + cotEnd + '</h4>' + popEnd
            }).mouseenter(function (e) {
                $(this).popover('show');
            });
            $(this).css('z-index', 10000);
        },

        eventMouseout: function (event, jsEvent) {
            $('.fc-event-inner', this).popover('hide');
        }
    });
});