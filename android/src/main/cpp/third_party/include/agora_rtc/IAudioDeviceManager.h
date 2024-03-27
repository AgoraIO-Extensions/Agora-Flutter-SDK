//
//  Agora SDK
//
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
#pragma once // NOLINT(build/header_guard)

namespace agora {
namespace rtc {

/**
 * The maximum device ID length.
 */
enum MAX_DEVICE_ID_LENGTH_TYPE {
  /**
   * The maximum device ID length is 512.
   */
  MAX_DEVICE_ID_LENGTH = 512
};

/**
 * The IAudioDeviceCollection class.
 */
class IAudioDeviceCollection {
public:
  virtual ~IAudioDeviceCollection() {}

  /**
   * Gets the total number of the playback or recording devices.
   *
   * Call \ref IAudioDeviceManager::enumeratePlaybackDevices
   * "enumeratePlaybackDevices" first, and then call this method to return the
   * number of the audio playback devices.
   *
   * @return
   * - The number of the audio devices, if the method call succeeds.
   * - < 0, if the method call fails.
   */
  virtual int getCount() = 0;

  /**
   * Gets the information of a specified audio device.
   * @param index An input parameter that specifies the audio device.
   * @param deviceName An output parameter that indicates the device name.
   * @param deviceId An output parameter that indicates the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDevice(int index, char deviceName[MAX_DEVICE_ID_LENGTH],
                        char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the information of a specified audio device.
   * @note 
   * @param index An input parameter that specifies the audio device.
   * @param deviceName An output parameter that indicates the device name.
   * @param deviceTypeName An output parameter that indicates the device type name. such as Built-in, USB, HDMI, etc. (MacOS only)
   * @param deviceId An output parameter that indicates the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDevice(int index, char deviceName[MAX_DEVICE_ID_LENGTH], char deviceTypeName[MAX_DEVICE_ID_LENGTH],
                        char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;                      

  /**
   * Specifies a device with the device ID.
   * @param deviceId The device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the default audio device of the system (for macOS and Windows only).
   *
   * @param deviceName The name of the system default audio device.
   * @param deviceId The device ID of the the system default audio device.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDefaultDevice(char deviceName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

   /**
   * Gets the default audio device of the system (for macOS and Windows only).
   *
   * @param deviceName The name of the system default audio device.
   * @param deviceTypeName The device type name of the the system default audio device, such as Built-in, USB, HDMI, etc. (MacOS only)
   * @param deviceId The device ID of the the system default audio device.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getDefaultDevice(char deviceName[MAX_DEVICE_ID_LENGTH], char deviceTypeName[MAX_DEVICE_ID_LENGTH], char deviceId[MAX_DEVICE_ID_LENGTH]) = 0; 

  /**
   * Sets the volume of the app.
   *
   * @param volume The volume of the app. The value range is [0, 255].
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setApplicationVolume(int volume) = 0;

  /**
   * Gets the volume of the app.
   *
   * @param volume The volume of the app. The value range is [0, 255]
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getApplicationVolume(int &volume) = 0;

  /** Mutes or unmutes the app.
   *
   * @param mute Determines whether to mute the app:
   * - true: Mute the app.
   * - false: Unmute the app.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setApplicationMute(bool mute) = 0;

  /**
   * Gets the mute state of the app.
   *
   * @param mute A reference to the mute state of the app:
   * - true: The app is muted.
   * - false: The app is not muted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int isApplicationMute(bool &mute) = 0;

  /**
   * Releases all IAudioDeviceCollection resources.
   */
  virtual void release() = 0;
};

/**
 * The IAudioDeviceManager class.
 */
class IAudioDeviceManager : public RefCountInterface {
public:
  virtual ~IAudioDeviceManager() {}

