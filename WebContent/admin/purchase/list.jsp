<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/header_admin_list.jsp" %>
<body class="gray-bg">
<div class="row wrapper white-bg">
	<div class="col-sm-12">
	    <div class="ibox float-e-margins" style="padding-bottom:0px;margin-bottom:0px;"  >
	        <div class="ibox-title">
	            <h5 id="menuTreeJs" style="color:#999;font-weight:normal;"></h5>
	        </div>
	        <form id="formId1" class="form-horizontal">
	        	<div id="show" class="ibox-content" style="padding-left:16px;">
	            	<div class="col-xs-10 col-sm-8 col-md-10 b-r">
		                <div class="form-group">
		                	<div class="col-md-2">
		                         <input name="name"  value="" placeholder="名称(模糊搜索)"  class="form-control " value="">    
		                    </div>
		                </div>
	               </div>
	               <div class="col-md-2">
	                    <div class="col-md-4">
	                        <button class="btn btn-primary input-sm col-sm-12 col-md-12 pull-left" id="search" type="button">&nbsp;搜&nbsp;&nbsp;&nbsp;索</button>
	                    </div>
	                    <div class="col-md-4">
	                        <button class="btn btn-success input-sm col-sm-12 col-md-12 pull-left mr-5" id="add" type="button">&nbsp;添加</button>
	                    </div>
	               </div>
	           </div>
	    	</form>
	 	</div>
	</div>
	
    <div class="mt-5 wrapper  animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox ">
                    <div class="ibox-content">
                        <div class="jqGrid_wrapper">
                            <table id="table_list_1"></table>
                            <div id="pager_list_1"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>    

<script>
$(document).ready(function(){
	$.ajax({
        type:"post", 
        dataType:"json", 
        data : {},
        url:"../supplier/getList.do",
        success:function(data){
       		for(k in data){
       			var options="<option value='"+data[k].id+"'>"+data[k].name+"</option>";
       	        $("#supplierid").append(options);
        	}
        },
        error:function(XMLHttpRequest, textStatus, errorThrown) {
        	alert(XMLHttpRequest.status + "\r\n"+ errorThrown);
        	console.log(XMLHttpRequest, XMLHttpRequest.status,textStatus, errorThrown);
        }
	});
	
    //表格
    var _this_page_data_url = "getPageList.do";
    $.jgrid.defaults.styleUI="Bootstrap";
    $(this).jqGridTable("table_list_1","pager_list_1",{
        url:_this_page_data_url,
        postData : JSON.parse($(this).form2JsonString("formId1")),
        colNames:["编号","采购名称","商品名称","采购数量","实到入库数量","采购状态","操作"],//"最大审核级别",
        colModel:[
          {name:"id",index:"id"},
          {name:"name",index:"name"},
          {name:"gname",index:"gname"},
          {name:"qty",index:"qty"},
          {name:"realqty",index:"realqty"},
          {name:"statusNm",index:"statusNm"},
          {name:"url",index:"url",formatter:function(cellvalue, options, rowObject){
        	 	var optstr = "";
        	 	if (rowObject.status=='10') {
        	 		optstr += '<a class="ml-10" onclick="update('+rowObject.id+')" >入库</a>';
        	 	} else {
        	 		optstr += '-';
        	 	}
         		return optstr;
          } }    
        ]
	}); 
	
    $("#search").click(function(){
    	var params = JSON.parse($(this).form2JsonString("formId1"));
    	console.log(params);
        jQuery("#table_list_1").jqGrid('setGridParam',{
        url:_this_page_data_url,
        datatype : 'json',
        postData : params,
        page : 1          
      }).trigger('reloadGrid');
    });
     
    $("#add").click(function(){
        layer.open({
            type: 2,
            title: '添加',
            shadeClose: true,
            shade: 0.6,
            maxmin: true, //开启最大化最小化按钮
            area: ['800px', '450px'],
            content: "add.jsp"
       });   
    }); 
});

function update(id){
   	layer.open({
	    type: 2,
	    title:'入库',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['800px', '450px'],
	    content: 'update.jsp?id='+id
	}); 
}
function show(id){
   	layer.open({
	    type: 2,
	    title:'查看',
	    shadeClose: true,
	    shade: 0.6,
	    area: ['800px', '450px'],
	    content: 'show.jsp?id='+id
	}); 
}
</script>
	
</body>
</html>
