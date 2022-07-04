package io.vlian.microlink;

import android.os.Environment;
import android.os.Build;
import android.content.Context;
import android.content.ContentUris;
import android.content.ContentResolver;
import android.provider.MediaStore;
import android.provider.DocumentsContract;
import android.database.Cursor;
import android.net.Uri;
import android.content.ContentProvider;

import java.io.File;
import java.util.Properties;
import java.util.Stack;
import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;
import java.io.RandomAccessFile;
import java.net.URI;
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;

public class AndroidSystemInfo{
    public static String getAndroid_os_Build(String value){
        if(value.equals("VERSION.RELEASE")){
            return android.os.Build.VERSION.RELEASE;
        }else if(value.equals("VERSION.SDK")){
            return android.os.Build.VERSION.SDK;
        }else if(value.equals("PRODUCT")){
            return android.os.Build.PRODUCT;
        }else if(value.equals("CPU_ABI")){
            return android.os.Build.CPU_ABI;
        }else if(value.equals("CPU_ABI2")){
            return android.os.Build.CPU_ABI2;
        }else if(value.equals("TAGS")){
            return android.os.Build.TAGS;
        }else if(value.equals("MODEL")){
            return android.os.Build.MODEL;
        }else if(value.equals("DEVICE")){
            return android.os.Build.DEVICE;
        }else if(value.equals("HARDWARE")){
            return android.os.Build.HARDWARE;
        }else if(value.equals("DISPLAY")){
            return android.os.Build.DISPLAY;
        }else if(value.equals("BRAND")){
            return android.os.Build.BRAND;
        }else if(value.equals("BOARD")){
            return android.os.Build.BOARD;
        }else if(value.equals("FINGERPRINT")){
            return android.os.Build.FINGERPRINT;
        }else if(value.equals("ID")){
            return android.os.Build.ID;
        }else if(value.equals("MANUFACTURER")){
            return android.os.Build.MANUFACTURER;
        }else if(value.equals("USER")){
            return android.os.Build.USER;
        }else if(value.equals("TYPE")){
            return android.os.Build.TYPE;
        }else if(value.equals("SERIAL")){
            return android.os.Build.SERIAL;
        }else if(value.equals("RADIO")){
            return android.os.Build.RADIO;
        }else if(value.equals("HOST")){
            return android.os.Build.HOST;
        }else if(value.equals("TIME")){
            return String.valueOf(android.os.Build.TIME);
        }else if(value.equals("UNKNOWN")){
            return android.os.Build.UNKNOWN;
        }
        return null;
    }


    public static String getPathFromUri(Context context, String url) {
        Uri uri=null;
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            uri=Uri.parse(url);
            //uri= FileProvider.getUriForFile(context, context.getApplicationInfo().packageName + ".fileprovider", new File(url));
        }else{
            uri=Uri.fromFile(new File(url));
        }

