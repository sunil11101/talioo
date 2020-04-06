package com.talio.travel_app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.app.Activity;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.ColorFilter;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.BitmapFactory;
import android.graphics.PorterDuff.Mode;
import android.graphics.PorterDuffXfermode;
import android.graphics.RadialGradient;
import android.graphics.LinearGradient;
import android.graphics.Shader.TileMode;
import android.graphics.BlurMaskFilter;
import android.graphics.RectF;
import android.renderscript.Allocation;
import android.renderscript.Element;
import android.renderscript.RenderScript;
import android.renderscript.ScriptIntrinsicBlur;
import android.content.Context;
import android.os.Build;
import android.media.ExifInterface;
import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import android.graphics.Path;;


//import java.awt.*;
//import java.awt.image.*;
//import java.awt.geom.*;


public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "flutter_native_image";

  private static double DELTA_INDEX[] = {
          0,    0.01, 0.02, 0.04, 0.05, 0.06, 0.07, 0.08, 0.1,  0.11,
          0.12, 0.14, 0.15, 0.16, 0.17, 0.18, 0.20, 0.21, 0.22, 0.24,
          0.25, 0.27, 0.28, 0.30, 0.32, 0.34, 0.36, 0.38, 0.40, 0.42,
          0.44, 0.46, 0.48, 0.5,  0.53, 0.56, 0.59, 0.62, 0.65, 0.68,
          0.71, 0.74, 0.77, 0.80, 0.83, 0.86, 0.89, 0.92, 0.95, 0.98,
          1.0,  1.06, 1.12, 1.18, 1.24, 1.30, 1.36, 1.42, 1.48, 1.54,
          1.60, 1.66, 1.72, 1.78, 1.84, 1.90, 1.96, 2.0,  2.12, 2.25,
          2.37, 2.50, 2.62, 2.75, 2.87, 3.0,  3.2,  3.4,  3.6,  3.8,
          4.0,  4.3,  4.7,  4.9,  5.0,  5.5,  6.0,  6.5,  6.8,  7.0,
          7.3,  7.5,  7.8,  8.0,  8.4,  8.7,  9.0,  9.4,  9.6,  9.8,
          10.0
  };



  public  Bitmap GetBitmapClippedCircle( Bitmap bitmap, float tx, float ty, float tr) {

    final int width = bitmap.getWidth();
    final int height = bitmap.getHeight();
    final Bitmap outputBitmap = Bitmap.createBitmap(width, height, bitmap.getConfig());
    
    final Path path = new Path();
    path.addCircle(
              (float)(tx)
            , (float)(ty)
            , (float) tr*5
            , Path.Direction.CCW);

    final Canvas canvas = new Canvas(outputBitmap);
    canvas.clipPath(path);
    canvas.drawBitmap(bitmap, 0, 0, null);
    return outputBitmap;
}


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    Activity activity = this;
    Context mContext = this;

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if(call.method.equals("compressImage")) {
                  String fileName = call.argument("file");
                  int resizePercentage = call.argument("percentage");
                  int targetWidth = call.argument("targetWidth") == null ? 0 : (int) call.argument("targetWidth");
                  int targetHeight = call.argument("targetHeight") == null ? 0 : (int) call.argument("targetHeight");
                  int quality = call.argument("quality");

                  File file = new File(fileName);

                  if(!file.exists()) {
                    result.error("file does not exist", fileName, null);
                    return;
                  }

                  Bitmap bmp = BitmapFactory.decodeFile(fileName);
                  ByteArrayOutputStream bos = new ByteArrayOutputStream();

                  int newWidth = targetWidth == 0 ? (bmp.getWidth() / 100 * resizePercentage) : targetWidth;
                  int newHeight = targetHeight == 0 ? (bmp.getHeight() / 100 * resizePercentage) : targetHeight;

                  bmp = Bitmap.createScaledBitmap(
                          bmp, newWidth, newHeight, true);

                  // reconfigure bitmap to use RGB_565 before compressing
                  // fixes https://github.com/btastic/flutter_native_image/issues/47
                  Bitmap newBmp = bmp.copy(Bitmap.Config.RGB_565, false);
                  newBmp.compress(Bitmap.CompressFormat.JPEG, quality, bos);

                  try {
                    String outputFileName = File.createTempFile(
                            getFilenameWithoutExtension(file).concat("_compressed"),
                            ".jpg",
                            activity.getExternalCacheDir()
                    ).getPath();

                    OutputStream outputStream = new FileOutputStream(outputFileName);
                    bos.writeTo(outputStream);

                    copyExif(fileName, outputFileName);

                    result.success(outputFileName);
                  } catch (FileNotFoundException e) {
                    e.printStackTrace();
                    result.error("file does not exist", fileName, null);
                  } catch (IOException e) {
                    e.printStackTrace();
                    result.error("something went wrong", fileName, null);
                  }

                  return;
                }
                if(call.method.equals("getImageProperties")) {
                  String fileName = call.argument("file");
                  File file = new File(fileName);

                  if(!file.exists()) {
                    result.error("file does not exist", fileName, null);
                    return;
                  }

                  BitmapFactory.Options options = new BitmapFactory.Options();
                  options.inJustDecodeBounds = true;
                  BitmapFactory.decodeFile(fileName,options);
                  HashMap<String, Integer> properties = new HashMap<String, Integer>();
                  properties.put("width", options.outWidth);
                  properties.put("height", options.outHeight);

                  int orientation = ExifInterface.ORIENTATION_UNDEFINED;
                  try {
                    ExifInterface exif = new ExifInterface(fileName);
                    orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_UNDEFINED);
                  } catch(IOException ex) {
                    // EXIF could not be read from the file; ignore
                  }
                  properties.put("orientation", orientation);

                  result.success(properties);
                  return;
                }
                if(call.method.equals("cropImage")) {
                  String fileName = call.argument("file");
                  int originX = call.argument("originX");
                  int originY = call.argument("originY");
                  int width = call.argument("width");
                  int height = call.argument("height");

                  File file = new File(fileName);

                  if(!file.exists()) {
                    result.error("file does not exist", fileName, null);
                    return;
                  }

                  Bitmap bmp = BitmapFactory.decodeFile(fileName);
                  ByteArrayOutputStream bos = new ByteArrayOutputStream();

                  try {
                    bmp = Bitmap.createBitmap(bmp, originX, originY, width, height);
                  } catch(IllegalArgumentException e) {
                    e.printStackTrace();
                    result.error("bounds are outside of the dimensions of the source image", fileName, null);
                  }

                  bmp.compress(Bitmap.CompressFormat.JPEG, 100, bos);
                  bmp.recycle();
                  OutputStream outputStream = null;
                  try {
                    String outputFileName = File.createTempFile(
                            getFilenameWithoutExtension(file).concat("_cropped"),
                            ".jpg",
                            activity.getExternalCacheDir()
                    ).getPath();


                    outputStream = new FileOutputStream(outputFileName);
                    bos.writeTo(outputStream);

                    copyExif(fileName, outputFileName);

                    result.success(outputFileName);
                  } catch (FileNotFoundException e) {
                    e.printStackTrace();
                    result.error("file does not exist", fileName, null);
                  } catch (IOException e) {
                    e.printStackTrace();
                    result.error("something went wrong", fileName, null);
                  }finally {
                    if (outputStream != null) {
                      try {
                        outputStream.close();
                      } catch (IOException e) {
                        e.printStackTrace();
                      }
                    }
                  }



                  return;
                }
                if (call.method.equals("adjustImage")) {
                  //return;
                  String fileName = call.argument("file");
                  double brightness = call.argument("brightness");
                  double contrast = call.argument("contrast");
                  double saturation = call.argument("saturation");
                  double tiltX = call.argument("tiltX");
                  double tiltY = call.argument("tiltY");
                  double tiltRadius = call.argument("tiltRadius");

                  float fBrightness = (float)brightness;
                  int fContrast = (int)contrast;
                  float fSaturation = (float)saturation;
                  float fTiltX = (float)tiltX;
                  float fTiltY = (float)tiltY;
                  float fTiltRadius = (float)tiltRadius;

                  File file = new File(fileName);

                  if(!file.exists()) {
                    result.error("file does not exist", fileName, null);
                    return;
                  }

                  Paint paint = new Paint();

                  Bitmap bmp = BitmapFactory.decodeFile(fileName);
                  ByteArrayOutputStream bos = new ByteArrayOutputStream();
/*
                  Bitmap blurBmp = fastblur(mContext, bmp, 8);

                  Bitmap ret = Bitmap.createBitmap(bmp.getWidth(), bmp.getHeight(), bmp.getConfig());
                  Canvas canvas = new Canvas(ret);
                  //Paint p = setData(fTiltX, fTiltY, fTiltRadius, ret);
                  canvas.drawBitmap(blurBmp, bmp.getWidth(), bmp.getHeight(),null);
                  //canvas.drawRect(0 ,0 , bmp.getWidth(), bmp.getHeight(), p);

                  //Bitmap croppedBitmap = setData(fTiltX, fTiltY, fTiltRadius, bmp);
*/

                  //canvas.drawRect(0, 0, bmp.getWidth(), bmp.getHeight(), p);

                  /*Bitmap ret = Bitmap.createBitmap(bmp.getWidth(), bmp.getHeight(), bmp.getConfig());

                  Canvas canvas = new Canvas(ret);
                  ColorFilter cf = adjustColor(fBrightness, fContrast, fSaturation);
                  paint.setColorFilter(cf);
                  canvas.drawBitmap(bmp, 0, 0, paint);
*/

                  Bitmap ret = Bitmap.createBitmap(bmp.getWidth(), bmp.getHeight(), bmp.getConfig());
                  //Bitmap ret1 = Bitmap.createBitmap(bmp.getWidth(), bmp.getHeight(), bmp.getConfig());
                  Canvas canvas = new Canvas(ret);
                  canvas.drawColor(Color.TRANSPARENT);
                  //ColorFilter cf = adjustColor(fBrightness, fContrast, fSaturation);
                  //paint.setColorFilter(cf);
                  int blurEffect=8;
                  Bitmap blurBmp = fastblur(mContext, bmp, blurEffect);
                  //canvas.drawBitmap(blurBmp, 0, 0, paint);
                  //Bitmap blurBmp = drawShadow(bmp, (int)fTiltRadius);
                  canvas.drawBitmap(blurBmp, 0, 0, null);
                  int j=blurEffect-1;
                  int k=0;

                  Bitmap cropImg[]={blurBmp, blurBmp, blurBmp, blurBmp, blurBmp, blurBmp, blurBmp};
                  for(int i=blurEffect-2;i>0;i--)
                  {
                    Bitmap blurBmp1 = fastblur(mContext, bmp, i);
                    cropImg[k++]=GetBitmapClippedCircle(blurBmp1, fTiltX, fTiltY, fTiltRadius*j--);
                    //canvas.drawBitmap(blurBmp, 0, 0, null);
                    canvas.drawBitmap(cropImg[k-1], 0, 0, null);
                  }

                  Bitmap cropImg1=GetBitmapClippedCircle( bmp, fTiltX, fTiltY, fTiltRadius*2);
                  //canvas.drawBitmap(blurBmp, 0, 0, null);
                  canvas.drawBitmap(cropImg1, 0, 0, null);


                  //Paint p = setData(fTiltX, fTiltY, fTiltRadius, ret);
                  //canvas.drawRect(0, 0, bmp.getWidth(), bmp.getHeight(), p);

                  /*Bitmap ret2 = Bitmap.createBitmap(bmp.getWidth(), bmp.getHeight(), bmp.getConfig());
                  Canvas canvas2 = new Canvas(ret2);
                  //canvas2.drawBitmap(bmp, 0, 0, null);
                  Bitmap bm2 = tiltShift(bmp, 10, (int)fTiltX, (int)fTiltY);

                  canvas2.drawBitmap(bm2, 0, 0, null);
*/

                  ret.compress(Bitmap.CompressFormat.JPEG, 100, bos);
                  ret.recycle();
                  blurBmp.recycle();
                  bmp.recycle();
                  OutputStream outputStream = null;

                  try {
                    String outputFileName = File.createTempFile(
                            getFilenameWithoutExtension(file).concat("_adjustedImage"),
                            ".jpg",
                            activity.getExternalCacheDir()
                    ).getPath();


                    outputStream = new FileOutputStream(outputFileName);
                    bos.writeTo(outputStream);

                    copyExif(fileName, outputFileName);

                    result.success(outputFileName);
                  } catch (FileNotFoundException e) {
                    e.printStackTrace();
                    result.error("file does not exist", fileName, null);
                  } catch (IOException e) {
                    e.printStackTrace();
                    result.error("something went wrong", fileName, null);
                  }finally {
                    if (outputStream != null) {
                      try {
                        outputStream.close();
                      } catch (IOException e) {
                        e.printStackTrace();
                      }
                    }
                  }
                  return;
                }
                if (call.method.equals("getPlatformVersion")) {
                  result.success("Android " + android.os.Build.VERSION.RELEASE);
                } else {
                  result.notImplemented();
                }
              }});
  }

  public static ColorFilter adjustColor(float brightness, int contrast, float saturation){
    ColorMatrix cm = new ColorMatrix();
    adjustContrast(cm, contrast);
    adjustBrightness(cm, brightness);
    adjustSaturation(cm, saturation);

    return new ColorMatrixColorFilter(cm);
  }


  

 


  public static void adjustBrightness(ColorMatrix cm, float value) {
    value = cleanValue(value,100);
    if (value == 0) {
      return;
    }

    float[] mat = new float[]
            {
                    1,0,0,0,value,
                    0,1,0,0,value,
                    0,0,1,0,value,
                    0,0,0,1,0,
                    0,0,0,0,1
            };
    cm.postConcat(new ColorMatrix(mat));
  }

  public static void adjustContrast(ColorMatrix cm, int value) {
    value = (int)cleanValue(value,100);
    if (value == 0) {
      return;
    }
    float x;
    if (value < 0) {
      x = 127 + (float) value / 100*127;
    } else {
      x = value % 1;
      if (x == 0) {
        x = (float)DELTA_INDEX[value];
      } else {
        //x = DELTA_INDEX[(p_val<<0)]; // this is how the IDE does it.
        x = (float)DELTA_INDEX[(value)]*(1-x) + (float)DELTA_INDEX[(value)+1] * x; // use linear interpolation for more granularity.
      }
      x = x*127+127;
    }

    float[] mat = new float[]
            {
                    x/127,0,0,0, 0.5f*(127-x),
                    0,x/127,0,0, 0.5f*(127-x),
                    0,0,x/127,0, 0.5f*(127-x),
                    0,0,0,1,0,
                    0,0,0,0,1
            };
    cm.postConcat(new ColorMatrix(mat));
  }

  public static void adjustSaturation(ColorMatrix cm, float value) {
    value = cleanValue(value,100);
    if (value == 0) {
      return;
    }

    float x = 1+((value > 0) ? 3 * value / 100 : value / 100);
    float lumR = 0.3086f;
    float lumG = 0.6094f;
    float lumB = 0.0820f;

    float[] mat = new float[]
            {
                    lumR*(1-x)+x,lumG*(1-x),lumB*(1-x),0,0,
                    lumR*(1-x),lumG*(1-x)+x,lumB*(1-x),0,0,
                    lumR*(1-x),lumG*(1-x),lumB*(1-x)+x,0,0,
                    0,0,0,1,0,
                    0,0,0,0,1
            };
    cm.postConcat(new ColorMatrix(mat));
  }

  protected static float cleanValue(float p_val, float p_limit)
  {
    return Math.min(p_limit, Math.max(-p_limit, p_val));
  }

  public Bitmap fastblur(Context context, Bitmap sentBitmap, int radius) {
    Bitmap bitmap = sentBitmap.copy(sentBitmap.getConfig(), true);

    final RenderScript rs = RenderScript.create(context);
    final Allocation input = Allocation.createFromBitmap(rs, sentBitmap, Allocation.MipmapControl.MIPMAP_NONE,
            Allocation.USAGE_SCRIPT);
    final Allocation output = Allocation.createTyped(rs, input.getType());
    final ScriptIntrinsicBlur script = ScriptIntrinsicBlur.create(rs, Element.U8_4(rs));
    script.setRadius(radius);
    script.setInput(input);
    script.forEach(output);
    output.copyTo(bitmap);
    return bitmap;
  }

  public Paint setData(float tiltX, float tiltY, float tiltRadius, Bitmap bmp) {
    Paint paint = new Paint();
    float tiltGradientRadius = tiltRadius / 2.0f;
    double bitmapResizedRatio = 1;
    //drawBitmap(previewBitmap);

    // 现在需要绘制一个带有渐变透明度的shader
    // 总共有4个区域
    // 0到1的区域是完全不透明
    // 1到2的区域是从不透明渐变到透明
    // 2到3的区域是完全透明
    int colors[] = new int[4];
    colors[0] = 0x00ffffff;
    colors[1] = 0x00ffffff;
    colors[2] = 0xffffffff;
    colors[3] = 0xffffffff;

    float tiltRadius1;
    tiltRadius1 = tiltRadius - tiltGradientRadius;

    //tiltRadius1 = tiltRadius - tiltGradientRadius;
    tiltRadius1 = Math.min(tiltRadius1, bmp.getWidth());
    tiltRadius1 = Math.max(tiltRadius1, 0.0f);
    float tiltRadius2 = tiltRadius;
    tiltRadius2 = Math.min(tiltRadius2, bmp.getWidth());
    tiltRadius2 = Math.max(tiltRadius2, 0.0f);

    float positions[] = new float[4];
    positions[0] = 0.0f;
    positions[1] = tiltRadius1 / tiltRadius;
    positions[2] = tiltRadius2 / tiltRadius;
    positions[3] = 1.0f;

    // 将屏幕上的坐标转成bitmap的坐标
    float shaderTiltX = (float) (tiltX / bitmapResizedRatio);
    float shaderTiltY = (float) (tiltY / bitmapResizedRatio);
    // 将屏幕上的移轴半径改成bitmap的移轴半径
    float shaderTiltRadius = (float) (tiltRadius / bitmapResizedRatio);

    RadialGradient shader = new RadialGradient(shaderTiltX, shaderTiltY, shaderTiltRadius, colors, positions, TileMode.CLAMP);
    //LinearGradient shader = new LinearGradient(0, 100, 0, 200, 0xffffffff, 0x00ffffff, TileMode.CLAMP);
    paint.setColor(Color.RED);
    paint.setShader(shader);
    // Mode.DST_IN是绘制2层图片的交集，在这里是将模糊图片与带有渐变透明度的shader取交集进行绘制。
    paint.setXfermode(new PorterDuffXfermode(Mode.DST_IN));
    //shiftCanvas.drawRect(0, 0, bmp.getWidth(), bmp.getHeight(), paint);
    return paint;
  }

  public static Bitmap tiltShift(Bitmap sentBitmap, int radius, int x,
                                 int y) {

    RectF rectF = new RectF(0,0,sentBitmap.getWidth(),sentBitmap.getHeight());
    float blurRadius = 100.0f;
    Bitmap bitmapResult = Bitmap.createBitmap(sentBitmap.getWidth(), sentBitmap.getHeight(), Bitmap.Config.ARGB_8888);
    Canvas canvasResult = new Canvas(bitmapResult);
    Paint blurPaintOuter = new Paint();
    blurPaintOuter.setColor(0xFFffffff);
    blurPaintOuter.setMaskFilter(new
            BlurMaskFilter(blurRadius, BlurMaskFilter.Blur.INNER));
    canvasResult.drawBitmap(sentBitmap, 0, 0, blurPaintOuter);
    Paint blurPaintInner = new Paint();
    blurPaintInner.setColor(0x80ffffff);
    blurPaintInner.setMaskFilter(new
            BlurMaskFilter(blurRadius, BlurMaskFilter.Blur.INNER));
    canvasResult.drawRect(rectF, blurPaintInner);
    return bitmapResult;
  }


  public static Bitmap drawShadow(Bitmap map, int radius) {
    if (map == null)
        return null;

    BlurMaskFilter blurFilter = new BlurMaskFilter(radius, BlurMaskFilter.Blur.SOLID);
    Paint shadowPaint = new Paint();
    shadowPaint.setMaskFilter(blurFilter);

    int[] offsetXY = new int[2];
    Bitmap shadowImage = map.extractAlpha(shadowPaint, offsetXY);
    shadowImage = shadowImage.copy(Bitmap.Config.ARGB_8888, true);
    Canvas c = new Canvas(shadowImage);
    c.drawBitmap(map, -offsetXY[0], -offsetXY[1], null);
    return shadowImage;
}

  private void copyExif(String filePathOri, String filePathDest) {
    try {
      ExifInterface oldExif = new ExifInterface(filePathOri);
      ExifInterface newExif = new ExifInterface(filePathDest);

      List<String> attributes =
              Arrays.asList(
                      "FNumber",
                      "ExposureTime",
                      "ISOSpeedRatings",
                      "GPSAltitude",
                      "GPSAltitudeRef",
                      "FocalLength",
                      "GPSDateStamp",
                      "WhiteBalance",
                      "GPSProcessingMethod",
                      "GPSTimeStamp",
                      "DateTime",
                      "Flash",
                      "GPSLatitude",
                      "GPSLatitudeRef",
                      "GPSLongitude",
                      "GPSLongitudeRef",
                      "Make",
                      "Model",
                      "Orientation");
      for (String attribute : attributes) {
        setIfNotNull(oldExif, newExif, attribute);
      }

      newExif.saveAttributes();

    } catch (Exception ex) {
      Log.e("FlutterNativeImagePlugin", "Error preserving Exif data on selected image: " + ex);
    }
  }

  private void setIfNotNull(ExifInterface oldExif, ExifInterface newExif, String property) {
    if (oldExif.getAttribute(property) != null) {
      newExif.setAttribute(property, oldExif.getAttribute(property));
    }
  }

  private static String pathComponent(String filename) {
    int i = filename.lastIndexOf(File.separator);
    return (i > -1) ? filename.substring(0, i) : filename;
  }

  private static String getFilenameWithoutExtension(File file) {
    String fileName = file.getName();

    if (fileName.indexOf(".") > 0) {
      return fileName.substring(0, fileName.lastIndexOf("."));
    } else {
      return fileName;
    }
  }




