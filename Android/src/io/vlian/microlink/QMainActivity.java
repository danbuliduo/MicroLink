package io.vlian.microlink;

import org.qtproject.qt.android.bindings.QtActivity;
import androidx.core.content.FileProvider;

import java.io.File;
import android.net.Uri;
import android.content.Intent;
import android.content.Context;
import android.os.Vibrator;

public class QMainActivity{
    private Vibrator vibrator;
    //震动服务
    public void startVibrator(Context context){
        vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
        long[] pattern = {200, 200};
        vibrator.vibrate(pattern, -1);
    }
    //分享文件
    public void shareFile(String filePath,QtActivity activity){
       File file = new File(filePath);
       Uri uri = FileProvider.getUriForFile(activity,"io.vlian.microlink.fileprovider",file);
       Intent intent = new Intent(Intent.ACTION_SEND);
       intent.setType("text/plain");
       intent.putExtra(Intent.EXTRA_STREAM, uri);
       intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
       intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
       activity.startActivity(Intent.createChooser(intent,"share"));
    }
    //APK安装
    public void installApk(String apkPath,QtActivity activity){
        File file = new File(apkPath);
        Uri uri = FileProvider.getUriForFile(activity,"io.vlian.microlink.fileprovider",file);
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        intent.setDataAndType(uri,"application/vnd.android.package-archive");
        activity.startActivity(intent);
    }
}
