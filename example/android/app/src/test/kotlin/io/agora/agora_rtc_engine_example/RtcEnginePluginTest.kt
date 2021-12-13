package io.agora.agora_rtc_engine_example

import io.agora.agora_rtc_engine.ResultCallback
import io.agora.rtc.RtcEngine
import io.agora.rtc.base.*
import org.junit.Assert
import org.junit.Before
import org.junit.Test

class FakeRtcEngineFactory(private val engine: RtcEngine) : RtcEngineFactory() {
  override fun create(
    params: Map<String, *>,
    rtcEngineEventHandler: RtcEngineEventHandler
  ): RtcEngine? {
    return engine
  }
}

class RtcEnginePluginTest {
  private lateinit var rtcChannelManager: RtcEngineManager
  private lateinit var rtcEngine: RtcEngine

  @Before
  fun setUp() {
    rtcEngine = FakeRtcEngine()
    rtcChannelManager = RtcEngineManager(
      emit = { _: String, _: Map<String, Any?>? -> },
      rtcEngineFactory = FakeRtcEngineFactory(rtcEngine)
    )
  }

  @Test
  fun shouldCallPluginCallback() {
    var onRtcEngineCreated = false
    var onRtcEngineDestroyed = false
    var engine: RtcEngine? = null
    val plugin = object : RtcEnginePlugin {

      override fun onRtcEngineCreated(rtcEngine: RtcEngine?) {
        onRtcEngineCreated = true
        engine = rtcEngine
      }

      override fun onRtcEngineDestroyed() {
        onRtcEngineDestroyed = true
      }
    }

    RtcEnginePlugin.register(plugin)

    rtcChannelManager.create(mutableMapOf<String, Any>("appType" to 0), ResultCallback(null))
    Assert.assertTrue(onRtcEngineCreated)
    Assert.assertEquals(rtcEngine, engine)

    rtcChannelManager.destroy(ResultCallback(null))
    Assert.assertTrue(onRtcEngineDestroyed)
    Assert.assertNull(rtcChannelManager.engine)

    RtcEnginePlugin.unregister(plugin)
  }

  @Test
  fun shouldNotCallPluginCallbackAfterUnregister() {
    var onRtcEngineCreated = false
    var onRtcEngineDestroyed = false
    val plugin = object : RtcEnginePlugin {

      override fun onRtcEngineCreated(rtcEngine: RtcEngine?) {
        onRtcEngineCreated = true
      }

      override fun onRtcEngineDestroyed() {
        onRtcEngineDestroyed = true
      }
    }

    RtcEnginePlugin.register(plugin)
    RtcEnginePlugin.unregister(plugin)

    rtcChannelManager.create(mutableMapOf<String, Any>("appType" to 0), ResultCallback(null))
    rtcChannelManager.destroy(ResultCallback(null))

    Assert.assertFalse(onRtcEngineCreated)
    Assert.assertFalse(onRtcEngineDestroyed)
  }
}