/*

  int mul_table[] = {
        512,512,456,512,328,456,335,512,405,328,271,456,388,335,292,512,
        454,405,364,328,298,271,496,456,420,388,360,335,312,292,273,512,
        482,454,428,405,383,364,345,328,312,298,284,271,259,496,475,456,
        437,420,404,388,374,360,347,335,323,312,302,292,282,273,265,512,
        497,482,468,454,441,428,417,405,394,383,373,364,354,345,337,328,
        320,312,305,298,291,284,278,271,265,259,507,496,485,475,465,456,
        446,437,428,420,412,404,396,388,381,374,367,360,354,347,341,335,
        329,323,318,312,307,302,297,292,287,282,278,273,269,265,261,512,
        505,497,489,482,475,468,461,454,447,441,435,428,422,417,411,405,
        399,394,389,383,378,373,368,364,359,354,350,345,341,337,332,328,
        324,320,316,312,309,305,301,298,294,291,287,284,281,278,274,271,
        268,265,262,259,257,507,501,496,491,485,480,475,470,465,460,456,
        451,446,442,437,433,428,424,420,416,412,408,404,400,396,392,388,
        385,381,377,374,370,367,363,360,357,354,350,347,344,341,338,335,
        332,329,326,323,320,318,315,312,310,307,304,302,299,297,294,292,
        289,287,285,282,280,278,275,273,271,269,267,265,263,261,259};
        
   
int shg_table = {
	     9, 11, 12, 13, 13, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 17, 
		17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 
		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20,
		20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 21,
		21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21,
		21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 
		22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22,
		22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 
		23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
		23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
		23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 
		23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 
		24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
		24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
		24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24,
    24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24 };
    



void compoundBlurImage( imageID, canvasID, radiusData, minRadius, increaseFactor, blurLevels, blurAlphaChannel )
{
			
 	var img = document.getElementById( imageID );
	var w = img.naturalWidth;
    var h = img.naturalHeight;
       
	var canvas = document.getElementById( canvasID );
      
    canvas.style.width  = w + "px";
    canvas.style.height = h + "px";
    canvas.width = w;
    canvas.height = h;
    
    var context = canvas.getContext("2d");
    context.clearRect( 0, 0, w, h );
    context.drawImage( img, 0, 0 );

	if ( isNaN(minRadius) || minRadius <= 0 || isNaN(increaseFactor) || increaseFactor == 0 ) return;
	
	if ( blurAlphaChannel )
		compundBlurCanvasRGBA( canvasID, 0, 0, w, h, radiusData, minRadius, increaseFactor, blurLevels );
	else 
		compundBlurCanvasRGB( canvasID, 0, 0, w, h, radiusData, minRadius, increaseFactor, blurLevels );
}

*/


}
