package br.com.rest;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;

@Path("/upload")
public class UploadArquivoService {
	
	@POST
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public Response uploadFile(
			@FormDataParam("nome") String nome,
			@FormDataParam("file") InputStream in,
			@FormDataParam("file") FormDataContentDisposition info) {
		
		try {
			Files.copy(in, new File("C:\\teste\\" + nome + " - " + info.getFileName()).toPath());
			System.out.println("nome: " + nome);
			return Response.status(Status.OK).build();
			
		} catch (IOException e) {
			e.printStackTrace();
			return Response.status(Status.INTERNAL_SERVER_ERROR).entity("Erro no servidor: " + e.getMessage()).build();
		}
		
	}
}






























