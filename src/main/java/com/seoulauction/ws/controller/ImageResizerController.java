package com.seoulauction.ws.controller;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleOp;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.net.URL;


@Controller
public class ImageResizerController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = LoggerFactory.getLogger(ImageResizerController.class);

	/*@RequestMapping("/image/thumbnail/{fileName}")
	public void getThumbnail(@PathVariable String fileName, String url, int maxWidth, int maxHeight
			, HttpServletRequest request, HttpServletResponse response) {
		String output = "jpg";
        if (output.equals("jpg"))
            response.setContentType("image/jpg");
        else
            response.setContentType("image/png");
        // Server Location of the image
        //String imageLoc = request.getSession().getServletContext().getRealPath(imageRoot) + imageFile;
        try {
            // Read the original image from the Server Location
            //BufferedImage bufferedImage = ImageIO.read(new File(imageLoc));
            BufferedImage bufferedImage = ImageIO.read(new URL(url));//http://www.seoulauction.com/auction_works_images/online/11101204/11101204000500.jpg
            // Calculate the new Height if not specified
            //int calcHeight = height > 0 ? height : (width * bufferedImage.getHeight() / bufferedImage.getWidth());
            double scale = getImageScale(bufferedImage.getWidth(), bufferedImage.getHeight(), maxWidth, maxHeight);
            
            ImageIO.write(createResizedCopy(bufferedImage, (int)(scale * bufferedImage.getWidth()), (int)(scale * bufferedImage.getHeight())), output, response.getOutputStream());
        } catch (Exception e) {
        	logger.error("Problem with image: " + url + e);
        }
	}*/
	
	
	@RequestMapping("/image/thumb/{fileName}")
	public void getThumbnail(@PathVariable String fileName, String url, int maxWidth, int maxHeight
			, HttpServletRequest request, HttpServletResponse response) {
		String output = "jpg";
        if (output.equals("jpg"))
            response.setContentType("image/jpg");
        else
            response.setContentType("image/png");
        
        try {
            BufferedImage bufferedImage = ImageIO.read(new URL(url));//http://www.seoulauction.com/auction_works_images/online/11101204/11101204000500.jpg
            double scale = getImageScale(bufferedImage.getWidth(), bufferedImage.getHeight(), maxWidth, maxHeight);
            ResampleOp  resampleOp = new ResampleOp((int)(bufferedImage.getWidth()*scale), (int)(bufferedImage.getHeight()*scale));
            resampleOp.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);
            BufferedImage rescaled = resampleOp.filter(bufferedImage, null);
            
            //ImageIO.write( Scalr.resize(bufferedImage, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.AUTOMATIC, maxWidth, maxHeight, Scalr.OP_ANTIALIAS), output, response.getOutputStream());
            ImageIO.write(rescaled, output, response.getOutputStream());
        } catch (Exception e) {
        	logger.error("Problem with image: " + url + e);
        }
	}
	
	BufferedImage createResizedCopy(BufferedImage originalImage, int scaledWidth, int scaledHeight) {
        /*BufferedImage scaledBI = new BufferedImage(scaledWidth, scaledHeight, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = scaledBI.createGraphics();
        g.setComposite(AlphaComposite.Src);
        g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        return scaledBI;*/
		
		/*int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
		BufferedImage resizedImage = new BufferedImage(scaledWidth, scaledHeight, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
		g.dispose();
		
		g.setComposite(AlphaComposite.Src);
		//g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);


		return resizedImage;
		*/
		
		int type = (originalImage.getTransparency() == Transparency.OPAQUE) ? BufferedImage.TYPE_INT_RGB : BufferedImage.TYPE_INT_ARGB;
		BufferedImage ret = (BufferedImage)originalImage;
		int w, h;
		w = originalImage.getWidth();
        h = originalImage.getHeight();
        do {
        	if (w > scaledWidth) {
				w /= 2;
				if (w < scaledWidth) {
					w = scaledWidth;
				}
        	}

        	if (h > scaledHeight) {
        		h /= 2;
        		if (h < scaledHeight) {
        			h = scaledHeight;
        		}
        	}
	        BufferedImage tmp = new BufferedImage(w, h, type);
	        Graphics2D g2 = tmp.createGraphics();
	        g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
	        g2.drawImage(ret, 0, 0, w, h, null);
	        g2.dispose();
		    ret = tmp;
	    } 
        while (w != scaledWidth || h != scaledHeight);

	    return ret;
    }
	
    // Check the param if it's not present return the default
    private String getParam(HttpServletRequest request, String param, String def) {
        String parameter = request.getParameter(param);
        if (parameter == null || "".equals(parameter)) {
            return def;
        } else {
            return parameter;
        }
    }
    
    private double getImageScale(int realWidth, int realHeight, int maxWidth, int maxHeight) {
    	
		double scalex = (double)maxWidth / (double)realWidth;
		double scaley = (double)maxHeight / (double)realHeight;
		double scale = (scalex < scaley) ? scalex : scaley;
		if (scale > 1){
			scale = 1;
		}
		return scale;

    }
    //<img src="/image?root=/albums&file=/<img src="/image?root=/albums&file=/thumbs/imagename.jpg&width=270&height=100">/imagename.jpg&width=270&height=100">
}
