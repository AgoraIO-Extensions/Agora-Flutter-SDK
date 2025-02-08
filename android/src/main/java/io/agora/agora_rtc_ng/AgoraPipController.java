package io.agora.agora_rtc_ng;

import android.app.Activity;
import android.app.PictureInPictureParams;
import android.content.pm.PackageManager;
import android.graphics.Rect;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.util.Rational;

import androidx.annotation.ChecksSdkIntAtLeast;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.lang.ref.WeakReference;

public class AgoraPipController {
    public enum PipState {
        Started(0),
        Stopped(1),
        Failed(2);

        private final int value;

        PipState(int value) {
            this.value = value;
        }

        public int getValue() {
            return value;
        }
    }

    public interface PipStateChangedListener {
        void onPipStateChangedListener(PipState state);
    }

    private static class PipParams {
        @Nullable
        private final Rational aspectRatio;
        @Nullable
        private final Boolean autoEnterEnabled;
        @Nullable
        private final Rect sourceRectHint;

        public PipParams(@Nullable Rational aspectRatio,
                         @Nullable Boolean autoEnterEnabled,
                         @Nullable Rect sourceRectHint) {
            this.aspectRatio = aspectRatio;
            this.autoEnterEnabled = autoEnterEnabled;
            this.sourceRectHint = sourceRectHint;
        }
    }

    private PipParams mPipParams;
    private PictureInPictureParams.Builder mParamsBuilder;
    private WeakReference<Activity> mActivity;
    private final PipStateChangedListener mListener;
    // Note: The interval is set to 100ms to reduce the flickering effect.
    // This is necessary because Flutter's activity lifecycle events don't include
    // PiP state transitions, so we rely on polling to detect changes.
    private static final long CHECK_INTERVAL_MS = 100;
    private Handler mHandler;
    private Runnable mCheckStateTask;
    private boolean mLastPipState = false;

    public AgoraPipController(@NonNull Activity activity,
                              @Nullable PipStateChangedListener listener) {
        mActivity = new WeakReference<>(activity);
        mListener = listener;
        mHandler = new Handler(Looper.getMainLooper());
    }

    private void checkPipState() {
        boolean currentState = isActived();
        if (currentState != mLastPipState) {
            mLastPipState = currentState;
            notifyPipStateChanged(currentState ? PipState.Started : PipState.Stopped);
        }
    }

    private boolean isPipEnabled() {
        return mPipParams != null && mParamsBuilder != null;
    }

    private void notifyPipStateChanged(PipState state) {
        if (mListener != null) {
            mListener.onPipStateChangedListener(state);
        }
    }

    public void attachToActivity(@NonNull Activity activity) {
        if (mActivity != null && mActivity.get() != null &&
                mActivity.get() != activity) {
            mActivity = new WeakReference<>(activity);
        }
    }

    public boolean isSupported() {
        Activity activity = mActivity.get();
        if (activity == null) {
            return false;
        }

        // for android 8
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
            return false;
        }

        final PackageManager pm =
                activity.getApplicationContext().getPackageManager();
        if (pm == null) {
            return false;
        }

