# Existing rule to suppress warnings for Kotlin's Parcelize
-dontwarn kotlinx.parcelize.Parcelize

# Add rules to prevent stripping important Jitsi Meet and React Native classes

# Keep Jitsi Meet classes
-keep class JitsiMeetMethods.** { *; }
-dontwarn org.jitsi.**

# Keep React Native classes (used by Jitsi Meet)
-keep class com.facebook.react.** { *; }
-dontwarn com.facebook.react.**

# Keep WebRTC classes if you're using WebRTC through Jitsi Meet
-keep class org.webrtc.** { *; }
-dontwarn org.webrtc.**

# For Gson (if Jitsi or any other lib uses it)
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# If you're using Retrofit or other libraries, add similar rules for them
