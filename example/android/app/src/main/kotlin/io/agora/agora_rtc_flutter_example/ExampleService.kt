package io.agora.agora_rtc_ng_example

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Binder
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat

class ExampleService: Service() {

    private val binder: Binder by lazy {
        Binder()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return if (intent?.action == ACTION_START_FOREGROUND_SERVICE) {
            startForegroundService()
            START_REDELIVER_INTENT
        } else {
            stopForegroundService()
            START_NOT_STICKY
        }
    }

    override fun onTaskRemoved(rootIntent: Intent?) {
        super.onTaskRemoved(rootIntent)
        // If we receive the `onTaskRemoved`, we consider that the user want to close the APP, so
        // destroy the `FlutterEngine` here.
        (applicationContext as MyApplication).destroyFlutterEngine()

        stopForegroundService()
    }

    override fun onBind(intent: Intent): IBinder? {
        return binder
    }

    private fun createNotificationChannel(
        context: Context,
        channelId: String,
        name: String,
        des: String
    ) {
        val notificationManager =
            ContextCompat.getSystemService(
                context,
                NotificationManager::class.java
            ) as NotificationManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            if (notificationManager.getNotificationChannel(channelId) == null) {
                val notificationChannel = NotificationChannel(
                    channelId,
                    name,
                    NotificationManager.IMPORTANCE_DEFAULT
                )
                notificationChannel.setSound(null, null)
                notificationChannel.enableLights(false)
                notificationChannel.enableVibration(false)
                notificationChannel.description = des
                notificationManager.createNotificationChannel(notificationChannel)
            }
        }
    }

    private fun startForegroundService() {
        createNotificationChannel(
            applicationContext,
            "MyChannelId",
            "agora_rtc_engine_example",
            "agora_rtc_engine_example running"
        )

        val notificationBuilder =
            NotificationCompat
                .Builder(this, "MyChannelId")
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle("agora_rtc_engine_example")
                .setContentText("agora_rtc_engine_example running")
                .setWhen(System.currentTimeMillis())
                .setPriority(NotificationCompat.PRIORITY_LOW)
                .setContentIntent(getContentIntent())
                .setShowWhen(false)

        startForeground(NOTIFICATION_ID_DAEMON_SERVICE, notificationBuilder.build())
    }

    private fun getContentIntent(): PendingIntent? {
        val intent = Intent(this, MainActivity::class.java).apply {
            action = "NOTIFICATION_OPEN"
        }
        return PendingIntent.getActivity(
            this,
            0,
            intent,
            PendingIntent.FLAG_IMMUTABLE
        )
    }

    private fun stopForegroundService() {
        stopForeground(true)
        stopSelf()
    }

    companion object {
        const val ACTION_START_FOREGROUND_SERVICE = "ACTION_START_FOREGROUND_SERVICE"
        private const val ACTION_STOP_FOREGROUND_SERVICE = "ACTION_STOP_FOREGROUND_SERVICE"

        const val NOTIFICATION_ID_DAEMON_SERVICE = 123

        private var isServiceRunning = false

        fun startDaemonService(context: Context) {
            if (isServiceRunning) {
                return
            }
            try {
                val intent = Intent(context, ExampleService::class.java)
                intent.action = ACTION_START_FOREGROUND_SERVICE


                val bundle = Bundle()
                intent.putExtras(bundle)

                // Crash: startForegroundService must call start startForeground
                // This crash usually happens when background global configuration changes(like: Debug DisplayCut configuration changes)
                context.startService(intent)
                isServiceRunning = true
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        fun stopDaemonService(context: Context) {
            if (!isServiceRunning) {
                return
            }
            try {
                val intent = Intent(context, ExampleService::class.java)
                intent.action = ACTION_STOP_FOREGROUND_SERVICE

                // Crash: startForegroundService must call start startForeground
                // This crash usually happens when background global configuration changes(like: Debug DisplayCut configuration changes)
                context.startService(intent)
                isServiceRunning = false
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}