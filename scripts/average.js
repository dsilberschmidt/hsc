function average(json, n) {
  //const obj = JSON.parse(json);
  array = json.dataset_data.data.map(x => x[1]).slice(0,n);
  const sum = array.reduce( (p, c) => p + c, 0);
  return sum / n;
}


function extract_array(json) {
  return json.dataset_data.data.map(x => x[1]).slice(0,n);
}


function adapt(json) {
  array = json.dataset_data.data.map(x => x[1]);
  return '{ "data:" [ '+ array + '] }'
}
