package com.phodal.dore.open;

import android.content.Context;

import org.json.JSONArray;
import org.json.JSONException;

import android.net.Uri;
import android.content.Intent;
import android.webkit.MimeTypeMap;
import android.content.ActivityNotFoundException;
import android.os.Build;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

class DoreOpenModule extends ReactContextBaseJavaModule {
  private Context context;

  public DoreOpenModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.context = reactContext;
  }

  @Override
  public String getName() {
    return "DoreOpen";
  }

  private static String getMimeType(String path) {
    String mimeType = null;

    String extension = MimeTypeMap.getFileExtensionFromUrl(path);
    if (extension != null) {
      MimeTypeMap mime = MimeTypeMap.getSingleton();
      mimeType = mime.getMimeTypeFromExtension(extension);
    }

    System.out.println("Mime type: " + mimeType);

    return mimeType;
  }

  @ReactMethod
  public void open(String path, Promise promise) {
    if (path != null && path.length() > 0) {
      try {
        Uri uri = Uri.parse(path);
        String mime = getMimeType(path);
        Intent fileIntent = new Intent(Intent.ACTION_VIEW);

        if (Build.VERSION.SDK_INT > 15) {
          fileIntent.setDataAndTypeAndNormalize(uri, mime); // API Level 16 -> Android 4.1
        } else {
          fileIntent.setDataAndType(uri, mime);
        }

        getCurrentActivity().startActivity(fileIntent);

        promise.resolve("success");
      } catch (ActivityNotFoundException e) {
        e.printStackTrace();
        promise.reject(e.getMessage());
      }
    } else {
      promise.reject("errorpackage");
    }
  }
}
