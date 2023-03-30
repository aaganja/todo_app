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
