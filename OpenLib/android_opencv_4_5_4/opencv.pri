ANDROID_OPENCV=$$PWD/OpenCV-android-sdk/sdk/native

INCLUDEPATH += $$ANDROID_OPENCV/jni/include/opencv2 \
                             $$ANDROID_OPENCV/jni/include

LIBS += $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_calib3d.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_core.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_dnn.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_features2d.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_flann.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_gapi.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_highgui.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_imgcodecs.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_imgproc.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_ml.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_objdetect.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_photo.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_stitching.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_video.a \
             $$ANDROID_OPENCV/staticlibs/armeabi-v7a/libopencv_videoio.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libade.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libcpufeatures.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libIlmImf.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libittnotify.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/liblibjpeg-turbo.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/liblibopenjp2.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/liblibpng.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/liblibprotobuf.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/liblibtiff.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/liblibwebp.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libquirc.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libtbb.a \
             $$ANDROID_OPENCV/3rdparty/libs/armeabi-v7a/libtegra_hal.a \
             $$ANDROID_OPENCV/libs/armeabi-v7a/libopencv_java4.so

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_EXTRA_LIBS = \
    $$PWD/OpenCV-android-sdk/sdk/native/libs/armeabi-v7a/libopencv_java4.so
}
