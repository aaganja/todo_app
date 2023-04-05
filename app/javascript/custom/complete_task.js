function completeTask(project_id, task_id) {
  $.ajax({
    type: "POST",
    url: "/projects/"+project_id+"/tasks/complete",
    headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
      'contentType': "application/json; charset=utf-8",
    },
    data: {"complete": task_id},
    dataType: 'JSON',
    success: function (msg)
    {
      $('#task_'+task_id).parent().parent().remove()

    }
  });
}

window.completeTask = completeTask;

function add_fields(link, association, content) {
  var newid = new Date().getTime();
  var regexp = new RegExp("new" + association, "g");
  $(link).parent().before(content.replace(regexp, newid));
}

window.add_fields = add_fields;

$(document).ready(function () {
  $('.bulk_task').click(function() {
    var completeTask = [];
    $('.complete_task:checked').each(function() {
      completeTask.push($(this).val());
    });

    var project_id = $('.bulk_task').attr('id');

    $.ajax({
      type: "POST",
      url: "/projects/"+project_id+"/bulk_task",
      headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
        'contentType': "application/json; charset=utf-8",
      },
      data: {"complete_task": completeTask},
      dataType: 'JSON',
      success: function (msg)
      {
        completeTask.forEach(function(task_id) {
          $('#task_'+task_id).parent().parent().remove()
        })
      }
    });
  })
});