  /**
   * Enumerates the audio playback devices.
   *
   * This method returns an IAudioDeviceCollection object that includes all the
   * audio playback devices in the system. With the IAudioDeviceCollection
   * object, the app can enumerate the audio playback devices. The app must call
   * the \ref IAudioDeviceCollection::release "IAudioDeviceCollection::release"
   * method to release the returned object after using it.
   *
   * @return
   * - A pointer to the IAudioDeviceCollection object that includes all the
   * audio playback devices in the system, if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual IAudioDeviceCollection *enumeratePlaybackDevices() = 0;

  /**
   * Enumerates the audio recording devices.
   *
   * This method returns an IAudioDeviceCollection object that includes all the
   * audio recording devices in the system. With the IAudioDeviceCollection
   * object, the app can enumerate the audio recording devices. The app needs to
   * call the \ref IAudioDeviceCollection::release
   * "IAudioDeviceCollection::release" method to release the returned object
   * after using it.
   *
   * @return
   * - A pointer to the IAudioDeviceCollection object that includes all the
   * audio recording devices in the system, if the method call succeeds.
   * - The empty pointer NULL, if the method call fails.
   */
  virtual IAudioDeviceCollection *enumerateRecordingDevices() = 0;

  /**
   * Specifies an audio playback device with the device ID.
   *
   * @param deviceId ID of the audio playback device. It can be retrieved by the
   * \ref enumeratePlaybackDevices "enumeratePlaybackDevices" method. Plugging
   * or unplugging the audio device does not change the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the ID of the audio playback device.
   * @param deviceId An output parameter that specifies the ID of the audio
   * playback device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getPlaybackDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the device ID and device name of the audio playback device.
   * @param deviceId An output parameter that specifies the ID of the audio
   * playback device.
   * @param deviceName An output parameter that specifies the name of the audio
   * playback device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getPlaybackDeviceInfo(char deviceId[MAX_DEVICE_ID_LENGTH],
                                    char deviceName[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the device ID and device name and device type name of the audio playback device.
   * @param deviceId An output parameter that specifies the ID of the audio playback device.
   * @param deviceName An output parameter that specifies the name of the audio playback device.
   * @param deviceTypeName An output parameter that specifies the device type name. such as Built-in, USB, HDMI, etc. (MacOS only)
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getPlaybackDeviceInfo(char deviceId[MAX_DEVICE_ID_LENGTH], char deviceName[MAX_DEVICE_ID_LENGTH], char deviceTypeName[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Sets the volume of the audio playback device.
   * @param volume The volume of the audio playing device. The value range is
   * [0, 255].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackDeviceVolume(int volume) = 0;

  /**
   * Gets the volume of the audio playback device.
   * @param volume The volume of the audio playback device. The value range is
   * [0, 255].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getPlaybackDeviceVolume(int *volume) = 0;

  /**
   * Specifies an audio recording device with the device ID.
   *
   * @param deviceId ID of the audio recording device. It can be retrieved by
   * the \ref enumerateRecordingDevices "enumerateRecordingDevices" method.
   * Plugging or unplugging the audio device does not change the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRecordingDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the audio recording device by the device ID.
   *
   * @param deviceId ID of the audio recording device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getRecordingDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the information of the audio recording device by the device ID and
   * device name.
   *
   * @param deviceId ID of the audio recording device.
   * @param deviceName The name of the audio recording device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getRecordingDeviceInfo(char deviceId[MAX_DEVICE_ID_LENGTH],
                                     char deviceName[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the device ID and device name and device type name of the audio recording device.
   *
   * @param deviceId An output parameter that indicates the device id.
   * @param deviceName An output parameter that indicates the device name.
   * @param deviceTypeName An output parameter that indicates the device type name. such as Built-in, USB, HDMI, etc. (MacOS only)
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getRecordingDeviceInfo(char deviceId[MAX_DEVICE_ID_LENGTH], char deviceName[MAX_DEVICE_ID_LENGTH], char deviceTypeName[MAX_DEVICE_ID_LENGTH]) = 0;    
                               
  /**
   * Sets the volume of the recording device.
   * @param volume The volume of the recording device. The value range is [0,
   * 255].
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRecordingDeviceVolume(int volume) = 0;

  /**
   * Gets the volume of the recording device.
   * @param volume The volume of the microphone, ranging from 0 to 255.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getRecordingDeviceVolume(int *volume) = 0;

  /**
   * Specifies an audio loopback recording device with the device ID.
   *
   * @param deviceId ID of the audio loopback recording device. It can be retrieved by
   * the \ref enumeratePlaybackDevices "enumeratePlaybackDevices" method.
   * Plugging or unplugging the audio device does not change the device ID.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setLoopbackDevice(const char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Gets the audio loopback recording device by the device ID.
   *
   * @param deviceId ID of the audio loopback recording device.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getLoopbackDevice(char deviceId[MAX_DEVICE_ID_LENGTH]) = 0;

  /**
   * Mutes or unmutes the audio playback device.
   *
   * @param mute Determines whether to mute the audio playback device.
   * - true: Mute the device.
   * - false: Unmute the device.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setPlaybackDeviceMute(bool mute) = 0;

  /**
   * Gets the mute state of the playback device.
   *
   * @param mute A pointer to the mute state of the playback device.
   * - true: The playback device is muted.
   * - false: The playback device is unmuted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getPlaybackDeviceMute(bool *mute) = 0;

  /**
   * Mutes or unmutes the audio recording device.
   *
   * @param mute Determines whether to mute the recording device.
   * - true: Mute the microphone.
   * - false: Unmute the microphone.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int setRecordingDeviceMute(bool mute) = 0;

  /**
   * Gets the mute state of the audio recording device.
   *
   * @param mute A pointer to the mute state of the recording device.
   * - true: The microphone is muted.
   * - false: The microphone is unmuted.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int getRecordingDeviceMute(bool *mute) = 0;

  /**
   * Starts the audio playback device test.
   *
   * This method tests if the playback device works properly. In the test, the
   * SDK plays an audio file specified by the user. If the user hears the audio,
   * the playback device works properly.
   *
   * @param testAudioFilePath The file path of the audio file for the test,
   * which is an absolute path in UTF8:
   * - Supported file format: wav, mp3, m4a, and aac.
   * - Supported file sampling rate: 8000, 16000, 32000, 44100, and 48000.
   *
   * @return
   * - 0, if the method call succeeds and you can hear the sound of the
   * specified audio file.
   * - An error code, if the method call fails.
   */
  virtual int startPlaybackDeviceTest(const char *testAudioFilePath) = 0;

