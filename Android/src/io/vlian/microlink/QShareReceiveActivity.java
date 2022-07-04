package io.vlian.microlink;

import org.qtproject.qt.android.bindings.QtActivity;

import android.content.Intent;
import android.content.Context;
import android.os.Bundle;
import android.app.Activity;

public class QShareReceiveActivity extends QtActivity{
    private static native void callNativeOne(int x);
    public static void foo(int x){
        System.out.println(x);
    }
    @Override
    public void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.activity_main);
        Intent intent = getIntent();
        String action = intent.getAction();
        String type = intent.getType();
        callNativeOne(19);
    }
}
