package com.cafe.util;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.RenderedOp;

public class FileUtil {

	public static File getFile(String path, String name) {
		return new File(path, name);
	}

	public static boolean deleteFile(String path, String name) {
		boolean result = false;
		File file = new File(path, name);
		if (file.isFile()) {
			result = file.delete();
		}
		return result;
	}
	
	public static String calcSize(long fileSize) {
		String viewSize = "";
		double dsize = 0.0;
		if(fileSize >= 1048579) {
			dsize = fileSize / (1024.0 * 1024.0);
			viewSize = fileSizeFormat(dsize) + "MBytes";
		} else if(fileSize >= 1024) {
			dsize = fileSize / 1024.0;
			viewSize = fileSizeFormat(dsize) + "KBytes";
		} else {
			viewSize = fileSize + "Bytes";
		}
		return viewSize;
	}
	
	private static String fileSizeFormat(double num) {
		NumberFormat nf = new DecimalFormat("####.##");
		return nf.format(num);		
	}
	
	public static boolean isPermissionCheck(String fileName) {
		boolean isExist = false;
		String permission = "gif,jpg,jpeg,png";
		String extendname = fileName.substring(fileName.lastIndexOf('.') + 1);
		StringTokenizer tokens = new StringTokenizer(permission, ",");
		while (tokens.hasMoreTokens()) {
			if (extendname.equalsIgnoreCase(tokens.nextToken())) {
				isExist = true;
				break;
			}
		}
		return isExist;
	}
	
	public static int createThumbImage(String path, String saveFilename) {
		int pictureMode = 0;
		String thumbPath = path + File.separator + "thumb";
		File thumbFolder = new File(thumbPath);
		if(!thumbFolder.exists())
			thumbFolder.mkdirs();
		
		String loadFile = path + File.separator + saveFilename;
		String thumbFile = thumbPath + File.separator + saveFilename;
		int thumbWidth = 0;
		int thumbHeight = 0;									
		BufferedInputStream bufferedis = null;
		FileInputStream fileis = null;
		BufferedImage bufferedimg = null;
		try {
			fileis = new FileInputStream(loadFile);
			bufferedis = new BufferedInputStream(fileis);
			bufferedimg = ImageIO.read(bufferedis);
			
			int size = 200;
			int width = bufferedimg == null? 0 : bufferedimg.getWidth();
			int height = bufferedimg == null? 0 : bufferedimg.getHeight();
			pictureMode = width > height ? 1 : 0;
			thumbWidth = size;
			thumbHeight = (width > 0)? size * height / width : size;
		} catch (Exception e) {
			System.out.println("Error at alice.UploadServlet caculate image");
			e.printStackTrace();
		} finally {
			if (fileis != null) try { fileis.close(); } catch (Exception e){}
			if (bufferedis != null) try { bufferedis.close(); } catch (Exception e){}
		}
		
		File 	    save = new File(thumbFile);
		RenderedOp    op = JAI.create("fileload", loadFile);
     	BufferedImage im = op.getAsBufferedImage();
     	
     	if(im.getWidth()  < thumbWidth) thumbWidth = im.getWidth();
     	if(im.getHeight() < thumbHeight) thumbHeight = im.getHeight();
		
		BufferedImage thumb = new BufferedImage(thumbWidth, thumbHeight, BufferedImage.TYPE_INT_RGB);
		Graphics2D 	  g2d   = thumb.createGraphics();
					
		g2d.drawImage(im, 0, 0, thumbWidth, thumbHeight, null);
		
//		if(border == true)
//		{
//			g2d.setColor(Color.decode(bdColor));
//			g2d.drawRect(0, 0, --thumbWidth, --thumbHeight);
//		}
					
		try {
			ImageIO.write(thumb, "png", save);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return pictureMode;
	}

}
