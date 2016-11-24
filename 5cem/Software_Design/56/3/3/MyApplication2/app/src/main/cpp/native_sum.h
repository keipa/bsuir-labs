//
// Created by Harwister on 11/23/2016.
//
#include <jni.h>
#include <time.h>
#include <android/log.h>
#include <vector>
#include <algorithm>

#ifndef MYAPPLICATION2_NATIVE_SUM_H
#define MYAPPLICATION2_NATIVE_SUM_H
extern "C" {
JNIEXPORT jlong JNICALL
Java_com_example_harwister_player_MusicActivity_sumNDK(
        JNIEnv *env, jclass cls, jlongArray arr);
};
#endif //MYAPPLICATION2_NATIVE_SUM_H
