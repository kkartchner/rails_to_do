window.onload = function () {
  let todosDiv = document.getElementById("todos-div");
  try {
    todosDiv.scrollTop = this.sessionStorage["scrollTop"];
  } catch (err){
    todosDiv.scrollTop = 0;
  }

  document.getElementById("todos-div").addEventListener("scroll", e => {
    let scrollTop = e.srcElement.scrollTop;
    let scrollHeight = e.srcElement.scrollHeight;
    let offsetHeight = e.srcElement.offsetHeight;
    if (scrollTop == scrollHeight - offsetHeight){
      if (load_more_records(20, 81)){
        this.sessionStorage["scrollTop"]=scrollTop;
      } else {
        this.sessionStorage["scrollTop"]=0;
      }
    }
  });
}
window.load_more_records = function (increment, total_tasks) {
  if (total_tasks < increment) {
    return false;
  }

  current_task_show_num = parseInt(window.location.search.substring(1).split("=")[1]);
  if (isNaN(current_task_show_num)) {
    current_task_show_num = increment;
  }
  new_task_show_num = current_task_show_num + increment;
  if (new_task_show_num > total_tasks) {
    new_task_show_num = total_tasks
  }
  window.location = "/to_dos?task_show=" + new_task_show_num;
  return true;
}