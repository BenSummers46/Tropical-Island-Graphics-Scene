using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;
using UnityEngine.UI;
using Unity.Profiling;

public class MemoryUsage : MonoBehaviour
{
    [SerializeField] Text memoryUI;
    [SerializeField] Text totalMemoryUI;

    ProfilerRecorder totalMemoryUsedRecorder;

    private void OnEnable()
    {
        totalMemoryUsedRecorder = ProfilerRecorder.StartNew(ProfilerCategory.Memory, "Total Used Memory");
    }

    private void OnDisable()
    {
        totalMemoryUsedRecorder.Dispose();
    }

    // Update is called once per frame
    void Update()
    {
        long memory = GC.GetTotalMemory(false);
        memoryUI.text = "Total GC Memory: " + memory / (1024 * 1024) + " MB";
        totalMemoryUI.text = "Total Used Memory: " + totalMemoryUsedRecorder.LastValue / (1024 * 1024) + " MB";
    }
}
