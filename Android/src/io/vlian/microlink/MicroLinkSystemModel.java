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
import android.webkit.MimeTypeMap;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;

import androidx.appcompat.app.AppCompatActivity;
import com.tencent.connect.UserInfo;

public class MicroLinkSystemModel{
    public static String getFileType(Context context,String uristring) {
        Uri uri=Uri.parse(uristring);
        if (uri.getScheme().equals(ContentResolver.SCHEME_CONTENT)) {
            ContentResolver contentResolver = context.getContentResolver();
            return MimeTypeMap.getSingleton().getExtensionFromMimeType(contentResolver.getType(uri));
        }else if (uri.getScheme().equals(ContentResolver.SCHEME_FILE)) {
            
        }
        return null;
    }
}