-keepattributes *Annotation*
-keep class kotlin.** { *; }
-keep class org.jetbrains.** { *; }

-keep class io.agora.**{*;}
# Suppress ERROR: R8: Missing class com.google.devtools.build.android.desugar.runtime.ThrowableExtension
-dontwarn com.google.devtools.build.android.desugar.runtime.ThrowableExtension
