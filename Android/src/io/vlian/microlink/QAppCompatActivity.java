package io.vlian.microlink;

import org.qtproject.qt.android.bindings.QtActivity;
import androidx.appcompat.app.AppCompatActivity;
import android.content.Intent;
import android.content.Context;
import android.os.Bundle;
import android.widget.TextView;
import android.view.View;
import android.view.View.OnClickListener;

public class QAppCompatActivity extends AppCompatActivity implements OnClickListener{

    private final static String ACTION_1 = "action1";
    private final static String ACTION_2 = "action2";
    private final static String ACTION_3 = "action3";
    
    /*private static native void callNativeOne(int x);
    public static void foo(int x){
        System.out.println(x);
    }*/

    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&");
        TextView textView = (TextView) findViewById(R.id.textview);

        switch (getIntent().getAction()){
            case ACTION_1:
                textView.setText(ACTION_1);
                break;
            case ACTION_2:
                textView.setText(ACTION_2);
                break;
            case ACTION_3:
                textView.setText(ACTION_3);
                break;
            default:
                break;
        }
    }

    @Override
	public void onClick(View view) {
        System.out.println("%%%%%%%%%");
    }
}
