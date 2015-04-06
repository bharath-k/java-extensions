%include "typemaps.i"

%module example

%{
#include "example.h"
#include "examplejni.h"
#include "jni.h"
%}

%inline %{

%}

// -------------------------- get_service ------------------------------------
// Define your typemaps before includeing the required methods.
// That way swig will know what to do with the methods when it actually encounters them.
%typemap(out) MYService *
{
    // $result will be a jstring
    jresult = (*jenv)->NewStringUTF(jenv, $1->stringEntry);
    free($1->stringEntry);
    free($1);
}

%typemap(jni) MYService * "jstring"
%typemap(jtype) MYService * "String"
%typemap(jstype) MYService * "String"

%typemap(javaout) MYService * {
    return $jnicall;
}

// -------------------------- get_service_array -----------------------------
%typemap(out) MYService **
{
    // Get count
    int len=0;
    while ($1[len])
    {
        len++;
    }

    const jclass strclass = (*jenv)->FindClass(jenv, "java/lang/String");
    jresult = (*jenv)->NewObjectArray(jenv, len, strclass, NULL);
    /* exception checking omitted */

    jstring temp_string;
    int i;
    for (i=0; i < len; i++)
    {
        MYService *service = $1[i];
        temp_string = (*jenv)->NewStringUTF(jenv, service->stringEntry);
        (*jenv)->SetObjectArrayElement(jenv, jresult, i, temp_string);
        (*jenv)->DeleteLocalRef(jenv, temp_string);
        free(service->stringEntry);
        free(service);
    }
    free($1);
}

%typemap(jni) MYService ** "jobjectArray"
%typemap(jtype) MYService ** "String[]"
%typemap(jstype) MYService ** "String[]"

%typemap(javaout) MYService ** {
    return $jnicall;
}

// -------------------------- fillup_service --------------------------------
%typemap(out) Container_Service *
{
    // Convert the value to integer again.
    if(result->retCode == 0)
    {
        // $result will be a jstring
        MYService *service = result->service;
        jresult = (*jenv)->NewStringUTF(jenv, service->stringEntry);
        free(service->stringEntry);
        free(service);
        free(result);
    }
    else
    {
        // TODO: Throw an exception in java.
    }
}

%typemap(jni) Container_Service * "jstring"
%typemap(jtype) Container_Service * "String"
%typemap(jstype) Container_Service * "String"

%typemap(javaout) Container_Service * {
    return $jnicall;
}

// -------------------------- fillup_service_array ----------------------------
%typemap(out) Container_Service_Array *
{
    // Convert the value to integer again.
    if(result->retCode != 0)
    {
        // TODO: Throw an exception in java.
    }

    // Get count of services
    MYService **services = result->services;
    int len=0;
    while (services[len])
    {
        len++;
    }

    const jclass strclass = (*jenv)->FindClass(jenv, "java/lang/String");
    jresult = (*jenv)->NewObjectArray(jenv, len, strclass, NULL);
    /* exception checking omitted */

    jstring temp_string;
    int i;
    for (i=0; i < len; i++)
    {
        MYService *service = services[i];
        temp_string = (*jenv)->NewStringUTF(jenv, service->stringEntry);
        (*jenv)->SetObjectArrayElement(jenv, jresult, i, temp_string);
        (*jenv)->DeleteLocalRef(jenv, temp_string);
        free(service->stringEntry);
        free(service);
    }
    free(services);
}

%typemap(jni) Container_Service_Array * "jobjectArray"
%typemap(jtype) Container_Service_Array * "String[]"
%typemap(jstype) Container_Service_Array * "String[]"

%typemap(javaout) Container_Service_Array * {
    return $jnicall;
}

MYService *get_service();
MYService **get_service_array();
Container_Service *fillup_service_proxy(int fail);
Container_Service_Array *fillup_service_array_proxy(int fail);
