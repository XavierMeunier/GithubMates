
var datas = $(".data").text();
datas = datas.replace(/=>/g,":");
datas = datas.replace(/nil/g,"\"\"");


datas = datas.substring(14);
datas = datas.slice(0, -11);

datas = datas.replace("\]",",");
// datas = datas.replace("},",",");
datas = datas.match(/{(.*?)},/g);

for (i=0;i<datas.length;i++){
  datas[i] = datas[i].replace("},","}");
  var obj = jQuery.parseJSON(datas[i]);
  if (obj.location!=""){
    console.log(obj.login + obj.location);
  }
  else
  {
    console.log("No location");
  }

}