  /**
   * Stops the audio playback device test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopPlaybackDeviceTest() = 0;

  /**
   * Starts the recording device test.
   *
   * This method tests whether the recording device works properly. Once the
   * test starts, the SDK uses the \ref
   * IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication"
   * callback to notify the app on the volume information.
   *
   * @param indicationInterval The time interval (ms) between which the SDK
   * triggers the `onAudioVolumeIndication` callback.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startRecordingDeviceTest(int indicationInterval) = 0;

  /**
   * Stops the recording device test.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopRecordingDeviceTest() = 0;

  /**
   * Starts the audio device loopback test.
   *
   * This method tests whether the local audio devices are working properly.
   * After calling this method, the microphone captures the local audio and
   * plays it through the speaker, and the \ref
   * IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication"
   * callback returns the local audio volume information at the set interval.
   *
   * @note This method tests the local audio devices and does not report the
   * network conditions.
   * @param indicationInterval The time interval (ms) at which the \ref
   * IRtcEngineEventHandler::onAudioVolumeIndication "onAudioVolumeIndication"
   * callback returns.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int startAudioDeviceLoopbackTest(int indicationInterval) = 0;

  /**
   * Stops the audio device loopback test.
   *
   * @note Ensure that you call this method to stop the loopback test after
   * calling the \ref IAudioDeviceManager::startAudioDeviceLoopbackTest
   * "startAudioDeviceLoopbackTest" method.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  virtual int stopAudioDeviceLoopbackTest() = 0;

  /** The status of following system default playback device.

   @note The status of following system default playback device.

   @param enable Variable to whether the current device follow system default playback device or not.
   - true: The current device will change when the system default playback device changed.
   - false: The current device will change only current device is removed.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int followSystemPlaybackDevice(bool enable) = 0;

  /** The status of following system default recording device.

   @note The status of following system default recording device.

   @param enable Variable to whether the current device follow system default recording device or not.
   - true: The current device will change when the system default recording device changed.
   - false: The current device will change only current device is removed.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int followSystemRecordingDevice(bool enable) = 0;

  /** The status of following system default loopback device.

   @note The status of following system default loopback device.

   @param enable Variable to whether the current device follow system default loopback device or not.
   - true: The current device will change when the system default loopback device changed.
   - false: The current device will change only current device is removed.
   @return
   - 0: Success.
   - < 0: Failure.
   */
  virtual int followSystemLoopbackDevice(bool enable) = 0;

  /**
   * Releases all IAudioDeviceManager resources.
   */
  virtual void release() = 0;
};

} // namespace rtc
} // namespace agora
