package io.agora.agora_rtc_ng;

import android.app.Activity;
import android.app.PictureInPictureParams;
import android.app.PictureInPictureUiState;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.graphics.Rect;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.util.Rational;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import java.lang.ref.WeakReference;
import java.util.Objects;

@RequiresApi(Build.VERSION_CODES.O)
public class AgoraPipController
        implements AgoraPipActivity.AgoraPipActivityListener {
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
        @Nullable
        private final Boolean seamlessResizeEnabled;
        @Nullable
        private final Boolean useExternalStateMonitor;
        @Nullable
        private final Integer externalStateMonitorInterval;

        public PipParams(@Nullable Rational aspectRatio,
                         @Nullable Boolean autoEnterEnabled,
                         @Nullable Rect sourceRectHint,
                         @Nullable Boolean seamlessResizeEnabled,
                         @Nullable Boolean useExternalStateMonitor,
                         @Nullable Integer externalStateMonitorInterval) {
            this.aspectRatio = aspectRatio;
            this.autoEnterEnabled = autoEnterEnabled;
            this.sourceRectHint = sourceRectHint;
            this.seamlessResizeEnabled = seamlessResizeEnabled;
            this.useExternalStateMonitor = useExternalStateMonitor;
            this.externalStateMonitorInterval = externalStateMonitorInterval;
        }
    }

    private boolean mIsSupported = false;
    private boolean mIsAutoEnterSupported = false;
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
        setActivity(activity);

        mListener = listener;
        mHandler = new Handler(Looper.getMainLooper());
    }

    private void checkPipState() {
        boolean currentState = isActivated();
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

    private boolean checkPipSupport() {
        Activity activity = mActivity.get();
        if (activity == null) {
            return false;
        }

        // only support android 8 and above
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

    private boolean checkAutoEnterSupport() {
        // Android 12 and above support to set auto enter enabled directly
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            return true;
        }

        // For android 11 and below, we need to check if the activity is kind of
        // AgoraPipActivity since we can enter pip mode when the onUserLeaveHint is
        // called to enter pip mode as a workaround
        Activity activity = mActivity.get();
        return activity instanceof AgoraPipActivity;
    }

    private void setActivity(Activity activity) {
        mActivity = new WeakReference<>(activity);
        if (activity instanceof AgoraPipActivity) {
            ((AgoraPipActivity) activity).setAgoraPipActivityListener(this);
        }

        mIsSupported = checkPipSupport();
        mIsAutoEnterSupported = checkAutoEnterSupport();
    }

    public void attachToActivity(@NonNull Activity activity) {
        setActivity(activity);
    }

    public boolean isSupported() {
        return mIsSupported;
    }

    public boolean isAutoEnterSupported() {
        return mIsAutoEnterSupported;
    }

    public boolean isActivated() {
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
                         @Nullable Rect sourceRectHint,
                         @Nullable Boolean seamlessResizeEnabled,
                         @Nullable Boolean useExternalStateMonitor,
                         @Nullable Integer externalStateMonitorInterval) {
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
                    !Objects.equals(mPipParams.aspectRatio, aspectRatio) ||
                    !Objects.equals(mPipParams.autoEnterEnabled, autoEnterEnabled) ||
                    !Objects.equals(mPipParams.sourceRectHint, sourceRectHint) ||
                    !Objects.equals(mPipParams.seamlessResizeEnabled, seamlessResizeEnabled) ||
                    !Objects.equals(mPipParams.useExternalStateMonitor, useExternalStateMonitor) ||
                    !Objects.equals(mPipParams.externalStateMonitorInterval, externalStateMonitorInterval)) {
                mPipParams =
                        new PipParams(aspectRatio, autoEnterEnabled, sourceRectHint,
                                seamlessResizeEnabled, useExternalStateMonitor,
                                externalStateMonitorInterval);
            }

            if (mPipParams.aspectRatio != null) {
                mParamsBuilder.setAspectRatio(mPipParams.aspectRatio);
            }

            // Note: setAutoEnterEnabled will not work if the target Android version
            // is 11 or lower
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                mParamsBuilder.setAutoEnterEnabled(
                        Boolean.TRUE.equals(mPipParams.autoEnterEnabled));
            }

            if (mPipParams.sourceRectHint != null) {
                mParamsBuilder.setSourceRectHint(mPipParams.sourceRectHint);
            }

            // Disables the seamless resize. The seamless resize works great for
            // videos where the content can be arbitrarily scaled, but you can disable
            // this for non-video content so that the picture-in-picture mode is
            // resized with a cross fade animation.
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && mPipParams.seamlessResizeEnabled != null) {
                mParamsBuilder.setSeamlessResizeEnabled(
                        Boolean.TRUE.equals(mPipParams.seamlessResizeEnabled));
            }

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

        if (isActivated()) {
            return true;
        }

        Activity activity = mActivity.get();
        if (activity == null) {
            return false;
        }

        if (!isPipEnabled()) {
            return false;
        }

        boolean bRes = true;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            bRes = activity.enterPictureInPictureMode(mParamsBuilder.build());
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            activity.enterPictureInPictureMode();
        }

        return bRes;
    }

    public void stop() {
        if (!isSupported() || !isActivated()) {
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
        // Do not need to monitor the pip state with external thread when the
        // activity is kind of AgoraPipActivity and the external state monitor is
        // not enabled
        if (mActivity.get() instanceof AgoraPipActivity &&
                !Boolean.TRUE.equals(mPipParams.useExternalStateMonitor)) {
            return;
        }

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
                mHandler.postDelayed(
                        this, mPipParams.externalStateMonitorInterval != null
                                ? mPipParams.externalStateMonitorInterval.longValue()
                                : CHECK_INTERVAL_MS);
            }
        };
        mHandler.post(mCheckStateTask);
    }

    private void stopStateMonitoring() {
        mHandler.removeCallbacks(mCheckStateTask);
    }

    @Override
    public void onPictureInPictureModeChanged(boolean isInPictureInPictureMode,
                                              Configuration newConfig) {
        if (Boolean.TRUE.equals(mPipParams.useExternalStateMonitor)) {
            return;
        }

        if (isInPictureInPictureMode) {
            notifyPipStateChanged(PipState.Started);
        } else {
            notifyPipStateChanged(PipState.Stopped);
        }
    }

    @Override
    public boolean onPictureInPictureRequested() {
        return false;
    }

    @Override
    public void onPictureInPictureUiStateChanged(PictureInPictureUiState state) {
        // do nothing for now
    }

    @Override
    public void onUserLeaveHint() {
        // Only need to handle auto enter pip for android version below 12
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
            if (Boolean.TRUE.equals(mPipParams.autoEnterEnabled)) {
                start();
            }
        }
    }
}
