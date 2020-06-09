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

}

jlong findSum(JNIEnv *env, jlongArray arr, jsize size) {
    jlong sum = 0;
    jlong *elements = env->GetLongArrayElements(arr, NULL);
    for (jsize i = 0; i < size; i++) {
        sum += elements[i];
    }
    env->ReleaseLongArrayElements(arr, elements, 0);
    return sum;
}

JNIEXPORT jlong
Java_com_example_harwister_player_MusicActivity_findDurationSumWithNDK(
        JNIEnv *env, jclass cls, jlongArray arr) {

    init(env);
    jsize size = env->GetArrayLength(arr);
    return findSum(env, arr, size);
}