const div_on_scroll = e => {
  let scrollTop = Math.ceil(e.srcElement.scrollTop);
  if (scrollTop >= e.srcElement.scrollHeight - e.srcElement.offsetHeight) {
    sessionStorage["scrollTop"] = scrollTop;
    console.log("called from div_on_scroll!");
    load_more_records(20);
  }
}
document.addEventListener('turbolinks:load', () => {
  let todosDiv = document.getElementById("todos-div");
  let cur_task_show = get_current_task_show();

  try {
    todosDiv.scrollTop = sessionStorage["scrollTop"];
  } catch (err) {
    console.log(err);
  }
  sessionStorage["scrollTop"] = 0;

  if (cur_task_show != "all") {
    todosDiv.addEventListener('scroll', div_on_scroll);
  }
})

const load_more_records = (increment) => {
  let new_task_show_num = parseInt(get_current_task_show()) + increment;
  let total_records = parseInt(document.getElementById("totalRecordSpan").innerHTML);
  let param = (new_task_show_num > total_records) ? "all" : new_task_show_num;

  window.location = "/to_dos?task_show=" + param;
}

const get_current_task_show = () => {
  return window.location.search.substring(1).split("=")[1];
}