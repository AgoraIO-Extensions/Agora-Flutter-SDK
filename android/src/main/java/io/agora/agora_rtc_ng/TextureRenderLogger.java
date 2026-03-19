package io.agora.agora_rtc_ng;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.BufferedWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * Shared file logger for texture rendering pipeline debugging.
 * Both native (C++) and Flutter (Dart) sides write to the same file
 * so logs are interleaved in chronological order.
 *
 * Disabled by default. Call {@link #enable(String)} to start logging.
 */
public class TextureRenderLogger {

    static {
        System.loadLibrary("iris_rendering_android");
    }

    private static volatile boolean sEnabled = false;
    private static BufferedWriter sWriter = null;
    private static String sLogFilePath = null;
    private static SimpleDateFormat sDateFormat = null;
    private static final Object sLock = new Object();

    public static void enable(String logDir) {
        synchronized (sLock) {
            disable();
            try {
                File dir = new File(logDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                sLogFilePath = logDir + File.separator + "flutter_texture_render.log";
                FileOutputStream fos = new FileOutputStream(sLogFilePath, true);
                sWriter = new BufferedWriter(new OutputStreamWriter(fos, "UTF-8"));
                sDateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS", Locale.US);
                sEnabled = true;
                // Also enable native C++ logger to write to the same file
                nativeEnableLogger(logDir);
            } catch (Exception e) {
                sEnabled = false;
                sWriter = null;
                sLogFilePath = null;
            }
        }
    }

    public static void disable() {
        synchronized (sLock) {
            sEnabled = false;
            nativeDisableLogger();
            if (sWriter != null) {
                try {
                    sWriter.flush();
                    sWriter.close();
                } catch (Exception ignored) {}
                sWriter = null;
            }
            sLogFilePath = null;
            sDateFormat = null;
        }
    }

    public static void log(String tag, String message) {
        if (!sEnabled) return;
        synchronized (sLock) {
            if (sWriter != null) {
                try {
                    String timestamp = sDateFormat.format(new Date());
                    sWriter.write(timestamp + " [Native][" + tag + "] " + message);
                    sWriter.newLine();
                    sWriter.flush();
                } catch (Exception ignored) {}
            }
        }
    }

    public static boolean isEnabled() {
        return sEnabled;
    }

    public static String getLogFilePath() {
        return sLogFilePath;
    }

    private static native void nativeEnableLogger(String logDir);
    private static native void nativeDisableLogger();
}
