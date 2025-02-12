package com.example.native_accelerometer

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.content.Context
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class NativeAccelerometerPlugin : FlutterPlugin, SensorEventListener {
    private lateinit var sensorManager: SensorManager
    private var accelerometer: Sensor? = null
    private var eventSink: EventChannel.EventSink? = null

    private lateinit var methodChannel: MethodChannel

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val context = binding.applicationContext
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        // Event Channel for Accelerometer Data
        val eventChannel = EventChannel(binding.binaryMessenger, "native_accelerometer")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                accelerometer?.let {
                    sensorManager.registerListener(this@NativeAccelerometerPlugin, it, SensorManager.SENSOR_DELAY_NORMAL)
                }
            }

            override fun onCancel(arguments: Any?) {
                sensorManager.unregisterListener(this@NativeAccelerometerPlugin)
                eventSink = null
            }
        })

        // Method Channel for Platform Version
        methodChannel = MethodChannel(binding.binaryMessenger, "native_accelerometer/methods")
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
                else -> result.notImplemented()
            }
        }
    }

    override fun onSensorChanged(event: SensorEvent?) {
        event?.let {
            if (event.sensor.type == Sensor.TYPE_ACCELEROMETER) {
                eventSink?.success(mapOf(
                    "x" to event.values[0],
                    "y" to event.values[1],
                    "z" to event.values[2]
                ))
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        sensorManager.unregisterListener(this)
        methodChannel.setMethodCallHandler(null)
    }
}
