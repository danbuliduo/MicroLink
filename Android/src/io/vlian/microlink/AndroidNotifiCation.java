package io.vlian.microlink;

import android.content.Context;
import android.content.Intent;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.NotificationChannel;
import android.app.PendingIntent;
import android.graphics.Color;
import android.graphics.BitmapFactory;

public class AndroidNotifiCation
{
    private static NotificationManager m_notificationManager;
    private static Notification.Builder m_builder;
    public AndroidNotifiCation() {}
    public static void notify(Context context, String message) {
        try {
            m_notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                int importance = NotificationManager.IMPORTANCE_HIGH;
                NotificationChannel notificationChannel = new NotificationChannel("WeLink", "WeLink Notifier", importance);
                m_notificationManager.createNotificationChannel(notificationChannel);
                m_builder = new Notification.Builder(context, notificationChannel.getId());
            } else {
                m_builder = new Notification.Builder(context);
            }
            m_builder.setSmallIcon(R.drawable.icon)
                    .setLargeIcon(BitmapFactory.decodeResource(context.getResources(), R.drawable.icon))
                    .setContentTitle("WeLink 系统测试!")
                    .setContentText(message)
                    .setWhen(System.currentTimeMillis())
                    .setDefaults(NotificationManager.IMPORTANCE_HIGH)
                    .setPriority(NotificationManager.IMPORTANCE_HIGH)
                    .setDefaults(Notification.DEFAULT_ALL)
                    .setColor(Color.GREEN)
                    .setAutoCancel(true);
            m_notificationManager.notify(0, m_builder.build());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
