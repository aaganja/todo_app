function toggleTask() {
  var x = document.getElementById("task");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}

window.toggleTask = toggleTask;