        String path = null;
        if (DocumentsContract.isDocumentUri(context, uri)) {
            //如果是document类型的Uri，通过document id处理，内部会调用Uri.decode(docId)进行解码
            String docId = DocumentsContract.getDocumentId(uri);
            //primary:Azbtrace.txt
            //video:A1283522
            String[] splits = docId.split(":");
            String type = null, id = null;
            if(splits.length == 2) {
                type = splits[0];
                id = splits[1];
            }
            switch (uri.getAuthority()) {
                case "com.android.externalstorage.documents":
                    if("primary".equals(type)) {
                        path = Environment.getExternalStorageDirectory() + File.separator + id;
                    }
                    break;
                case "com.android.providers.downloads.documents":
                    if("raw".equals(type)) {
                        path = id;
                    } else {
                        Uri contentUri = ContentUris.withAppendedId(Uri.parse("content://downloads/public_downloads"), Long.valueOf(docId));
                        path = getMediaPathFromUri(context, contentUri, null, null);
                    }
                    break;
                case "com.android.providers.media.documents":
                    Uri externalUri = null;
                    switch (type) {
                        case "image":
                            externalUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
                            break;
                        case "video":
                            externalUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
                            break;
                        case "audio":
                            externalUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
                            break;
                        case "document":
                            externalUri = MediaStore.Files.getContentUri("external");
                            break;
                    }
                    if(externalUri != null) {
                        String selection = "_id=?";
                        String[] selectionArgs = new String[]{ id };
                        path = getMediaPathFromUri(context, externalUri, selection, selectionArgs);
                    }
                    break;
            }
        } else if (ContentResolver.SCHEME_CONTENT.equalsIgnoreCase(uri.getScheme())) {
            path = getMediaPathFromUri(context, uri, null, null);
        } else if (ContentResolver.SCHEME_FILE.equalsIgnoreCase(uri.getScheme())) {
            //如果是file类型的Uri(uri.fromFile)，直接获取图片路径即可
            path = uri.getPath();
        }
        //确保如果返回路径，则路径合法
        System.out.println("P"+path);
        return path == null ? null : (new File(path).exists() ? path : null);
    }
    
    private static String getMediaPathFromUri(Context context, Uri uri, String selection, String[] selectionArgs) {
        String path;
        String authroity = uri.getAuthority();
        path = uri.getPath();
        String sdPath = Environment.getExternalStorageDirectory().getAbsolutePath();
        if(!path.startsWith(sdPath)) {
            int sepIndex = path.indexOf(File.separator, 1);
            if(sepIndex == -1) path = null;
            else {
                path = sdPath + path.substring(sepIndex);
            }
        }
        
        if(path == null) {
            ContentResolver resolver = context.getContentResolver();
            String[] projection = new String[]{ MediaStore.MediaColumns.DATA };
            Cursor cursor = resolver.query(uri, projection, selection, selectionArgs, null);
            if (cursor != null) {
                if (cursor.moveToFirst()) {
                    try {
                        int index = cursor.getColumnIndexOrThrow(projection[0]);
                        if (index != -1) path = cursor.getString(index);
                        System.out.println("getMediaPathFromUri query " + path);
                    } catch (IllegalArgumentException e) {
                        e.printStackTrace();
                        path = null;
                    } finally {
                        cursor.close();
                    }
                }
            }
        }

        System.out.println("path:"+path);
        return path;
    }    




    public static String getCurCpuFreq(){
        String result = "N/A";
            try {
                FileReader fr = new FileReader("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq");
                BufferedReader br = new BufferedReader(fr);
                String text = br.readLine();
                result = text.trim();
                br.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        return result;
    }

    public static String getMaxCpuFreq(){
        String result = "";
        ProcessBuilder cmd;
        try {
            String[] args = {"/system/bin/cat","/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"};
            cmd = new ProcessBuilder(args);
            Process process = cmd.start();
            InputStream in = process.getInputStream();
            byte[] re = new byte[24];
            while (in.read(re) != -1) {
                result = result + new String(re);
            }
            in.close();
        } catch (IOException ex) {
            ex.printStackTrace();
            result = "N/A";
        }
        return result.trim();
    }

    public static float getRate(){
        Map<String,String> map1 = getMap();//采样第一次CPU信息快照
        long totalTime1 = Long.parseLong(map1.get("user")) + Long.parseLong(map1.get("nice"))
                         + Long.parseLong(map1.get("system")) + Long.parseLong(map1.get("idle"))
                         + Long.parseLong(map1.get("iowait")) + Long.parseLong(map1.get("irq"))
                         + Long.parseLong(map1.get("softirq"));//获取totalTime1
        long idleTime1 = Long.parseLong(map1.get("idle"));//获取idleTime1
        try{
            Thread.sleep(360);//等待360ms
        }catch (Exception e){
            e.printStackTrace();
        }
        Map<String,String> map2 = getMap();//采样第二次CPU快照
        long totalTime2 = Long.parseLong(map2.get("user")) + Long.parseLong(map2.get("nice"))
                + Long.parseLong(map2.get("system")) + Long.parseLong(map2.get("idle"))
                + Long.parseLong(map2.get("iowait")) + Long.parseLong(map2.get("irq"))
                + Long.parseLong(map2.get("softirq"));//获取totalTime2
        long idleTime2 = Long.parseLong(map2.get("idle"));//获取idleTime2
        float cpuRate = 100*((totalTime2-totalTime1)-(idleTime2-idleTime1))/(totalTime2-totalTime1);
        return cpuRate;
    }

    public static Map<String,String> getMap(){
        String[] cpuInfos = null;
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("/proc/stat")));//读取CPU信息文件
            String load = br.readLine();
            br.close();
            cpuInfos = load.split(" ");
        }catch (IOException e){
            e.printStackTrace();
        }
        Map<String,String> map = new HashMap<String,String>();
        map.put("user",cpuInfos[2]);
        map.put("nice",cpuInfos[3]);
        map.put("system",cpuInfos[4]);
        map.put("idle",cpuInfos[5]);
        map.put("iowait",cpuInfos[6]);
        map.put("irq",cpuInfos[7]);
        map.put("softirq",cpuInfos[8]);
        return map;
    }
}
