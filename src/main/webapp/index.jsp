<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Upload</title>
<style>
	#myProgress {
	  width: 100%;
	  background-color: #ddd;
	}
	
	#myBar {
	  width: 10%;
	  height: 30px;
	  background-color: #4CAF50;
	  text-align: center;
	  line-height: 30px;
	  color: white;
	}
</style>
</head>
<body>

	<div id="myProgress">
  		<div id="myBar">1%</div>
	</div>
	
	<input id="nome" type="text"/>
	<br/>
	
	Escolha:
	<input type="file" name="arq_upload" id="arquivo" onchange="previewIMG(this)" />
		
	<br/>
	<h3>Preview</h3>
	<img id="imgPreview" src="" />
		
	<br/>
	<button id="btn_enviar" onclick="move();" disabled>Enviar</button>
</body>


<script type="text/javascript" src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#btn_enviar').click(function (){
			var arquivo = $("input[name = 'arq_upload']").get(0).files[0];
			var nome    = $("#nome").val();

			var formData = new FormData();
			formData.append('file', arquivo);
			formData.append('nome', nome);

			$.ajax({
				url: 'rest/upload',
				type: 'POST',
				data: formData,
				cache: false,
				contentType: false,
				processData: false,
				success: function(){
					$("#imgPreview").css({width: "0", height: "0"});
					$("h3").html("Arquivo enviado com sucesso!");
				},
				error: function(e){
					alert('erro');
				}
					
			});
		});
	});

	$("input[type='file']").change(function (){
		var ext = this.value.match(/\.(.+)$/)[1];
		
		switch (ext) {
	        case 'jpg':
	        case 'JPG':
	        case 'jpeg':
	        case 'JPEG':
	        case 'png':
	        case 'PNG':
	        case 'gif':
	            $('#btn_enviar').attr('disabled', false);

	            //previewIMG(input);
	            break;
	        default:
	            alert('Arquivo com extensão inválida. Informe apenas imagens!');
	            this.value = '';
    	}	
	});

	
	function previewIMG(input){
		var file = $("input[type=file]").get(0).files[0];
		
		if(file){
			var reader = new FileReader();
			
			reader.onload = function(){
				$("#imgPreview").attr("src", reader.result).css({width: "600px", height: "400px"});
			}	

			reader.readAsDataURL(file);
		}
			
	}

	var i = 0;
	function move() {
	  if (i == 0) {
	    i = 1;
	    var elem = document.getElementById("myBar");
	    var width = 0;
	    var id = setInterval(frame, 1);
	    function frame() {
	      if (width >= 100) {
	        clearInterval(id);
	        i = 0;
	      } else {
	        width++;
	        elem.style.width = width + "%";
	        elem.innerHTML = width  + "%";
	      }
	    }
	  }
	}
</script>
</html>



















