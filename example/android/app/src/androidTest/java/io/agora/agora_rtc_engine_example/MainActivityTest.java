package io.agora.agora_rtc_engine_example;

import androidx.test.rule.ActivityTestRule;

import org.junit.Rule;
import org.junit.runner.RunWith;

import dev.flutter.plugins.e2e.FlutterRunner;

@RunWith(FlutterRunner.class)
public class MainActivityTest {
    @Rule
    public ActivityTestRule<MainActivity> rule =
            new ActivityTestRule<>(MainActivity.class);
}
