package io.agora.agora_rtc_ng;

import android.app.PictureInPictureUiState;
import android.content.res.Configuration;
import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.android.FlutterActivity;

@RequiresApi(Build.VERSION_CODES.O)
public class AgoraPipActivity extends FlutterActivity {
    public interface AgoraPipActivityListener {
        void onPictureInPictureModeChanged(boolean isInPictureInPictureMode, Configuration newConfig);

        void onPictureInPictureUiStateChanged(PictureInPictureUiState state);

        boolean onPictureInPictureRequested();

        void onUserLeaveHint();
    }

    private AgoraPipActivityListener mListener;

    public void setAgoraPipActivityListener(AgoraPipActivityListener listener) {
        mListener = listener;
    }

    // only available in API level 26 and above
    @RequiresApi(26)
    @Override
    public void onPictureInPictureModeChanged(boolean isInPictureInPictureMode, Configuration newConfig) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig);
        if (mListener != null) {
            mListener.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig);
        }
    }

    // only available in API level 30 and above
    @RequiresApi(30)
    @Override
    public boolean onPictureInPictureRequested() {
        if (mListener != null) {
            return mListener.onPictureInPictureRequested();
        }
        return super.onPictureInPictureRequested();
    }

    // only available in API level 31 and above
    @RequiresApi(31)
    @Override
    public void onPictureInPictureUiStateChanged(@NonNull PictureInPictureUiState state) {
        super.onPictureInPictureUiStateChanged(state);
        if (mListener != null) {
            mListener.onPictureInPictureUiStateChanged(state);
        }
    }

    @Override
    public void onUserLeaveHint() {
        super.onUserLeaveHint();
        if (mListener != null) {
            mListener.onUserLeaveHint();
        }
    }
}
