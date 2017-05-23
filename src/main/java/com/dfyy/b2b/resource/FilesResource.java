package com.dfyy.b2b.resource;

import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import javax.ws.rs.core.UriInfo;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dfyy.b2b.service.FileService;

@Component
@Path("/files")
public class FilesResource {
	
	@Autowired
	private FileService service;

	@POST
	@Path("/addimage")
	@Consumes("multipart/form-data")
	public void addImg(@Context HttpServletRequest request,@Context HttpServletResponse response){
		
		try {
			String folder = request.getHeader("folder");
			response.setContentType("text/plain; charset=utf-8");			
			PrintWriter out = response.getWriter();
			if(StringUtils.isBlank(folder)){
				response.setStatus(404);
				return ;
			}
			
			FileItemFactory fileItemFactory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fileItemFactory);
			List<FileItem> fileItems = upload.parseRequest(request);
			
			String filename = "";
			
			InputStream is = null;
			Iterator<FileItem> iterator;
			for (iterator = fileItems.iterator();iterator.hasNext();) {
				FileItem item = iterator.next();
				if(item.isFormField()&&item.getFieldName().equals("filename")){
					filename = item.getString("UTF-8");
				}
				else if(item.getName() != null && !item.getName().equals("")){
					is = item.getInputStream();
				}
			}
			
			String format = filename.substring(filename.lastIndexOf(".") + 1);
			
			String fname = service.saveImage(format,folder, is);
			
			response.setStatus(200);
			is.close();
			out.write(fname);
			out.close();
		} catch (Exception e) {
			response.setStatus(404);
		}
	}
	
	@POST
	@Path("/deleteimage")
	@Consumes("application/x-www-form-urlencoded")
	public Response deleteImg(@FormParam("name") String name,@Context UriInfo uriInfo,
			@Context HttpServletRequest request,
			@Context SecurityContext securityContext){
		
		String folder = request.getHeader("folder");
		if(StringUtils.isBlank(folder)){
			return Response.status(Response.Status.BAD_REQUEST).build();
		}
		service.deleteImage(name,folder);
		return Response.ok().build();
	}
}