        return pm.hasSystemFeature(PackageManager.FEATURE_PICTURE_IN_PICTURE);
    }

    @ChecksSdkIntAtLeast(api = Build.VERSION_CODES.S)
    public boolean isAutoEnterSupported() {
        // // for android 12
        // // whether support setAutoEnterEnabled or not
        // return Build.VERSION.SDK_INT >= Build.VERSION_CODES.S;

        // since flutter do not delegate onPause and onPiPModeChanged and
        // onPipStateChanged, we do not support auto enter pip on android for now
        return false;
    }

    public boolean isActived() {
        Activity activity = mActivity.get();
        if (activity == null) {
            return false;
        }

        // for android 7
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            return isSupported() && activity.isInPictureInPictureMode();
        }

        return false;
    }

    public boolean setup(@Nullable Rational aspectRatio,
                         @Nullable Boolean autoEnterEnabled,
                         @Nullable Rect sourceRectHint) {
        if (!isSupported()) {
            return false;
        }

        Activity activity = mActivity.get();
        if (activity == null) {
            return false;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            if (mParamsBuilder == null) {
                mParamsBuilder = new PictureInPictureParams.Builder();
            }

            if (mPipParams == null ||
                    (aspectRatio != null && mPipParams.aspectRatio != aspectRatio) ||
                    (autoEnterEnabled != null &&
                            mPipParams.autoEnterEnabled != autoEnterEnabled) ||
                    (sourceRectHint != null &&
                            mPipParams.sourceRectHint != sourceRectHint)) {
                mPipParams =
                        new PipParams(aspectRatio, autoEnterEnabled, sourceRectHint);
            }

            if (mPipParams.aspectRatio != null) {
                mParamsBuilder.setAspectRatio(mPipParams.aspectRatio);
            }

            // Note: setAutoEnterEnabled will not work if the target Android version
            // is 11 or lower
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                // mParamsBuilder.setAutoEnterEnabled(
                //         Boolean.TRUE.equals(mPipParams.autoEnterEnabled));
                // since flutter do not delegate onPause and onPiPModeChanged and
                // onPipStateChanged, we do not support auto enter pip on android for
                // now
                //
                // so we always set autoEnterEnabled to false for now
                mParamsBuilder.setAutoEnterEnabled(false);
            }

            if (mPipParams.sourceRectHint != null) {
                mParamsBuilder.setSourceRectHint(mPipParams.sourceRectHint);
            }

            // Disables the seamless resize. The seamless resize works great for videos where the
            // content can be arbitrarily scaled, but you can disable this for non-video content so
            // that the picture-in-picture mode is resized with a cross fade animation.
            mParamsBuilder.setSeamlessResizeEnabled(false);

            activity.setPictureInPictureParams(mParamsBuilder.build());
        }

        // Start monitoring PIP state after setup
        startStateMonitoring();

        return true;
    }

    public boolean start() {
        if (!isSupported()) {
            return false;
        }

        if (isActived()) {
            return true;
        }

        Activity activity = mActivity.get();
        if (activity == null) {
            return false;
        }

        if (!isPipEnabled()) {
            return false;
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            activity.enterPictureInPictureMode(mParamsBuilder.build());
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            activity.enterPictureInPictureMode();
        }

        return true;
    }

    public void stop() {
        if (!isSupported() || !isActived()) {
            return;
        }

        Activity activity = mActivity.get();
        if (activity == null) {
            return;
        }

        // this will not stop the pip, it will just move the activity to the
        // background and the pip will still be active when the activity is resumed
        activity.moveTaskToBack(false);
    }

    public void dispose() {
        stopStateMonitoring();

        // do not call stop() here, coz there is no truly stop in android, the
        // implement of stop() is just moveTaskToBack(false), which is not what we
        // want.
        //
        // stop();

        Activity activity = mActivity.get();
        if (activity != null) {
            // only call setPictureInPictureParams to clear flag setAutoEnterEnabled
            // when setAutoEnterEnabled is supported
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                activity.setPictureInPictureParams(new PictureInPictureParams.Builder()
                        .setAutoEnterEnabled(false)
                        .build());
            }
        }

        mPipParams = null;
        mParamsBuilder = null;
        mHandler = null;
        mLastPipState = false;
        mCheckStateTask = null;
    }

    private void startStateMonitoring() {
        if (mHandler == null) {
            mHandler = new Handler(Looper.getMainLooper());
        }

        // If task is already running, don't create a new one
        if (mCheckStateTask != null) {
            return;
        }

        mCheckStateTask = new Runnable() {
            @Override
            public void run() {
                checkPipState();
                mHandler.postDelayed(this, CHECK_INTERVAL_MS);
            }
        };
        mHandler.post(mCheckStateTask);
    }

    private void stopStateMonitoring() {
        mHandler.removeCallbacks(mCheckStateTask);
    }

    // since flutter do not delegate onPause and onPiPModeChanged and
    // onPipStateChanged, we do not support auto enter pip on android for now
    // private void onUserLeaveHint() {
    //     if (!isSupported() || mPipParams == null) {
    //         return;
    //     }

    //     // only call start when !isAutoEnterSupported() and autoEnterEnabled is
    //     set to true if (Boolean.TRUE.equals(mPipParams.autoEnterEnabled) &&
    //     !isAutoEnterSupported() && !isActived()) {
    //         start();
    //     }
    // }
}
