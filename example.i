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
    jresult = NULL;
    // Get a class reference for org.me.myservice
    const jclass cls = (*jenv)->FindClass(jenv, "org/me/myservice");
    if (cls) {
        jobject mystringInstance = (*jenv)->AllocObject(jenv, cls);
        if (mystringInstance) {
            jmethodID setstringEntryMethod = (*jenv)->GetMethodID(jenv, cls, "setstringEntry", "(Ljava/lang/String;)V");
            if (setstringEntryMethod) {
                jstring stringEntry = (*jenv)->NewStringUTF(jenv, $1->stringEntry);
                (*jenv)->CallVoidMethod(jenv, mystringInstance, setstringEntryMethod, stringEntry);
                jresult = mystringInstance;
            }
        }
    }
    free($1->stringEntry);
    free($1);
}

%typemap(jni) MYService * "jobject"
%typemap(jtype) MYService * "org.me.myservice"
%typemap(jstype) MYService * "org.me.myservice"

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

    const jclass servicecls = (*jenv)->FindClass(jenv, "org/me/myservice");
    jmethodID setstringEntryMethod = (*jenv)->GetMethodID(jenv, servicecls, "setstringEntry", "(Ljava/lang/String;)V");
    if(servicecls && setstringEntryMethod)
    {
        jresult = (*jenv)->NewObjectArray(jenv, len, servicecls, NULL);
        if (jresult)
        {
            int i;
            for (i=0; i < len; i++)
            {
                MYService *service = $1[i];
                jobject myserviceInstance = (*jenv)->AllocObject(jenv, servicecls);
                if(myserviceInstance)
                {
                    jstring stringEntry = (*jenv)->NewStringUTF(jenv, service->stringEntry);
                    (*jenv)->CallVoidMethod(jenv, myserviceInstance, setstringEntryMethod, stringEntry);
                    (*jenv)->SetObjectArrayElement(jenv, jresult, i, myserviceInstance);
                    (*jenv)->DeleteLocalRef(jenv, myserviceInstance);
                    free(service->stringEntry);
                    free(service);
                }
            }
        }
    }
    free($1);
}

%typemap(jni) MYService ** "jobjectArray"
%typemap(jtype) MYService ** "org.me.myservice[]"
%typemap(jstype) MYService ** "org.me.myservice[]"

%typemap(javaout) MYService ** {
    return $jnicall;
}

// -------------------------- fillup_service --------------------------------
%typemap(out) Container_Service *
{
    // Convert the value to integer again.
    if(result->retCode != 0)
    {
        // TODO: Throw an exception in java.
    }

    MYService *service = result->service;
    jresult = NULL;
    // Get a class reference for org.me.myservice
    const jclass cls = (*jenv)->FindClass(jenv, "org/me/myservice");
    if (cls) {
        jobject mystringInstance = (*jenv)->AllocObject(jenv, cls);
        if (mystringInstance) {
            jmethodID setstringEntryMethod = (*jenv)->GetMethodID(jenv, cls, "setstringEntry", "(Ljava/lang/String;)V");
            if (setstringEntryMethod) {
                jstring stringEntry = (*jenv)->NewStringUTF(jenv, service->stringEntry);
                (*jenv)->CallVoidMethod(jenv, mystringInstance, setstringEntryMethod, stringEntry);
                jresult = mystringInstance;
            }
        }
    }

    free(service->stringEntry);
    free(service);
    // Free original result
    free(result);
}

%typemap(jni) Container_Service * "jobject"
%typemap(jtype) Container_Service * "org.me.myservice"
%typemap(jstype) Container_Service * "org.me.myservice"

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

    MYService **services = result->services;
    // Get count
    int len=0;
    while (services[len])
    {
        len++;
    }

    const jclass servicecls = (*jenv)->FindClass(jenv, "org/me/myservice");
    jmethodID setstringEntryMethod = (*jenv)->GetMethodID(jenv, servicecls, "setstringEntry", "(Ljava/lang/String;)V");
    if(servicecls && setstringEntryMethod)
    {
        jresult = (*jenv)->NewObjectArray(jenv, len, servicecls, NULL);
        if (jresult)
        {
            int i;
            for (i=0; i < len; i++)
            {
                MYService *service = services[i];
                jobject myserviceInstance = (*jenv)->AllocObject(jenv, servicecls);
                if(myserviceInstance)
                {
                    jstring stringEntry = (*jenv)->NewStringUTF(jenv, service->stringEntry);
                    (*jenv)->CallVoidMethod(jenv, myserviceInstance, setstringEntryMethod, stringEntry);
                    (*jenv)->SetObjectArrayElement(jenv, jresult, i, myserviceInstance);
                    (*jenv)->DeleteLocalRef(jenv, myserviceInstance);
                    free(service->stringEntry);
                    free(service);
                }
            }
        }
    }
    free(services);
    // Free the container
    free(result);
}

%typemap(jni) Container_Service_Array * "jobjectArray"
%typemap(jtype) Container_Service_Array * "org.me.myservice[]"
%typemap(jstype) Container_Service_Array * "org.me.myservice[]"
%typemap(javaout) Container_Service_Array * {
    return $jnicall;
}

MYService *get_service();
MYService **get_service_array();
Container_Service *fillup_service_proxy(int fail);
Container_Service_Array *fillup_service_array_proxy(int fail);
