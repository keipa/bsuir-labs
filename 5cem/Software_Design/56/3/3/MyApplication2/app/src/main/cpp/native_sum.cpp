//
// Created by Harwister on 11/23/2016.
//

#include "native_sum.h"

jclass arrClass;
jmethodID arrGet;
jmethodID arrSet;
jmethodID arrSize;

jclass newsClass;
jfieldID duration;

void init(JNIEnv *env) {
    arrClass = static_cast<jclass>(env->NewGlobalRef(
            env->FindClass("java/util/List")));
    arrSize = env->GetMethodID (arrClass, "size", "()I");
    arrGet = env->GetMethodID(arrClass, "get", "(I)Ljava/lang/Object;");
    arrSet = env->GetMethodID(arrClass, "set", "(ILjava/lang/Object;)Ljava/lang/Object;");

    newsClass = static_cast<jclass>(env->NewGlobalRef(
            env->FindClass("com/example/harwister/player/Song")));
    duration = env->GetFieldID(newsClass, "duration", "J");
}

jlong findSum(JNIEnv *env, jobjectArray arr, jsize size) {
    jlong sum = 0;

    // for (jsize i = 0; i < size; i++) {
    jobject a = env->GetObjectArrayElement(arr, size - 1);
    jlong kek = (jlong)env->GetObjectField(a, duration);
    env->DeleteLocalRef(a);
   // }
    return sum;
}

JNIEXPORT jlong
Java_com_example_harwister_player_MusicActivity_sumNDK(
        JNIEnv *env, jclass cls, jobjectArray arr) {

    init(env);
    jsize size = env->GetArrayLength(arr);
    return findSum(env, arr, size);
}